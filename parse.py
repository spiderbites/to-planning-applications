import re
import os
import dbcfg
import MySQLdb
import sys
import traceback

##################################
# PUTTING DATA INTO DICTIONARIES #
##################################

# entry point
def build_all_objects():
  all_objects = []
  for dirpath, _, filenames in os.walk('./data'):
    for f in filenames:
      file = os.path.join(dirpath,f)
      big_list = string_to_list(file)
      keys = get_main_record_keys(big_list[-2])
      big_list = clean(big_list)
      pointer_map = build_pointer_map(keys, big_list)
      all_objects.append(build_objects(keys, big_list, pointer_map))
  return all_objects

def string_to_list(file):
  return open(file).read().split(";")

def is_key(s):
  return re.search('s\d+', s)

def get_main_record_keys(s):
  '''Return a list of all the "outer keys", found at the end of the data files'''
  return s[s.index('[') + 1 : -2].split(',')

def clean(big_list):
  return map(str.strip, big_list)[:-2] # we don't need the last two items in the file

def build_pointer_map(keys, big_list):
  '''
  Here we're looking for entries where the values are pointers, i.e. s0.proposal=s33
  Return a dict that takes the form {key : [pointer, name]} i.e. {'s0' : ['s33','proposal' ]}
  '''
  pointer_map = {}
  for item in big_list:
    try:
      key_name, pointer = item.split('=')
      key, name = key_name.split('.')
      if is_key(key) and is_key(pointer):
        pointer_map[pointer] = [key, name]
    except ValueError:
      pass    
  return pointer_map

def build_objects(keys, big_list, pointer_map):
  '''
  Main processing function for each data file that contains developments for a single ward.
  Return a dictionary of dictionaries, where each inner dictionary contains the information
  for a single development.  Development data can be 'nested' within the data files. Currently
  this goes one nesting level deep when creating development objects.
  '''
  obj = {}
  for key in keys:
    obj[key] = {}
  for item in big_list:

    # we get a ValueError if strings aren't of the form sNUM.key = STRING
    # but that's okay because we want to ignore those values
    try:
      key_name, value = item.split('=')
      key, value_name = key_name.split('.', 1)
      value = value.replace('"','') # remove unneeded quote marks

      # now we have key, value_name and value

      # skip over the entries that are just pointers, we have those in pointer_map
      if not is_key(value):

        # check if the key is an 'outer key'
        if key in obj.keys():
          obj[key][value_name] = value

        # this is a pointer
        elif key in pointer_map.keys():
          outer_key = pointer_map[key][0]

          # even though pointers are nested, for now we only go one level deep
          if outer_key in obj.keys(): 
            value_name = pointer_map[key][1] + "_" + value_name
            obj[outer_key][value_name] = value

    except ValueError:
      pass

  return obj  



#########################
# CONVENIENCE FUNCTIONS #
#########################
   
def print_objects(objects):
  for key in objects:
    print key
    for k,v in objects[key].iteritems():
      print k + ": " + v
    print

def get_sorted_value_names(objects):
  s = set()
  for k,v in objects.iteritems():
    for name in v.keys():
      s.add(name)
  s = list(s)
  s.sort()
  return s



################
# DB FUNCTIONS #
################

def connect():
  return MySQLdb.connect(host=dbcfg.mysql['host'],
                       user=dbcfg.mysql['user'], 
                       passwd=dbcfg.mysql['passwd'],
                       db=dbcfg.mysql['db'])

def add_row(cursor, tablename, rowdict):
    keys = ", ".join(rowdict.keys())
    values_template = ", ".join(["%s"] * len(rowdict))

    sql = "insert into %s (%s) values (%s)" % (
       tablename, keys, values_template)
    values = tuple(rowdict[key] for key in rowdict)
    cursor.execute(sql, values)



##################
# DATA CLEANSING #
##################

def null_empty_str_to_none(val):
  return None if val == "null" or val == '' else val

def try_int_conversion(val):
  try:
    int_val = int(val.replace(',', ''))
    return int_val
  except (ValueError, AttributeError):
    return val

########
# MAIN #
########

if __name__ == "__main__":
  all_objects = build_all_objects()

  db = connect()
  cursor = db.cursor()
  tablename = "parse"

for ward_object in all_objects:
    for development in ward_object.keys():
      row = ward_object[development]
      row = {k: null_empty_str_to_none(v) for k,v in row.iteritems()}
      row = {k: try_int_conversion(v) for k,v in row.iteritems()}
      try:
        add_row(cursor, tablename, row)
      except:
        e = sys.exc_info()[0]
        print e
        traceback.print_exc()
        print row
        sys.exit(0)

db.commit()