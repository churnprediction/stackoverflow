from numpy import *
from pylab import *

X = genfromtxt("data/gap1_days.csv")
X = X[X != 0]
hist(X, bins=300, label="Histogram of days for the first post")
#axvline(x=0.07238078, color="k", linestyle='dashed', linewidth='4', label='Mean1=0.072')
#axvline(x=2.59525552,  color="k", linestyle='dashed', linewidth='4', label='Mean2=2.595')

#plotDensity()
legend()
show()

