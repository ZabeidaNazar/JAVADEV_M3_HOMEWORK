SELECT "name", EXTRACT (YEAR FROM age(finish_date, start_date)) * 12 + EXTRACT (MONTH FROM age(finish_date, start_date)) AS month_count
FROM project p 
WHERE EXTRACT (YEAR FROM age(finish_date, start_date)) * 12 + EXTRACT (MONTH FROM age(finish_date, start_date)) = (
	SELECT max(EXTRACT (YEAR FROM age(finish_date, start_date)) * 12 + EXTRACT (MONTH FROM age(finish_date, start_date))) 
	FROM project
)
ORDER BY id ASC;

