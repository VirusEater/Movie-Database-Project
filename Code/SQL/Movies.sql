drop table if exists Movies;

create table Movies(
    tmdbID      int,
    imdbID      char(10),
    originalTitle   varchar(255),
    EnglishTitle    varchar(255),
    releaseDate     date,
    runtime         int,
    overview        varchar(1000),
    status          varchar(20),
    budget          bigint,
    tagline         text,
    voteAverage     float,
    voteCount       int,
    primary key(tmdbID)
);

insert ignore into Movies
    select id, imdb_id, original_title, title, release_date, runtime, 
            overview, status, budget, tagline, vote_average, vote_count
    from movies_metadata;