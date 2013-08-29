from multiprocessing import Pool
import numpy
from ../classify_utils import *

numToFactor = 976

def isFactor(arg):
    x,y = arg
    print x,y
    return y*y

if __name__ == '__main__':
    pool = Pool(processes=16)
    arr = [(x, 2*x) for x in range(5)]
    result = pool.map(isFactor, arr)
    cleaned = [x for x in result if not x is None]
    print 'Factors are', cleaned
