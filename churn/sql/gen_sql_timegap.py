from numpy import *


#print "UPDATE churn_users cu, posts p   SET gap1 = null, "
for i in arange(2, 3, 1):
#    print "SELECT \'",i,"\';"
    print "UPDATE churn_users cu, posts p   SET gap" + str(i) + \
        " = p.gap_from_prev   WHERE p.post_seq = " + str(i) + " and p.owneruserid = cu.uid and cu.k >= " + str(i) + ";"
    print "     gap" + str(i) + " = null,"



