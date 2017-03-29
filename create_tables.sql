-- @author Evan Arroyo
-- @author Joshua Sims
-- @version 29 March 2017

CREATE TABLE sailors
(
    sid     INTEGER,
    sname   VARCHAR(20),
    rating  INTEGER,
    age     REAL,
    PRIMARY KEY(sid)
);

CREATE TABLE boats
(
    bid     INTEGER,
    sname   VARCHAR(20),
    color   VARCHAR(10),
    PRIMARY KEY(bid)
);


CREATE TABLE reserves
(
    sid     INTEGER,
    bid     INTEGER,
    day     DATE,
    PRIMARY KEY(sid,bid),
    FOREIGN KEY(sid) REFERENCES sailors,
    FOREIGN KEY(bid) REFERENCES boats
);
