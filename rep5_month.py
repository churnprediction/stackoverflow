from jdcommon import *
import numpy as np
import pylab
from pylab import *
from collections import Counter


def cdfRep(users):
    postCt = np.array(users[:, 1].T)[0]

    title("Reputation of the user a month after 5 posts vs user count")
    xlabel("Reputation")
    ylabel("#Users")
    res = pylab.hist(postCt, bins=np.max(postCt), range=(0, np.max(postCt)), histtype='step', cumulative=False)
    pylab.savefig("rep5_month.png")
    close()

    title("CDF of reputation of the user a month after 5 posts vs user count")
    xlabel("Reputation")
    ylabel("#Users")
    res = pylab.hist(postCt, bins=np.max(postCt), range=(0, np.max(postCt)), histtype='step', normed=True, cumulative=True)
    pylab.savefig("cdf_rep5_month.png")
    close()
    #res = pylab.hist(postCt, bins=np.max(postCt), range=(0, np.max(postCt)), histtype='step', normed=True, cumulative=True)
    #res = pylab.hist(postCt, bins=np.max(postCt), range=(0, np.max(postCt)), histtype='step', cumulative=False)

#    cumulative=True, 
#    normed=True, histtype='step')
#pylab.yticks(np.arange(0, 1, 10))
    #print res

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



QRY = "select t2.uid, t2.posttypeid, votetypeid, count(votetypeid) from votes force index(idx_votes_postid_votetypeid), (select uid, posttypeid, id from posts force index(idx_owneruserid_postid), user5_month  where posts.owneruserid = user5_month.uid and posts.id <= user5_month.post5monthid) t2 where t2.id = votes.postid and votes.votetypeid in(1, 2, 3) group by t2.uid, t2.posttypeid, votetypeid"

res = getRes(QRY, True, 'user5month_res')

#rowNum = 1
#mc['user5_res'] = res
#for row in np.asarray(np.matrix(res)):
#    mc["user5_row_" + str(rowNum)] = row
#    rowNum += 1

#mc["length_user5"] = rowNum
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

