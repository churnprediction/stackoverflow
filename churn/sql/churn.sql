
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

select count(*) from churn_users;
desc churn_users;
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

select churner, k, avg(relative_rank_pos) 
from churn_users 
group by churner, k
order by churner, k ;

select uid,
gap1, mean_accepted_answerer_rep, a_post_length,
time_for_first_ans, q_comments
 from churn_users where gap1 > 0.5 
and mean_accepted_answerer_rep <= 0.5 or mean_accepted_answerer_rep  is null
and a_post_length <= 75.5
and time_for_first_ans > 41936
and q_comments <= 1.5 limit 0,1;
select * from users where id = 4124;
select * from churn_users;

select churner, k, avg(a_post_length) from churn_users
where a_post_length < 2000
group by  churner, k
order by  churner, k;

select posttypeid, sum(score) from posts
group by posttypeid;
/*5163895, 128052718*/
select posttypeid, avg(score) from posts where score > 0
group by posttypeid;

select posttypeid, count(*) from posts where score > 0
group by posttypeid;

select churner, T, avg(mean_accepted_answerer_rep)
from churn_time_users
group by churner, T
order by churner, T;

select creationdate from posts where owneruserid=1 order by creationdate ;
select count(*) from posts where posttypeid = 1 and answercount > 0;

/*3153790*/
Select count(*) from posts where posttypeid = 1 ;
desc posts;

select time_for_first_ans, count(*) from posts
where posttypeid = 1 and answercount > 0 and time_for_first_ans >= 0
group by time_for_first_ans
order by time_for_first_ans;
/*2010-05-24 11:16:15, 11:20:19*/
select * from posts where time_for_first_ans = 2 limit 0,2;
select * from posts where parentid=414137; /*2009-01-05 19:05:26*/
select count(*) from users;
desc temp_min;
create table temp_min
select parentid, min(minutes_from_ques)
from posts group by parentid
order by parentid;
select count(*) from temp_min;
create index idx_temp_min_parentid on temp_min(parentid);
update posts p1,  temp_min m1 set 
p1.time_for_first_ans = m1.`min(minutes_from_ques)`
where p1.id = m1.parentid;
;
select max(creationdate) from posts;

select posttypeid, count(*) from posts where  post_seq=1 group by posttypeid;