def cumct(ct):
    cumct = [0] * len(ct)
    cumct[0] = ct[0]
    for i in range(len(ct)-1):
        cumct[i+1] = cumct[i] + ct[i+1]
    return cumct

def logct(ct):
    logct = [0] * len(ct)
    for i in range(len(ct)):
        logct[i] = log(ct[i])
    return logct

def loglogct(ct):
    loglogct = [0] * len(ct)
    for i in range(len(ct)):
        loglogct[i] = log(log(ct[i]+1))
    
    return loglogct

def logcumct(ct):
    return logct(cumct(ct))

def getChart(res, period, start, func):
    ct = [y for (x, y) in res if x % period == start]
    rep = [x for (x, y) in res if x % period == start]
    return (rep, func(ct))
