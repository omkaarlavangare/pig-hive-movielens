DROP VIEW IF EXISTS bestmovies;

CREATE VIEW IF NOT EXISTS bestmovies AS
SELECT movieid, COUNT(rating) AS ratingcount, AVG(rating) AS averagerating
FROM ratings
GROUP BY movieid
ORDER BY ratingcount DESC;

SELECT movies.title AS title, ratingcount AS no_of_rating, averagerating AS average_of_rating
FROM bestmovies
JOIN movies ON bestmovies.movieid = movies.movieid
WHERE averagerating > 4.0
LIMIT 10;