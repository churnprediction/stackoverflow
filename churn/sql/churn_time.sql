select timestampdiff(WEEK, '2013-05-02', '2013-05-8');

select * from users;

select max(creationdate) from posts;

update users set pre_week_posts = '7' where id = -1;


    INSERT INTO churn_time_uses(time, churner, uid)
        SELECT '7' time, week_churner, id
            FROM users WHERE week_churner != 2;

create table temp(a int(1));
insert into temp select '7'  from users where id = -1;
select * from temp;

select count(*) from users where week_churner is null;
select count(*) from users where week_churner = 1;

select count(*) from churn_time_users;
select * from churn_time_users;
select count(*) from churn_time_users cu, users u where u.id = cu.uid and u.numposts = 0;

    UPDATE churn_time_users cu, users u 
        SET cu.period_after_creation = 
            (CASE WHEN T = 7 THEN week_after_creation
                  WHEN T = 15 THEN fortnight_after_creation
                  WHEN T = 30 THEN month_after_creation end);
show processlist;
kill 1714;

select count(*) from churn_time_users;
select * from churn_time_users;
select count(*) from churn_time_users where churner = 0;
select count(*) from users where week_churner = 1;

SELECT '7' , week_churner, id
            FROM users WHERE week_churner != 2;

call insert_churn_time_users();
call update_churn_time_feats();

show warnings;
select * from posts;

update ptemp  ffp
    set rep_co_answerers = 
    (select (rep_answerers - u.reputation)/(ffp.answercount-1) 
        from posts p force index(idx_parentid_owneruserid), users u 
        where ffp.parentid = id and ffp.owneruserid = u.id) 
    where ffp.posttypeid = 2;

UPDATE posts SET rep_answerers = null WHERE posttypeid = 2;

UPDATE posts p1, posts p2, users u
    SET p1.rep_answerers = 
        ((p2.answercount*p2.rep_answerers) - u.reputation)/(p2.answercount - 1)
    WHERE p1.parentid = p2.id
    AND p1.owneruserid = u.id AND p2.answercount <> 1
    AND p1.posttypeid = 2;

select sum(reputation) from users where id in (select owneruserid from posts where parentid = 19);


    update churn_time_users cu set mean_rep_co_answerers =    
        (select avg(rep_answerers) from posts 
                force index(idx_posttypeid_owneruserid_post_seq)
            where posttypeid = 2
            and owneruserid = cu.uid 
            and post_seq <= cu.num_posts);

select * from churn_time_users;

update churn_time_users set churn_class_label = -1 where churner = 0;

   set @norm = @norm + 1;
    select @norm;
    UPDATE churn_time_users cu
        SET mean_gap = 
           (SELECT avg(gap_from_prev) 
                FROM posts
                WHERE owneruserid = cu.uid
                AND post_seq <= cu.num_posts);


    SELECT count(*) 
        FROM churn_time_users
        WHERE T = 30 AND churn_class_label = 1;
    
call get_time_features(30);
select count(*) from churn_time_users where churner = 0;
select count(*) from churn_time_users;

select fortnight_churner, count(*) from users group by fortnight_churner;
select churner, count(*) from churn_time_users group by churner;



    INSERT INTO churn_time_users(T, churner, uid, observation_time_deadline) 
        SELECT '45' , week_churner, id, week_after_creation
            FROM users WHERE pre_week_posts > 0 and week_churner != 2;
select churner, count(*) from churn_time_users where T=45 group by churner;

select distinct(week_churner) from (
    SELECT  week_churner, id, week_after_creation
            FROM users WHERE pre_week_posts > 0 and week_churner != 2
)d;
    SELECT  month_churner, avg(pre_month_posts)
            FROM users where month_churner != 2 group by month_churner;


select timestampdiff(WEEK, '2012-01-27 23:59:57', '2012-01-31 23:59:57');
select id, creationdate from users where week_churner = 1 limit 0, 20;
select creationdate from posts where owneruserid = 16 order by creationdate limit 1, 3 ;


SELECT * from users u WHERE u.pre_week_posts = (
    SELECT count(*) FROM posts p 
                WHERE p.owneruserid = u.id 
                    AND timestampdiff(WEEK, u.creationdate, p.creationdate) < 1 );

select count(*) from users u, posts p where month_churner = 1 ;


select month_churner, avg(pre_week_posts), count(*) from users group by month_churner;

delete from churn_time_users;
select timestampdiff(day, creationdate, week_after_creation) from users limit 0, 20;

select max(creationdate) from users where week_churner = 2 limit 0, 10;

select week_churner, pre_week_posts from users 
where week_churner = 1
group by week_churner, pre_week_posts;

select min(timestampdiff(day, creationdate, first_post_date))
    from users where fortnight_churner = 0 and creationdate <= first_post_date;

select count(*) from users where numposts = 0;

UPDATE users 
    SET days_before_first_post = timestampdiff(day, creationdate, first_post_date)
    WHERE numposts > 0;

select id  from users u where days_before_first_post <= 7 
    and numposts > 0 and (select count(*) from posts p where owneruserid = u.id
          and p.creationdate <= u.week_after_creation) > 0 and 
            (select count(*) from posts p where owneruserid = u.id
                and p.creationdate > u.week_after_creation 
                and p.creationdate <= date_add(u.creationdate, INTERVAL 187 DAY)) =0 ;
select creationdate from users where id = 8;
/*'2008-07-31 21:33:24'*/
select id, creationdate, post_seq from posts where owneruserid = 8 order by post_seq;

select count(*) from users where pre_week_posts > 0;

    UPDATE users u SET u.post_week_halfyear_posts = 
        (SELECT count(*) FROM posts p 
            WHERE p.owneruserid = u.id 
                AND timestampdiff(DAY, 
                    week_after_creation, p.creationdate) < 180);

select timestampdiff(DAY, 
                    u.week_after_creation, p.creationdate)
from posts p , users u where u.id = 8 and p.owneruserid = u.id;

SELECT count(*) FROM posts p , users u
            WHERE p.owneruserid = u.id
                AND timestampdiff(DAY, 
                    week_after_creation, p.creationdate) < 180; 

select * from users ;

select T, churner, count(*) 
from churn_time_users group by T, churner order by T, churner;

    update churn_time_users cu set churn_class_label =    
        IF(churner=1, 1, -1);

select count(*) from users where week_churner = 0;
select * from churn_time_users ;

select timestampdiff(MINUTE, p.creationdate, 
                DATE_ADD(u.creationdate, INTERVAL 7 DAY))
from posts p, users u
where p.owneruserid = 8 and u.id = 8 and p.post_seq = u.numposts;

     
        select distinct 
            timestampdiff(MINUTE, p.creationdate, 
                DATE_ADD(u.creationdate, INTERVAL T DAY))
            from churn_time_users cu, posts p, users u 
        WHERE post_seq = cu.num_posts and cu.uid = p.owneruserid and cu.uid = u.id and u.id=8;

    UPDATE churn_time_users cu, posts p, users u 
        SET cu.time_since_last_gap = 
            timestampdiff(MINUTE, p.creationdate, 
                DATE_ADD(u.creationdate, INTERVAL cu.T DAY))
        WHERE p.post_seq = cu.num_posts and cu.uid = p.owneruserid and cu.uid = u.id;

    UPDATE churn_time_users cu
        SET mean_gap = 
           (SELECT avg(gap_from_prev) 
                FROM posts
                WHERE owneruserid = cu.uid
                AND post_seq > 1 and post_seq <= cu.num_posts);



    UPDATE churn_time_users cu
        SET mean_gap = 
           (SELECT avg(gap_from_prev) 
                FROM posts
                WHERE owneruserid = cu.uid
                AND post_seq > 1 and post_seq <= cu.num_posts);

    UPDATE churn_time_users cu
        SET num_answers_recvd = 
        (select avg(answercount) 
            from posts  force index(idx_posttypeid_owneruserid_post_seq)
            where posttypeid = 1
            and owneruserid = cu.uid 
            and post_seq <= cu.num_posts);

        update posts p1, posts p2
            set p1.accepted = 1 
            where p1.parentid = p2.id 
            and p2.acceptedanswerid = p1.id;


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

select numposts, avg(accepted_answers/num_answers)
from users where num_answers > 0
group by numposts;


select num_answers, avg(accepted_answers/num_answers)
from users where num_answers > 0
group by num_answers;

select numposts, avg(num_answers/numposts)
from users where numposts > 0
group by numposts;
