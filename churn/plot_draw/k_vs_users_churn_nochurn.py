from pylab import *
from numpy import *
import matplotlib.pyplot as plt
matplotlib.rc('xtick', labelsize=20)
matplotlib.rc('ytick', labelsize=20)
matplotlib.rc('font', weight='bold')



D = genfromtxt("data/k_vs_churn_ratio.csv", delimiter=",")
X = D[:, 0]
title("#churners/non-churners vs #Posts", fontsize=30, fontweight='bold')
xlabel("Number of posts made", fontsize=24,  fontweight='bold')
ylabel("Number of users", fontsize=24,  fontweight='bold')


width = 0.5       # the width of the bars: can also be len(x) sequence

p1 = plt.bar(X, D[:, 2],   width, color='g', label="Users who stay")
p2 = plt.bar(X, D[:, 1],   width, color='r', label="Users who churn", bottom=D[:, 2])
xticks(arange(1, 21, 1))

legend(prop={'weight':'bold', 'size':24})
show()


'''
plot(X, D[:, 1], linewidth=4,  label="Users who churn")
plot(X, D[:, 2], linewidth=4,  label="Users who stay")
plot(X, (D[:, 1]+D[:, 2])/2, linestyle='dashdot',  label="Half of the users")
'''
