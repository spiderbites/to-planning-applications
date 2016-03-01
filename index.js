var request = require('request');
var querystring = require('querystring');
var _ = require('lodash');
var _eval = require('eval');
var MongoClient = require('mongodb').MongoClient;
var ObjectId = require('mongodb').ObjectID;
var async = require('async');

// var DB_URI = require('./env').dburi;
var DB_URI = 'mongodb://localhost/planning';

var WARDCODES = ['W01','W02','W03','W04','W05','W06','W07','N08','N09','N10','W11',
                 'W12','W13','S14','N15','N16','W17','S18','S19','S20','S21','S22',
                 'N23','N24','N25','N26','S27','S28','S29','S30','S31','S32','N33',
                 'N34','E35','E36','E37','E38','E39','E40','E41','E42','E43','E44'];

var postData = function(wardcode) {
  return querystring.stringify({
    'callCount':'1',
    'page':'/DevelopmentApplications/mapSearchSetup.do?action=init',
    'httpSessionId':'',
    'c0-scriptName':'MapSearchService',
    'c0-methodName':'searchApplications',
    'c0-id':'0',
    'c0-param0':'string:S',
    'c0-param1':'string:' + wardcode,
    'c0-param2':'string:',
    'c0-param3':'string:',
    'c0-param4':'string:',
    'c0-param5':'string:',
    'c0-param6':'string:',
    'c0-param7':'string:',
    'c0-param8':'string:',
    'c0-param9':'string:',
    'c0-param10':'string:',
    'c0-param11':'string:',
    'c0-param12':'string:0',
    'c0-param13':'string:',
    'batchId':'0',
    'scriptSessionId':'CB2643E9BF354DDA93760481609B5990524'
  });
}

var getVarNames = function(dwrString) {
  // sample string:
  // dwr.engine._remoteHandleCallback('0','0',[s0,s1,s2,s3,s4,s5,s6,s7,s8,s9,s10,s11,s12,s13,s14,s15]);
  // so we return the list of variable names:  ['s0', 's1', ..., 's15']
  return dwrString.match(/\[(.*)\]/)[1].split(',')
}

var scrape = function(wardcode, callback) {
  var options = {
    url: 'http://app.toronto.ca/DevelopmentApplications/dwr/call/plaincall/MapSearchService.searchApplications.dwr',
    method: 'post',
    body: ''
  };
  options.body = postData(wardcode);
  request(options, function(err, res, body) {
    if (!err && res.statusCode == 200) {
      callback(null, body);
    }
  });
}

var parseResults = function(data, callback) {
  // get rid of this crap
  data = _.replace(data, "throw 'allowScriptTagRemoting is false.';", '');
  data = _.replace(data, /\/\/\#DWR.*/, '');
  data = _.replace(data, /\/\/\#DWR.*/, '');

  // grab the remoteHandleCallback line and grab the variables that reference properties
  var split = data.split('\n')
  var varNames = getVarNames(split[split.length - 2]);

  // done with that line
  data = _.replace(data, /dwr\.engine\._remoteHandleCallback.*\);/, '')

  // add these exports lines for the upcoming eval
  _.forEach(varNames, function(varName) {
    data = data + `exports.${varName}=${varName};`;
  });

  // trying to sandbox this eval
  res = _eval(data);

  // return an array of documents
  callback(null, _.values(res));
}

var insertDocs = function(db, docs, callback) {
  db.collection('planning').insertMany(docs, function(err, result) {
    if (err) {
      callback(err);
      return;
    }
    console.log('inserted');
    callback(null, result);
  })
}

MongoClient.connect(DB_URI, function(err, db) {
  async.each(WARDCODES, function(ward, callback) {
    console.log(`ward ${ward}`);
    async.waterfall([
      // scrape ward
      async.apply(scrape, ward),
      // parse results
      parseResults,
      // insert each document into db
      insertDocs.bind(insertDocs, db)
    ], function(err, result) {
      if (err) console.log(err);
      callback();
    });
  }, function(err) {
    if (err) {
      console.log(err);
    } else {
      db.close();
    }
  });
});