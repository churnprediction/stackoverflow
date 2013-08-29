from pylab import *
from numpy import *
from matplotlib import *

D = genfromtxt("data/k_vs_churn_ratio.csv", delimiter=",")
X = D[:, 0]
Y = divide(D[:, 1], vectorize(float)(D[:, 1]) + D[:, 2])
ylim((0, 1))
title("Number of posts vs Churn probability", fontsize=24)
xlabel("Number of posts made", fontsize=24)
ylabel("Probability of user churn", fontsize=24)
plot(X, Y, linewidth=4, color='r')
show()
