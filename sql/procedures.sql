
delimiter $$
drop procedure if exists update_all_churns$$

delimiter @@
CREATE PROCEDURE update_all_churns(mx int(11))
    BEGIN
              DECLARE KK  INT;
              SET KK = 1;
              WHILE KK  <= mx DO
                    call update_churn(KK);
                    set KK = KK + 1;
              END WHILE;
    END@@

delimiter $$
drop procedure if exists update_churn$$

delimiter $$
CREATE  PROCEDURE update_churn(KK int(11))
    BEGIN
        
        insert into churn_users(uid, kth_postid) 
            SELECT owneruserid, p.id FROM posts p, users u where post_seq = KK
            AND timestampdiff(MONTH, p.creationdate, '2012-07-31 23:59:57') > 6 
            AND u.id = p.owneruserid and u.NumPosts = KK;

        update churn_users set churnedbygap = -1 where churnedbygap is null;

        insert into churn_users(uid, kth_postid) 
            SELECT p1.owneruserid, p1.id FROM posts p1, posts p2 
            where p1.post_seq = KK AND p2.post_seq = KK+1
            AND p1.owneruserid = p2.owneruserid
            AND timestampdiff(MONTH, p1.creationdate, p2.creationdate) > 6;

        update churn_users set churnedbygap = 1 where churnedbygap is null;
        update churn_users set churner = 1 where churner is null;

        insert into churn_users(uid, kth_postid) 
            SELECT p1.owneruserid, p1.id FROM posts p1, posts p2 
            where p1.post_seq = KK AND p2.post_seq = KK+1
            AND p1.owneruserid = p2.owneruserid
            AND timestampdiff(MONTH, p1.creationdate, p2.creationdate) <= 6;

        update churn_users set churnedbygap = 1 where churnedbygap is null;
        update churn_users set churner = -1 where churner is null;

        update churn_users set K = KK where K is null;
    END$$



delimiter @@
CREATE PROCEDURE update_timegaps()
    BEGIN
        UPDATE churn_users cu, posts p SET gap1 = p.gap_from_prev WHERE post_seq = 1;
        UPDATE churn_users cu, posts p SET gap2 = p.gap_from_prev WHERE post_seq = 2;
        UPDATE churn_users cu, posts p SET gap3 = p.gap_from_prev WHERE post_seq = 3;
        UPDATE churn_users cu, posts p SET gap4 = p.gap_from_prev WHERE post_seq = 4;
        UPDATE churn_users cu, posts p SET gap5 = p.gap_from_prev WHERE post_seq = 5;
        UPDATE churn_users cu, posts p SET gap6 = p.gap_from_prev WHERE post_seq = 6;
        UPDATE churn_users cu, posts p SET gap7 = p.gap_from_prev WHERE post_seq = 7;
        UPDATE churn_users cu, posts p SET gap8 = p.gap_from_prev WHERE post_seq = 8;
        UPDATE churn_users cu, posts p SET gap9 = p.gap_from_prev WHERE post_seq = 9;
        UPDATE churn_users cu, posts p SET gap10 = p.gap_from_prev WHERE post_seq = 10;
        UPDATE churn_users cu, posts p SET gap11 = p.gap_from_prev WHERE post_seq = 11;
        UPDATE churn_users cu, posts p SET gap12 = p.gap_from_prev WHERE post_seq = 12;
        UPDATE churn_users cu, posts p SET gap13 = p.gap_from_prev WHERE post_seq = 13;
        UPDATE churn_users cu, posts p SET gap14 = p.gap_from_prev WHERE post_seq = 14;
        UPDATE churn_users cu, posts p SET gap15 = p.gap_from_prev WHERE post_seq = 15;
        UPDATE churn_users cu, posts p SET gap16 = p.gap_from_prev WHERE post_seq = 16;
        UPDATE churn_users cu, posts p SET gap17 = p.gap_from_prev WHERE post_seq = 17;
        UPDATE churn_users cu, posts p SET gap18 = p.gap_from_prev WHERE post_seq = 18;
        UPDATE churn_users cu, posts p SET gap19 = p.gap_from_prev WHERE post_seq = 19;
        UPDATE churn_users cu, posts p SET gap20 = p.gap_from_prev WHERE post_seq = 20;

    END@@
