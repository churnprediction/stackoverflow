from numpy import *
import numpy as np
from matplotlib import *
from pylab import *
import pylab


#matplotlib.rc('xtick', labelsize=5)
#matplotlib.rc('ytick', labelsize=5)
matplotlib.rc('font')
matplotlib.rc('xtick', labelsize=15)
matplotlib.rc('ytick', labelsize=15)



def drawParent():
    f=figure(figsize=(15, 8))
    f.suptitle('Classification accuracy for each feature category', fontsize=30)
    ax = f.add_subplot(111) 
# Turn off axis lines and ticks of the big subplot
    ax.spines['top'].set_color('none')
    ax.spines['bottom'].set_color('none')
    ax.spines['left'].set_color('none')
    ax.spines['right'].set_color('none')
#ax.set_xticks([0, 0])
    ax.set_yticks([100000, 100000], {'fontsize':'24'})
    ax.set_xticks([100000, 100000], {'fontsize':'24'})
    ax.tick_params(labelcolor='none',  top='off', bottom='off', left='off', right='off')

    ax.set_xlabel('Observation period in days (T)', {'fontsize':'24'})
    ax.set_ylabel('Accuracy' , {'fontsize':'24'})
    return f

categories = ['Consistency', 'Clarity', 'Frequency', 'Quality', 'Competitiveness', 'Speed', 'Content', 'Knowledge Level', 'Temporal Gap', 'All Features']

def drawRep(fig, gridNum, K, Xk):
    global fname
    ax = fig.add_subplot(2,5,gridNum, xmargin=0.05)
    #ax.yaxis.grid(color='gray', linestyle='dashed')
    #ax.xaxis.grid(color='gray', linestyle='dashed')

    ax.set_xlim([0, 4])
    ax.set_ylim([50, 77])
    width=0.5
    ax.set_xticks(arange(1, 4))
    ax.set_yticks(arange(50, 77, 5))
    ax.set_xticklabels([7, 15, 30])

    #ax.set_title(categories[K], {'fontweight':'bold'})
    #ax.title(categories[K], x=0.5, y=0.6)
    ax.text(.5,0.9,categories[K],
        horizontalalignment='center',
        transform=ax.transAxes, fontsize='18')
    ax.bar(arange(1, 4, 1),  Xk, width,  color='b')

    #xlim(0, max(X[:, 1]))
    '''ylim(0.2, 0.7)
    yticks(arange(0.2, 0.7, 0.1))
    '''
   # xticks(arange(0, 21, 1))
    #ax.plot(NoChurn[:, 1], NoChurn[:, 2], 'o-', label='Alive')

if __name__ == "__main__":
    fname = 'data/cat.csv'
    X = genfromtxt(fname, delimiter=",")
    X = X[10:, :]
    X = X.T
    fig = drawParent()
    for K in arange(0, 10, 1):
    #for K in arange(2, 21, 1):
    #for K in arange(17, 21, 1):
        #drawRep(fig, K-16, K, array(mat(X[X[:, 0]==K])[:, arange(1, K+1, 1)]))
        drawRep(fig, K+1, K, X[K])

    show()
#f.tight_layout()

