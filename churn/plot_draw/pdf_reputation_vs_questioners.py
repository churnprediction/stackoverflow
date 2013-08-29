from numpy import *
from feat_common import *
import numpy as np
from matplotlib import *
from pylab import *
import pylab



title('Questioner reputation vs Fraction of questioner', {'fontsize':'24'})
xlabel('Questioner reputation', {'fontsize':'24'})
ylabel('Fraction of questioners', {'fontsize':'24'})
fname='data/pdf_reputation_vs_questioners.csv'

X = genfromtxt(fname, delimiter=',')
m,n = shape(X)
totCt = float(sum(matrix(X)[:, 1]))
X[:, 1] = X[:, 1]/totCt
for i in arange(1, m, 1):
    X[i, 1] += X[i-1, 1]
#xlim(0, max(X[:, 1]))
#ylim(0, 1)
#yticks(linspace(0, 1, 11))
loglog(X[:, 0],  X[:, 1], '+-', linewidth='4')
#pylab.axvline(x=20, color='g', linestyle='dashed', linewidth='4', label='20 posts')
pylab.axhline(y=0.25, color='g', linestyle='dashed', linewidth='4', label='U 25%')
pylab.axvline(x=67, color='g', linestyle='dashed', linewidth='4', label='Rep 67')
pylab.axhline(y=0.50, color='g', linestyle='dashed', linewidth='4', label='U 50%')
pylab.axvline(x=445, color='g', linestyle='dashed', linewidth='4', label='Rep 445')

pylab.axhline(y=0.75, color='m', linestyle='dashed', linewidth='4', label='U 75%')
pylab.axvline(x=1640, color='m', linestyle='dashed', linewidth='4', label='Rep 1640')

legend(prop={'size':'20'}, loc='best')

show()

