drop table if exists bomojoReleases;

create table bomojoReleases(
    bomojoID                char(15),
    imdbID                  char(10),
    distributorName         varchar(50),
    domesticGross           bigint,
    internationalGross      bigint,
    worldwideGross          bigint,
    mpaa                    varchar(50),
    primary key(bomojoID)
    );

insert into bomojoReleases
    select identifier, imdb_title_identifier, distributor_name, domestic_gross,
            international_gross, worldwide_gross, mpaa_rating
    from boxofficemojo_releases;
    