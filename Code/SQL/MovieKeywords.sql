drop table if exists MovieKeywords;

create table MovieKeywords(
    tmdbID      int,
    keywords    text,
    primary key(tmdbID),
    foreign key(tmdbID) references Movies(tmdbID)
);

load data infile '/var/lib/mysql-files/03-Movies/keywords.csv' ignore into table MovieKeywords
     fields terminated by ','
     enclosed by '"'
     lines terminated by '\n'
     ignore 1 lines
     (tmdbID,keywords);

