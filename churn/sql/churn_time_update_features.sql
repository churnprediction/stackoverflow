    set @norm = 0;



    set @norm = @norm + 1;

    select @norm;

    UPDATE churn_time_users cu
        SET num_questions = 
            (SELECT count(*) 
                FROM posts p force index(idx_posttypeid_owneruserid_post_seq) 

                WHERE posttypeid = 1 

                AND p.owneruserid = cu.uid 

                AND p.post_seq < cu.num_posts);

    set @norm = @norm + 1;

    select @norm;

    UPDATE churn_time_users cu
        SET num_answers = 
            (SELECT count(*) 
                FROM posts p force index(idx_posttypeid_owneruserid_post_seq) 

                WHERE posttypeid = 2 

                AND p.owneruserid = cu.uid 

                AND p.post_seq < cu.num_posts);

    set @norm = @norm + 1;

    select @norm;

    UPDATE churn_time_users cu set num_questions = 0 where num_questions is null;

    set @norm = @norm + 1;

    select @norm;

    update churn_time_users cu set a_score =    
        (select avg(score) from posts force index(idx_posttypeid_owneruserid_post_seq)
            where posttypeid = 2
            and owneruserid = cu.uid 
            and post_seq <= cu.num_posts);

    set @norm = @norm + 1;

    select @norm;

    update churn_time_users cu set q_score =    
        (select avg(score) from posts  force index(idx_posttypeid_owneruserid_post_seq)
            where posttypeid = 1
            and owneruserid = cu.uid 
            and post_seq <= cu.num_posts);

    set @norm = @norm + 1;

    select @norm;

    update churn_time_users cu set a_score_stddev =    
        (select stddev(score) from posts  force index(idx_posttypeid_owneruserid_post_seq)
            where posttypeid = 2
            and owneruserid = cu.uid 
            and post_seq <= cu.num_posts);

    set @norm = @norm + 1;

    select @norm;

    update churn_time_users cu set q_score_stddev =    
        (select stddev(score) from posts  force index(idx_posttypeid_owneruserid_post_seq)
            where posttypeid = 1
            and owneruserid = cu.uid 
            and post_seq <= cu.num_posts);

    set @norm = @norm + 1;

    select @norm;

    UPDATE churn_time_users cu SET relative_rank_pos = 
        (SELECT  round(avg(parent_answer_count/answer_rank))
            FROM posts p force index(idx_posts_owneruserid_rank_answer_post_seq)
            WHERE p.owneruserid = cu.uid
            AND answer_rank is not null
            AND p.post_seq <= cu.num_posts and p.posttypeid = 2) WHERE num_answers > 0;

    
    set @norm = @norm + 1;

    select @norm;

    UPDATE churn_time_users cu 
        SET answering_speed = 
            (SELECT AVG(minutes_from_ques) FROM posts force index(idx_posttypeid_owneruserid_post_seq)
                WHERE posttypeid = 2 and cu.uid = owneruserid
                AND post_seq <= cu.num_posts) WHERE num_answers > 0;

    set @norm = @norm + 1;

    select @norm;

    UPDATE churn_time_users cu 
        SET time_for_first_ans = 
            (SELECT AVG(time_for_first_ans) FROM posts  
                force index(idx_posttypeid_owneruserid_post_seq)
                WHERE posttypeid = 1 and cu.uid = owneruserid
                AND post_seq <= cu.num_posts) WHERE num_questions > 0;

    set @norm = @norm + 1;

    select @norm;

    update churn_time_users cu set a_comments = 
        (select avg(num_comments) from posts force index(idx_posttypeid_owneruserid_post_seq)
                where posttypeid = 2 and cu.uid = owneruserid
                AND post_seq <= cu.num_posts);

    set @norm = @norm + 1;

    select @norm;

    update churn_time_users cu set q_comments = 
        (select avg(num_comments) from posts force index(idx_posttypeid_owneruserid_post_seq)
                where posttypeid = 1 and cu.uid = owneruserid
                AND post_seq <= cu.num_posts);


    set @norm = @norm + 1;

    select @norm;

    update churn_time_users cu set mean_rep_questioner = 
        (SELECT avg(rep_questioner) from posts  force index(idx_posttypeid_owneruserid_post_seq)
            WHERE  posttypeid = 2 AND owneruserid = cu.uid and post_seq <= cu.num_posts)
        where num_answers > 0;


    set @norm = @norm + 1;

    select @norm;

    update churn_time_users cu set mean_rep_co_answerers = 
        (select avg(rep_answerers) 
            from posts  force index(idx_posttypeid_owneruserid_post_seq)
            where posttypeid = 2 and cu.uid = owneruserid and post_seq <= cu.num_posts) 
        where num_answers > 0;

    set @norm = @norm + 1;

    select @norm;

    update churn_time_users cu set mean_rep_answerers = 
        (select avg(rep_answerers) 
            from posts  force index(idx_posttypeid_owneruserid_post_seq)
            where posttypeid = 1 and cu.uid = owneruserid and post_seq <= cu.num_posts) 
        where num_questions > 0;


    set @norm = @norm + 1;

    select @norm;

    update churn_time_users set a_q_ratio = (num_answers+1)/(num_questions+1);

    set @norm = @norm + 1;

    select @norm;

    update churn_time_users cu set a_post_length = 
        (select avg(length(body)) from posts  force index(idx_posttypeid_owneruserid_post_seq)
        where posttypeid = 2 and owneruserid = cu.uid 
        AND post_seq <= cu.num_posts) where num_answers > 0;


    set @norm = @norm + 1;

    select @norm;

    update churn_time_users cu set q_post_length = 
        (select avg(length(body)) from posts  force index(idx_posttypeid_owneruserid_post_seq)
            where posttypeid = 1 and owneruserid = cu.uid 
        AND post_seq <= cu.num_posts) where num_questions > 0;


    set @norm = @norm + 1;

    select @norm;



create index idx_posts_owneruserid_posttypeid_post_seq_answercount 

    on posts(owneruserid, posttypeid, post_seq, answercount);


    update churn_time_users cu set cu.num_q_answered = 
        (SELECT count(*) FROM posts WHERE owneruserid = cu.uid
            AND posttypeid = 1 AND post_seq <= cu.num_posts
            AND AnswerCount > 0) WHERE num_questions > 0;

    set @norm = @norm + 1;

    select @norm;

    update churn_time_users cu set mean_max_rep_answerer = 
        (SELECT avg(max_rep_answerer) 
            FROM posts force index(idx_posttypeid_owneruserid_post_seq)
            WHERE posttypeid = 1 AND owneruserid = cu.uid AND post_seq <= cu.num_posts)
        WHERE num_questions > 0;

    set @norm = @norm + 1;

    select @norm;

    update churn_time_users cu set mean_accepted_answerer_rep = 
        (SELECT avg(accepted_answerer_rep) 
            FROM posts  force index(idx_posttypeid_owneruserid_post_seq)
            WHERE posttypeid = 1 AND owneruserid = cu.uid AND post_seq <= cu.num_posts)
        WHERE num_questions > 0;

    set @norm = @norm + 1;

    select @norm;

    UPDATE churn_time_users cu, posts p 
        SET first_post_gap = p.gap_from_prev 
        WHERE post_seq = cu.num_posts and cu.uid = p.owneruserid;

    set @norm = @norm + 1;

    select @norm;

    UPDATE churn_time_users cu, posts p 
        SET last_post_gap = p.gap_from_prev 
        WHERE post_seq = cu.num_posts and cu.uid = p.owneruserid;
    
    set @norm = @norm + 1;

    select @norm;

    UPDATE churn_time_users cu, posts p 
        SET time_since_last_gap = 
            timestampdiff(MINUTE, p.creationdate, DATE_ADD(p.creationdate, INTERVAL T DAY))
        WHERE post_seq = cu.num_posts and cu.uid = p.owneruserid;

    set @norm = @norm + 1;

    select @norm;

    
