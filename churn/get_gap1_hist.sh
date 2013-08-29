K=1
MAX=20
if [ "$1" != "" ] ; then
    k=$1
    MAX=$1
fi

while [ $K -le $MAX ] ; do
    echo "K: $K"
    qry="call get_features($K)"
#echo $qry
    echo "$qry" |  mysql -u $1 -p'$2' $3 | sed "s/churn_class_label/#churn_class_label/g" | sed "s/\t/,/g"  |   sed "s/NULL//g"  | rev  | cut -d, -f`expr 21 - $K`- | rev >  data/y_X_churn_K_$K.csv
    wc -l data/y_X_churn_K_$K.csv
    POS=`grep -c "^1" data/y_X_churn_K_$K.csv` 
    NEG=`grep -c "^-1" data/y_X_churn_K_$K.csv` 

    echo "1: $POS, -1: $NEG"
    K=`expr $K + 1`

done

