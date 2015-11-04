import requests
import sys
import MySQLdb
import dbcfg

out_dir = './data/'

wardcodes = ["W01","W02","W03","W04","W05","W06","W07","N08","N09","N10","W11",
             "W12","W13","S14","N15","N16","W17","S18","S19","S20","S21","S22",
             "N23","N24","N25","N26","S27","S28","S29","S30","S31","S32","N33",
             "N34","E35","E36","E37","E38","E39","E40","E41","E42","E43","E44"]

wardcodes = ["W18"]

request_url = "http://app.toronto.ca/DevelopmentApplications/dwr/call/plaincall/MapSearchService.searchApplications.dwr"

session_id = 'AD485EE3CA6FA7518C3A5501AFF5AAA6911'

# add 'c0-param1':'string:WARDCODE' and 'scriptSessionId':session_id 
# for a full payload
payload = {
  'callCount':'1',
  'page':'/DevelopmentApplications/mapSearchSetup.do?action=init',
  'httpSessionId':'',
  'c0-scriptName':'MapSearchService',
  'c0-methodName':'searchApplications',
  'c0-id':'0',
  'c0-param0':'string:S',
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
  'batchId':'0'
}

def add_row(cursor, tablename, rowdict):
    # XXX tablename not sanitized
    # XXX test for allowed keys is case-sensitive

    # filter out keys that are not column names
    cursor.execute("describe %s" % tablename)
    allowed_keys = set(row[0] for row in cursor.fetchall())
    keys = allowed_keys.intersection(rowdict)

    if len(rowdict) > len(keys):
        unknown_keys = set(rowdict) - allowed_keys
        print >> sys.stderr, "skipping keys:", ", ".join(unknown_keys)

    columns = ", ".join(keys)
    values_template = ", ".join(["%s"] * len(keys))

    sql = "insert into %s (%s) values (%s)" % (
        tablename, columns, values_template)
    values = tuple(rowdict[key] for key in keys)
    cursor.execute(sql, values)


def ward_request(wardcode):
  f = open(out_dir + wardcode, 'w')

  # add the desired wardcode to the payload
  payload["c0-param1"] = "string:" + wardcode

  # this may have to change, unclear when the session id expires
  payload['scriptSessionId'] = session_id

  print("{0}...".format(wardcode)),
  sys.stdout.flush()

  # make the request and write the response to ./data/wardcode
  r = requests.post(request_url, data=payload)
  f.write(r.text)

  # write to DB

  f.close()
  r.close()
  print "done!"


if __name__ == "__main__":

  tablename = "parse"
  db = MySQLdb.connect(host=dbcfg.mysql['host'],
	user=dbcfg.mysql['user'], passwd=dbcfg.mysql['passwd'], db=dbcfg.mysql['db'])
  cursor = db.cursor()
#  with open(filename) as instream:
#    row = json.load(instream)

  add_row(cursor, tablename, row)
  



  for ward in wardcodes:
    ward_request(ward)
