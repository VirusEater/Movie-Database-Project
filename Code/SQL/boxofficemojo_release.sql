drop table if exists boxofficemojo_releases;

create table boxofficemojo_releases(
    identifier              char(15),
    old_bomojo_id           varchar(100),
    title                   varchar(255),
    imdb_title_identifier   char(10),
    imdb_title_bomojo_url   varchar(255),
    budget                  bigint,
    distributor_name        varchar(50),
    domestic_gross          bigint,
    international_gross     bigint,
    worldwide_gross         bigint,
    domestic_opening        int,
    release_date            date,
    widest_release          varchar(20),
    synopsis                varchar(10000),
    genres                  varchar(255),
    mpaa_rating             varchar(50),
    running_time            varchar(50),
    hsx_symbol              char(1),
    bomojo_type             char(7),
    url                     varchar(255),
    updated_at              varchar(50),

    primary key(identifier)
    );

load data infile 
        '/var/lib/mysql-files/03-Movies/hsx_bomojo_data/boxofficemojo_releases.csv'
        into table boxofficemojo_releases
    fields terminated by ','
    enclosed by '"'
    lines terminated by '\n'
    ignore 1 lines
    (identifier,old_bomojo_id,title,imdb_title_identifier,imdb_title_bomojo_url,
    @budget,distributor_name,@domestic_gross,@international_gross,@worldwide_gross,
    domestic_opening,@release_date,widest_release,synopsis,genres,mpaa_rating,
    running_time,hsx_symbol,bomojo_type,url,updated_at)
    
    set budget = if(@budget = '', null, @budget),
        domestic_gross = if(@domestic_gross = '', null, @domestic_gross),
        international_gross = if(@international_gross = '', null, @international_gross),
        worldwide_gross = if(@worldwide_gross = '', null, @worldwide_gross),
        release_date = if(@release_date = '', null, @release_date);
    