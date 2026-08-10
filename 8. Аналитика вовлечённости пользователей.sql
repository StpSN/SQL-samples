#Напишите запрос SQL, выводящий одним числом количество уникальных пользователей в этой таблице в период с 2023-11-07 по 2023-11-15.

SELECT COUNT(DISTINCT user_id) AS 'Кол-во уникальных пользователей с 2023-11-07 по 2023-11-15' FROM users 
WHERE date BETWEEN '2023-11-07' AND '2023-11-15';

#Определите пользователя, который за весь период посмотрел наибольшее количество объявлений. 

SELECT user_id, SUM(view_adverts) AS sum_views FROM users
GROUP BY user_id
ORDER BY SUM(view_adverts) DESC
LIMIT 1;

#Определите день с наибольшим средним количеством просмотренных рекламных объявлений на пользователя, но учитывайте только дни с более чем 500 уникальными пользователями.

SELECT date, COUNT(DISTINCT user_id) AS number_of_users, AVG(view_adverts) AS avg_views FROM users
GROUP BY date
HAVING number_of_users > 500
ORDER BY avg_views DESC
LIMIT 1;

#Напишите запрос возвращающий LT (продолжительность присутствия пользователя на сайте) по каждому пользователю. Отсортировать LT по убыванию.

SELECT 
	user_id, 
    COUNT(DISTINCT date) AS activity_days,
    DATEDIFF(curdate(), MIN(date)) AS days_from_first_activity,
    DATEDIFF(MAX(date), MIN(date)) AS from_first_to_last_activity
FROM users
GROUP BY user_id
ORDER BY from_first_to_last_activity DESC, activity_days DESC;

#Для каждого пользователя подсчитайте среднее количество просмотренной рекламы за день, а затем выясните, у кого самый высокий средний показатель среди тех, кто был активен как минимум в 5 разных дней.

SELECT user_id, AVG(view_adverts) AS avg_views FROM users
GROUP BY user_id
HAVING COUNT(DISTINCT date) > 5
ORDER BY avg_views DESC
LIMIT 1;
