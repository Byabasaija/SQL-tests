  SELECT population FROM world
  WHERE name = 'Germany'

  SELECT name, population FROM world
  WHERE name IN ('Sweden', 'Norway', 'Denmark');

  SELECT name, area FROM world
  WHERE area BETWEEN 200000 AND 250000

  SELECT name, continent, population FROM world

  SELECT name
  FROM world
  WHERE population > 200000000

  SELECT name, GDP/population
  FROM world
  WHERE population > 200000000

  SELECT yr, subject, winner
  FROM nobel
  WHERE yr = 1950 

  SELECT winner
  FROM nobel
  WHERE yr = 1962
   AND subject = 'Literature'

   SELECT yr, subject
  FROM nobel
 WHERE winner = 'Albert Einstein'

SELECT winner
  FROM nobel
 WHERE yr >= 2000
 AND subject = 'Peace'

 SELECT yr, subject, winner
  FROM nobel
 WHERE yr BETWEEN 1980 AND 1989
 AND subject = 'Literature'

 SELECT * FROM nobel
 WHERE winnerg IN ('Theodore Roosevelt',
                  'Woodrow Wilson',
                  'Jimmy Carter', 'Barack Obama')