from numpy import *
from feat_common import *
import numpy as np
from matplotlib import *
from pylab import *
import pylab



title('Score per post vs Number of posts', {'fontsize':'24'})
xlabel('Score', {'fontsize':'24'})
ylabel('Number of posts', {'fontsize':'24'})
fname='data/score_vs_numposts.csv'

X = genfromtxt(fname, delimiter=',')
#xlim(0, max(X[:, 1]))
#ylim(0, 1)
#yticks(linspace(0, 1, 11))
loglog(X[:, 0],  X[:, 1]+1, '+-', linewidth='4')
#pylab.axvline(x=20, color='g', linestyle='dashed', linewidth='4', label='20 posts')

show()
