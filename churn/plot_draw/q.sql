SELECT churner, k, p.score FROM churn_users cu, posts p WHERE cu.uid = p.owneruserid AND p.post_seq <= cu.k AND posttypeid = 1 AND p.score > 0;
