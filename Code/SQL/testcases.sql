-- -----------------------------------------------------------------------------
--
-- ECE 356 Project
-- serverside testcases

-- This file contains testcases to test the server-side schema


-- TEST 1) 
-- What's is being tested: 	
select 'TEST 1: Select the language of a movie that is part of movies_metadata' as '';
-- Input/setup: 
select EnglishTitle, originalLanguage from 
    Movies inner join MovieLanguages using (tmdbID) 
        where EnglishTitle = 'Neither Wolf Nor Dog';
-- Expected output:	This should return a row that 
--                  has the title of the movie in the first column,
--                  and the language in the second column.		
-- Status: 			PASS 
 

-- TEST 2) 
-- What's is being tested:
select 'TEST 2: No duplicated tuples (imdbID, genres) in MovieGenres' as '';
-- Input/setup: 
-- No duplicated tuples (movieID, genre) in MovieGenre due to the enforcement of the primary key (movieID, genre) on it 
select count(*) as 'count all (imdbID, genres) tuples' FROM MovieGenres;
select distinct count(*) as 'count distinct (imdbID, genres) tuples' FROM MovieGenres;
-- Expected output: Counts must be the same for the following commands 
--                  as all duplicated entries should be deleted due to the primary key (movieID, genre) 
-- Status: 			PASS


-- TEST 3) 
-- What's is being tested:
select 'TEST 3: No duplicated tuples (tmdbID, originalLanguage, languages) in MovieLanguage' as '';
-- Input/setup: 
-- No duplicated tuples (tmdbID, originalLanguage, languages) in MovieLanguages 
-- due to the enforcement of the primary key tmdbID on it 
select count(*) as 'count all (tmdbID, originalLanguage, languages) tuples' FROM MovieLanguages;
select distinct count(*) as 'count distinct (tmdbID, originalLanguage, languages) tuples' FROM MovieLanguages;
-- Expected output: Counts must be the same for the following commands 
-- as all duplicated entries should be deleted due to the primary key tmdbID
-- Status: 			PASS

-- TEST 4) 
-- What's is being tested:
select 'TEST 4: Select 5 distinct movies titles in English' as ''; 
-- Input/setup: 
-- There are 11320 movies in English 
select EnglishTitle from Movies inner join MovieLanguages using (tmdbID) where originalLanguage = 'en' limit 5;
-- Expected output: 5 movie titles in English 
-- Status: 			PASS

-- TEST 5) 
-- What's is being tested: 
select 'TEST 5: select distinct First names of directors whose first name start with Fred' as '';
-- Input/setup: 
with director_distinct as 
	(select distinct director from MovieCrewsCasts where director like 'Fred%'), 
	director_substring as 
	(select substring_index(director, ' ', 1) as ss_name from director_distinct)
select distinct ss_name from director_substring;
-- Expected output: 2 Distinct First names of directors whose first name start with Fred
-- Status: 			PASS

