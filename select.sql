/* Задание 2 */
SELECT name, duration
  FROM track
 WHERE duration = (SELECT MAX(duration) FROM track);
 
SELECT name, duration
  FROM track
 WHERE duration >= 210
 ORDER BY duration;
 
SELECT name, release_date
  FROM collection
 WHERE EXTRACT (YEAR FROM release_date)
       BETWEEN 2018 AND 2020;
 ORDER BY release_date;
 
SELECT pseudonym
  FROM songwriter
 WHERE TRIM(pseudonym) NOT LIKE '% %';
 
SELECT name
  FROM track
 WHERE LOWER(name) LIKE '%мой%'
    OR LOWER(name) LIKE '%my%';
    
/* Задание 3 */
SELECT name, COUNT(sg.songwriter_id)
  FROM genres AS g
  JOIN singer_genres AS sg
    ON sg.genres_id = g.genres_id 
 GROUP BY g.genres_id;

SELECT a.name, release_date, COUNT(t.album_id)
  FROM album AS a
  LEFT JOIN track AS t
    ON a.album_id = t.album_id
 WHERE EXTRACT (YEAR FROM release_date)
	     BETWEEN 2019 AND 2020   
 GROUP BY a.album_id;

SELECT a.name, release_date, AVG(t.duration)
  FROM album AS a
  LEFT JOIN track AS t
    ON a.album_id = t.album_id
 GROUP BY a.album_id;

SELECT pseudonym
  FROM songwriter AS s
  LEFT JOIN (SELECT s.songwriter_id
  			       FROM songwriter AS s
  		         JOIN singer_album AS sa
    			       ON sa.songwriter_id = s.songwriter_id
  		         JOIN album AS a
    			       ON sa.album_id = a.album_id
 			        WHERE EXTRACT (YEAR FROM a.release_date) = 2020
 			        GROUP BY s.songwriter_id)	AS sample
 	  ON s.songwriter_id = sample.songwriter_id
 WHERE sample.songwriter_id IS NULL
 GROUP BY s.songwriter_id;

SELECT c.name
  FROM collection AS c
  JOIN track_collection AS tc
    ON c.collection_id = tc.collection_id
  JOIN track AS t
    ON tc.track_id = t.track_id
  JOIN singer_album AS sa
    ON t.album_id = sa.album_id
  JOIN songwriter AS s
    ON sa.songwriter_id = s.songwriter_id 
 WHERE s.pseudonym = 'Высоцкий'
 GROUP BY c.name;

/* Задание 4 */
SELECT a.name, COUNT(sg.genres_id)
  FROM album AS a
  JOIN singer_album AS sa
    ON a.album_id = sa.album_id
  JOIN singer_genres AS sg
    ON sa.songwriter_id = sg.songwriter_id
 GROUP BY a.name
HAVING COUNT(sg.genres_id) > 1;

SELECT t.name
  FROM track AS t
  LEFT JOIN track_collection AS tc
    ON t.track_id = tc.track_id
 WHERE tc.track_id IS NULL
 GROUP BY t.name;

SELECT pseudonym
  FROM songwriter AS s
  JOIN singer_album AS sa
    ON s.songwriter_id = sa.songwriter_id
  JOIN track AS t
    ON sa.album_id = t.album_id
 WHERE t.duration = (SELECT MIN(duration) FROM track)
 GROUP BY s.songwriter_id;

SELECT a.name, COUNT(t.album_id)
  FROM album AS a
  JOIN track AS t
    ON a.album_id = t.album_id
 GROUP BY a.name
HAVING COUNT(t.album_id) = (SELECT COUNT(t.album_id)
							                FROM album AS a
							                JOIN track AS t
							                	ON a.album_id = t.album_id
							               GROUP BY a.name
							               ORDER BY COUNT(t.album_id)
							               LIMIT 1);
 