from numpy import *
from pylab import *
from matplotlib import *

fig = pylab.figure()
ax = fig.add_subplot(1,1,1)
ax.yaxis.grid(color='gray', linestyle='dashed')
ax.xaxis.grid(color='gray', linestyle='dashed')


def vecToArr(y):
    m,n=shape(y)
    if m != 1:
        return array(y.T)[0]
    else:
        return array(y)[0]

