
    UPDATE users set week_after_creation = DATE_ADD(creationdate, INTERVAL 1 WEEK);
    UPDATE users set fortnight_after_creation = DATE_ADD(creationdate, INTERVAL 15 DAY);
    UPDATE users set month_after_creation = DATE_ADD(creationdate, INTERVAL 1 MONTH);

    UPDATE users u SET u.pre_week_posts = 
        (SELECT count(*) FROM posts p 
            WHERE p.owneruserid = u.id 
                AND timestampdiff(WEEK, u.creationdate, p.creationdate) < 1);

    UPDATE users u SET u.pre_fortnight_posts = 
        (SELECT count(*) FROM posts p 
            WHERE p.owneruserid = u.id 
                AND timestampdiff(DAY, u.creationdate, p.creationdate) < 15);

    UPDATE users u SET u.pre_month_posts = 
        (SELECT count(*) FROM posts p 
            WHERE p.owneruserid = u.id 
                AND timestampdiff(MONTH, u.creationdate, p.creationdate) < 1);

    UPDATE users u SET u.post_week_halfyear_posts = 
        (SELECT count(*) FROM posts p 
            WHERE p.owneruserid = u.id 
                AND timestampdiff(MONTH, 
                    week_after_creation, p.creationdate) < 6);

    UPDATE users u SET u.post_fortnight_halfyear_posts = 
        (SELECT count(*) FROM posts p 
            WHERE p.owneruserid = u.id 
                AND timestampdiff(MONTH, 
                    fortnight_after_creation, p.creationdate) < 6);

    UPDATE users u SET u.post_month_halfyear_posts = 
        (SELECT count(*) FROM posts p 
            WHERE p.owneruserid = u.id 
                AND timestampdiff(MONTH, 
                    month_after_creation, p.creationdate) < 6);

    UPDATE users u set u.week_churner = IF(uu.post_week_halfyear_posts = 0, 1, 0);
    UPDATE users u set u.fortnight_churner = 
            IF(u.post_fortnight_halfyear_posts = 0, 1, 0);
    UPDATE users u set u.month_churner = IF(u.post_month_halfyear_posts = 0, 1, 0);

    
