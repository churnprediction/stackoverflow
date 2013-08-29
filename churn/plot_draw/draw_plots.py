import sys
sys.path.append('../')

from classify_utils import *
from draw_hist import *
from numpy import *

X, y = getControlFiles('data/X_answercount_k1.csv', 'data/y_answercount_k1.csv')
X= matrix(X).T
y = vecToArr(mat(y))

if __name__ == '__main__':
    drawHists(X, y, 
        [('AnswerCount', 'Number of answers received', True, True)], 
        ['Dead', 'Alive'], loglog=True,  outdir='plots', 
        title="Frequency vs Number of answers received when k=1")
