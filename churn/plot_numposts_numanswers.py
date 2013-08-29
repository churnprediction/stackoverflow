from pylab import *
from numpy import *

X1 = genfromtxt('data/numanswers_vs_accepted_answers.csv', delimiter=",")


loglog(X1[:, 0], X1[:, 1], linewidth=4)
title("Number of answers posted vs Fraction of answers accepted", fontsize=24)
xlabel("Number of answers posted", fontsize=24)
ylabel("Fraction of answers accepted", fontsize=24)
#axvline(x=1,  linestyle='dashdot', linewidth=4, color='g', label="Posts=1")
axvline(x=5,  linestyle='dashdot', linewidth=4, color='g', label="Posts=5")
axvline(x=15,  linestyle='dashed', linewidth=4, color='r', label="Posts=15")
axvline(x=20,  linestyle='dashed', linewidth=4, color='r', label="Posts=20")
legend()
show()

'''
X2 = genfromtxt('data/numposts_vs_accepted_answers.csv', delimiter=",")
loglog(X2[:, 0], X2[:, 1], linewidth=4)
title("Number of posts vs Number of answers accepted", fontsize=24)
xlabel("Number of answers posted", fontsize=24)
ylabel("Number of answers accepted", fontsize=24)
axvline(x=1,  linestyle='dashdot', linewidth=4, color='g', label="Posts=1")
axvline(x=5,  linestyle='dashdot', linewidth=4, color='g', label="Posts=5")
axvline(x=15,  linestyle='dashed', linewidth=4, color='r', label="Posts=15")
axvline(x=20,  linestyle='dashed', linewidth=4, color='r', label="Posts=20")
'''

X3 = genfromtxt('data/numposts_vs_numanswers.csv', delimiter=",")
loglog(X1[:, 0], X1[:, 1], linewidth=4)
title("Number of posts vs Answer/Question ratio", fontsize=24)
xlabel("Number of posts", fontsize=24)
ylabel("Answer/Question Ratio", fontsize=24)
#axvline(x=1,  linestyle='dashdot', linewidth=4, color='g', label="Posts=1")
axvline(x=5,  linestyle='dashdot', linewidth=4, color='g', label="Posts=5")
axvline(x=15,  linestyle='dashed', linewidth=4, color='r', label="Posts=15")
axvline(x=20,  linestyle='dashed', linewidth=4, color='r', label="Posts=20")
legend()
show()

