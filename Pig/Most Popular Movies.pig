movies = load '/user/maria_dev/pigInput/movies.csv' USING PigStorage(',') 
as (movieId:int, title:chararray, genres:chararray);

ratings = load '/user/maria_dev/pigInput/ratings.csv' USING PigStorage(',') 
as (userId:int,movieId:int,rating:float,timestamp:int);

Idsandtitlesonly = FOREACH movies GENERATE movieId, title;

Groupedbyrating = GROUP ratings BY movieId;

Averageratings = FOREACH Groupedbyrating GENERATE group AS movieId, AVG(ratings.rating) 
AS averageratings, COUNT(ratings.rating) AS numberofratings;

Bestmovies = FILTER Averageratings BY averageratings > 4.0;

Finalresults = JOIN Bestmovies BY movieId,Idsandtitlesonly BY movieId;

Finalresultsbynameonly = FOREACH Finalresults GENERATE Idsandtitlesonly::title 
AS moviename, Bestmovies::averageratings AS averageratings, Bestmovies::numberofratings AS numberofratings;

Finalresultssorted = ORDER Finalresultsbynameonly BY numberofratings DESC;

dump Finalresultssorted;