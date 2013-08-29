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

UPDATE churn_users cu SET relative_rank_pos = 
    (SELECT  round(avg(answercount/answer_rank))
        FROM posts p force index(idx_posts_owneruserid_rank_answer_post_seq)
        WHERE p.owneruserid = cu.uid
        AND answer_rank is not null
        AND p.post_seq <= cu.k) WHERE num_answers > 0;

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
    set score = 
    (select (rep_answerers - u.reputation)/(ffp.answercount-1) 
        from posts p force index(idx_parentid_owneruserid), users u where parentid = ffp.id
        and ffp.owneruserid <> owneruserid and owneruserid = u.id) 
    where ffp.posttypeid = 2;

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


*/

update churn_users cu set q_post_length = 
    (select avg(length(body)) from posts  force index(idx_posttypeid_owneruserid_post_seq)
        where posttypeid = 1 and owneruserid = cu.uid 
    AND post_seq <= cu.k) where num_questions > 0;

/*create table churn_timegaps(k int(11), uid int(11), gapnum int(11), gap int(11));*/

update posts p1, posts p2 set p2.gap_from_prev = 
    timestampdiff(MINUTE, p1.creationdate, p2.creationdate) 
    where p1.post_seq = p2.post_seq - 1 
        and p1.owneruserid = p2.owneruserid;


update posts p1, user u set gap_from_prev = 
    timestampdiff(MINUTE, u.creationdate, p1.creationdate) 
    where p1.post_seq = 1
        and p1.owneruserid = u.id;

call update_timegaps();