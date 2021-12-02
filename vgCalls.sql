-- Calls to game profit by region 
call gameProfitByRegion(35, 'WD'); 
call gameProfitByRegion(12, 'EU'); 
call gameProfitByRegion(10, 'JP'); 

-- Calls to genre ranking by region 
call genreRankingByRegion('Sports', 'WD'); 
call genreRankingByRegion('Role-playing', 'NA'); 
call genreRankingByRegion('Role-playing', 'JP'); 
 
-- Calls to published releases 
call publishedReleases('Electronic Arts', 'Sports'); 
call publishedReleases('Electronic Arts', 'Action'); 

-- Calls to add new release 
call addNewRelease('Foo Attacks', 'X360', 'Strategy', 'Stevenson Studios'); 