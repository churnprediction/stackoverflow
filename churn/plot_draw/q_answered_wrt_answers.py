from numpy import *
from matplotlib import *
from pylab import *

X = genfromtxt('data/q_answered_wrt_answers.csv', delimiter=',')

xlim(0, 6)
ylim(0, 0.2)
XX = [0]*6;
for i in range(6): XX[i] = matrix(X[X[:, 0]==i, :])
#for i in range(4): plot(XX[i][:, 1], divide(XX[i][:, 2], XX[i][:, 3]))
for i in range(6): plot(XX[i][:, 1], divide(XX[i][:, 2], XX[i][:, 3]), '+-', label=str(i) + ' ans', linewidth=2)
title('Number of ques of user answered vs Probability of dying (Users ask 5 q and answer at most 5)', fontsize='24')
lgd = ['0 answered']
legend(prop={'size':'24'}, loc='best')
xlabel('Number of questions that were answered', fontsize=24)
ylabel('Probability of dying', fontsize=24)

show()
