-- use the psql command
-- \i assg3_tester.sql
-- to load and run this batch file

-- Assignment Three: Tester 
-- Use the sail database
-- @author Mark Holliday
-- @version 24 February 2017


\i create_tables.sql

\i populate_tables.sql


\echo 'Problem 1: Find the names of sailors who have reserved boat 103.'

\echo '\nResult should be:\nsname\nDustin\nLubber\nHoratio\n'

SELECT distinct sname
FROM sailors as S, reserves
WHERE bid IN(SELECT bid
             FROM reserves as R
             WHERE bid = 103 AND S.sid = R.sid );

\echo 'Problem 2: Find the name of sailors who have reserved a red boat.'

\echo 'Result should be:\nsname\nDustin\nLubber\nHoratio\n'

SELECT distinct S.sname
FROM boats, sailors as S
WHERE color IN(SELECT color
               FROM reserves as R
               WHERE color = 'red' AND S.sid = R.sid);
                


\echo 'Problem 3: Find the names of sailors who have not reserved a red boat.'

\echo 'Result should be:\nsname\nBrutus\nAndy\nRusty\nZorba\nArt\nBob\n'

SELECT distinct S.sname
FROM boats, sailors as S
WHERE color NOT IN(SELECT color 
                   FROM reserves as R
                   WHERE R.sid = S.sid);


\echo 'Problem 4:Find the names of sailors who have reserved boat number 103.' 

\echo '\nResult should be:\nsname\nDustin\nLubber\nHoratio\n'

SELECT distinct S.sname
FROM sailors as S, reserves as R
WHERE S.sid = R.sid AND EXISTS(SELECT *
                               FROM reserves 
                               WHERE bid = '103');
                    


\echo 'Problem 5: Find the sailors whose rating is better than some sailor called Horatio.'

\echo 'Result should be:\nsname\nLubber\nAndy\nRusty\nZorba\nHoratio\n'

\echo 'Result should be:\nsid\n31\n32\n58\n71\n74\n'

SELECT distinct sname, sid
FROM sailors
WHERE rating > some(SELECT rating
                    FROM sailors
                    WHERE sname = 'Horatio');
                    


\echo 'Problem 6: Find the sailors whose rating is better than all the sailors called Horatio.'

\echo 'Result should be:\nsname\nRusty\nZorba\n'

\echo 'Result should be:\nsid\n58\n71\n'

SELECT distinct sname, sid
FROM sailors
WHERE rating > all(SELECT rating
                   FROM sailors
                   WHERE sname = 'Horatio');


\echo 'Problem 7: Find sailors with the highest rating.'

\echo 'Result should be:\nsname\nRusty\nZorba\n'

\echo 'Result should be:\nsid\n58\n71\n'

SELECT distinct sname, sid
FROM sailors
GROUP BY sname, sid
HAVING max(rating) >= all(SELECT max(rating)
                          FROM sailors
                          GROUP BY sname, sid);
                    



\echo 'Problem 8: Find the names of sailors who have reserved both a red and a green boat.'

\echo 'Result should be:\nsname\nDustin\nLubber\n'



(SELECT distinct S.sname
FROM boats, sailors as S
WHERE color IN(SELECT color
               FROM reserves as R
               WHERE color = 'red' AND S.sid = R.sid))

INTERSECT

(SELECT distinct S.sname
FROM boats, sailors as S
WHERE color IN(SELECT color
               FROM reserves as R
               WHERE color = 'green' AND S.sid = R.sid));





\echo 'Problem 9: Find the names of sailors who have reserved both a red and a green boat.
Yes, this is the same query as the previous query above but
your answer must be substantially different with respect to the form of 
the nested subquery that you use.'

\echo 'Result should be:\nsname\nDustin\nLubber\n'

\echo 'replace this line (including \echo) with your query'


\echo 'Problem 10: Find the names of sailors who have reserved all boats.'

\echo 'Result should be:\nsname\nDustin\n'

\echo 'replace this line (including \echo) with your query'



\echo 'Problem 11: Find the names of sailors who have reserved all boats. 
Same query as the previous one but 
your answer must be a substantively different nested subquery.'

\echo 'Result should be:\nsname\nDustin\n'

\echo 'replace this line (including \echo) with your query'

\i drop_tables.sql
