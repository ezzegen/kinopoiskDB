SELECT *
  FROM film;

-- Выборка данных о съемочной группе

SELECT film_name, director.name || ' ' || director.surname as director
  FROM film
  JOIN person USING(film_id)
  JOIN director USING(director_id)
 WHERE film_name LIKE 'Зелёная миля';

SELECT film_name,
       director.name || ' ' || director.surname as director,
       screenwriter.name || ' ' || screenwriter.surname as screenwriter,
       producer.name || ' ' || producer.surname as producer,
       cameraman.name || ' ' || cameraman.surname as cameraman,
       composer.name || ' ' || composer.surname as composer,
       artist.name || ' ' || artist.surname as artist,
       editor.name || ' ' || editor.surname as editor
  FROM person
  JOIN film USING(film_id)
  JOIN director USING(director_id)
  JOIN screenwriter USING(screenwriter_id)
  JOIN producer USING(producer_id)
  JOIN cameraman USING(cameraman_id)
  JOIN composer USING(composer_id)
  JOIN artist USING(artist_id)
  JOIN editor USING(editor_id);

-- Запрос на информацию о стране, где проходили съемки.

SELECT film_name, country_name
  FROM film
  JOIN country USING(country_id);

-- Запрос на выборку количества зрителей по странам.

SELECT film_name, usa, russia, italy, japan, belgian
  FROM viewer
  JOIN film USING(film_id);

-- Информация о жанре (связь м-м).

SELECT film_name, genre_name
  FROM film_genre
  JOIN film USING(film_id)
  JOIN genre USING(genre_id);

SELECT genre_name as Жанр_Зеленой_мили
  FROM film_genre
  JOIN film USING(film_id)
  JOIN genre USING(genre_id)
 WHERE film_name LIKE 'Зелёная миля';
 
 
-- Информация об актерах.

SELECT starring.name || ' ' || starring.surname AS В_главных_ролях,
       actor_dubbing.name || ' ' || actor_dubbing.surname AS Роли_дублировали
  FROM film_actor
  JOIN film USING(film_id)
  JOIN starring USING(starring_id)
  JOIN actor_dubbing USING(actor_dubbing_id)
 WHERE film_name LIKE 'Зелёная миля';
 
SELECT starring.name || ' ' || starring.surname AS В_главных_ролях
  FROM film_actor
  JOIN film USING(film_id)
  JOIN starring USING(starring_id)
 WHERE film_name LIKE 'Москва слезам не верит';
 
SELECT starring.name || ' ' || starring.surname AS В_главных_ролях,
       actor_dubbing.name || ' ' || actor_dubbing.surname AS Роли_дублировали
  FROM film_actor
  JOIN film USING(film_id)
  JOIN starring USING(starring_id)
  JOIN actor_dubbing USING(actor_dubbing_id)
 WHERE film_name LIKE '1 + 1';
 
-- Поиск фильмов (по сценаристу, по актерам, по странам, по годам)
 
SELECT film_name
  FROM film
  JOIN person USING(film_id)
  JOIN screenwriter AS s USING(screenwriter_id)
 WHERE s.name || ' ' || s.surname = 'Стивен Кинг';
 
SELECT film_name
  FROM film
  JOIN film_actor USING(film_id)
  JOIN starring AS s USING(starring_id)
 WHERE s.name || ' ' || s.surname = 'Том Хэнкс';
 
SELECT film_name
  FROM film
  JOIN country AS c USING(country_id)
 WHERE c.country_name = 'СССР';
 
SELECT film_name
  FROM film
 WHERE year_release BETWEEN 1970 AND 2000;
 
 
 
 
 
 
 
 
