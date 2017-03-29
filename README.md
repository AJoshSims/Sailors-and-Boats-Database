## Creates the tables, populates the tables, queries, and deletes the tables for a database containing information describing sailors, boats, and boat reservations.

Authors: Evan Arroyo and Joshua Sims  
Date: 29 March 2017

**The psql command "\i assg3_tester.sql" creates the tables, populates the
tables, queries the database, and deletes the tables.**

### Here are short descriptions of each file associated with this project
* create_tables.sql
	* Creates the tables for the data
* data/
	* The data
* populate_tables.sql
	* Populates the tables with the data
* drop_tables.sql
	* Removes the tables previously created for the data
* assg3_tester.sql
    * Executes each of the aforementioned .sql files and queries the database

The solutions to problems 1, 2, 3, and 8 use correlated subqueries. The correlated subqueries therein are identified as such because they are reevaluated for each row of the virtual table defined by the FROM clause of the outer query.

