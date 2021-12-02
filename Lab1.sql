SELECT *
FROM MLB_TEAM;

-- 1 --
SELECT team_id, league, division, name
FROM MLB_TEAM;

-- 2 --
SELECT MAX(complete_games)
FROM mlb_pitching;

-- 3 --
SELECT COUNT(player_id)
FROM mlb_master
WHERE debut  BETWEEN '2014-09-10' AND '2014-09-30';

-- 4 --
SELECT MAX(datediff(final_game,debut))
FROM mlb_master;

-- 5 --
SELECT AVG(opp_batting_avg)
FROM mlb_pitching
WHERE games >= 25;
-- 6 --
SELECT MAX(attendance),MIN(attendance),MAX(attendance)-MIN(attendance)
FROM mlb_team;

-- 7 --
SELECT park
FROM mlb_team
WHERE park LIKE '%park%'
			OR park LIKE '%field%'
			OR park LIKE '%stadium%'
ORDER BY park;

-- 8 --
SELECT COUNT(team_id)
FROM mlb_manager
WHERE stint = 2;

-- 9 --
SELECT MAX(stolen_bases/(stolen_bases + caught_stealing))
FROM mlb_batting
WHERE (stolen_bases + caught_stealing) > 20;

-- 10 --
SELECT name, league, won_ws, won_lg, won_div, won_wc
FROM mlb_team
WHERE won_div = 'Y' OR won_wc = 'Y'
ORDER BY won_ws DESC, won_lg DESC, won_div DESC, won_wc DESC, name;