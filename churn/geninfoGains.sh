i=1
while [ $i -le 20 ] ; do
    python plot_decision_tree.py $i
    cat InfoGains_$i.csv
    i=`expr $i + 1`
done
