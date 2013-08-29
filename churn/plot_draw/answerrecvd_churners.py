from numpy import *
from matplotlib import *
from pylab import *

X = genfromtxt('data/answer_answerrecvd_churners.csv', delimiter=',')
xlim(0, max(X[:, 1]))

XX = [0]*6;
for i in range(6): XX[i] = matrix(X[X[:, 0]==i, :])
#for i in range(4): plot(XX[i][:, 1], divide(XX[i][:, 2], XX[i][:, 3]))
for i in range(6): loglog(XX[i][:, 1], divide(XX[i][:, 2], XX[i][:, 3]), '+-', label=str(i) + ' ans', linewidth=2)
title('Number of ans received vs Probability of dying (Users ask 5 q and answer at most 5)', fontsize='24')
lgd = ['0 answered']
legend(prop={'size':'24'})
xlabel('Avg number of answers received per question', fontsize=24)
ylabel('Probability of dying', fontsize=24)

show()
