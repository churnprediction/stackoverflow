
update users u set LastPostDate = 
    (select max(creationdate) from posts force index(idx_owneruserid) where u.id = owneruserid);


update users u set u.NumPosts = 
    (select count(*) from posts force index(idx_owneruserid) where owneruserid = u.id);


insert into churn_users(uid) select id from users where NumPosts >= 1 ; 
update churn_users set k=1 where uid is not null;

update churn_users cu, users u set cu.NumPosts = u.NumPosts where u.id = cu.uid;
update churn_users set churned = 1 where NumPosts = 1;


select count(*) from post_temp;

update posts p1
    set p1.post_seq = 
        (select count(*) from post_temp force index(idx_posttemp_ouid_id)
        where id <= p1.id and owneruserid = p1.owneruserid);


SELECT  max(creationdate)  from posts;

set @K = 5;

delete from churn_users;

set @now = '2012-07-31 23:59:57';

select @K;
select @now;

insert into churn_users(uid, kth_postid) 
    SELECT owneruserid, p.id FROM posts p, users u where post_seq = @K
    AND timestampdiff(MONTH, p.creationdate, @now) > 6 
    AND u.id = p.owneruserid and u.NumPosts = @K;
select count(*) from users where numposts = 1;
select count(*) from users where numposts = 5;
update churn_users set churnedbygap = -1 where churnedbygap is null;

insert into churn_users(uid, kth_postid) 
    SELECT p1.owneruserid, p1.id FROM posts p1, posts p2 
    where p1.post_seq = @K AND p2.post_seq = @K+1
    AND p1.owneruserid = p2.owneruserid
    AND timestampdiff(MONTH, p1.creationdate, p2.creationdate) > 6;

update churn_users set churnedbygap = 1 where churnedbygap is null;
update churn_users set churner = 1 where churner is null;

insert into churn_users(uid, kth_postid) 
    SELECT p1.owneruserid, p1.id FROM posts p1, posts p2 
    where p1.post_seq = @K AND p2.post_seq = @K+1
    AND p1.owneruserid = p2.owneruserid
    AND timestampdiff(MONTH, p1.creationdate, p2.creationdate) <= 6;

update churn_users set churnedbygap = 1 where churnedbygap is null;
update churn_users set churner = -1 where churner is null;

update churn_users set K = @k where K is null;
select count(*) from (select distinct uid from churn_users) x; /*695952*/
select count(*) from churn_users;

select * from churn_users; /*695952*/
show warnings;

show processlist;
select distinct(K) from churn_users;

select count(*) from churn_users where k=19;

select id from posts where owneruserid = 8 limit 0,10;

SELECT churner, AnswerCount 
    FROM churn_users cu, posts p
    WHERE cu.kth_postid = p.id
    AND cu.k = 1 AND p.posttypeid = 1 AND churner = 1 order by rand() limit 180000;


select max(answercount) from posts;

UPDATE churn_users cu
    SET num_questions = 
        (SELECT count(*) 
            FROM posts p WHERE p.id <= cu.kth_postid
            AND posttypeid = 1) WHERE k = 5;
UPDATE churn_users cu set num_questions = 0 where num_questions is null and k = 5;

select count(*) from posts where post_seq = 0;