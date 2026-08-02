SELECT COUNT(*) as count_2024 FROM users
WHERE YEAR(registration_date)=2024;

SELECT country, COUNT(*) as count_users FROM users
GROUP BY country;

SELECT country, ROUND(AVG(watch_time_min),1) AS avg_time_min
FROM users u
JOIN views v
ON u.user_id=v.user_id
WHERE country = 'USA'
GROUP BY country;

SELECT movie_id, COUNT(DISTINCT(user_id)) AS count_users
FROM views
GROUP BY movie_id
ORDER BY count_users ASC
LIMIT 5;

SELECT DATE_FORMAT(start_date, '%Y-%m') as period, SUM(price) as sum_price
FROM subscriptions
WHERE YEAR(start_date) = 2024
GROUP BY period;

SELECT u.user_id, IFNULL(MAX(view_date), 'Ничего не смотрел') as last_date
FROM users u
LEFT JOIN views v
ON u.user_id=v.user_id
GROUP BY user_id;