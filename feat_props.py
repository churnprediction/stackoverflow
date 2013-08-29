from numpy import *
'''
giniErr = array([  2.95147717e-02,   1.05992136e-01,   4.01229683e-02,
         2.53839987e-02,   6.24353107e-01,   9.44378898e-02,
         0.00000000e+00,   9.22081756e-03,   1.71650824e-02,
         3.95454034e-04,   8.27250174e-04,   1.52571587e-04,
         3.24891559e-02,   3.07822365e-03,   1.08266431e-02,
         6.03993039e-03])

infoGain = array([ 0.02041145,  0.06671005,  0.00558245,  0.,   0.74076152,  0.115523,
                      0.,  0.00534892,  0.01867715,  0.,          0.,                0.,
             0.02698545,   0.,          0.,          0.        ]);
'''
#(Pdb) argsort(dtc.feature_importances_)
#array([ 6, 11,  9, 10, 13, 15,  7, 14,  8,  3,  0, 12,  2,  5,  1,  4])


featNames = ['gap1', 'gap2', 'gap3', 'gap4', 'gap5', 'num_answers', 'num_questions', \
        ' q_score', 'a_score', 'q_score_stddev', 'a_score_stddev', ' relative_rank_pos', \
        'answering_speed', 'tot_comments', ' mean_tot_rep_co_answerers', 'a_q_ratio', \
        'time_for_first_ans', ' mean_tot_rep_answerers', 'rep_questioner', 'a_post_length', \
        'q_post_length']

#(FeatName, FeatDesc, Draw loglog, drawHist?)
featProps = [('gap1', 'Gap between account creation and first post', True, True),
              ('gap2', 'Gap between first and second posts', True, True),
              ('gap3', 'Gap between second and third posts', True, True),
              ('gap4', 'Gap between third and fourth posts', True, True),
              ('gap5',  'Gap between fourth and fifth posts', True, True),
              ('num_answers',  'Number of answers among the first five posts', False, False),
              ('num_questions', 'Number of questions obtained among the first five questions', False, False),
              ('q_score', 'Mean score obtained for questions', True, False),
              ('a_score', 'Mean score obtained for the answers', True, False),
              ('q_score_stddev', 'Stddev of score obtained for questions', True, False),
              ('a_score_stddev', 'Stddev of score obtained for answers', True, False),
              ('relative_rank_pos', 'Mean of Total_number_of_answers/Rank_of_the_answer'),
              ('answering_speed', 'Time between a question posted and the answer made by user', False, False),
              ('tot_comments', 'Average number of comments made on the users posts', True, True),
              ('mean_tot_rep_co_answerers', 'Mean of the average reputation of co-answerers', True, True),
              ('a_q_ratio', 'Number_of_answers/Number_of_questions', False, True),
              ('time_for_first_ans', 'Time taken for the first answer to arrive for the question posted by user', True, True),
              ('mean_tot_rep_answerers', 'Mean of the average reputation of answerers', True, True),
              ('rep_questioner', 'Mean reputation of the question-asker to whom the user answered', True, True),
              ('a_post_length', 'Average length of answers', True, True),
              ('q_post_length', 'Average length of questions', True, True) ]

user_categories = ['0 posts', '>6 posts']


if __name__ == "__main__":
    for featIdx in reversed(argsort(infoGain)):
       print featNames[featIdx],'  ',infoGain[featIdx] 
   #print infoGain[featIdx]#,'  ',infoGain[featIdx] 
