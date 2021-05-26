movies = load '/user/maria_dev/pigInput/movies.csv' USING PigStorage(',') 
as (movieId:int, title:chararray, genres:chararray);

ratings = load '/user/maria_dev/pigInput/ratings.csv' USING PigStorage(',') 
as (userId:int,movieId:int,rating:float,timestamp:int);

Idsandtitlesonly = FOREACH movies GENERATE movieId, title;

Groupedbyrating = GROUP ratings BY movieId;

Numberofratings = FOREACH Groupedbyrating GENERATE group AS movieId, 
COUNT(ratings.rating) AS numberofratings;

Finalresults = JOIN Numberofratings BY movieId, Idsandtitlesonly BY movieId;

Finalresultsbynameonly = FOREACH Finalresults GENERATE Idsandtitlesonly::title 
AS moviename, Numberofratings::numberofratings AS numberofratings;

Finalresultssorted = ORDER Finalresultsbynameonly BY numberofratings DESC;

dump Finalresultssorted;