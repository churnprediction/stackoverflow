    UPDATE churn_time_users cu, users u 

            SET cu.period_after_creation = 

                        (CASE WHEN T = 7 THEN week_after_creation

                                          WHEN T = 15 THEN fortnight_after_creation

                                                            WHEN T = 30 THEN month_after_creation end);

