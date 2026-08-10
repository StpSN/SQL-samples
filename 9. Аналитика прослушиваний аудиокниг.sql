-- Выведите сколько пользователей добавили книгу 'Coraline', сколько пользователей прослушало больше 10%. 

SELECT 'Добавили Coraline' AS type_of_users, COUNT(DISTINCT user_id) AS number_of_users
FROM audio_cards
JOIN audiobooks
ON audiobook_uuid=uuid
WHERE title = 'Coraline'
UNION
SELECT 'Прослушали больше 10%' AS type_of_users, COUNT(DISTINCT user_id) AS number_of_users
FROM (
	SELECT user_id
	FROM listenings
	JOIN public.audiobooks
	ON audiobook_uuid=uuid
	WHERE title = 'Coraline'
	GROUP BY user_id
	HAVING MAX(position_to)>(SELECT duration FROM audiobooks WHERE title = 'Coraline')*0.1);

-- По каждой операционной системе и названию книги выведите количество пользователей, сумму прослушивания в часах, не учитывая тестовые прослушивания. 

SELECT os_name, title, ROUND(SUM(position_to-position_from)/3600.0, 2)
FROM listenings
JOIN public.audiobooks
ON audiobook_uuid=uuid
GROUP BY os_name, title
ORDER BY os_name, title;

-- Найдите книгу, которую слушает больше всего людей. 

SELECT title, COUNT(DISTINCT user_id) AS number_of_listeners
FROM listenings
JOIN public.audiobooks
ON audiobook_uuid=uuid
GROUP BY title
ORDER BY number_of_listeners DESC
LIMIT 1;

-- Найдите книгу, которую чаще всего дослушивают до конца.
SELECT title, COUNT(DISTINCT user_id) as number_of_unfinished_listenings
FROM(
	SELECT title, user_id
	FROM listenings
	JOIN public.audiobooks
	ON audiobook_uuid=uuid
	GROUP BY title, user_id, duration
	HAVING MAX(position_to) < duration)
GROUP BY title
ORDER BY number_of_unfinished_listenings DESC
LIMIT 1;