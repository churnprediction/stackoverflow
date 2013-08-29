from pylab import *

y = [
0.688,
0.674,
0.679,
0.673,
0.663,
0.666,
0.661,
0.655,
0.657,
0.662,
0.649,
0.644,
0.636,
0.634,
0.618,
0.608,
0.595,
0.566,
0.552,
0.702
]
title("Accuracies for various K using decision trees", {'fontsize': 24})
xlabel("K")
ylabel("Accuracy")
x = arange(1, 21, 1)
plot(x, y, linewidth=2)
show()
