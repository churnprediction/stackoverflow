    set @norm =  1;

    select @norm;

    UPDATE churn_time_users cu, posts p, users u 

        SET time_since_last_gap = 

            timestampdiff(MINUTE, p.creationdate, DATE_ADD(u.creationdate, INTERVAL T DAY))

        WHERE post_seq = cu.num_posts and cu.uid = p.owneruserid and cu.uid = u.id;

     

    set @norm = @norm + 1;

    select @norm;

    UPDATE churn_time_users cu

        SET num_answers_recvd = 

        (select avg(answercount) 

            from posts  force index(idx_posttypeid_owneruserid_post_seq)

            where posttypeid = 1

            and owneruserid = cu.uid 

            and post_seq <= cu.num_posts);

     


