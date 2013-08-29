qry="SELECT k, churner, AVG(gap1),  AVG(gap2),  AVG(gap3),  AVG(gap4),  
       AVG(gap5),  AVG(gap6),  AVG(gap7),  AVG(gap8),  AVG(gap9),  AVG(gap10),  AVG(gap11),  
       AVG(gap12),  AVG(gap13),  AVG(gap14),  AVG(gap15),  AVG(gap16),  AVG(gap17),  AVG(gap18),  AVG(gap19),  AVG(gap20)
   FROM churn_users
       WHERE churner = 0 OR (churner = 1 AND churnedbygap = -1)
       GROUP BY  k, churner
       ORDER BY  k, churner";

#echo $qry
echo "$qry" |  mysql -u $1 -p'$2' $3 | sed "s/k/#k/g" | sed "s/NULL//g" | sed "s/\t/,/g"  >  data/temporal_gap_by_k.csv


