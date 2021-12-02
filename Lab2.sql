-- 1 --
SELECT name_first,name_last, shut_outs
FROM mlb_pitching JOIN mlb_master
	ON mlb_pitching.player_id = mlb_master.player_id 
ORDER BY shut_outs DESC, name_last;

-- 2 --
SELECT name_first,name_last,homeruns*4+triples*3+doubles*2+hits-(homeruns*4+triples*3+doubles*2) AS "Total Bases"
FROM mlb_batting JOIN mlb_master
	ON mlb_batting.player_id = mlb_master.player_id
WHERE name_last LIKE "%Smith%";

-- 3 --
SELECT name, name_first, name_last
FROM mlb_manager JOIN mlb_team
	ON mlb_manager.team_id = mlb_team.team_id
    JOIN mlb_master
    ON mlb_manager.player_id = mlb_master.player_id
WHERE league LIKE "%NL" AND division LIKE "%C";

-- 4 --
SELECT SUM(throws LIKE "%L") AS "Left-Handed Pitchers", SUM(throws LIKE "%R") AS "Right-Handed Pitchers"
FROM mlb_pitching JOIN mlb_master
	ON mlb_pitching.player_id = mlb_master.player_id;
    
-- 5 --
SELECT name,AVG(weight)
FROM mlb_pitching JOIN mlb_team
	ON mlb_pitching.team_id = mlb_team.team_id
    JOIN mlb_master
    ON mlb_pitching.player_id = mlb_master.player_id
GROUP BY name
ORDER BY AVG(weight) DESC;

-- 6 --
SELECT name_first, name_last, height, name
FROM mlb_manager JOIN mlb_master
	ON mlb_manager.player_id = mlb_master.player_id
    JOIN mlb_team
    ON mlb_manager.team_id = mlb_team.team_id
WHERE height <70;

-- 7 --
SELECT mlb_pitching.player_id, name_first, name_last, sum(outs_pitched/3)
FROM mlb_pitching JOIN mlb_master
    ON mlb_pitching.player_id = mlb_master.player_id
GROUP BY mlb_pitching.player_id
ORDER BY sum(outs_pitched/3) DESC;


-- 8 --
SELECT concat(name_first,' ',name_last) AS "Player Name", wild_pitches
FROM mlb_pitching JOIN mlb_master
	ON mlb_pitching.player_id = mlb_master.player_id
WHERE wild_pitches >= 13 AND outs_pitched >= 500;

-- 9 --
SELECT name_last, (mlb_batting.hits/at_bats) AS "Batting Avg", (outs_pitched/3) AS "Innings Pitched"
FROM mlb_master LEFT JOIN mlb_pitching
	ON mlb_master.player_id = mlb_pitching.player_id
	JOIN mlb_batting
    ON mlb_master.player_id = mlb_batting.player_id
WHERE name_last LIKE 'Z%';