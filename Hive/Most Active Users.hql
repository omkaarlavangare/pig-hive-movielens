SELECT userid, COUNT(userid) AS moviesrated
FROM ratings
GROUP BY userid
ORDER BY moviesrated DESC;