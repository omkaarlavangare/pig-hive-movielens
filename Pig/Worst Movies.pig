movies = load '/user/maria_dev/pigInput/movies.csv' USING PigStorage(',') 
as (movieId:int, title:chararray, genres:chararray);

ratings = load '/user/maria_dev/pigInput/ratings.csv' USING PigStorage(',') 
as (userId:int,movieId:int,rating:float,timestamp:int);

Idsandtitlesonly = FOREACH movies GENERATE movieId, title;

Groupedbyrating = GROUP ratings BY movieId;

Averageratings = FOREACH Groupedbyrating GENERATE group AS movieId, AVG(ratings.rating) 
AS averageratings, COUNT(ratings.rating) AS numberofratings;

Worstmovies = FILTER Averageratings BY averageratings < 2.0;

Finalresults = JOIN Worstmovies BY movieId,Idsandtitlesonly BY movieId;

Finalresultsbynameonly = FOREACH Finalresults GENERATE Idsandtitlesonly::title 
AS moviename, Worstmovies::averageratings AS averageratings, Worstmovies::numberofratings AS numberofratings;

Finalresultssorted = ORDER Finalresultsbynameonly BY numberofratings DESC;

dump Finalresultssorted;