-- 1) What's the average energy of all hardstyle tracks? 
SELECT track_genre AS "Genre", avg(energy) as "Avg. Energy" 
FROM dataset WHERE track_genre == "hardstyle";

-- 2) What are the average stats of all sleep tracks?
SELECT track_genre as "Genre", avg(energy), avg(speechiness), avg(danceability), avg(acousticness) 
FROM dataset WHERE track_genre == "sleep";


-- 3) What are the most popular genres on average?
SELECT track_genre AS "Genre", round(avg(popularity),2) AS "Most popular genre" 
FROM dataset GROUP BY track_genre ORDER BY "Most popular genre" DESC;

 
 -- 4) What is the highest energy spread within each genre?
SELECT track_genre AS "Genre", max(energy) - min(energy) AS "Energy Spread" FROM dataset GROUP BY track_genre ORDER BY "Energy Spread" DESC;
 

-- 5) What are the most and least energetic genres on average?
SELECT track_genre AS "Genre", round(avg(energy),2) AS "Most energetic genres" 
FROM dataset GROUP BY track_genre ORDER BY "Most energetic genres" DESC;

CREATE TEMP TABLE energetic_genres AS SELECT track_genre AS "Genre", round(avg(energy),2) AS "Most energetic genres" 
FROM dataset GROUP BY track_genre ORDER BY "Most energetic genres" DESC;

-- 6) Which genres differ the most in terms of energy on average? Show the entire list of differences.
SELECT "Genre", "Most energetic genres" - min("Most energetic genres") OVER () AS "Energy Difference to Minimum" 
FROM energetic_genres ORDER BY "Difference" DESC;


-- Alternative: Calculate Avg. - Max for each genre - Displays Energy difference to Maximum
CREATE TEMP TABLE "avg_energies" AS
SELECT track_genre, avg(energy) as avg_energy from dataset group by track_genre;

SELECT 
	track_genre, 
	avg_energy, 
	(select max(avg_energy) from avg_energies) 
	as max_energy, 
	((select max(avg_energy) from avg_energies) - avg_energy) 
	as distance 
FROM avg_energies 
ORDER BY distance DESC 
LIMIT 1;
 
-- 7) Find a pair of genres where the maximum energy of the 1st equals the minimum energy of the 2nd
CREATE TEMP TABLE MaxE AS SELECT track_genre AS Genre, max(energy) AS MaxEnergy 
FROM dataset GROUP BY track_genre ORDER BY "Max Energy";

CREATE TEMP TABLE MinE AS SELECT track_genre AS Genre, min(energy) AS MinEnergy 
FROM dataset GROUP BY track_genre ORDER BY "Min Energy";

SELECT MaxE.Genre AS "GenreA", MinE.Genre AS "GenreB", MaxE.MaxEnergy AS "Max Energy", MinE.MinEnergy AS "Min Energy", (MaxE.MaxEnergy - MinE.MinEnergy) AS Difference
FROM MaxE FULL OUTER JOIN MinE ORDER BY Difference LIMIT 20;
-- There is no match! The closest pair is tango (Max Energy 0.832) and hardstyle (Min Energy 0.565)


-- 8) What are the genres that differ the most in terms of average acousticness?
CREATE TEMP TABLE "avg_acousticnesses" AS
SELECT track_genre, avg(acousticness) AS avg_acousticness 
FROM dataset GROUP BY track_genre ORDER BY avg_acousticness;

CREATE TEMP TABLE "genre_max_ac_distance" AS
SELECT 
	track_genre, 
	avg_acousticness, 
	(select max(avg_acousticness) from avg_acousticnesses) 
	as max_acousticness, 
	((select max(avg_acousticness) from avg_acousticnesses) - avg_acousticness) 
	as distance 
FROM avg_acousticnesses
ORDER BY distance DESC LIMIT 1;

select 
a.track_genre as genreA,
b.track_genre as genreB,
a.avg_acousticness as avg_ac_A,
b.avg_acousticness as avg_ac_B,
a.distance
FROM genre_max_ac_distance as a LEFT JOIN avg_acousticnesses as b on a.max_acousticness == b.avg_acousticness


-- 9) What are the genres that differ the most in terms of a weighted aggregate of average speechiness, danceability and acousticness? 
SELECT track_genre as "Genre", (2 * avg(speechiness) + 3* avg(danceability) + 1.5 *avg(acousticness)) AS "speech/dance/acoustic-Aggregate" 
FROM dataset GROUP BY track_genre ORDER BY "speech/dance/acoustic-Aggregate" DESC;



-- 10) What are the genres with maximum "distance" with respect to average danceability and acousticness?
CREATE TEMP TABLE DanceA AS SELECT track_genre AS Genre, avg(danceability) AS avgdance FROM dataset GROUP BY track_genre;
CREATE TEMP TABLE DanceB AS SELECT track_genre AS Genre, avg(danceability) AS avgdance FROM dataset GROUP BY track_genre;
CREATE TEMP TABLE DanceSquare AS SELECT DanceA.Genre AS GenreA, DanceB.Genre AS GenreB, power((DanceA.avgdance - DanceB.avgdance),2) AS powdance 
FROM DanceA FULL OUTER JOIN DanceB;

CREATE TEMP TABLE AcousticA AS SELECT track_genre AS Genre, avg(acousticness) AS avgacoustic FROM dataset GROUP BY track_genre;
CREATE TEMP TABLE AcousticB AS SELECT track_genre AS Genre, avg(acousticness) AS avgacoustic FROM dataset GROUP BY track_genre;
CREATE TEMP TABLE AcousticSquare AS SELECT AcousticA.Genre AS GenreA, AcousticB.Genre AS GenreB, power((AcousticA.avgacoustic - AcousticB.avgacoustic),2) AS powacoustic 
FROM AcousticA FULL OUTER JOIN AcousticB;

SELECT A.GenreA AS GenreA, A.GenreB AS GenreB, power((A.powacoustic + B.powdance),0.5) AS distance 
FROM AcousticSquare AS A JOIN DanceSquare AS B ON A.GenreA = B.GenreA AND A.GenreB = B.GenreB ORDER BY distance DESC;