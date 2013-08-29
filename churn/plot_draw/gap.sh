
gapNum=1
while [ $gapNum -le 20 ] ; do
 qry="select churner, k, avg(gap$gapNum ) from churn_users where churner = 0 or (churner = 1 and churnedbygap = -1) group by churner, k order by churner, k";
 echo $gapNum
 echo "$qry" |  mysql -u $1 -p'$2' $3 | sed "s/churner/#churner/g" | sed "s/\t/,/g"  >  data/temporal_gap_$gapNum".csv"
 gapNum=`expr $gapNum + 1`
done
    




