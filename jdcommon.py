import MySQLdb
import pylibmc
import sys

db = MySQLdb.connect(host="localhost", user=sys.argv[1], passwd=sys.argv[2], db=sys.argv[3])
mc = pylibmc.Client(["127.0.0.1"])
cur = db.cursor()

def getRes(qry, memcache, key="Dummy", parameters=()):
    if memcache == False or mc.get(key) == None:
        print "Not there in MC"
        cur.execute(qry, parameters)
        res = cur.fetchall()
        if memcache:
            mc[key] = res
    else:
        print("Fetching from memcache")
        res = mc[key]
    return res

