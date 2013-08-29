from numpy import *
from classify_utils import *

X1, y = getXyFromCsv('data/y_X_churn_time_T_7.csv', fillMissingWith0=True)
for i in range(26): print i,; res[i]  = mean(performClassification(mat(X1)[:, i:i+1], y, DecisionTreeClassifier(min_samples_leaf=500)))
resarg = list(reversed(argsort(res)))
meanperf = zeros(26)
for i in range(26): print i,; meanperf[i]  = mean(performClassification(mat(X1)[:, resarg[0:i+1]], y, DecisionTreeClassifier(min_samples_leaf=500)))
perfshift = meanperf - hstack([0], meanperf[0:25])
perfsarg = list(reversed(argsort(perfshift)))

performClassification(mat(X1)[:, perfshift[0:10]], y, DecisionTreeClassifier(min_samples_leaf=500))

