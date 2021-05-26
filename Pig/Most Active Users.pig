
ratings = load '/user/maria_dev/pigInput/ratings.csv' USING PigStorage(',') 
as (userId:int,movieId:int,rating:float,timestamp:int);

Groupedbyrating = GROUP ratings BY userId;

Countingratings = FOREACH Groupedbyrating GENERATE group AS userId,
COUNT(ratings.rating) AS numberofmoviesrated;

Mostactiveusers = ORDER Countingratings BY numberofmoviesrated DESC;

dump Mostactiveusers;