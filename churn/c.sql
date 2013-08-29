UPDATE posts SET rep_answerers = null WHERE posttypeid = 2;



UPDATE posts p1, posts p2, users u

    SET p1.rep_answerers = 

            ((p2.answercount*p2.rep_answerers) - u.reputation)/(p2.answercount - 1)

                WHERE p1.parentid = p2.id

                    AND p1.owneruserid = u.id AND p2.answercount <> 1

                        AND p1.posttypeid = 2;


