-----------------------------------------------------------------
User Churn in Focused Q&A Sites: Characterizations and Prediction
-----------------------------------------------------------------

Given a user who posted k questions and/or answers on a
Q&A site, how can we tell whether s/he is engaged with
the site or is rather likely to leave? How about when we
observe the user for a time period of T days? What are
the most evidential factors that relate to users churning?
Question and Answer (Q&A) sites, such as StackOver
ow and Yahoo! Answers, form excellent repositories of crowd-
sourced knowledge, provided by those who ask questions and
those who answer those questions. In order to make these
sites self-sustainable and long-lasting, it is crucial for the
site owners to ensure that new users keep engaged with the
site, while also ensuring that site veterans who provide most
of the answers continue to do so. As such, quantifying the
engagement of users and preventing churn in Q&A sites are
vital to improve the lifespan of these sites.
In this work, we study a large collection of data from
stackoverflow.com to identify signicant factors that cor-
relate with newcomer user churn in the early stage and those
that relate to veterans leaving in the later stage. We con-
sider the problem under two settings: given (i) the first k
posts, or (ii) first T days of activity of a user, we aim to
identify evidential features to automatically classify users so
as to spot those who are about to leave. We find that in
both cases, the time gap between subsequent posts is the
most significant in determining the diminishing interest of
users, and other factors like answering speed, reputation of
those who answer their questions, and number of answers
received by the user come close, where we obtain accuracies
that range from 64% to 74% for changing k and T. We con-
clude by discussing how the insights provided by our study
can be used by the site owners to try and stop the users who
are about to leave.
