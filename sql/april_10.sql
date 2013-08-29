alter table prol_users add column a_q_ratio float(11);
update prol_users set a_q_ratio = (num_answers + 1)/(num_questions + 1);

alter table prol_users add column time_for_first_ans int(11);

select count(*) from first_five_posts where posttypeid =1;

update first_five_posts ffp set answer_time = 
    timestampdiff(SECOND, ffp.creationdate,
        (select min(creationdate) from posts force index(idx_posts_parentid)
            where parentid = ffp.pid))
    where posttypeid = 1 ;

select count(*) from first_five_posts where answer_time is not null and posttypeid = 1;

select min(creationdate) from posts force index(idx_posts_parentid)
            where parentid = 13731;
select timestampdiff(MINUTE, 
        (select min(creationdate) from posts force index(idx_posts_parentid)
            where parentid = 13731), '2005-05-18 02:44:32');


select min(creationdate) from posts force index(idx_posts_parentid)
            where parentid = 134;

select * from first_five_posts where tot_answers = 1 and posttypeid = 2 limit 1,1;

alter table prol_users add column answering_speed int(11);
update prol_users set answering_speed = null;
update prol_users pu set answering_speed = 
    (select round(avg(answer_time)) from first_five_posts force index(idx_ffp_uid) where uid = pu.id);

update first_five_posts ffp set tot_answers = 
    (select count(*) from posts force index(idx_posts_parentId)
        where parentId = ffp.pid) where posttypeid = 1;

select answer_time from first_five_posts where posttypeid = 1 limit 1,10;
update prol_users pu set time_for_first_ans = ( 
    select avg(ffp.answer_time)
    from first_five_posts ffp
    where ffp.uid = pu.id and ffp.posttypeid = 1);

update prol_users set time_for_first_ans = 0 where time_for_first_ans is null;

select count(*) from prol_users where time_for_first_ans = 0 ;

alter table prol_users change mean_rep_co_answerers mean_tot_rep_co_answerers int(11);
alter table prol_users change mean_rep_answerers mean_tot_rep_answerers int(11);

alter table prol_users add column mean_rep_answerers int(11);

update prol_users pu set mean_tot_rep_co_answerers = 
    (select avg(tot_rep_co_posters) from first_five_posts where uid = pu.id and posttypeid = 2);

update prol_users pu set mean_tot_rep_answerers = 
    (select avg(tot_rep_co_posters) from first_five_posts where uid = pu.id and posttypeid = 1);

update prol_users pu set mean_tot_rep_answerers = 0 where mean_tot_rep_answerers is null;

select tot_rep_co_posters from first_five_posts where posttypeid = 1 limit 1,10;

select * from posttypes;

alter table first_five_posts add column rep_questioner int(11);

update first_five_posts ffp, users u
    set ffp.rep_questioner = 
        u.reputation where posttypeid = 2 and u.id = ffp.parent_uid;

alter table prol_users add column rep_questioner int(11);
update prol_users pu set rep_questioner = 
    (select avg(rep_questioner) from first_five_posts ffp where ffp.uid = pu.id);

create table ab(x int(11), y int(11));

update prol_users set mean_tot_rep_co_answerers = 0 where mean_tot_rep_co_answerers is null;

insert into ab(y) values(5);
delete from ab where y = 5;
select avg(y) from ab;
alter table first_five_posts add column parent_uid int(11);

update first_five_posts ffp, posts p
    set ffp.parent_uid = p.owneruserid 
    where ffp.parent_qid = p.id;

select * from first_five_posts where posttypeid = 2 and parent_uid is null limit 1,1;
select * from posts where id = 34;

alter table prol_users  add column a_post_length int(11);
alter table prol_users  add column q_post_length int(11);

alter table prol_users drop column post_length;
update prol_users pu set a_post_length = 
    (select avg(post_length) from first_five_posts where pu.id = uid and posttypeid = 2);
update prol_users pu set q_post_length = 
    (select avg(post_length) from first_five_posts where pu.id = uid and posttypeid = 1);



update prol_users pu set gap1 = 
    (select timestampdiff(MINUTE, pu.u_creationdate, ffp.creationdate) 
    from first_five_posts ffp force index(idx_ffp_uid_creationdate) 
    where ffp.uid = pu.id order by ffp.creationdate asc limit 0,1);

update prol_users pu set gap2 = 
    (select timestampdiff(MINUTE, pu.u_creationdate, ffp.creationdate) 
    from first_five_posts ffp force index(idx_ffp_uid_creationdate) 
    where ffp.uid = pu.id order by ffp.creationdate asc limit 1,1);

update prol_users pu set gap3 = 
    (select timestampdiff(MINUTE, pu.u_creationdate, ffp.creationdate) 
    from first_five_posts ffp force index(idx_ffp_uid_creationdate) 
    where ffp.uid = pu.id order by ffp.creationdate asc limit 2,1);

update prol_users pu set gap4 = 
    (select timestampdiff(MINUTE, pu.u_creationdate, ffp.creationdate) 
    from first_five_posts ffp force index(idx_ffp_uid_creationdate) 
    where ffp.uid = pu.id order by ffp.creationdate asc limit 3,1);

update prol_users pu set gap5 = 
    (select timestampdiff(MINUTE, pu.u_creationdate, ffp.creationdate) 
    from first_five_posts ffp force index(idx_ffp_uid_creationdate) 
    where ffp.uid = pu.id order by ffp.creationdate asc limit 4,1);

select count(*) from prol_users where gap1 < 0;

select * from prol_users where gap1 < 0 limit 0,1;

select * from first_five_posts where uid = 48;
select * from posts where id = 23;
select * from users where id = 48;


select count(*) from control_users;

delete from control_users where gap1 < 0;



select count(*) from prol_users where gap1 < 0 and num_posts_month > 6;

