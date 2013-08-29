alter table users add column NumPosts int(11);

alter table users add column LastPostDate datetime;
alter table users drop column LastPost;

create index idx_users_numposts on users(numposts);


alter table posts add column post_seq int(11);

create index idx_user_postseq on posts(owneruserid, post_seq);

create table post_temp select id, owneruserid from posts;
create index idx_posttemp_ouid_id on post_temp(owneruserid, id);

create table churn_users(k int(11), uid int(11), kth_postid int(11), churner int(2));

alter table churn_users add column churnedbygap int(2);

create index idx_churn_users_k on churn_users(k);
create index idx_churn_users_k_churner on churn_users(k, churner);

alter table churn_users add column num_questions int(11);
create index idx_churn_users_k_num_questions on churn_users(k, num_questions);

alter table churn_users add column num_answers int(11);
create index idx_churn_users_k_num_answers on churn_users(k, num_answers);

alter table churn_users add column churn_class_label int(11);

alter table churn_users add column num_answers_recvd float(11);

create index   idx_posts_post_seq on posts(post_seq);

alter table churn_users 
    add column a_score int(11),
    add column q_score int(11),
    add column a_score_stddev int(11),
    add column q_score_stddev int(11),
    add column relative_rank_pos int(11),
    add column answering_speed int(11),
    add column mean_rep_co_answerers int(11),
    add column mean_rep_answerers int(11),
    add column mean_rep_questioner int(11),
    add column time_for_first_ans int(11),
    add column a_q_ratio float(11),
    add column a_post_length int(11),
    add column q_post_length int(11);

alter table churn_users drop column tot_comments;

alter table churn_users add column a_comments int(11);
alter table churn_users add column q_comments int(11);

desc churn_users;

alter table posts add column answer_rank int(11);
create index idx_posts_posttypeid_parentId_score on posts(posttypeid, parentid, score);

create index idx_posts_owneruserid_rank_answer_post_seq on posts(owneruserid, answer_rank, post_seq);

ALTER TABLE posts
    ADD COLUMN minutes_from_ques int(11),
    ADD COLUMN minutes_from_prev_post int(11);

create index idx_posts_parentid_posttypeid on posts(parentid, posttypeid);

ALTER TABLE posts add column time_for_first_ans int(11);

create table ptemp (id int(11), answercount int(11),
    owneruserid int(11), posttypeid int(11), 
    score int(11), parentid int(11), rank int(11));
insert into ptemp(id, answercount, posttypeid, owneruserid,  score, parentid) 
    select id, answercount, posttypeid, owneruserid, score, parentid from posts;

drop table ptemp;
select count(*) from ptemp where parentid is null;
select count(*) from posts where parentid is null;
create index idx_ptemp_id on ptemp(id);

alter table posts add column num_comments int(11),
    add column rep_answerers int(11),
    add column rep_questioner int(11),
    add column post_length int(11);

alter table posts add column post_length int(11);

create index idx_posttypeid_owneruserid_post_seq on posts(posttypeid, owneruserid, post_seq);

create index idx_parentid_posttypeid_post_seq on posts(parentid, posttypeid, post_seq);

create table churn_timegaps(k int(11), uid int(11), gapnum int(11), gap int(11));

alter table posts add column gap_from_prev int(11);

alter table churn_users 
    add column gap1 int(11),
    add column gap2 int(11),
    add column gap3 int(11),
    add column gap4 int(11),
    add column gap5 int(11),
    add column gap6 int(11),
    add column gap7 int(11),
    add column gap8 int(11),
    add column gap9 int(11),
    add column gap10 int(11),
    add column gap11 int(11),
    add column gap12 int(11),
    add column gap13 int(11),
    add column gap14 int(11),
    add column gap15 int(11),
    add column gap16 int(11),
    add column gap17 int(11),
    add column gap18 int(11),
    add column gap19 int(11),
    add column gap20 int(11);