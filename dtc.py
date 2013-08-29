ples_split=210)
(Pdb) dtc.fit(X, y)
DecisionTreeClassifier(compute_importances=True, criterion='entropy',
            max_depth=None, max_features=None, min_density=0.1,
            min_samples_leaf=105, min_samples_split=210,
            random_state=<mtrand.RandomState object at 0x7f9df4453168>)
(Pdb) dtc.feature_importances_
array([  2.95147717e-02,   1.05992136e-01,   4.01229683e-02,
         2.53839987e-02,   6.24353107e-01,   9.44378898e-02,
         0.00000000e+00,   9.22081756e-03,   1.71650824e-02,
         3.95454034e-04,   8.27250174e-04,   1.52571587e-04,
         3.24891559e-02,   3.07822365e-03,   1.08266431e-02,
         6.03993039e-03])
(Pdb) argsort(dtc.feature_importances_)
array([ 6, 11,  9, 10, 13, 15,  7, 14,  8,  3,  0, 12,  2,  5,  1,  4])

