from numpy import *
import numpy as np
from matplotlib import *
from pylab import *
import pylab



title('Choice of K=20: Number of posts vs Number of users ', {'fontsize':'24'})
xlabel('Number of Posts', {'fontsize':'24'})
ylabel('Number of Users', {'fontsize':'24'})
fname='data/k_vs_user_count.csv'
X = genfromtxt(fname, delimiter=',')
#xlim(0, max(X[:, 1]))
#ylim(0, 1)
#yticks(linspace(0, 1, 11))
pylab.loglog(X[:, 0],  X[:, 1], '+-', linewidth='4')
pylab.axhline(y=0.35, color='m', linestyle='dashed', linewidth='4', label='35%')
pylab.axhline(y=0.94, color='r', linestyle='dashed', linewidth='4', label='94%')
pylab.axvline(x=20, color='g', linestyle='dashed', linewidth='4', label='20 posts')
legend()

show()
