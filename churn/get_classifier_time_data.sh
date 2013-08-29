
for T in 7 15 30 ; do
    echo "T: $T"
    qry="call get_time_features($T)"
    echo $qry
    echo "$qry" |  mysql -u $1 -p'$2' jagat | sed "s/churn_class_label/#churn_class_label/g" | sed "s/\t/,/g"  |   sed "s/NULL//g"   >  data/y_X_churn_time_T_$T.csv
    wc -l data/y_X_churn_time_T_$T.csv
    POS=`grep -c "^1" data/y_X_churn_time_T_$T.csv` 
    NEG=`grep -c "^-1" data/y_X_churn_time_T_$T.csv` 

    echo "1: $POS, -1: $NEG"
    T=`expr $T + 1`

done

