from feat_props import *
from collections import Counter
from multiprocessing import Pool
from numpy import *
import numpy as np
from matplotlib import *
import matplotlib.pyplot as plt
import matplotlib.mlab as mlab
import multiprocessing
from classify_utils import *
from jdcommon import *

def vecToArr(y):
    m,n=shape(y)
    if m != 1:
        return array(y.T)[0]
    else:
        return array(y)[0]

def drawHists(X, y, featProps, categories, histogram=False, 
        loglog=False, linestyle=('-', 'dashedline'), histbinsize=50, outdir='feat_hists', parallel=False, title=None):

    print "Histogram: ",histogram," LogLog: ",loglog," Linestyle: ",linestyle
    labels = unique(y)
    n, m = shape(X)
    colors = ['r' + linestyle[0], 'b' + linestyle[0], 'g' + linestyle[0]]

    n, m = shape(X)
    args = [(X, y, featProps, categories, histogram, loglog, linestyle,
                histbinsize, outdir, featNum, title) for featNum in range(m)]
    if parallel:
        p = Pool(multiprocessing.cpu_count())
        p.map(tempo, args)
        p.close()
    else:
        for arg in args:
            tempo(arg)

def tempo(x):
    drawHistsForFeat(*x)

def drawHist(X, featureName, histogram=False, 
        loglog=False, linestyle=('-', 'dashline'), histbinsize=50, title=None, cumulative=False, normed=False, vline=None, hline=None):

    f = plt.figure()
    ax = f.add_subplot(111)
    if title == None:
        title = 'Frequency of ' + featureName
    if loglog:
        title = title + ', loglog'
    if histogram:
        title = title + ', binned'

    ax.set_title(title, fontsize=24)
    ax.set_xlabel(featureName, fontsize=24)
    ax.set_ylabel('Frequency', fontsize=24)
    #ax.set_ylim(0, int(len(y)))
    mn = float(min(X))
    mx = float(max(X))
    rg = mx;
    ax.set_xlim(0, mx*1.1) 

    hists = []
        #val = ax.hist(f1, bins=mx, range=(0, mx), cumulative=False,  
        #        normed=False, histtype='step', facecolor=colors[cat])
    f1 = X
    if histogram:
        hist, bins = np.histogram(f1,bins = min(histbinsize, int(mx+1)), normed=normed)
        #width = 0.7*(bins[1]-bins[0])
        xaxis = (bins[:-1]+bins[1:])/2 
        yaxis = hist
        if cumulative:
            n = len(yaxis)
            for i in range(n-1):
                yaxis[i+1] = yaxis[i+1] + yaxis[i]
    else:
        ct = matrix(Counter(f1).items())
        xaxis = vecToArr(ct[:, 0])
        yaxis = vecToArr(ct[:, 1])

    if loglog:
        val = plt.loglog(xaxis, yaxis, color, linewidth=4)
    else: 
        val = plt.plot(xaxis, yaxis, color, linewidth=4)
                
    if vline != None:
        axvline(x=vline[0], color="k", linestyle='dashed', linewidth='4', label=vline[1])
    if hline != None:
        axhline(y=hline[0],  linestyle='dashed', linewidth='4', label=hline[1])
        
    ax.grid(True)
    ax.legend()
    show()
    return xaxis, yaxis



def drawHistsForFeat(X, y, featProps, categories, histogram=False, 
        loglog=False, linestyle=('--', 'dashline'), histbinsize=50, outdir='feat_hists', featNum=0, title=None):

    labels = unique(y)
    n, m = shape(X)
    colors = ['r' + linestyle[0], 'b' + linestyle[0], 'g' + linestyle[0]]


    f = plt.figure()
    ax = f.add_subplot(111)
    if title == None:
        title = 'Frequency of ' + featProps[featNum][1]
    if loglog:
        title = title + ', loglog'
    if histogram:
        title = title + ', binned'

    ax.set_title(title)
    ax.set_xlabel(featProps[featNum][1])
    ax.set_ylabel('Frequency')
    #ax.set_ylim(0, int(len(y)))
    mn = float(min(X[:, featNum]))
    mx = float(max(X[:, featNum]))
    rg = mx - mn;
    ax.set_xlim(0.9*mn - 0.1*rg, mx*1.1) 

    hists = []
    for cat in range(len(categories)):
        lab = labels[cat]
        f1 = vecToArr(X[vecToArr(where(mat(y)==lab)[1]), featNum])
        if len(f1) == 0:
            continue
        #val = ax.hist(f1, bins=mx, range=(0, mx), cumulative=False,  
        #        normed=False, histtype='step', facecolor=colors[cat])
        if histogram:
            hist, bins = np.histogram(f1,bins = min(histbinsize, int(rg+1)))
            #width = 0.7*(bins[1]-bins[0])
            xaxis = (bins[:-1]+bins[1:])/2 
            yaxis = hist
        else:
            ct = matrix(Counter(f1).items())
            xaxis = vecToArr(ct[:, 0])
            yaxis = vecToArr(ct[:, 1])

        if loglog:
            val = plt.loglog(xaxis, yaxis, colors[cat])
        else: 
            val = plt.plot(xaxis, yaxis, colors[cat])
                    
        hists.append(val)
        ax.grid(True)
    ax.legend(categories)
    filename = outdir + "/" + featProps[featNum][0]
    if histogram:
        filename += "_hist"
    if loglog:
        filename += "_loglog"
    filename += '_' + linestyle[1]
    f.savefig(filename)
    print "done with",filename


if __name__ == "__main__":
    X = mc.get('X_Control')
    y = mc.get('y_Control')
    if(True or X == None):
        X, y = getControlFiles()
        mc['X_Control'] = X
        mc['y_Control'] = y
    else:
        print "Using X and y from memcached"

    X = mat(X)
    args = [(X, y, featProps, user_categories, h, ll, ls)  
            for h in [True, False] 
                for ll in [True, False] 
                    for ls in  [('--','dashline',), (':', 'dotline'), ('x', 'xmark'), ('.', 'dotmark')]]
                        
    for arg in args:
        drawHists(*arg)
    print "done"


def test():
    drawHists(matrix([[1, 2, 3], [4, 5, 6], [7, 8, 9]]), [-1, 1, 1], 
            [('feat1', 'feat1desc'), ('feat2', 'feat2desc'), ('feat3', 'Feat 3 desc')],
            ['Negative 1', 'Positive 1'])

if __name__ == "__main__":
    X = mc.get('X_Control')
    y = mc.get('y_Control')
    if(True or X == None):
        X, y = getControlFiles()
        mc['X_Control'] = X
        mc['y_Control'] = y
