-- @author Evan Arroyo
-- @author Joshua Sims
-- @version 29 March 2017

CREATE TABLE sailors(

    sid     INTEGER
    sname   varchar(20),
    rating  INTEGER
    age     REAL
    primary key(sid)

);

CREATE TABLE boats(

    bid     INTEGER
    sname   varchar(20),
    color   varchar(10),
    primary key(bid)

);


CREATE TABLE reserves(

    sid     INTEGER
    bid     INTEGER
    day     DATE
    primary key(sid,bid),
    foreign key(sid) references sailors,
    foreign key(bid) references boats

);
