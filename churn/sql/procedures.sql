
delimiter $$
drop procedure if exists update_all_churns$$

delimiter @@
CREATE PROCEDURE update_all_churns(mx int(11))
    BEGIN
              DECLARE KK  INT;
              SET KK = 1;
              WHILE KK  <= mx DO
                    call update_churn(KK);
                    set KK = KK + 1;
              END WHILE;
    END@@

delimiter $$
drop procedure if exists update_churn$$

delimiter $$
CREATE  PROCEDURE update_churn(KK int(11))
    BEGIN
        update users u set num_answers = 
            (select count(*) from posts p where p.owneruserid = u.id
                and p.posttypeid = 2);

        update posts p1, posts p2
            set p1.accepted = 1 
            where p1.parentid = p2.id 
            and p2.acceptedanswerid = p1.id;

        update users u set accepted_answers = 
            (select count(*) from posts p where p.owneruserid = u.id
                and p.accepted = 1);

        insert into churn_users(uid, kth_postid) 
            SELECT owneruserid, p.id FROM posts p, users u where post_seq = KK
            AND timestampdiff(MONTH, p.creationdate, '2012-07-31 23:59:57') > 6 
            AND u.id = p.owneruserid and u.NumPosts = KK;

        update churn_users set churnedbygap = -1 where churnedbygap is null;

        insert into churn_users(uid, kth_postid) 
            SELECT p1.owneruserid, p1.id FROM posts p1, posts p2 
            where p1.post_seq = KK AND p2.post_seq = KK+1
            AND p1.owneruserid = p2.owneruserid
            AND timestampdiff(MONTH, p1.creationdate, p2.creationdate) > 6;

        update churn_users set churnedbygap = 1 where churnedbygap is null;
        update churn_users set churner = 1 where churner is null;

        insert into churn_users(uid, kth_postid) 
            SELECT p1.owneruserid, p1.id FROM posts p1, posts p2 
            where p1.post_seq = KK AND p2.post_seq = KK+1
            AND p1.owneruserid = p2.owneruserid
            AND timestampdiff(MONTH, p1.creationdate, p2.creationdate) <= 6;

        update churn_users set churnedbygap = 1 where churnedbygap is null;
        update churn_users set churner = -1 where churner is null;

        update churn_users set K = KK where K is null;
    END$$

delimiter $$
    DROP PROCEDURE IF EXISTS update_timegaps$$

delimiter @@
CREATE PROCEDURE update_timegaps()
    BEGIN
        SELECT ' 1 ';                                                                                                                             
        UPDATE churn_users cu, posts p   SET gap1 = p.gap_from_prev   WHERE p.post_seq = 1 and p.owneruserid = cu.uid and cu.k >= 1;              
        SELECT ' 2 ';                                                                                                                             
        UPDATE churn_users cu, posts p   SET gap2 = p.gap_from_prev   WHERE p.post_seq = 2 and p.owneruserid = cu.uid and cu.k >= 2;              
        SELECT ' 3 ';                                                                                                                             
        UPDATE churn_users cu, posts p   SET gap3 = p.gap_from_prev   WHERE p.post_seq = 3 and p.owneruserid = cu.uid and cu.k >= 3;              
        SELECT ' 4 ';                                                                                                                             
        UPDATE churn_users cu, posts p   SET gap4 = p.gap_from_prev   WHERE p.post_seq = 4 and p.owneruserid = cu.uid and cu.k >= 4;              
        SELECT ' 5 ';                                                                                                                             
        UPDATE churn_users cu, posts p   SET gap5 = p.gap_from_prev   WHERE p.post_seq = 5 and p.owneruserid = cu.uid and cu.k >= 5;              
        SELECT ' 6 ';                                                                                                                             
        UPDATE churn_users cu, posts p   SET gap6 = p.gap_from_prev   WHERE p.post_seq = 6 and p.owneruserid = cu.uid and cu.k >= 6;              
        SELECT ' 7 ';                                                                                                                             
        UPDATE churn_users cu, posts p   SET gap7 = p.gap_from_prev   WHERE p.post_seq = 7 and p.owneruserid = cu.uid and cu.k >= 7;              
        SELECT ' 8 ';                                                                                                                             
        UPDATE churn_users cu, posts p   SET gap8 = p.gap_from_prev   WHERE p.post_seq = 8 and p.owneruserid = cu.uid and cu.k >= 8;              
        SELECT ' 9 ';                                                                                                                             
        UPDATE churn_users cu, posts p   SET gap9 = p.gap_from_prev   WHERE p.post_seq = 9 and p.owneruserid = cu.uid and cu.k >= 9;              
        SELECT ' 10 ';                                                                                                                            
        UPDATE churn_users cu, posts p   SET gap10 = p.gap_from_prev   WHERE p.post_seq = 10 and p.owneruserid = cu.uid and cu.k >= 10;           
        SELECT ' 11 ';                                                                                                                            
        UPDATE churn_users cu, posts p   SET gap11 = p.gap_from_prev   WHERE p.post_seq = 11 and p.owneruserid = cu.uid and cu.k >= 11;           
        SELECT ' 12 ';                                                                                                                            
        UPDATE churn_users cu, posts p   SET gap12 = p.gap_from_prev   WHERE p.post_seq = 12 and p.owneruserid = cu.uid and cu.k >= 12;
        SELECT ' 13 ';
        UPDATE churn_users cu, posts p   SET gap13 = p.gap_from_prev   WHERE p.post_seq = 13 and p.owneruserid = cu.uid and cu.k >= 13;
        SELECT ' 14 ';
        UPDATE churn_users cu, posts p   SET gap14 = p.gap_from_prev   WHERE p.post_seq = 14 and p.owneruserid = cu.uid and cu.k >= 14;
        SELECT ' 15 ';
        UPDATE churn_users cu, posts p   SET gap15 = p.gap_from_prev   WHERE p.post_seq = 15 and p.owneruserid = cu.uid and cu.k >= 15;
        SELECT ' 16 ';
        UPDATE churn_users cu, posts p   SET gap16 = p.gap_from_prev   WHERE p.post_seq = 16 and p.owneruserid = cu.uid and cu.k >= 16;
        SELECT ' 17 ';
        UPDATE churn_users cu, posts p   SET gap17 = p.gap_from_prev   WHERE p.post_seq = 17 and p.owneruserid = cu.uid and cu.k >= 17;
        SELECT ' 18 ';
        UPDATE churn_users cu, posts p   SET gap18 = p.gap_from_prev   WHERE p.post_seq = 18 and p.owneruserid = cu.uid and cu.k >= 18;
        SELECT ' 19 ';
        UPDATE churn_users cu, posts p   SET gap19 = p.gap_from_prev   
            WHERE p.post_seq = 19 and p.owneruserid = cu.uid and cu.k >= 19;
        SELECT ' 20 ';
        UPDATE churn_users cu, posts p   SET gap20 = p.gap_from_prev   WHERE p.post_seq = 20 and p.owneruserid = cu.uid and cu.k >= 20;
        SELECT ' 21 ';
    END@@

delimiter $$
    DROP PROCEDURE IF EXISTS update_qrep$$

delimiter @@
CREATE PROCEDURE update_qrep()
    BEGIN
        select 'Hi';
        update churn_users cu set qrep1 = 
            (SELECT avg(questioner_rep) 
                FROM posts  force index(idx_posttypeid_owneruserid_post_seq_questioner_rep)
                WHERE posttypeid = 2 AND owneruserid = cu.uid AND post_seq <= cu.k
                AND questioner_rep <=67 ) where num_answers > 0;
        select 'Hi';

        update churn_users cu set qrep2 = 
            (SELECT avg(questioner_rep) 
                FROM posts  force index(idx_posttypeid_owneruserid_post_seq_questioner_rep)
                WHERE posttypeid = 2 AND owneruserid = cu.uid AND post_seq <= cu.k
                AND questioner_rep > 67 and questioner_rep <= 445) where num_answers > 0;
        
        select 'Hi';
        update churn_users cu set qrep3 = 
            (SELECT avg(questioner_rep) 
                FROM posts  force index(idx_posttypeid_owneruserid_post_seq_questioner_rep)
                WHERE posttypeid = 2 AND owneruserid = cu.uid AND post_seq <= cu.k
                AND questioner_rep > 446 and questioner_rep <= 1640) where num_answers > 0;
        select 'Hi';
        update churn_users cu set qrep4 = 
            (SELECT avg(questioner_rep) 
                FROM posts  force index(idx_posttypeid_owneruserid_post_seq_questioner_rep)
                WHERE posttypeid = 2 AND owneruserid = cu.uid AND post_seq <= cu.k
                AND questioner_rep > 1641) where num_answers > 0;
        select 'Hi';

END@@


delimiter $$
    DROP PROCEDURE IF EXISTS get_time_features$$


delimiter @@
CREATE PROCEDURE get_time_features(TT int(11)) 
BEGIN
    DECLARE num_churners int(11) default 0;

    SELECT count(*) 
        INTO num_churners
        FROM churn_time_users cu
        WHERE T = TT AND cu.churn_class_label = 1;
    
    IF num_churners > 50000 THEN
        SET num_churners = 50000;
    END IF;
    
    (SELECT
        `churn_time_users`.`churn_class_label`,
        `churn_time_users`.`num_posts`,
        `churn_time_users`.`num_questions`,
        `churn_time_users`.`num_answers`,
        `churn_time_users`.`num_answers_recvd`,
        `churn_time_users`.`a_score`,
        `churn_time_users`.`q_score`,
        `churn_time_users`.`a_score_stddev`,
        `churn_time_users`.`q_score_stddev`,
        `churn_time_users`.`relative_rank_pos`,
        `churn_time_users`.`answering_speed`,
        `churn_time_users`.`mean_rep_co_answerers`,
        `churn_time_users`.`mean_rep_answerers`,
        `churn_time_users`.`mean_rep_questioner`,
        `churn_time_users`.`time_for_first_ans`,
        `churn_time_users`.`a_q_ratio`,
        `churn_time_users`.`a_post_length`,
        `churn_time_users`.`q_post_length`,
        `churn_time_users`.`a_comments`,
        `churn_time_users`.`q_comments`,
        `churn_time_users`.`num_q_answered`,
        `churn_time_users`.`mean_max_rep_answerer`,
        `churn_time_users`.`mean_accepted_answerer_rep`,
        `churn_time_users`.`first_post_gap`,
        `churn_time_users`.`last_post_gap`,
        `churn_time_users`.`time_since_last_gap`,
        `churn_time_users`.`mean_gap`
    FROM `jagat`.`churn_time_users`
    WHERE T=TT
    AND churn_class_label = 1
    ORDER BY RAND()
    LIMIT 0, num_churners)
    
    UNION ALL
    (SELECT
        `churn_time_users`.`churn_class_label`,
        `churn_time_users`.`num_posts`,
        `churn_time_users`.`num_questions`,
        `churn_time_users`.`num_answers`,
        `churn_time_users`.`num_answers_recvd`,
        `churn_time_users`.`a_score`,
        `churn_time_users`.`q_score`,
        `churn_time_users`.`a_score_stddev`,
        `churn_time_users`.`q_score_stddev`,
        `churn_time_users`.`relative_rank_pos`,
        `churn_time_users`.`answering_speed`,
        `churn_time_users`.`mean_rep_co_answerers`,
        `churn_time_users`.`mean_rep_answerers`,
        `churn_time_users`.`mean_rep_questioner`,
        `churn_time_users`.`time_for_first_ans`,
        `churn_time_users`.`a_q_ratio`,
        `churn_time_users`.`a_post_length`,
        `churn_time_users`.`q_post_length`,
        `churn_time_users`.`a_comments`,
        `churn_time_users`.`q_comments`,
        `churn_time_users`.`num_q_answered`,
        `churn_time_users`.`mean_max_rep_answerer`,
        `churn_time_users`.`mean_accepted_answerer_rep`,
        `churn_time_users`.`first_post_gap`,
        `churn_time_users`.`last_post_gap`,
        `churn_time_users`.`time_since_last_gap`,
        `churn_time_users`.`mean_gap`
    FROM `jagat`.`churn_time_users`
        WHERE T=TT
        AND churn_class_label = -1
        ORDER BY RAND() 
        LIMIT 0, num_churners)
    ORDER BY churn_class_label;

END@@


delimiter $$
    DROP PROCEDURE IF EXISTS get_features$$

delimiter @@
CREATE PROCEDURE get_features(KK int(11)) 
BEGIN
    DECLARE num_churners int(11) default 0;

    SELECT count(*) 
        INTO num_churners
        FROM churn_users
        WHERE K = KK AND churn_class_label = 1;
    
    IF num_churners > 50000 THEN
        SET num_churners = 50000;
    END IF;
    
    (SELECT
        `churn_users`.`churn_class_label`,
        `churn_users`.`num_questions`,
        `churn_users`.`num_answers`,
        `churn_users`.`num_answers_recvd`,
        `churn_users`.`a_score`,
        `churn_users`.`q_score`,
        `churn_users`.`a_score_stddev`,
        `churn_users`.`q_score_stddev`,
        `churn_users`.`relative_rank_pos`,
        `churn_users`.`answering_speed`,
        `churn_users`.`mean_rep_co_answerers`,
        `churn_users`.`mean_rep_answerers`,
        `churn_users`.`mean_rep_questioner`,
        `churn_users`.`time_for_first_ans`,
        `churn_users`.`a_q_ratio`,
        `churn_users`.`a_post_length`,
        `churn_users`.`q_post_length`,
        `churn_users`.`a_comments`,
        `churn_users`.`q_comments`,
        `churn_users`.`num_q_answered`,
        `churn_users`.`mean_max_rep_answerer`,
        `churn_users`.`mean_accepted_answerer_rep`,
/*        `churn_users`.`qrep1`,
        `churn_users`.`qrep2`,
        `churn_users`.`qrep3`,
        `churn_users`.`qrep4`,
*/        `churn_users`.`gap1`,
        `churn_users`.`gap2`,
        `churn_users`.`gap3`,
        `churn_users`.`gap4`,
        `churn_users`.`gap5`,
        `churn_users`.`gap6`,
        `churn_users`.`gap7`,
        `churn_users`.`gap8`,
        `churn_users`.`gap9`,
        `churn_users`.`gap10`,
        `churn_users`.`gap11`,
        `churn_users`.`gap12`,
        `churn_users`.`gap13`,
        `churn_users`.`gap14`,
        `churn_users`.`gap15`,
        `churn_users`.`gap16`,
        `churn_users`.`gap17`,
        `churn_users`.`gap18`,
        `churn_users`.`gap19`,
        `churn_users`.`gap20`
    FROM `jagat`.`churn_users`
    WHERE K=KK 
    AND churn_class_label = 1
    ORDER BY RAND()
    LIMIT 0, num_churners)
    
    UNION ALL
    (SELECT
        `churn_users`.`churn_class_label`,
        `churn_users`.`num_questions`,
        `churn_users`.`num_answers`,
        `churn_users`.`num_answers_recvd`,
        `churn_users`.`a_score`,
        `churn_users`.`q_score`,
        `churn_users`.`a_score_stddev`,
        `churn_users`.`q_score_stddev`,
        `churn_users`.`relative_rank_pos`,
        `churn_users`.`answering_speed`,
        `churn_users`.`mean_rep_co_answerers`,
        `churn_users`.`mean_rep_answerers`,
        `churn_users`.`mean_rep_questioner`,
        `churn_users`.`time_for_first_ans`,
        `churn_users`.`a_q_ratio`,
        `churn_users`.`a_post_length`,
        `churn_users`.`q_post_length`,
        `churn_users`.`a_comments`,
        `churn_users`.`q_comments`,
        `churn_users`.`num_q_answered`,
        `churn_users`.`mean_max_rep_answerer`,
        `churn_users`.`mean_accepted_answerer_rep`,
/*        `churn_users`.`qrep1`,
        `churn_users`.`qrep2`,
        `churn_users`.`qrep3`,
        `churn_users`.`qrep4`,
*/        `churn_users`.`gap1`,
        `churn_users`.`gap2`,
        `churn_users`.`gap3`,
        `churn_users`.`gap4`,
        `churn_users`.`gap5`,
        `churn_users`.`gap6`,
        `churn_users`.`gap7`,
        `churn_users`.`gap8`,
        `churn_users`.`gap9`,
        `churn_users`.`gap10`,
        `churn_users`.`gap11`,
        `churn_users`.`gap12`,
        `churn_users`.`gap13`,
        `churn_users`.`gap14`,
        `churn_users`.`gap15`,
        `churn_users`.`gap16`,
        `churn_users`.`gap17`,
        `churn_users`.`gap18`,
        `churn_users`.`gap19`,
        `churn_users`.`gap20`
    FROM `jagat`.`churn_users`
        WHERE K=KK 
        AND churn_class_label = -1
        ORDER BY RAND() 
        LIMIT 0, num_churners)
    ORDER BY churn_class_label;

END@@


delimiter $$
    DROP PROCEDURE IF EXISTS update_time_feats_on_users$$

delimiter @@
CREATE PROCEDURE update_time_feats_on_users() 
BEGIN

    DECLARE six_months_b4_end datetime;
    SET six_months_b4_end = '2012-01-31 23:59:57';
    UPDATE users set week_after_creation = DATE_ADD(creationdate, INTERVAL 7 DAY);
    UPDATE users set fortnight_after_creation = DATE_ADD(creationdate, INTERVAL 15 DAY);
    UPDATE users set month_after_creation = DATE_ADD(creationdate, INTERVAL 30 DAY);

    UPDATE users u, posts p 
        SET u.first_post_date = p.creationdate
        WHERE u.id = p.owneruserid AND p.post_seq = 1;

    UPDATE users u SET u.pre_week_posts = 
        (SELECT count(*) FROM posts p 
            WHERE p.owneruserid = u.id 
                AND timestampdiff(WEEK, u.creationdate, p.creationdate) < 1);

    UPDATE users u SET u.post_week_halfyear_posts = 
        (SELECT count(*) FROM posts p 
            WHERE p.owneruserid = u.id 
                AND timestampdiff(DAY, 
                    week_after_creation, p.creationdate) < 180);

    UPDATE users u SET u.pre_fortnight_posts = 
        (SELECT count(*) FROM posts p 
            WHERE p.owneruserid = u.id 
                AND timestampdiff(DAY, u.creationdate, p.creationdate) < 15);

    UPDATE users u SET u.post_fortnight_halfyear_posts = 
        (SELECT count(*) FROM posts p 
            WHERE p.owneruserid = u.id 
                AND timestampdiff(DAY, 
                    fortnight_after_creation, p.creationdate) < 180);

    UPDATE users u SET u.pre_month_posts = 
        (SELECT count(*) FROM posts p 
            WHERE p.owneruserid = u.id 
                AND timestampdiff(DAY, u.creationdate, p.creationdate) < 30);

    UPDATE users u SET u.post_month_halfyear_posts = 
        (SELECT count(*) FROM posts p 
            WHERE p.owneruserid = u.id 
                AND timestampdiff(DAY, 
                    month_after_creation, p.creationdate) < 180);

    UPDATE users SET 
        post_week_halfyear_posts = post_week_halfyear_posts - pre_week_posts,
        post_fortnight_halfyear_posts = post_fortnight_halfyear_posts - pre_fortnight_posts,
        post_month_halfyear_posts = post_month_halfyear_posts - pre_month_posts;

    UPDATE users u SET u.week_churner = 
        IF(u.post_week_halfyear_posts = 0, 1, 0);
    UPDATE users u SET u.fortnight_churner = 
            IF(u.post_fortnight_halfyear_posts = 0, 1, 0);
    UPDATE users u SET u.month_churner = IF(u.post_month_halfyear_posts = 0, 1, 0);

    UPDATE users u SET u.week_churner = 2 WHERE 
        week_after_creation > six_months_b4_end;
    UPDATE users u SET u.fortnight_churner = 2 
        WHERE fortnight_after_creation > six_months_b4_end;
    UPDATE users u SET u.month_churner = 2 
        WHERE month_after_creation > six_months_b4_end;


    UPDATE users u SET u.week_churner = 3 WHERE 
        pre_week_posts = 0 and post_week_halfyear_posts = 0;

    UPDATE users u SET u.fortnight_churner = 3 WHERE 
        pre_fortnight_posts = 0 and post_fortnight_halfyear_posts = 0;

    UPDATE users u SET u.month_churner = 3 WHERE 
        pre_month_posts = 0 and post_month_halfyear_posts = 0;

    UPDATE posts p1, posts p2, users u
        SET p1.rep_answerers = 
            ((p2.answercount*p2.rep_answerers) - u.reputation)/(p2.answercount - 1)
        WHERE p1.parentid = p2.id
        AND p1.owneruserid = u.id AND p2.answercount <> 1
        AND p1.posttypeid = 2;

END@@

delimiter $$
    DROP PROCEDURE IF EXISTS insert_churn_time_users$$

delimiter @@
CREATE PROCEDURE insert_churn_time_users() 
BEGIN
    DECLARE last_posttime datetime;
    SET last_posttime = '2012-01-31 23:59:57';

    INSERT INTO churn_time_users(T, churner, uid, observation_time_deadline) 
        SELECT '7' , week_churner, id, week_after_creation
            FROM users WHERE pre_week_posts > 0 and week_churner in(0, 1);
      
    INSERT INTO churn_time_users(T, churner, uid, observation_time_deadline) 
        SELECT '15' , fortnight_churner, id, fortnight_after_creation
            FROM users WHERE pre_fortnight_posts > 0 and fortnight_churner in(0,1);

    INSERT INTO churn_time_users(T, churner, uid, observation_time_deadline) 
        SELECT '30', month_churner, id, month_after_creation
            FROM users WHERE pre_month_posts > 0 and month_churner in(0,1);

END@@


delimiter $$
    DROP PROCEDURE IF EXISTS update_churn_time_feats$$

delimiter @@
CREATE PROCEDURE update_churn_time_feats() 
BEGIN
    set @norm = 0;
    set @norm = @norm + 1;
    select @norm;
    UPDATE churn_time_users cu, users u 
        SET cu.period_after_creation = 
            (CASE WHEN T = 7 THEN week_after_creation
                  WHEN T = 15 THEN fortnight_after_creation
                  WHEN T = 30 THEN month_after_creation end) 
        WHERE u.id = cu.uid;

    set @norm = @norm + 1;
    select @norm;


    UPDATE churn_time_users cu SET cu.num_posts = (
        SELECT count(*) FROM posts p 
            WHERE owneruserid = cu.uid AND creationdate < cu.period_after_creation);
    
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
    UPDATE churn_time_users cu, posts p, users u 
        SET time_since_last_gap = 
            timestampdiff(MINUTE, p.creationdate, 
                DATE_ADD(u.creationdate, INTERVAL T DAY))
        WHERE post_seq = cu.num_posts 
            and cu.uid = p.owneruserid and cu.uid = u.id;

    set @norm = @norm + 1;
    select @norm;
    UPDATE churn_time_users cu
        SET mean_gap = 
           (SELECT avg(gap_from_prev) 
                FROM posts
                WHERE owneruserid = cu.uid
                AND post_seq > 1 and post_seq <= cu.num_posts);

    set @norm = @norm + 1;
    select @norm;
    UPDATE churn_time_users cu
        SET num_answers_recvd = 
        (select avg(answercount) 
            from posts  force index(idx_posttypeid_owneruserid_post_seq)
            where posttypeid = 1
            and owneruserid = cu.uid 
            and post_seq <= cu.num_posts);
     

    set @norm = @norm + 1;
    select @norm;
    update churn_time_users cu set mean_rep_co_answerers =    
        (select avg(rep_answerers) from posts 
                force index(idx_posttypeid_owneruserid_post_seq)
            where posttypeid = 2
            and owneruserid = cu.uid 
            and post_seq <= cu.num_posts);

    set @norm = @norm + 1;
    select @norm;
    update churn_time_users cu set churn_class_label =    
        IF(churner=1, 1, -1);
    
    
END@@


delimiter $$
    DROP PROCEDURE IF EXISTS get_time_features$$


delimiter @@
CREATE PROCEDURE get_time_features(TT int(11)) 
BEGIN
    DECLARE num_churners int(11) default 0;

    SELECT count(*) 
        INTO num_churners
        FROM churn_time_users cu
        WHERE T = TT AND cu.churn_class_label = 1;
    
    IF num_churners > 150000 THEN
        SET num_churners = 150000;
    END IF;
    
    (SELECT
        `churn_time_users`.`churn_class_label`,
        `churn_time_users`.`num_posts`,
        `churn_time_users`.`num_questions`,
        `churn_time_users`.`num_answers`,
        `churn_time_users`.`num_answers_recvd`,
        `churn_time_users`.`a_score`,
        `churn_time_users`.`q_score`,
        `churn_time_users`.`a_score_stddev`,
        `churn_time_users`.`q_score_stddev`,
        `churn_time_users`.`relative_rank_pos`,
        `churn_time_users`.`answering_speed`,
        `churn_time_users`.`mean_rep_co_answerers`,
        `churn_time_users`.`mean_rep_answerers`,
        `churn_time_users`.`mean_rep_questioner`,
        `churn_time_users`.`time_for_first_ans`,
        `churn_time_users`.`a_q_ratio`,
        `churn_time_users`.`a_post_length`,
        `churn_time_users`.`q_post_length`,
        `churn_time_users`.`a_comments`,
        `churn_time_users`.`q_comments`,
        `churn_time_users`.`num_q_answered`,
        `churn_time_users`.`mean_max_rep_answerer`,
        `churn_time_users`.`mean_accepted_answerer_rep`,
        `churn_time_users`.`first_post_gap`,
        `churn_time_users`.`last_post_gap`,
        `churn_time_users`.`time_since_last_gap`,
        `churn_time_users`.`mean_gap`
    FROM `jagat`.`churn_time_users`
    WHERE T=TT
    AND churn_class_label = 1
    ORDER BY RAND()
    LIMIT 0, num_churners)
    
    UNION ALL
    (SELECT
        `churn_time_users`.`churn_class_label`,
        `churn_time_users`.`num_posts`,
        `churn_time_users`.`num_questions`,
        `churn_time_users`.`num_answers`,
        `churn_time_users`.`num_answers_recvd`,
        `churn_time_users`.`a_score`,
        `churn_time_users`.`q_score`,
        `churn_time_users`.`a_score_stddev`,
        `churn_time_users`.`q_score_stddev`,
        `churn_time_users`.`relative_rank_pos`,
        `churn_time_users`.`answering_speed`,
        `churn_time_users`.`mean_rep_co_answerers`,
        `churn_time_users`.`mean_rep_answerers`,
        `churn_time_users`.`mean_rep_questioner`,
        `churn_time_users`.`time_for_first_ans`,
        `churn_time_users`.`a_q_ratio`,
        `churn_time_users`.`a_post_length`,
        `churn_time_users`.`q_post_length`,
        `churn_time_users`.`a_comments`,
        `churn_time_users`.`q_comments`,
        `churn_time_users`.`num_q_answered`,
        `churn_time_users`.`mean_max_rep_answerer`,
        `churn_time_users`.`mean_accepted_answerer_rep`,
        `churn_time_users`.`first_post_gap`,
        `churn_time_users`.`last_post_gap`,
        `churn_time_users`.`time_since_last_gap`,
        `churn_time_users`.`mean_gap`
    FROM `jagat`.`churn_time_users`
        WHERE T=TT
        AND churn_class_label = -1
        ORDER BY RAND() 
        LIMIT 0, num_churners)
    ORDER BY churn_class_label;

END@@

