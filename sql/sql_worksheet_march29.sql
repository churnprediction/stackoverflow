desc prol_users;


alter table first_five_posts add column posttypeid int(11);

create index idx_ffp_posttypeid on first_five_posts(posttypeid);

update first_five_posts ffp, posts p set ffp.posttypeid = p.posttypeid 
    where ffp.pid = p.id;
desc prol_users;

alter table prol_users drop column date5;

alter table prol_users add column num_answers int(11);

alter table prol_users add column num_questions int(11);

update prol_users pu 
 set num_answers = (select count(*) from first_five_posts ffp
    where pu.id = ffp.uid and posttypeid=2);

update prol_users pu 
 set num_questions = (select count(*) from first_five_posts ffp
    where pu.id = ffp.uid and posttypeid=1);


alter table prol_users add column boundary_date datetime;

update prol_users pu, posts p 
    set pu.boundary_date = p.creationdate 
    where p.id = pu.fifth_post;

create index idx_votes_postid on votes(postid);
create index idx_votes_postid_creationdate on votes(postid, creationdate);

alter table first_five_posts add column upvotes int(11);

alter table first_five_posts add column accepted int(11);

alter table first_five_posts add column downvotes int(11);

alter table first_five_posts add column favorites int(11);

alter table first_five_posts add column deleted int(11);

create index idx_votetypeid on votes(votetypeid);

update first_five_posts ffp set ffp.downvotes = 
    (select count(*) from votes force index(idx_votes_postid_votetypeid)
        where postid = ffp.pid and votetypeid=3);


update first_five_posts ffp, prol_users pu set ffp.accepted = 
    (select count(*) from  votes v
        force index(idx_votes_postid_creationdate_votetype)
        where v.postid = ffp.pid and 
        pu.boundary_date >=  v.creationdate
        and votetypeid=1) and pu.id = ffp.uid;

update first_five_posts ffp, prol_users pu set ffp.upvote = 
    (select count(*) from  votes v
        force index(idx_votes_postid_creationdate_votetype)
        where v.postid = ffp.pid and 
        pu.boundary_date >=  v.creationdate
        and votetypeid=2) and pu.id = ffp.uid;

update first_five_posts ffp, prol_users pu set ffp.downvote = 
    (select count(*) from  votes v
        force index(idx_votes_postid_creationdate_votetype)
        where v.postid = ffp.pid and 
        pu.boundary_date >=  v.creationdate
        and votetypeid=3) and pu.id = ffp.uid;

update first_five_posts ffp force index(idx_ffp_uid), prol_users pu 
    set ffp.favorites = 
    (select count(*) from  votes v
        force index(idx_votes_postid_creationdate_votetype)
        where v.postid = ffp.pid and 
        pu.boundary_date >=  v.creationdate
        and votetypeid=5) and pu.id = ffp.uid;

update first_five_posts ffp force index(idx_ffp_uid), 
        prol_users pu set ffp.deleted = 
    (select count(*) from  votes v
        force index(idx_votes_postid_creationdate_votetype)
        where v.postid = ffp.pid and 
        pu.boundary_date >=  v.creationdate
        and votetypeid=10) and pu.id = ffp.uid;

create index idx_ffp_uid on first_five_posts(uid);

select sum(accepted) from first_five_posts;


select count(*) from posts where parentId is not null;

select votetypeid, count(*) ct from votes force index(idx_votetypeid)
group by votetypeid  order by ct desc;

select count(*) from votes;

select count(*) from first_five_posts where accepted=1;

create index idx_votes_postid_creationdate_votetype 
on votes(postid, creationdate, votetypeid);

select count(*) from first_five_posts where favorites is not null;

alter table first_five_posts add column score int(11);
update first_five_posts ffp, posts p set ffp.score = p.score where ffp.pid = p.id;

create index idx_ffp_posttypeid_uid on first_five_posts(posttypeid, uid);

alter table prol_users drop column q_score ;
alter table prol_users drop column a_score ;

alter table prol_users add column q_score int(11);
update prol_users pu set q_score = 
        (select sum(score) from first_five_posts ffp force index(idx_ffp_posttypeid_uid)
            where posttypeid = 1 and ffp.uid = pu.id);

alter table prol_users add column a_score int(11);
update prol_users pu set a_score = 
        (select sum(score) from first_five_posts ffp force index(idx_ffp_posttypeid_uid)
            where posttypeid = 2 and ffp.uid = pu.id);

update prol_users set a_score = -50 where a_score is null;
update prol_users set q_score = -50 where q_score is null;

update prol_users set a_score = 0 where a_score = -50;
update prol_users set q_score = 0 where q_score = -50;

select a_score, count(*) from prol_users where a_score < 4 group by a_score;

alter table prol_users drop column q_score_stddev ;
alter table prol_users drop column a_score_stddev ;

alter table prol_users add column q_score_stddev int(11);
update prol_users pu set q_score_stddev = 
        (select stddev_samp(score) from first_five_posts ffp force index(idx_ffp_posttypeid_uid)
            where posttypeid = 1 and ffp.uid = pu.id);

alter table prol_users add column a_score_stddev int(11);
update prol_users pu set a_score_stddev = 
        (select stddev_samp(score) from first_five_posts ffp force index(idx_ffp_posttypeid_uid)
            where posttypeid = 2 and ffp.uid = pu.id);


update prol_users set a_score_stddev = -1 where a_score_stddev is null;
update prol_users set q_score_stddev = -1 where q_score_stddev is null;

select min(q_score) from prol_users;
select max(a_score_stddev) from prol_users;


alter table first_five_posts add column parent_qid int(11);
create index idx_posts_parentId on posts(parentId);

update first_five_posts ffp, posts p 
    set ffp.parent_qid = p.parentId 
    where ffp.pid = p.id and ffp.posttypeid = 2;

select count(*) from first_five_posts where parent_qid is not null;

alter table first_five_posts drop column tot_answers;


alter table first_five_posts add column tot_answers int(11);
update first_five_posts ffp set tot_answers = 
    (select count(*) from posts force index(idx_posts_parentId)
        where parentId = ffp.parent_qid) where parent_qid is not null;

select count(*) from first_five_posts where tot_answers is not null;
select count(*) from first_five_posts where parent_qid is null;
select count(*) from 
(select distinct uid, parent_qid from first_five_posts where parent_qid is not null) dr;

alter table first_five_posts add column rank_answer int(11);
create index idx_posts_parentId_score on posts(parentId, score);

update first_five_posts ffp set rank_answer = 
    (select count(*) from posts force index(idx_posts_parentId_score) where parentId = ffp.parent_qid 
        and score >= ffp.score);

select count(*) from first_five_posts where rank_answer < 1 and rank_answer is not null;
select count(*) from first_five_posts where rank_answer is null;
update first_five_posts set rank_answer = null where rank_answer = 0;
update first_five_posts set tot_answers = null where rank_answer is null;

select count(*) from first_five_posts where tot_answers is null;

alter table first_five_posts add column relative_rank_pos int(11);

update first_five_posts set relative_rank_pos = round(tot_answers/rank_answer)
    where tot_answers is not null and rank_answer is not null;
select max(relative_rank_pos) from first_five_posts;

select count(*) from first_five_posts where tot_answers is  null and rank_answer is  null;

select count(*) from first_five_posts where relative_rank_pos is not null;

select floor(3/2) ;

select count(*) from first_five_posts where rank_answer is not null;

alter table prol_users add column relative_rank_pos int(11);
update prol_users pu set relative_rank_pos = 
    (select round(avg(relative_rank_pos)) 
        from first_five_posts force index(idx_ffp_uid) where uid = pu.id);
        
select round(avg(null));

select distinct ct from (select postId, count(*) ct from votes where votetypeid=1 group by postid) dr;

alter table first_five_posts add column accepted_by_orig int(1);
alter table first_five_posts modify column accepted_by_orig int(11);

update first_five_posts ffp set accepted_by_orig = 
    ( select count(*) from votes where postid = ffp.pid 
            and votetypeid = 1) where posttypeid=2;

select * from first_five_posts where pid  < 20;

select count(*) from first_five_posts where accepted_by_orig  = 1;
select * from votes where postid = 12;

alter table first_five_posts add column answer_time int(11);

update first_five_posts ffp set answer_time = 
    timestampdiff(MINUTE, (select creationdate from posts where id = ffp.parent_qid), ffp.creationdate)
    where posttypeid = 2;

create table abc(a int(11), b int(11));
insert into abc(a, b) values(10, 20);
insert into abc(a) values(20);
select avg(a) from abc;

alter table prol_users add column answering_speed int(11);
update prol_users set answering_speed = null;
update prol_users pu set answering_speed = 
    (select round(avg(answer_time)) from first_five_posts force index(idx_ffp_uid) where uid = pu.id);

alter table first_five_posts add  constraint primary key(pid);

select tags from posts limit 0, 4;

alter table first_five_posts add column num_comments int(11);

create index idx_comments_postid on comments(postid);

update first_five_posts ffp set num_comments = 
    (select count(*) from comments force index(idx_comments_postid) where postid = ffp.pid);

alter table prol_users add column tot_comments int(11);
update prol_users pu set tot_comments = 
    (select sum(num_comments) from first_five_posts where uid = pu.id);

alter table first_five_posts add column tot_rep_co_posters int(11);

create index idx_owneruserid_parentid on posts(owneruserid, parentid);

select count(*) from first_five_posts where tot_rep_co_posters is not null;
select count(*) from posts where parentid is null;

alter table first_five_posts add column post_length int(11);

update first_five_posts ffp, posts p 
    set post_length = length(p.body)
    where ffp.pid = p.id;


create index idx_parentid_owneruserid on posts(parentId, owneruserId);

update first_five_posts ffp force index(idx_ffp_posttypeid) 
    set tot_rep_co_posters = 
    (select sum(u.reputation) 
        from users u, posts p force index(idx_parentid_owneruserid)
        where p.parentid = ffp.parent_qid
            and u.id <> ffp.uid
            and p.owneruserid=u.id) where ffp.posttypeid = 2;

select count(*) from first_five_posts where tot_answers is not null;
update first_five_posts ffp force index(idx_ffp_posttypeid) 
    set tot_rep_co_posters = 
    (select sum(u.reputation) 
        from users u, posts p force index(idx_parentid_owneruserid)
        where p.parentid = ffp.pid
            and u.id <> ffp.uid
            and  p.owneruserid = u.id ) where ffp.posttypeid = 1;

select count(*) from first_five_posts where tot_rep_co_posters = 0;
    
select count(*) from first_five_posts where tot_rep_co_posters is not null;

alter table prol_users add column tot_rep_co_posters int(11);
update prol_users pu set tot_rep_co_posters = 
    (select round(avg(tot_rep_co_posters))
        from first_five_posts ffp force index(idx_ffp_uid)
        where ffp.uid = pu.id);
select distinct gap5 from prol_users;
alter table prol_users add column post_length int(11);
update prol_users pu set post_length = 
    (select round(avg(post_length)) 
        from first_five_posts ffp force index(idx_ffp_uid)
        where ffp.uid = pu.id);

drop table control_users;

create table control_users 
    SELECT  num_posts_month, id, gap1, gap2, gap3, gap4, gap5, num_answers, num_questions,
        q_score, a_score, q_score_stddev, a_score_stddev, relative_rank_pos,
        answering_speed, tot_comments, tot_rep_co_posters, post_length
FROM    prol_users
WHERE   num_posts_month = 0 order by rand() limit 0,50000;

insert into control_users 
    SELECT  num_posts_month, id, gap1, gap2, gap3, gap4, gap5, num_answers, num_questions,
        q_score, a_score, q_score_stddev, a_score_stddev, relative_rank_pos,
        answering_speed, tot_comments, tot_rep_co_posters, post_length
FROM    prol_users
WHERE   num_posts_month > 6 order by rand() limit 0,50000;

select num_posts_month, count(*) from control_users group by num_posts_month order by num_posts_month;

select count(*) from control_users where num_posts_month != 0;

update prol_users pu set gap5 = 
    (select timestampdiff(MINUTE, pu.u_creationdate, ffp.creationdate) 
        from first_five_posts ffp 
        where ffp.uid = pu.id 
    order by ffp.creationdate desc limit 4,1);



SELECT  num_posts_month, id, gap1, gap2, gap3, gap4, gap5, num_answers, num_questions,
        q_score, a_score, q_score_stddev, a_score_stddev, relative_rank_pos,
        answering_speed, tot_comments, tot_rep_co_posters, post_length
FROM    prol_users
WHERE   num_posts_month > 6 limit 0,2;

create table control_users 
    SELECT  num_posts_month, gap1, gap2, gap3, gap4, gap5, num_answers, num_questions,
        q_score, a_score, q_score_stddev, a_score_stddev, relative_rank_pos,
        answering_speed, tot_comments, tot_rep_co_posters, post_length
FROM    prol_users
WHERE   num_posts_month = 0 order by rand() limit 0,50000;

insert into control_users 
    SELECT  num_posts_month, gap1, gap2, gap3, gap4, gap5, num_answers, num_questions,
        q_score, a_score, q_score_stddev, a_score_stddev, relative_rank_pos,
        answering_speed, tot_comments, tot_rep_co_posters, post_length
FROM    prol_users
WHERE   num_posts_month > 6 order by rand() limit 0,50000;

drop table control_users;