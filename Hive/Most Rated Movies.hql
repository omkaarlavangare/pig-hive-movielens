DROP VIEW IF EXISTS popularmovies;

CREATE VIEW IF NOT EXISTS popularmovies AS
SELECT movieId, COUNT(movieId) AS ratingcount
FROM ratings
GROUP BY movieId
ORDER BY ratingcount DESC;

SELECT movies.title AS title, ratingcount AS no_of_rating
FROM popularmovies 
JOIN movies ON popularmovies.movieId = movies.movieId
LIMIT 10;