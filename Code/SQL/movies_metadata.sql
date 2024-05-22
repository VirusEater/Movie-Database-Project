drop table if exists movies_metadata;

create table movies_metadata (
    adult char(5),
    belongs_to_collection char(255),
    budget bigint,
    genres TEXT,
    homepage char(255),
    id int,
    imdb_id char(10),
    original_language char(2),
    original_title varchar(255),
    overview varchar (1000),
    popularity float,
    poster_path varchar(255),
    production_companies TEXT,
    production_countries TEXT,
    release_date date,
    revenue bigint,
    runtime int,
    spoken_languages TEXT,
    status varchar(20),
    tagline TEXT,
    title varchar(255),
    video char(5),
    vote_average float,
    vote_count int,
    primary key (id)
);

load data infile '/var/lib/mysql-files/03-Movies/movies_metadata.csv' ignore into table movies_metadata
     fields terminated by ','
     enclosed by '"'
     lines terminated by '\n'
     ignore 1 lines
     (adult,belongs_to_collection,budget,genres,homepage,id,@imdb_id,
     original_language,original_title,overview,@popularity,poster_path,production_companies,
     production_countries,@release_date,@revenue,@runtime,spoken_languages,status,tagline,title,video,@vote_average,vote_count)
     set runtime = if(@runtime = '', NULL, @runtime),
        popularity = if(@popularity = '',NULL,@popularity),
        revenue = if (@revenue = '',NULL,@revenue),
        release_date = if (@release_date = '',NULL,@release_date),
        vote_average = if (@vote_average = '',NULL,@vote_average),
        vote_count = if (@vote_count = '',NULL,@vote_count),
        imdb_id = if(@imdb_id = '', NULL, @imdb_id);

