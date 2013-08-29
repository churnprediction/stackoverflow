insert into prol_users(id, postcount)  select owneruserid, count(id) from posts force index(idx_owneruserid) group by owneruserid having count(id) >= 5;

update prol_users pu set pu.fifth_post = (select id from posts force index(idx_owneruserid) where owneruserid = pu.id order by id limit 4, 1);

update prol_users u set u.num_posts_month = (select count(*) from posts p force index(idx_creationdate_owneruserid) where owneruserid = u.id and p.id > u.fifth_post and p.creationdate < date_add((select creationdate from posts where id=u.fifth_post), INTERVAL 1 month));


create table community_posts select * from  posts force index(idx_owneruserid) where owneruserid is null;

alter table prol_users add column u_creationdate datetime;

create index idx_pu_u_creationdate on prol_users(u_creationdate);

update prol_users pu, users u set pu.u_creationdate = u.creationdate  where  pu.id=u.id;


alter table prol_users add column gap1 int(11);
alter table prol_users add column gap2 int(11);
alter table prol_users add column gap3 int(11);
alter table prol_users add column gap4 int(11);
alter table prol_users add column gap5 int(11);

update prol_users pu set gap1 = (select timestampdiff(MINUTE, pu.u_creationdate, ffp.creationdate) from first_five_posts ffp force index(idx_ffp_uid_creationdate) where ffp.uid = pu.id order by ffp.creationdate asc limit 0,1);
update prol_users pu set gap2 = (select timestampdiff(MINUTE, pu.u_creationdate, ffp.creationdate) from first_five_posts ffp force index(idx_ffp_uid_creationdate) where ffp.uid = pu.id order by ffp.creationdate asc limit 1,1);
update prol_users pu set gap3 = (select timestampdiff(MINUTE, pu.u_creationdate, ffp.creationdate) from first_five_posts ffp force index(idx_ffp_uid_creationdate) where ffp.uid = pu.id order by ffp.creationdate asc limit 2,1);
update prol_users pu set gap4 = (select timestampdiff(MINUTE, pu.u_creationdate, ffp.creationdate) from first_five_posts ffp force index(idx_ffp_uid_creationdate) where ffp.uid = pu.id order by ffp.creationdate asc limit 3,1);
update prol_users pu set gap5 = (select timestampdiff(MINUTE, pu.u_creationdate, ffp.creationdate) from first_five_posts ffp force index(idx_ffp_uid_creationdate) where ffp.uid = pu.id order by ffp.creationdate asc limit 4,1);



