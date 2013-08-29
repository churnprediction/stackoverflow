 call get_features(1);

select count(*) from churn_users where k=1 and churner = 1;

set @num_ch = 0;
    SELECT count(*) 
        INTO @num_ch
        FROM churn_users
        WHERE K = 1 AND churn_class_label = 1;
    
select @num_ch;

    SELECT count(*) 
    FROM (select * from `jagat`.`churn_users`
        WHERE K=1 
        AND churn_class_label = -1
        ORDER BY RAND() 
        LIMIT 0, 302288) d;
