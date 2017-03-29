-- use the psql command
-- \i assg3_tester.sql
-- to load and run this batch file

-- Assignment Three: Tester 
-- Use the sail database
-- @author Mark Holliday
-- @author Evan Arroyo
-- @author Joshua Sims
-- @version 29 March 2017



\i create_tables.sql

\i populate_tables.sql



\echo 'Problem 1: Find the names of sailors who have reserved boat 103.'

\echo '\nResult should be:\nsname\nDustin\nLubber\nHoratio\n'

SELECT DISTINCT s.sname
FROM sailors AS s, reserves
WHERE bid IN (
    SELECT bid
    FROM reserves AS r
    WHERE bid = 103 AND s.sid = r.sid);



\echo 'Problem 2: Find the name of sailors who have reserved a red boat.'

\echo 'Result should be:\nsname\nDustin\nLubber\nHoratio\n'

SELECT DISTINCT s.sname
FROM boats, sailors AS s
WHERE color IN (
    SELECT color
    FROM reserves AS r
    WHERE color = 'red' AND s.sid = r.sid);
                


\echo 'Problem 3: Find the names of sailors who have not reserved a red boat.'

\echo 'Result should be:\nsname\nBrutus\nAndy\nRusty\nZorba\nArt\nBob\n'

SELECT DISTINCT s.sname
FROM boats, sailors AS s
WHERE color NOT IN (
    SELECT color 
    FROM reserves AS r
    WHERE r.sid = s.sid);



\echo 'Problem 4:Find the names of sailors who have reserved boat number 103.' 

\echo '\nResult should be:\nsname\nDustin\nLubber\nHoratio\n'

SELECT DISTINCT s.sname
FROM sailors AS s, reserves AS r
WHERE s.sid = r.sid AND EXISTS (
    SELECT *
    FROM reserves 
    WHERE bid = '103');
                    


\echo 'Problem 5: Find the sailors whose rating is better than some sailor called Horatio.'

\echo 'Result should be:\nsname\nLubber\nAndy\nRusty\nZorba\nHoratio\n'

\echo 'Result should be:\nsid\n31\n32\n58\n71\n74\n'

SELECT DISTINCT sname, sid
FROM sailors
WHERE rating > SOME (
    SELECT rating
    FROM sailors
    WHERE sname = 'Horatio');
                    


\echo 'Problem 6: Find the sailors whose rating is better than all the sailors called Horatio.'

\echo 'Result should be:\nsname\nRusty\nZorba\n'

\echo 'Result should be:\nsid\n58\n71\n'

SELECT DISTINCT sname, sid
FROM sailors
WHERE rating > ALL (
    SELECT rating
    FROM sailors
    WHERE sname = 'Horatio');



\echo 'Problem 7: Find sailors with the highest rating.'

\echo 'Result should be:\nsname\nRusty\nZorba\n'

\echo 'Result should be:\nsid\n58\n71\n'

SELECT DISTINCT sname, sid
FROM sailors
GROUP BY sname, sid
HAVING MAX(rating) >= ALL (
    SELECT MAX(rating)
    FROM sailors
    GROUP BY sname, sid);
                    



\echo 'Problem 8: Find the names of sailors who have reserved both a red and a green boat.'

\echo 'Result should be:\nsname\nDustin\nLubber\n'

SELECT DISTINCT s.sname
FROM boats, sailors AS s
WHERE color IN (
    SELECT color
    FROM reserves AS r
    WHERE color = 'red' AND s.sid = r.sid)
INTERSECT
SELECT DISTINCT s.sname
FROM boats, sailors AS s
WHERE color IN (
    SELECT color
    FROM reserves AS r
    WHERE color = 'green' AND s.sid = r.sid);



\echo 'Problem 9: Find the names of sailors who have reserved both a red and a green boat. Yes, this is the same query as the previous query above but your answer must be substantially different with respect to the form of the nested subquery that you use.'

\echo 'Result should be:\nsname\nDustin\nLubber\n'

WITH sailors_who_reserved_red_and_green AS
(
	WITH red_boats AS 
	(
		SELECT bid 
		FROM boats 
		WHERE color = 'red'
	),
	blue_boats AS
	(
		SELECT bid
		FROM boats
		WHERE color = 'green'
	)
	SELECT sid 
	FROM reserves NATURAL JOIN red_boats
	INTERSECT
	SELECT sid 
	FROM reserves NATURAL JOIN blue_boats
)
SELECT sname
FROM sailors NATURAL JOIN sailors_who_reserved_red_and_green;



\echo 'Problem 10: Find the names of sailors who have reserved all boats.'

\echo 'Result should be:\nsname\nDustin\n'

WITH sailors_who_reserved_all_boats AS 
(
	SELECT sid 
	FROM reserves
	GROUP BY sid
	HAVING COUNT(bid) = (SELECT COUNT(bid) FROM boats)
)
SELECT sname
FROM sailors NATURAL JOIN sailors_who_reserved_all_boats;



\echo 'Problem 11: Find the names of sailors who have reserved all boats. Same query as the previous one but your answer must be a substantively different nested subquery.'

\echo 'Result should be:\nsname\nDustin\n'

SELECT sname 
FROM sailors
WHERE sid in 
	(SELECT sid FROM reserves GROUP BY sid HAVING COUNT(bid) = 
	(SELECT COUNT(bid) FROM BOATS));



\i drop_tables.sql
