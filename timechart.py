import pandas
import MySQLdb
from pandas import Series
import numpy as np
import pylab
from pylab import *
import pylibmc
from math import *
from collections import Counter
from jdcommon import *


 
def getRes(qry, memcache, key):
    if memcache == False or mc.get(key) == None:
        cur = db.cursor()
        cur.execute(qry)
        res = cur.fetchall()
        print "not there"
        if memcache:
            mc[key] = res
    else:
        print("Fetching from memcache")
        res = mc[key]
    return res




def postsInMonth(users, loglog=False):
    monthPostC = Counter(np.array(users[:, 3].T)[0])
    lg = ""
    if loglog:
        lg = "loglog"
    pylab.title(lg + "Num posts made within a month after the fifth post")
    pylab.xlabel("#Post within a month after 5 posts")
    pylab.ylabel("User count")
    if loglog:
        pylab.loglog(monthPostC.keys(), monthPostC.values())
    else:
        pylab.plot(monthPostC.keys(), monthPostC.values())
    pylab.show();
#    pylab.savefig(lg + "posts_within_month.png")
#    pylab.close()


def cdfPosts(users):
    title("CDF of number of posts in a month after 5 posts vs user count")
    xlabel("#Posts")
    ylabel("#Users")
    postCt = np.array(users[:, 3].T)[0]
    val = pylab.hist(postCt, bins=np.max(postCt), range=(0, np.max(postCt)), cumulative=True,  normed=True, histtype='step')
#pylab.yticks(np.arange(0, 1, 10))
    pylab.show()
    close()


users = np.matrix(getRes("SELECT * FROM prol_users", True, 'prol_users_full'))
cdfPosts(users)
#postsInMonth(users, True)
#cdfPosts(users)
