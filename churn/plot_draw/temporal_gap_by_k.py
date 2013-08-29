from numpy import *
import numpy as np
from matplotlib import *
from pylab import *
import pylab


matplotlib.rc('xtick', labelsize=12)
matplotlib.rc('ytick', labelsize=12)
matplotlib.rc('font', weight='bold')


def drawParent():
    f=figure(figsize=(15, 10))
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

    ax.set_title('Gap between posts', {'fontsize':'30', 'fontweight':'bold'})
    ax.set_xlabel('P where y(P) indicates gap between post P-1 and P', {'fontsize':'24', 'fontweight':'bold'})
    ax.set_ylabel('Mean timegap between posts (minutes)' , {'fontsize':'24', 'fontweight':'bold'})
    return f

def drawRep(fig, gridNum, K, Xk):
    global fname
    ax = fig.add_subplot(2,2,gridNum, xmargin=0.05)
    ax.yaxis.grid(color='gray', linestyle='dashed')
    ax.xaxis.grid(color='gray', linestyle='dashed')

    ax.set_xlim([0, 21])
    #ax.set_title('K = ' + str(K), {'fontsize':'20', 'fontweight':'bold'})
    ax.text(.5,0.85, 'K = ' + str(K),
        horizontalalignment='center',
        transform=ax.transAxes, fontsize='20', fontweight='bold')

#    ax.set_xticks(arange(1, 21, 1))
    #xlim(0, max(X[:, 1]))
    '''ylim(0.2, 0.7)
    yticks(arange(0.2, 0.7, 0.1))
    '''
   # xticks(arange(0, 21, 1))
    Churn = Xk[Xk[:, 0] == 1]
    NoChurn = Xk[Xk[:, 0] == 0]
    ax.plot(arange(2, K+1, 1),  Churn[0][1:], 'd-', color='r', label='Churn', linewidth='4')
    ax.plot(arange(2, K+1, 1),  NoChurn[0][1:], 'd-', color='g', label='Stay', linewidth='4')
    #ax.plot(NoChurn[:, 1], NoChurn[:, 2], 'o-', label='Alive')
    ax.legend(prop={'size':'15', 'weight':'bold'}, loc='best')

if __name__ == "__main__":
    fname = 'data/temporal_gap_by_k.csv'
    X = mat(genfromtxt(fname, delimiter=","))
    X = array(hstack((X[:, 0:2], X[:, 3:])))
    fig = drawParent()
    #for K in arange(2, 6, 1):
    #for K in arange(2, 21, 1):
    for K in arange(16, 21, 1):
        #drawRep(fig, K-16, K, array(mat(X[X[:, 0]==K])[:, arange(1, K+1, 1)]))
        drawRep(fig, K-16, K, array(mat(X[X[:, 0]==K])[:, arange(1, K+1, 1)]))

    show()
#f.tight_layout()

