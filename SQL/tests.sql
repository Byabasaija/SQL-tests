-- Basic select

SELECT population FROM world
WHERE name = 'Germany'

SELECT name, population FROM world
WHERE name IN ('Sweden', 'Norway', 'Denmark');

SELECT name, area FROM world
WHERE area BETWEEN 200000 AND 250000

-- Advanced Select

SELECT name FROM world
WHERE name LIKE 'Y%'

SELECT name FROM world
WHERE name LIKE '%y'

SELECT name FROM world
WHERE name LIKE '%x%'

SELECT name FROM world
WHERE name LIKE '%land'

SELECT name FROM world
WHERE name LIKE 'C%ia'

SELECT name FROM world
WHERE name LIKE '%oo%'

SELECT name FROM world
WHERE name LIKE '%a%a%a%'

SELECT name FROM world
WHERE name LIKE '_t%'
ORDER BY name

SELECT name FROM world
WHERE name LIKE '%o__o%'

SELECT name FROM world
WHERE name LIKE '____'

SELECT name FROM world
WHERE name = capital

SELECT name FROM world
WHERE capital = concat(name, ' City')

SELECT capital, name FROM world
WHERE capital LIKE concat('%', name, '%')

SELECT capital, name FROM world
WHERE capital LIKE concat(name, '_%')

SELECT name,
REPLACE(capital, name, '') FROM world
WHERE capital LIKE concat(name, '_%')

-- Select from world

SELECT name, continent, population FROM world

SELECT name FROM world
WHERE population > 200000000

SELECT name, gdp/population FROM world
WHERE population > 200000000

SELECT name, population/1000000 FROM world
WHERE continent = 'South America'

SELECT name, population FROM world
WHERE name IN ('France', 'Germany', 'Italy')

SELECT name FROM world
WHERE name LIKE '%United%'

SELECT name, population, area FROM world
WHERE population > 250000000 OR area > 3000000

SELECT name, population, area FROM world
WHERE population > 250000000 XOR area > 3000000

SELECT name, ROUND(population/1000000, 2), ROUND(gdp/1000000000, 2) FROM world
WHERE continent = 'South America'

SELECT name, ROUND(gdp/population, -3) FROM world
WHERE gdp > 1000000000000

SELECT name, capital FROM world
WHERE LENGTH(name) = LENGTH(capital)

SELECT name, capital FROM world
WHERE LEFT(name, 1) = LEFT(capital, 1)
AND NOT name = capital

SELECT name FROM world
WHERE name LIKE '%a%'
AND name LIKE '%e%'
AND name LIKE '%i%'
AND name LIKE '%o%'
AND name LIKE '%u%'
AND name NOT LIKE '% %'

-- Select from nobel

SELECT yr, subject, winner FROM nobel
WHERE yr = 1950

SELECT winner FROM nobel
WHERE yr = 1962
AND subject = 'Literature'

SELECT yr, subject FROM nobel
WHERE winner = 'Albert Einstein'

SELECT winner FROM nobel
WHERE subject = 'Peace'
AND yr >= 2000

SELECT * FROM nobel
WHERE subject = 'Literature'
AND yr >= 1980
AND yr <= 1989

SELECT * FROM nobel
WHERE winner IN ('Theodore Roosevelt', 'Woodrow Wilson', 'Barack Obama', 'Jimmy Carter')

SELECT winner FROM nobel
WHERE winner LIKE 'John %'

SELECT * FROM nobel
WHERE (subject = 'Physics' AND yr = 1980)
OR (subject = 'Chemistry' AND yr = 1984)

SELECT * FROM nobel
WHERE yr = 1980
AND NOT subject = 'Chemistry'
AND NOT subject = 'Medicine'

SELECT * FROM nobel
WHERE (yr < 1910 AND subject = 'Medicine')
OR (yr >= 2004 AND subject = 'Literature')

SELECT * FROM nobel
WHERE winner = 'PETER GRÜNBERG'

SELECT * FROM nobel
WHERE winner = 'EUGENE O''NEILL'

SELECT winner, yr, subject FROM nobel
WHERE winner LIKE 'Sir %'
ORDER BY yr DESC, winner

SELECT winner, subject FROM nobel
WHERE yr=1984
ORDER BY subject IN ('Physics','Chemistry'), subject, winner

-- Select in Select

SELECT name FROM world
WHERE population >
(SELECT population FROM world
WHERE name='Russia')

SELECT name FROM world
WHERE continent = 'Europe'
AND gdp/population >
(SELECT gdp/population FROM world
WHERE name='United Kingdom')

SELECT name, continent FROM world
WHERE continent IN
(SELECT continent FROM world
WHERE name IN ('Argentina','Australia'))
ORDER BY name

SELECT name, population FROM world
WHERE population >
(SELECT population FROM world
WHERE name = 'Canada')
AND population <
(SELECT population FROM world
WHERE name = 'Poland')

SELECT name, ROUND((population/(SELECT population FROM world
WHERE name = 'Germany'))*100, 0) || '%' FROM world
WHERE continent = 'Europe'

SELECT name FROM world
WHERE gdp > (SELECT MAX(gdp) FROM world WHERE continent = 'Europe')

SELECT continent, MIN(name) FROM world GROUP BY continent

SELECT name, continent, population FROM world
WHERE continent IN
(SELECT continent FROM (SELECT continent, MAX(population) AS MaxPop FROM world
GROUP BY continent) AS Pop
WHERE MaxPop <= 25000000)

SELECT name, continent FROM world x
WHERE population > ALL(SELECT population * 3 FROM world y
WHERE y.continent = x.continent AND y.population > 0 AND x.name != y.name)

-- Sum and count

SELECT SUM(population) FROM world

SELECT continent FROM world
GROUP BY continent

SELECT SUM(gdp) FROM world
WHERE continent = 'Africa'

SELECT COUNT(name) FROM world
WHERE area > 1000000

SELECT SUM(population) FROM world
WHERE name IN ('Estonia', 'Latvia', 'Lithuania')

SELECT continent, COUNT(name) FROM world
GROUP BY continent

SELECT continent, COUNT(name) FROM world
WHERE population > 10000000
GROUP BY continent

SELECT continent FROM world
GROUP BY continent
HAVING SUM(population) > 100000000

-- Join

SELECT matchid, player FROM goal 
WHERE teamid = 'Ger'

SELECT id,stadium,team1,team2 FROM game
WHERE id = 1012

SELECT player, teamid, stadium, mdate FROM game JOIN goal ON (id=matchid)
WHERE goal.teamid = 'Ger'

SELECT team1, team2, player FROM game JOIN goal ON (id=matchid)
WHERE goal.player LIKE 'Mario%'

SELECT player, teamid, coach, gtime FROM goal JOIN eteam on teamid=id 
WHERE gtime<=10

SELECT mdate, teamname FROM game JOIN eteam ON (team1=eteam.id)
WHERE coach = 'Fernando Santos' 

SELECT player FROM goal JOIN game ON matchid=id
WHERE stadium = 'National Stadium, Warsaw'

SELECT DISTINCT player FROM game JOIN goal ON matchid = id 
WHERE 'GER' IN (team1, team2)
AND NOT teamid = 'GER'

SELECT teamname, COUNT(*) FROM eteam JOIN goal ON id=teamid
GROUP BY teamname

SELECT stadium, COUNT(*) FROM game JOIN goal ON id=matchid
GROUP BY stadium

SELECT matchid, mdate, COUNT(teamid) FROM game JOIN goal ON matchid = id 
WHERE (team1 = 'POL' OR team2 = 'POL')
GROUP BY matchid, mdate

SELECT matchid, mdate, COUNT(*) FROM game JOIN goal ON (id=matchid)
WHERE goal.teamid = 'Ger'
GROUP BY matchid, mdate

SELECT mdate, team1,
SUM(CASE WHEN teamid=team1 THEN 1 ELSE 0 END) AS score1,
team2,
SUM(CASE WHEN teamid=team2 THEN 1 ELSE 0 END) AS score2 FROM game LEFT JOIN goal ON matchid = id
GROUP BY mdate, team1, team2
ORDER BY mdate, matchid, team1, team2

-- Advanced join

SELECT id, title FROM movie
WHERE yr=1962

SELECT yr FROM movie
WHERE title= 'Citizen Kane'

SELECT id, title, yr FROM movie
WHERE title LIKE '%Star Trek%'
ORDER BY yr

SELECT id FROM actor
WHERE name = 'Glenn Close'

SELECT id FROM movie
WHERE title = 'Casablanca'

SELECT name FROM casting JOIN actor ON id=actorid
WHERE movieid = 11768

SELECT name FROM casting
JOIN actor ON actor.id = actorid
JOIN movie ON movie.id = movieid
WHERE title = 'Alien'

SELECT title FROM casting
JOIN actor ON actor.id = actorid
JOIN movie ON movie.id = movieid
WHERE name = 'Harrison Ford'

SELECT title FROM casting
JOIN actor ON actor.id = actorid
JOIN movie ON movie.id = movieid
WHERE name = 'Harrison Ford'
AND ord != 1

SELECT title, name FROM casting
JOIN actor ON actor.id = actorid
JOIN movie ON movie.id = movieid
WHERE yr = '1962'
AND ord = 1

SELECT yr,COUNT(title) FROM
movie JOIN casting ON movie.id=movieid
JOIN actor   ON actorid=actor.id
WHERE name='Rock Hudson'
GROUP BY yr
HAVING COUNT(title) > 2

SELECT title, name FROM casting
JOIN actor ON actor.id = actorid
JOIN movie ON movie.id = movieid
WHERE ord = 1
AND movieid IN (SELECT movieid FROM casting
JOIN actor ON actor.id = actorid
WHERE name = 'Julie Andrews')

SELECT name FROM casting
JOIN actor ON actor.id = actorid
WHERE ord = 1
GROUP BY name
HAVING COUNT(actorid) >= 15
ORDER BY name

SELECT title, COUNT(actorid) AS count FROM movie
JOIN casting ON movieid = movie.id
WHERE yr = '1978'
GROUP BY title
ORDER BY count DESC, title

SELECT DISTINCT name FROM casting
JOIN actor ON actor.id = actorid
JOIN movie ON movie.id = movieid
WHERE name != 'Art Garfunkel'
AND movieid IN (SELECT movieid FROM casting
JOIN actor ON actor.id = actorid
WHERE name = 'Art Garfunkel')

--Null

SELECT name FROM teacher
WHERE dept IS NULL

SELECT teacher.name, dept.name FROM teacher INNER JOIN dept
ON (teacher.dept=dept.id)

SELECT teacher.name, dept.name FROM teacher LEFT JOIN dept
ON (teacher.dept=dept.id)

SELECT teacher.name, dept.name FROM teacher RIGHT JOIN dept
ON (teacher.dept=dept.id)

SELECT name, COALESCE(mobile, '07986 444 2266') FROM teacher

SELECT teacher.name, COALESCE(dept.name, 'None') FROM teacher
LEFT JOIN dept ON teacher.dept = dept.id

SELECT COUNT(name), COUNT(mobile) FROM teacher

SELECT dept.name, COUNT(teacher.name) FROM teacher
RIGHT JOIN dept ON teacher.dept = dept.id
GROUP BY dept.name

SELECT name,
CASE WHEN dept = 1 OR dept = 2 THEN 'Sci' ELSE 'Art' END FROM teacher

SELECT name,
CASE WHEN dept = 1 OR dept = 2 THEN 'Sci'
WHEN dept = 3 THEN 'Art' ELSE 'None' END FROM teacher



-- self join

SELECT COUNT(1) FROM stops

SELECT id FROM stops WHERE name = 'Craiglockhart'

SELECT id, name FROM stops
JOIN route ON id = stop
WHERE num = '4'
AND company = 'LRT'

SELECT company, num, COUNT(*) as count
FROM route WHERE stop = 149 OR stop = 53
GROUP BY company, num
HAVING count = 2

SELECT a.company, a.num, a.stop, b.stop
FROM route a JOIN route b ON
(a.company = b.company AND a.num = b.num)
WHERE a.stop = 53 AND b.stop = 149

SELECT routeA.company, routeA.num, stopA.name, stopB.name
FROM route routeA JOIN route routeB ON
(routeA.company = routeB.company AND routeA.num = routeB.num)
JOIN stops stopA ON (routeA.stop = stopA.id)
JOIN stops stopB ON (routeB.stop = stopB.id)
WHERE stopA.name = 'Craiglockhart'
AND stopB.name = 'London Road'

SELECT DISTINCT RouteA.company, RouteA.num
FROM route RouteA, route RouteB
WHERE RouteA.num = RouteB.num AND RouteA.company = RouteB.company
AND RouteA.stop = 115 AND RouteB.stop = 137

SELECT RouteA.company, RouteA.num
FROM route RouteA, route RouteB, stops StopA, stops StopB
WHERE RouteA.num = RouteB.num AND RouteA.company = RouteB.company
AND RouteA.stop = StopA.id AND RouteB.stop = StopB.id
AND StopA.name = 'Craiglockhart'
AND StopB.name = 'Tollcross'


SELECT DISTINCT StopB.name, RouteB.company, RouteB.num
FROM stops StopA, stops StopB, route RouteA, route RouteB
WHERE StopA.name = 'Craiglockhart'
AND StopA.id = RouteA.stop
AND RouteA.company = RouteB.company AND RouteA.num = RouteB.num
AND RouteB.stop = StopB.id