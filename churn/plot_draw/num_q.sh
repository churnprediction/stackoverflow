i=$1
end=$2
intr=$3
echo "hey$i $end $intr hey"
tot=`echo "select count(*) from users"  |  mysql -u $1 -p'$2' $3 | tail -1`
while [ $i -lt $end ] 
    do 
        rat=`echo "select (select count(*) from users where numposts < $i)/$tot" |  mysql -u $1 -p'$2' $3 | tail -1`
        echo "$i,$rat"
        i=`expr $i + $intr`  
    done

