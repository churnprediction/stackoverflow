from numpy import *
import numpy as np
from matplotlib import *
from pylab import *
import pylab



title('#Answers vs Churn probability', fontsize=30, fontweight='bold')
xlabel('Number of answers given by the user', fontsize='30', fontweight='bold')
ylabel('Probability of churning', fontsize='30', fontweight='bold')
fname='data/answer_churners_qfixed.csv'
X = genfromtxt(fname, delimiter=',')
#xlim(0, max(X[:, 1]))
#ylim(0, 1)
yticks(fontsize=20, fontweight='bold')
xticks(fontsize=20, fontweight='bold')

XX = [0]*6;
for i in range(6): XX[i] = matrix(X[X[:, 0]==i, :])
for i in range(6):
    pylab.loglog(XX[i][:, 1],  divide(XX[i][:, 2], XX[i][:, 3]), 'd-', linewidth='4', label=str(i) + ' ques asked')
legend(prop={'size':'25', 'weight':'bold'})

show()
