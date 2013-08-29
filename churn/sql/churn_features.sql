/*
    add column a_score int(11),
    add column q_score int(11),
    add column a_score_stddev int(11),
    add column q_score_stddev int(11),
    add column relative_rank_pos int(11),
    add column answering_speed int(11),

    add column time_for_first_ans int(11),

    add column tot_comments int(11),
    add column mean_rep_co_answerers int(11),
    add column mean_rep_answerers int(11),
    add column mean_rep_questioner int(11),
    add column a_q_ratio float(11),
    add column a_post_length int(11),
    add column q_post_length int(11);
*/
update churn_users cu set a_score =    
    (select avg(score) from posts 
        where posttypeid = 2
        and owneruserid = cu.uid 
        and post_seq <= cu.k);

update churn_users cu set q_score =    
    (select avg(score) from posts 
        where posttypeid = 1
        and owneruserid = cu.uid 
        and post_seq <= cu.k);

update churn_users cu set a_score_stddev =    
    (select stddev(score) from posts 
        where posttypeid = 2
        and owneruserid = cu.uid 
        and post_seq <= cu.k);

update churn_users cu set q_score_stddev =    
    (select stddev(score) from posts 
        where posttypeid = 1
        and owneruserid = cu.uid 
        and post_seq <= cu.k);


update ptemp ffp set rank = 
    (select count(*) from posts 
        force index(idx_posts_posttypeid_parentId_score) where parentId = ffp.parentId 
        and score >= ffp.score and posttypeid = 2);


update posts p, ptemp p1 set p.answer_rank = p1.rank where p.id = p1.id;
select * from posts where posttypeid = 2;
select count(*) from posts where answer_rank is not null and posttypeid = 2;
select distinct answer_rank from posts where posttypeid = 1;
select count(distinct rank) from ptemp;

select distinct(rank) from ptemp;

update posts p1 force index(idx_posts_parentid), posts p2 force index(idx_posts_parentid)
set p1.parent_answer_count = p2.answercount
where p1.parentId = p2.id ;

UPDATE churn_users cu SET relative_rank_pos = 
    (SELECT  round(avg(parent_answer_count/answer_rank))
        FROM posts p force index(idx_posts_owneruserid_rank_answer_post_seq)
        WHERE p.owneruserid = cu.uid
        AND answer_rank is not null
        AND p.post_seq <= cu.k and p.posttypeid = 2) WHERE num_answers > 0;




SELECT  answercount
        FROM posts p force index(idx_posts_owneruserid_rank_answer_post_seq)
        WHERE answer_rank is not null
        AND p.post_seq <= 1 and p.posttypeid = 2 and owneruserid = 4;

desc churn_users;
select count(*) from posts where answer_rank = 0 and posttypeid = 2;
select * from churn_users;
UPDATE posts p1, posts p2
    SET p2.minutes_from_ques = 
        timestampdiff(MINUTE, p1.creationdate, p2.creationdate)
        WHERE p2.parentId = p1.id AND 
        p2.posttypeid = 2 AND p1.posttypeid = 1;
create index idx_posttypeid_owneruserid_post_seq on posts(posttypeid, owneruserid, post_seq);

UPDATE churn_users cu 
    SET answering_speed = 
        (SELECT AVG(minutes_from_ques) FROM posts force index(idx_posttypeid_owneruserid_post_seq)
            WHERE posttypeid = 2 and cu.uid = owneruserid
            AND post_seq <= cu.k) WHERE num_answers > 0;

create index idx_parentid_posttypeid_post_seq on posts(parentid, posttypeid, post_seq);
set @marker = 1;
select @marker;
UPDATE ptemp p1
    SET p1.score = 
        (SELECT MIN(minutes_from_ques) FROM posts p2 force index(idx_parentid_posttypeid_post_seq)
            WHERE p2.parentId = p1.id AND 
            p2.posttypeid = 2);
select @marker;
update posts p1, ptemp p2 set p1.time_for_first_ans = p2.score where p1.id = p2.id
    and p2.parentid is null;
select @marker;

UPDATE churn_users cu 
    SET time_for_first_ans = 
        (SELECT AVG(time_for_first_ans) FROM posts  
            force index(idx_posttypeid_owneruserid_post_seq)
            WHERE posttypeid = 1 and cu.uid = owneruserid
            AND post_seq <= cu.k) WHERE num_questions > 0;
select @marker;
update posts ffp set num_comments = 
    (select count(*) from comments force index(idx_comments_postid) where postid = ffp.id);
select @marker;
alter table churn_users drop column tot_comments;
select @marker;
alter table churn_users add column a_comments int(11);
alter table churn_users add column q_comments int(11);
/*select @marker;
update churn_users cu set a_comments = 
    (select avg(num_comments) from posts force index(idx_posttypeid_owneruserid_post_seq)
            where posttypeid = 2 and cu.uid = owneruserid
            AND post_seq <= cu.k);
select @marker;
update churn_users cu set q_comments = 
    (select avg(num_comments) from posts force index(idx_posttypeid_owneruserid_post_seq)
            where posttypeid = 1 and cu.uid = owneruserid
            AND post_seq <= cu.k);
select count(*) from ptemp;
select @marker;
update ptemp  ffp
    set score = 
    (select sum(u.reputation) 
        from users u, posts p force index(idx_parentid_owneruserid)
        where p.parentid = ffp.id
            and  p.owneruserid = u.id ) where ffp.posttypeid = 1;

update posts p1, ptemp p2 set p1.time_for_first_ans = p2.score where p1.id = p2.id
    and p2.parentid is null;

select @marker;
update ptemp  ffp
    set rep_co_answerers = 
    (select (rep_answerers - u.reputation)/(ffp.answercount-1) 
        from posts p force index(idx_parentid_owneruserid), users u 
        where ffp.parentid = id and ffp.owneruserid = u.id) 
    where ffp.posttypeid = 2;

alter table ptemp add column rep_co_answerers;
select @marker;

update posts p1, ptemp p2 set p1.rep_answerers = p2.score where p1.id = p2.id
    and p2.parentid is null;

select @marker;

update posts  ffp
    set rep_answerers = rep_answerers/answercount where posttypeid = 1;

update posts  ffp, users u
    set rep_questioner = u.reputation where ffp.posttypeid = 1 and ffp.owneruserid = u.id;

update posts  p1, posts p2
    set p1.rep_questioner = p2.rep_questioner
    where p1.posttypeid = 2 and p1.parentid = p2.id;


update churn_users cu set mean_rep_questioner = 
    (SELECT avg(rep_questioner) from posts  force index(idx_posttypeid_owneruserid_post_seq)
        WHERE  posttypeid = 2 AND owneruserid = cu.uid and post_seq <= cu.k)
    where num_answers > 0;

update churn_users cu set mean_rep_co_answerers = 
    (select avg(rep_answerers) 
        from posts  force index(idx_posttypeid_owneruserid_post_seq)
        where posttypeid = 2 and cu.uid = owneruserid and post_seq <= cu.k) 
    where num_answers > 0;

update churn_users cu set mean_rep_answerers = 
    (select avg(rep_answerers) 
        from posts  force index(idx_posttypeid_owneruserid_post_seq)
        where posttypeid = 1 and cu.uid = owneruserid and post_seq <= cu.k) 
    where num_questions > 0;


update churn_users set a_q_ratio = (num_answers+1)/(num_questions+1);

update posts set post_length =  length(body);
update churn_users cu set a_post_length = 
    (select avg(length(body)) from posts  force index(idx_posttypeid_owneruserid_post_seq)
    where posttypeid = 2 and owneruserid = cu.uid 
    AND post_seq <= cu.k) where num_answers > 0;


update churn_users cu set q_post_length = 
    (select avg(length(body)) from posts  force index(idx_posttypeid_owneruserid_post_seq)
        where posttypeid = 1 and owneruserid = cu.uid 
    AND post_seq <= cu.k) where num_questions > 0;


update posts p1, posts p2 set p2.gap_from_prev = 
    timestampdiff(MINUTE, p1.creationdate, p2.creationdate) 
    where p1.post_seq = p2.post_seq - 1 
        and p1.owneruserid = p2.owneruserid;

*/


update posts p1, users u set gap_from_prev = 
    timestampdiff(MINUTE, u.creationdate, p1.creationdate) 
    where p1.post_seq = 1
        and p1.owneruserid = u.id;

call update_timegaps();

select * from churn_users;

update churn_users cu set cu.num_q_answered = 
    (SELECT count(*) FROM posts WHERE owneruserid = cu.uid
        AND posttypeid = 1 AND post_seq <= cu.k
        AND AnswerCount > 0) WHERE num_questions > 0;

SELECT num_answers, num_q_answered, sum(churner), count(*) 
    FROM churn_users
    WHERE num_questions = 5
    GROUP BY num_answers, num_q_answered
    ORDER BY num_answers, num_q_answered;

select distinct(num_q_answered) from churn_users;

select score, count(*) from posts group by score order by score;
select count(*) from posts where score <= 5;

SELECT churner, k, sum(p.score > 0)/count(*)
FROM churn_users cu, posts p
WHERE cu.uid = p.owneruserid
AND p.post_seq <= cu.k
AND posttypeid = 2
GROUP BY churner, k
ORDER BY churner, k;

SELECT churner, k, avg(p.score)
FROM churn_users cu, posts p
WHERE cu.uid = p.owneruserid
AND p.post_seq <= cu.k
AND posttypeid = 2
AND p.score > 0
GROUP BY churner, k
ORDER BY churner, k;



SELECT churner, k, sum(p.score > 0)/count(*)
FROM churn_users cu, posts p
WHERE cu.uid = p.owneruserid
AND p.post_seq <= cu.k
AND posttypeid = 1
GROUP BY churner, k
ORDER BY churner, k;


update ptemp p set score = 
    (SELECT max(u.reputation) FROM users u, posts pt force index(idx_parentid_owneruserid)
      WHERE pt.parentid = p.id and pt.owneruserid = u.id) where p.posttypeid = 1;

update posts p, ptemp pt set p.max_rep_answerer = pt.score where p.id = pt.id;

update churn_users cu set mean_max_rep_answerer = 
    (SELECT avg(max_rep_answerer) 
        FROM posts force index(idx_posttypeid_owneruserid_post_seq)
        WHERE posttypeid = 1 AND owneruserid = cu.uid AND post_seq <= cu.k)
    WHERE num_questions > 0;


update posts p1, posts p2, users u
    set p1.accepted_answerer_rep = u.reputation
        where p1.acceptedanswerid = p2.id
        and p2.owneruserid = u.id;

update churn_users cu set mean_accepted_answerer_rep = 
    (SELECT avg(accepted_answerer_rep) 
        FROM posts  force index(idx_posttypeid_owneruserid_post_seq)
        WHERE posttypeid = 1 AND owneruserid = cu.uid AND post_seq <= cu.k)
    WHERE num_questions > 0;

SELECT churner, k, avg(mean_max_rep_answerer)
FROM churn_users cu
GROUP BY churner, k
ORDER BY churner, k;


SELECT churner, k, avg(mean_accepted_answerer_rep)
FROM churn_users cu
GROUP BY churner, k
ORDER BY churner, k;

select churner, num_questions, avg(mean_accepted_answerer_rep)
FROM churn_users cu
GROUP BY churner, num_questions
ORDER BY churner, num_questions;

select reputation, count(*)/1295620
from users
group by reputation order by reputation;

select count(*) from users;
select max(questioner_rep) from posts;

update posts p1, posts p2, users u
    set p1.questioner_rep = u.reputation
        where p1.parentid = p2.id
        and p2.owneruserid = u.id and p1.posttypeid = 2;

update churn_users cu set qrep1 = 
    (SELECT avg(question_rep) 
        FROM posts  force index(idx_posttypeid_owneruserid_post_seq_questioner_rep)
        WHERE posttypeid = 2 AND owneruserid = cu.uid AND post_seq <= cu.k
        AND questioner_rep <=1 ) where num_answers > 0;


update churn_users cu set qrep2 = 
    (SELECT avg(question_rep) 
        FROM posts  force index(idx_posttypeid_owneruserid_post_seq_questioner_rep)
        WHERE posttypeid = 2 AND owneruserid = cu.uid AND post_seq <= cu.k
        AND questioner_rep > 1 and questioner_rep <= 11) where num_answers > 0;


update churn_users cu set qrep3 = 
    (SELECT avg(question_rep) 
        FROM posts  force index(idx_posttypeid_owneruserid_post_seq_questioner_rep)
        WHERE posttypeid = 2 AND owneruserid = cu.uid AND post_seq <= cu.k
        AND questioner_rep > 11 and questioner_rep <= 95) where num_answers > 0;

update churn_users cu set qrep4 = 
    (SELECT avg(question_rep) 
        FROM posts  force index(idx_posttypeid_owneruserid_post_seq_questioner_rep)
        WHERE posttypeid = 2 AND owneruserid = cu.uid AND post_seq <= cu.k
        AND questioner_rep > 95) where num_answers > 0;


alter table churn_users 
    add column qrep1 int(11),
    add column qrep2 int(11),
    add column qrep3 int(11),
    add column qrep4 int(11);

call update_qrep();

select * from churn_users;
select id, questioner_rep from posts where posttypeid = 2;

select questioner_rep, count(*)
    from posts where posttypeid = 2 and questioner_rep is not null
    group by questioner_rep;


select count(*) 
    from posts where posttypeid = 2 and questioner_rep is not null;


select count(*) from posts where  posttypeid = 2 and questioner_rep is not null;

select count(*) from (select distinct uid from churn_users) cu
where (select count(*) from posts where cu.uid = owneruserid 
    and questioner_rep is null and posttypeid = 2);

select count(*) from posts p, users u where 
p.owneruserid = u.id and posttypeid = 1 and u.reputation is null;

select * from churn_users where k = 1 and gap2 is not null and churner=1;
select count(*) from churn_users where churnedbygap = -1;
select churner, k, avg(qrep4) 
    from churn_users
    group by churner, k 
    order by churner, k;

select churner, k, avg(gap2) 
    from churn_users
    group by churner, k 
    order by churner, k;

select churner, k, avg(gap2 ) from churn_users 
where churner = 0 or churnedbygap = -1 group by churner, k order by churner, k;

select uid, gap2  from churn_users 
where k = 1 and churner = 0 order by gap2;
select creationdate from posts where owneruserid = 907628 and post_seq <= 1;
select creationdate from users where id = 907628;
select uid, gap2 from churn_users where k = 1 and churner = 0;
show processlist;

SELECT k, churner, AVG(gap1), AVG(gap2), AVG(gap3), 
    AVG(gap4), AVG(gap5), AVG(gap6), AVG(gap7), AVG(gap8), 
    AVG(gap9), AVG(gap10), AVG(gap11), AVG(gap12), AVG(gap13), 
    AVG(gap14), AVG(gap15), AVG(gap16), AVG(gap17), AVG(gap18), 
    AVG(gap19), AVG(gap20) FROM churn_users WHERE churner = 0 
    OR (churner = 1 AND churnedbygap = -1) GROUP BY k, churner ORDER BY k, churner;
select max(gap_from_prev) from posts where post_seq <= 20;

