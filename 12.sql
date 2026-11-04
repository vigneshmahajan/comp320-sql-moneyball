SELECT 
    players.first_name, 
    players.last_name
FROM players
JOIN salaries ON players.id = salaries.player_id
JOIN performances ON players.id = performances.player_id 
  AND salaries.year = performances.year
WHERE salaries.year = 2001 
  AND performances.year = 2001 
  AND performances.H > 0 
  AND players.id IN (
      SELECT p.id
      FROM players p
      JOIN salaries s ON p.id = s.player_id
      JOIN performances perf ON p.id = perf.player_id 
        AND s.year = perf.year
      WHERE s.year = 2001 
        AND perf.year = 2001 
        AND perf.H > 0
      ORDER BY (s.salary * 1.0 / perf.H) ASC
      LIMIT 10
  )
  AND players.id IN (
      SELECT p.id
      FROM players p
      JOIN salaries s ON p.id = s.player_id
      JOIN performances perf ON p.id = perf.player_id 
        AND s.year = perf.year
      WHERE s.year = 2001 
        AND perf.year = 2001 
        AND perf.RBI > 0
      ORDER BY (s.salary * 1.0 / perf.RBI) ASC
      LIMIT 10
  )
ORDER BY players.id ASC;