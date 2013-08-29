import MySQLdb

db = MySQLdb.connect(host="localhost", user="jagat", passwd="d", db="jagat")
cur = db.cursor()

cur.execute(QRY)

res = cur.fetchall()


