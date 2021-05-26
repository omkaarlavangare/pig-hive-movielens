DROP VIEW IF EXISTS worstmovies;

CREATE VIEW IF NOT EXISTS worstmovies AS
SELECT movieid, COUNT(movieid) AS ratingcount, AVG(rating) AS averagerating
FROM ratings
GROUP BY movieid
ORDER BY ratingcount DESC;

SELECT movies.title AS title, ratingcount AS no_of_ratings, averagerating AS average_of_rating
FROM worstmovies 
JOIN movies ON worstmovies.movieid = movies.movieid
WHERE averagerating < 2.0
LIMIT 10;