drop table if exists MovieProductions;

create table MovieProductions(
    tmdbID                  int,
    productionCompanies     text,
    productionCountries     text,
    primary key(tmdbID),
    foreign key(tmdbID) references Movies(tmdbID)
);

insert into MovieProductions
    select id, production_companies, production_countries
    from movies_metadata;