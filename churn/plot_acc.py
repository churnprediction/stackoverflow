from pylab import *

y = [0.712,
0.693,
0.703,
0.697,
0.694,
0.691,
0.688,
0.680,
0.686,
0.690,
0.675,
0.677,
0.676,
0.672,
0.657,
0.652,
0.650,
0.644,
0.671,
0.727,
]
title("Accuracies for various K using decision trees", {'fontsize': 24})
xlabel("K")
ylabel("Accuracy")
x = arange(1, 21, 1)
plot(x, y, linewidth=2)

