from numpy import *
from feat_common import *
import numpy as np
from matplotlib import *
from pylab import *
import pylab



title('User reputation vs Fraction of users', {'fontsize':'24'})
xlabel('User reputation', {'fontsize':'24'})
ylabel('Fraction of users', {'fontsize':'24'})
fname='data/pdf_reputation_vs_users.csv'

X = genfromtxt(fname, delimiter=',')
m,n = shape(X)
for i in arange(1, m, 1):
    X[i, 1] += X[i-1, 1]
#xlim(0, max(X[:, 1]))
#ylim(0, 1)
#yticks(linspace(0, 1, 11))
loglog(X[:, 0],  X[:, 1], '+-', linewidth='4')
#pylab.axvline(x=20, color='g', linestyle='dashed', linewidth='4', label='20 posts')
pylab.axhline(y=0.54, color='g', linestyle='dashed', linewidth='4', label='U 50%')
pylab.axvline(x=1, color='g', linestyle='dashed', linewidth='4', label='Rep 1')

pylab.axhline(y=0.70, color='m', linestyle='dashed', linewidth='4', label='U 70%')
pylab.axvline(x=11, color='m', linestyle='dashed', linewidth='4', label='Rep 10')

pylab.axhline(y=0.90, color='c', linestyle='dashed', linewidth='4', label='U 90%')
pylab.axvline(x=95, color='c', linestyle='dashed', linewidth='4', label='Rep 95')

legend(prop={'size':'20'}, loc='best')

show()

