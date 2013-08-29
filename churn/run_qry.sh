#echo "K: $K"
#qry="call get_features($K)"
#qry="select numposts, avg(accepted_answers/num_answers) from users where num_answers > 0 group by numposts"
#FILENAME="data/numposts_vs_accepted_answers.csv"

#qry="select num_answers, avg(accepted_answers/num_answers) from users where num_answers > 0 group by num_answers"
#FILENAME="data/numanswers_vs_accepted_answers.csv"

qry="select numposts, avg(num_answers/numposts) from users where numposts > 0 group by numposts"
FILENAME="data/numposts_vs_numanswers.csv"

echo $qry
echo "$qry" |  mysql -u $1 -p'$2' $3 | sed "s/num/#num/g" | sed "s/\t/,/g"  |   sed "s/NULL//g" >  $FILENAME
wc -l $FILENAME
