select count(*) from control_users where answering_speed = -1;


update control_users set tot_rep_co_posters = 0 where tot_rep_co_posters is null;


update control_users set num_posts_month = 1 where num_posts_month > 6;
update control_users set num_posts_month = -1 where num_posts_month = 0;


update control_users set answering_speed = -500 where answering_speed is null;

update control_users set answering_speed = -500 where answering_speed = -1;

update control_users set relative_rank_pos = -500 where relative_rank_pos is null;


delete from control_users;
drop table control_users;

create table control_users SELECT  id, num_posts_month, gap1, gap2, gap3, gap4, gap5, num_answers, num_questions,
        q_score, a_score, q_score_stddev, a_score_stddev, relative_rank_pos,
        answering_speed, tot_comments, mean_tot_rep_co_answerers, a_q_ratio, 
        time_for_first_ans, mean_tot_rep_answerers, rep_questioner,
        a_post_length, q_post_length
FROM    prol_users
WHERE   num_posts_month > 6 
ORDER BY id limit 0,50000;

insert into control_users 
SELECT  id, num_posts_month, gap1, gap2, gap3, gap4, gap5, num_answers, num_questions,
        q_score, a_score, q_score_stddev, a_score_stddev, relative_rank_pos,
        answering_speed, tot_comments, mean_tot_rep_co_answerers, a_q_ratio, 
        time_for_first_ans, mean_tot_rep_answerers, rep_questioner,
        a_post_length, q_post_length
FROM    prol_users
WHERE   num_posts_month > 6 
        and gap1 >= 0 and answering_speed >=0 and time_for_first_ans >= 0
ORDER BY id limit 0,50000;

select count(*) from control_users where mean_tot_rep_co_answerers is null;

update prol_users set mean_tot_rep_co_answerers = 0 where mean_tot_rep_co_answerers is null;
update prol_users set relative_rank_pos = 0 where relative_rank_pos is null;
update prol_users set answering_speed = 0 where answering_speed is null;
update prol_users set mean_tot_rep_answerers = 0 where mean_tot_rep_answerers is null;

update control_users set mean_tot_rep_co_answerers = 0 where mean_tot_rep_co_answerers is null;
update control_users set answering_speed = 0 where answering_speed is null;
update control_users set mean_tot_rep_answerers = 0 where mean_tot_rep_answerers is null;

update control_users set relative_rank_pos = 0 where relative_rank_pos is null;


SELECT  gap1, gap2, gap3, gap4, gap5, num_answers, num_questions,
        q_score, a_score, q_score_stddev, a_score_stddev, relative_rank_pos,
        answering_speed, tot_comments, mean_tot_rep_co_answerers, a_q_ratio, 
        time_for_first_ans, mean_tot_rep_answerers, rep_questioner,
        a_post_length, q_post_length
FROM    control_users
ORDER BY ID;

select count(*) from control_users where time_for_first_ans < 0;

select count(*) from control_users where answering_speed =0;

alter table control_users add column class_label int(2);

update control_users set class_label = 1 where num_posts_month > 6;
update control_users set class_label = -1 where num_posts_month = 0;

SELECT class_label, count(*)  
FROM control_users group by class_label;

select count(*) from control_users where answering_speed is null;

alter table prol_users add column classify_label int(11);


update prol_users set mean_tot_rep_answerers = 0 where mean_tot_rep_answerers is  null;
select count(*) from prol_users where q_post_length = 0;

select id from prol_users where q_post_length = 0 limit 1,1;
select posttypeid from first_five_posts where uid = 5;

select answer_time from first_five_posts where posttypeid = 1 limit 1, 10 ;


