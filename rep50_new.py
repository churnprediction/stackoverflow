from jdcommon import *
import numpy as np
import pylab
from pylab import *
from collections import Counter

def repIn50(users, loglog=False):
    monthPostC = Counter(np.array(users[:, 1].T)[0])
    lg = ""
    if loglog:
        lg = "loglog"
    pylab.title(lg + " Reputation after 50 posts vs number of users")
    pylab.xlabel("Reputation after 50 posts")
    pylab.ylabel("User count")
    if loglog:
        pylab.loglog(monthPostC.keys(), monthPostC.values())
    else:
        pylab.plot(monthPostC.keys(), monthPostC.values(), color="r")
    show()
    #pylab.savefig(lg + "rep_after_50.png")
    pylab.close()



def cdfRep(users):
    title("Reputation of user after 50 posts vs user count")
    xlabel("Reputation")
    ylabel("#Users(Tot:37k)")
    postCt = np.array(users[:, 1].T)[0]
    res = pylab.hist(postCt, bins=np.max(postCt), range=(0, np.max(postCt)), histtype='step', normed=True, cumulative=True) 
    #res = pylab.hist(postCt, bins=np.max(postCt), range=(0, np.max(postCt)), histtype='step' )
#    cumulative=True, 
#    normed=True, histtype='step')
#pylab.yticks(np.arange(0, 1, 10))
    #print res
    pylab.show()
    close()




def getTotVotes(votes, posttype):
    totVotes = 0
    up = 10
    down = -2
    acc = 15
    if posttype == 1:
        up = 5

    for (vtype, ct) in votes:
        if vtype == 1:
            totVotes += (acc * ct)
        elif vtype == 2:
            totVotes += (up * ct)
        elif vtype == 3:
            totVotes += (down * ct)
    return totVotes


QRY = "select t2.uid, t2.posttypeid, votetypeid, count(votetypeid) from votes force index(idx_votes_postid_votetypeid), (select uid, posttypeid, id from posts force index(idx_owneruserid_postid), user50  where posts.owneruserid = user50.uid and posts.id <= user50.post50id) t2 where t2.id = votes.postid and votes.votetypeid in(1, 2, 3) group by t2.uid, t2.posttypeid, votetypeid"

res = getRes(QRY, True, 'user50_res')

#rowNum = 1
#mc['user50_res'] = res
resMat = np.matrix(res)
resMat[:, 1] = resMat[:, 1] - 1
resArr = np.asarray(resMat)

uvot = [{}, {}]
totVot = {}
for row in resArr:
    totVot[row[0]] = totVot.get(row[0], 0) + getTotVotes([(row[2], row[3])], row[1])
    uvot[row[1]][row[0]] = uvot[row[1]].get(row[0], 0) + getTotVotes([(row[2], row[3])], row[1])
    


cdfRep(np.matrix(totVot.items()))
#repIn50(np.matrix(totVot.items()))
#mc["length_user50"] = rowNum
print "Done"
