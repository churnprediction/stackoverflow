k=1 
while [ $k -le 20 ] ; do 
    echo "k: $k";  
    python churn_classify.py $k ; 
    k=`expr $k + 1` ; 
done
