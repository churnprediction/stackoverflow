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

drop table ptemp;
create table ptemp (id int(11), answercount int(11),
    owneruserid int(11), posttypeid int(11), 
    score int(11), parentid int(11), rank int(11));
insert into ptemp(id, answercount, posttypeid, owneruserid,  score, parentid) 
    select id, answercount, posttypeid, owneruserid, score, parentid from posts;

alter table posts add column parent_answer_count int(11);

select count(distinct parentid) from ptemp;
select count(*) from ptemp;
select * from ptemp;
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

alter table churn_users add column num_q_answered int(11);
alter table posts add column max_rep_answerer int(11);

alter table churn_users add column mean_max_rep_answerer int(11);

alter table posts add column accepted_answerer_rep int(11);
alter table churn_users add column mean_accepted_answerer_rep int(11);

alter table ptemp add column acceptedansweruser int(11);
alter table posts add column questioner_rep int(11);


alter table churn_users drop column qrep1;
alter table churn_users drop column qrep2;
alter table churn_users drop column qrep3;
alter table churn_users drop column qrep4;

alter table churn_users       
    add column qrep1 float(11),      
    add column qrep2 float(11),      
    add column qrep3 float(11),      
    add column qrep4 float(11);

create index idx_churn_users_k_churn_class_label on churn_users(k, churn_class_label);
create index idx_churn_users_churn_class_label_uid on churn_users(churn_class_label, uid);

show processlist;

CREATE TABLE `churn_time_users` (
  `T` int(11) DEFAULT NULL,
  `uid` int(11) DEFAULT NULL,
  `kth_postid` int(11) DEFAULT NULL,
  `churner` int(2) DEFAULT NULL,
  `churnedbygap` int(2) DEFAULT NULL,
  `num_questions` int(11) DEFAULT NULL,
  `num_answers` int(11) DEFAULT NULL,
  `churn_class_label` int(11) DEFAULT NULL,
  `num_answers_recvd` float DEFAULT NULL,
  `a_score` int(11) DEFAULT NULL,
  `q_score` int(11) DEFAULT NULL,
  `a_score_stddev` int(11) DEFAULT NULL,
  `q_score_stddev` int(11) DEFAULT NULL,
  `relative_rank_pos` int(11) DEFAULT NULL,
  `answering_speed` int(11) DEFAULT NULL,
  `mean_rep_co_answerers` int(11) DEFAULT NULL,
  `mean_rep_answerers` int(11) DEFAULT NULL,
  `mean_rep_questioner` int(11) DEFAULT NULL,
  `time_for_first_ans` int(11) DEFAULT NULL,
  `a_q_ratio` float DEFAULT NULL,
  `a_post_length` int(11) DEFAULT NULL,
  `q_post_length` int(11) DEFAULT NULL,
  `a_comments` int(11) DEFAULT NULL,
  `q_comments` int(11) DEFAULT NULL,
  `num_q_answered` int(11) DEFAULT NULL,
  `mean_max_rep_answerer` int(11) DEFAULT NULL,
  `mean_accepted_answerer_rep` int(11) DEFAULT NULL,
   `first_post_gap` int(11) DEFAULT NULL,
   `last_post_gap` int(11) DEFAULT NULL,
   `time_since_last_gap` int(11) DEFAULT NULL,
   `num_posts` int(11) DEFAULT NULL,
    period_after_creation datetime,
    observation_time_deadline datetime,

  KEY `idx_churn_time_users_t` (`T`),
  KEY `idx_churn_time_users_k_churner` (`T`,`churner`),
  KEY `idx_churn_time_users_k_num_questions` (`T`,`num_questions`),
  KEY `idx_churn_time_users_k_num_answers` (`T`,`num_answers`),
  KEY `idx_churn_time_users_k_num_answers_recvd` (`T`, `num_answers_recvd`),
  KEY `idx_churn_time_users_kk_churn_class_label` (`T`,`churn_class_label`),
  KEY `idx_churn_time_users_churn_class_label_uid` (`churn_class_label`,`uid`)
) ENGINE=InnoDB;


alter table users add column week_churner int(1),
                  add column fortnight_churner int(1),
                  add column month_churner int(1);

alter table users add column pre_week_posts int(11),
                  add column post_week_halfyear_posts int(11),
                  add column pre_fortnight_posts int(11),
                  add column post_fortnight_halfyear_posts int(11),
                  add column pre_month_posts int(11),
                  add column post_month_halfyear_posts int(11);

alter table users add column week_after_creation datetime,
                  add column fortnight_after_creation datetime,
                  add column month_after_creation datetime;

alter table churn_time_users add column period_after_creation datetime;


alter table churn_time_users add column observation_time_deadline datetime;

alter table churn_time_users add column mean_gap int(11);

alter table users add column first_post_date datetime;

alter table users add column days_before_first_post int(11);


CREATE TABLE `churn_time_users` (
  `T` int(11) DEFAULT NULL,
  `uid` int(11) DEFAULT NULL,
  `kth_postid` int(11) DEFAULT NULL,
  `churner` int(2) DEFAULT NULL,
  `churnedbygap` int(2) DEFAULT NULL,
  `num_questions` int(11) DEFAULT NULL,
  `num_answers` int(11) DEFAULT NULL,
  `churn_class_label` int(11) DEFAULT NULL,
  `num_answers_recvd` float DEFAULT NULL,
  `a_score` int(11) DEFAULT NULL,
  `q_score` int(11) DEFAULT NULL,
  `a_score_stddev` int(11) DEFAULT NULL,
  `q_score_stddev` int(11) DEFAULT NULL,
  `relative_rank_pos` int(11) DEFAULT NULL,
  `answering_speed` int(11) DEFAULT NULL,
  `mean_rep_co_answerers` int(11) DEFAULT NULL,
  `mean_rep_answerers` int(11) DEFAULT NULL,
  `mean_rep_questioner` int(11) DEFAULT NULL,
  `time_for_first_ans` int(11) DEFAULT NULL,
  `a_q_ratio` float DEFAULT NULL,
  `a_post_length` int(11) DEFAULT NULL,
  `q_post_length` int(11) DEFAULT NULL,
  `a_comments` int(11) DEFAULT NULL,
  `q_comments` int(11) DEFAULT NULL,
  `num_q_answered` int(11) DEFAULT NULL,
  `mean_max_rep_answerer` int(11) DEFAULT NULL,
  `mean_accepted_answerer_rep` int(11) DEFAULT NULL,
  `first_post_gap` int(11) DEFAULT NULL,
  `last_post_gap` int(11) DEFAULT NULL,
  `time_since_last_gap` int(11) DEFAULT NULL,
  `num_posts` int(11) DEFAULT NULL,
  `period_after_creation` datetime DEFAULT NULL,
  `observation_time_deadline` datetime DEFAULT NULL,
  `mean_gap` int(11) DEFAULT NULL,
  KEY `idx_churn_time_users_t` (`T`),
  KEY `idx_churn_time_users_k_churner` (`T`,`churner`),
  KEY `idx_churn_time_users_k_num_questions` (`T`,`num_questions`),
  KEY `idx_churn_time_users_k_num_answers` (`T`,`num_answers`),
  KEY `idx_churn_time_users_k_num_answers_recvd` (`T`,`num_answers_recvd`),
  KEY `idx_churn_time_users_kk_churn_class_label` (`T`,`churn_class_label`),
  KEY `idx_churn_time_users_churn_class_label_uid` (`churn_class_label`,`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

alter table posts add column accepted int(1) default 0;

alter table users add column accepted_answers int(11),
                add column num_answers int(11);

