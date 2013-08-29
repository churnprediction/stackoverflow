alter table first_five_posts add column fifth_post int(1);

insert into first_five_posts(uid, pid, creationdate, fifth_post)
select u.id uid, p.id pid, creationdate, 1 
from posts p force index(idx_owneruserid), prol_users u 
where u.id = p.owneruserid and p.id = u.fifth_post;

update first_five_posts set fifth_post = 0 where fifth_post is null;


update first_five_posts ffp, posts p set ffp.posttypeid = p.posttypeid 
    where ffp.pid = p.id and fifth_post = 1;

update first_five_posts ffp, posts p 
    set ffp.score = p.score where ffp.pid = p.id and fifth_post = 1;

update first_five_posts ffp, posts p 
    set ffp.parent_qid = p.parentId 
    where ffp.pid = p.id and ffp.posttypeid = 2 and fifth_post = 1;

update first_five_posts ffp set tot_answers = 
    (select count(*) from posts force index(idx_posts_parentId)
        where parentId = ffp.parent_qid) where parent_qid is not null;


update first_five_posts ffp set rank_answer = 
    (select count(*) from posts force index(idx_posts_parentId_score) where parentId = ffp.parent_qid 
        and score >= ffp.score) where parent_qid is not null;

update first_five_posts set relative_rank_pos = round(tot_answers/rank_answer)
    where tot_answers is not null and rank_answer is not null;

select count(*) from first_five_posts where rank_answer is null and posttypeid = 2;

update first_five_posts ffp set accepted_by_orig = 
    ( select count(*) from votes where postid = ffp.pid 
            and votetypeid = 1) where posttypeid=2 and fifth_post = 1;

select count(*) from first_five_posts where score is null;
update first_five_posts ffp set answer_time = 
    timestampdiff(SECOND, ffp.creationdate,
        (select creationdate from posts where id = ffp.parent_qid))
    where posttypeid = 2;

update first_five_posts ffp set answer_time = 
    timestampdiff(SECOND, 
        (select creationdate from posts where id = ffp.parent_qid), ffp.creationdate)
    where posttypeid = 2 and fifth_post = 1 and pid = 8327;

select * from first_five_posts where posttypeid = 2 and fifth_post = 1 and answer_time is null;

update first_five_posts ffp set num_comments = 
    (select count(*) from comments force index(idx_comments_postid) where postid = ffp.pid)
    ;

update first_five_posts ffp set num_comments = 
    (select count(*) from comments force index(idx_comments_postid) where postid = ffp.pid);

insert into posts select * from community_posts;

update first_five_posts ffp, posts p 
    set post_length = length(p.body)
    where ffp.pid = p.id and ffp.fifth_post = 1;

update first_five_posts ffp force index(idx_ffp_posttypeid) 
    set tot_rep_co_posters = 
    (select avg(u.reputation) 
        from users u, posts p force index(idx_parentid_owneruserid)
        where p.parentid = ffp.parent_qid
            and u.id <> ffp.uid
            and p.owneruserid=u.id) where ffp.posttypeid = 2;

update first_five_posts ffp force index(idx_ffp_posttypeid) 
    set tot_rep_co_posters = 
    (select avg(u.reputation) 
        from users u, posts p force index(idx_parentid_owneruserid)
        where p.parentid = ffp.pid
            and u.id <> ffp.uid
            and p.owneruserid=u.id) where ffp.posttypeid = 1;

update first_five_posts set tot_rep_co_posters = tot_rep_co_posters/tot_answers 
    where posttypeid = 1 and tot_answers != 0;

select * from posttypes;
select count(*) from first_five_posts where posttypeid = 2 and relative_rank_pos is not null;

update prol_users pu set gap1 = 
    (select timestampdiff(MINUTE, pu.u_creationdate, ffp.creationdate) 
    from first_five_posts ffp where ffp.uid = pu.id order by ffp.creationdate desc limit 4,1);


update prol_users pu 
 set num_answers = (select count(*) from first_five_posts ffp
    where pu.id = ffp.uid and posttypeid=2);

update prol_users pu 
 set num_questions = (select count(*) from first_five_posts ffp
    where pu.id = ffp.uid and posttypeid=1);

update prol_users pu set q_score = 
        (select sum(score) from first_five_posts ffp force index(idx_ffp_posttypeid_uid)
            where posttypeid = 1 and ffp.uid = pu.id);

update prol_users pu set a_score = 
        (select sum(score) from first_five_posts ffp force index(idx_ffp_posttypeid_uid)
            where posttypeid = 2 and ffp.uid = pu.id);

update prol_users set a_score = 0 where a_score is null;
update prol_users set q_score = 0 where q_score is null;

select * from prol_users limit 0, 2;

update prol_users pu set q_score_stddev = 
        (select stddev_samp(score) from first_five_posts ffp force index(idx_ffp_posttypeid_uid)
            where posttypeid = 1 and ffp.uid = pu.id);
update prol_users pu set q_score_stddev = 0 where q_score_stddev = -500;
update prol_users pu set a_score_stddev = 
        (select stddev_samp(score) from first_five_posts ffp force index(idx_ffp_posttypeid_uid)
            where posttypeid = 2 and ffp.uid = pu.id);
update prol_users pu set a_score_stddev = 0 where a_score_stddev = -500;
update prol_users pu set q_score_stddev = 0 where q_score_stddev is null;
update prol_users pu set a_score_stddev = 0 where a_score_stddev is null;

update prol_users set a_score_stddev = -1 where a_score_stddev is null;
update prol_users set q_score_stddev = -1 where q_score_stddev is null;

update prol_users set a_score_stddev = -500 where a_score_stddev = -1;
update prol_users set q_score_stddev = -500 where q_score_stddev = -1;

update prol_users pu set relative_rank_pos = 
    (select round(avg(relative_rank_pos)) 
        from first_five_posts force index(idx_ffp_uid) where uid = pu.id);

update prol_users pu set answering_speed = 
    (select round(avg(answer_time)) from first_five_posts force index(idx_ffp_uid) where uid = pu.id);


update prol_users pu set tot_comments = 
    (select sum(num_comments) from first_five_posts where uid = pu.id);

update prol_users pu set tot_rep_co_posters = 
    (select round(avg(tot_rep_co_posters))
        from first_five_posts ffp force index(idx_ffp_uid)
        where ffp.uid = pu.id);

update prol_users pu set post_length = 
    (select round(avg(post_length)) 
        from first_five_posts ffp force index(idx_ffp_uid)
        where ffp.uid = pu.id);
