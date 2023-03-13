-- Предварительное удаление имеющихся таблиц.
DROP TABLE IF EXISTS director CASCADE;
DROP TABLE IF EXISTS screenwriter CASCADE;
DROP TABLE IF EXISTS producer CASCADE;
DROP TABLE IF EXISTS cameraman CASCADE;
DROP TABLE IF EXISTS composer CASCADE;
DROP TABLE IF EXISTS artist CASCADE;
DROP TABLE IF EXISTS editor CASCADE;
DROP TABLE IF EXISTS person CASCADE;
DROP TABLE IF EXISTS country CASCADE;
DROP TABLE IF EXISTS viewer CASCADE;
DROP TABLE IF EXISTS genre CASCADE;
DROP TABLE IF EXISTS film CASCADE;
DROP TABLE IF EXISTS film_genre CASCADE;
DROP TABLE IF EXISTS starring CASCADE;
DROP TABLE IF EXISTS actor_dubbing CASCADE;
DROP TABLE IF EXISTS film_actor CASCADE;

-- Создание таблиц.
CREATE TABLE director (
       director_id bigint GENERATED ALWAYS AS IDENTITY,
       name varchar(50) NOT NULL,
       surname varchar(50) NOT NULL,
       CONSTRAINT PK_director_director_id PRIMARY KEY(director_id)
);

CREATE TABLE screenwriter (
       screenwriter_id bigint GENERATED ALWAYS AS IDENTITY,
       name varchar(50) NOT NULL,
       surname varchar(50) NOT NULL, 
       CONSTRAINT PK_screenwriter_screenwriter_id PRIMARY KEY(screenwriter_id)
);

CREATE TABLE producer (
       producer_id bigint GENERATED ALWAYS AS IDENTITY,
       name varchar(50) NOT NULL,
       surname varchar(50) NOT NULL,
       CONSTRAINT PK_dproducer_producer_id PRIMARY KEY(producer_id)
);

CREATE TABLE cameraman (
       cameraman_id bigint GENERATED ALWAYS AS IDENTITY,
       name varchar(50) NOT NULL,
       surname varchar(50) NOT NULL,
       CONSTRAINT PK_cameraman_cameraman_id PRIMARY KEY(cameraman_id)
);

CREATE TABLE composer (
       composer_id bigint GENERATED ALWAYS AS IDENTITY,
       name varchar(50) NOT NULL,
       surname varchar(50) NOT NULL,
       CONSTRAINT PK_composer_composer_id PRIMARY KEY(composer_id)
);

CREATE TABLE artist (
       artist_id bigint GENERATED ALWAYS AS IDENTITY,
       name varchar(50) NOT NULL,
       surname varchar(50) NOT NULL,
       CONSTRAINT PK_artist_artist_id PRIMARY KEY(artist_id)
);

CREATE TABLE editor (
       editor_id bigint GENERATED ALWAYS AS IDENTITY,
       name varchar(50) NOT NULL,
       surname varchar(50) NOT NULL,
       CONSTRAINT PK_editor_editor_id PRIMARY KEY(editor_id)
);

CREATE TABLE country (
       country_id int GENERATED ALWAYS AS IDENTITY,
       country_name varchar(50),
       CONSTRAINT PK_country_country_id PRIMARY KEY(country_id)
);

CREATE TABLE genre (
       genre_id bigint GENERATED ALWAYS AS IDENTITY,
       genre_name varchar(50),
       CONSTRAINT PK_genre_genre_id PRIMARY KEY(genre_id)
);

CREATE TABLE film (
       film_id bigint GENERATED ALWAYS AS IDENTITY,
       film_name varchar(50) NOT NULL,
       year_release int NOT NULL CHECK (year_release > 1900 AND year_release < 2040),
       country_id int NOT NULL,
       description text,
       slogan text,
       budget_$ numeric NOT NULL,
       collect_money_$ numeric NOT NULL,
       age_restrict int NOT NULL CHECK (age_restrict > 0 AND age_restrict < 21),
       time_min int NOT NULL CHECK (time_min > 0),
       rating real NOT NULL CHECK (rating > 0 AND rating <= 10),
	
       CONSTRAINT PK_film_film_id PRIMARY KEY(film_id),
	
       CONSTRAINT FK_country_country_id
       FOREIGN KEY (country_id) REFERENCES country(country_id)
);


CREATE TABLE person (
       person_id bigint GENERATED ALWAYS AS IDENTITY,
       film_id bigint NOT NULL,
       director_id bigint NOT NULL,
       screenwriter_id bigint NOT NULL,
       producer_id bigint NOT NULL,
       cameraman_id bigint NOT NULL,
       composer_id bigint NOT NULL,
       artist_id bigint NOT NULL,
       editor_id bigint NOT NULL,
       CONSTRAINT PK_person_id PRIMARY KEY(person_id),
	
       CONSTRAINT FK_film_person_film_id 
       FOREIGN KEY (film_id) REFERENCES film(film_id),
	
       CONSTRAINT FK_director_director_id 
       FOREIGN KEY (director_id) REFERENCES director(director_id),
	
       CONSTRAINT FK_screenwriter_screenwriter_id 
       FOREIGN KEY (screenwriter_id) REFERENCES screenwriter(screenwriter_id),
	
       CONSTRAINT FK_producer_producer_id 
       FOREIGN KEY (producer_id) REFERENCES producer(producer_id),
	
       CONSTRAINT FK_cameraman_cameraman_id 
       FOREIGN KEY (cameraman_id) REFERENCES cameraman(cameraman_id),
	
       CONSTRAINT FK_composer_composer_id 
       FOREIGN KEY (composer_id) REFERENCES composer(composer_id),

       CONSTRAINT FK_artist_artist_id 
       FOREIGN KEY (artist_id) REFERENCES artist(artist_id),
	
       CONSTRAINT FK_editor_editor_id 
       FOREIGN KEY (editor_id) REFERENCES editor(editor_id));
	   
CREATE TABLE viewer (
       viewer_id bigint GENERATED ALWAYS AS IDENTITY,
       film_id bigint NOT NULL,
       usa bigint,
       russia bigint,
       france bigint,
       italy bigint,
       japan bigint,
       belgian bigint,
       germany bigint,
       CONSTRAINT PK_viewer_viewer_id PRIMARY KEY (viewer_id),
	
       CONSTRAINT FK_film_viewer_film_id 
       FOREIGN KEY (film_id) REFERENCES film(film_id)
);


CREATE TABLE film_genre (
       film_genre_id int GENERATED ALWAYS AS IDENTITY,
       film_id bigint NOT NULL,
       genre_id int NOT NULL,
       CONSTRAINT PK_film_genre_id PRIMARY KEY(film_genre_id),
	   
       CONSTRAINT FK_genre_film_id 
       FOREIGN KEY(film_id) REFERENCES film(film_id),
	
       CONSTRAINT FK_film_genre_id 
       FOREIGN KEY(genre_id) REFERENCES genre(genre_id)
);

CREATE TABLE starring(
       starring_id bigint GENERATED ALWAYS AS IDENTITY,
       name varchar(50) NOT NULL,
       surname varchar(50) NOT NULL,
       CONSTRAINT PK_starring_id PRIMARY KEY(starring_id)
);
 
CREATE TABLE actor_dubbing(
       actor_dubbing_id bigint GENERATED ALWAYS AS IDENTITY,
       name varchar(50) NOT NULL,
       surname varchar(50) NOT NULL,
       CONSTRAINT PK_actor_dubbing_id PRIMARY KEY(actor_dubbing_id)
);

CREATE TABLE film_actor (
       film_actor_id int GENERATED ALWAYS AS IDENTITY,
       film_id bigint NOT NULL,
       starring_id bigint NOT NULL,
       actor_dubbing_id bigint,
	
       CONSTRAINT PK_film_actor_id PRIMARY KEY(film_actor_id),
	
       CONSTRAINT FK_film_film_id
       FOREIGN KEY(film_id) REFERENCES film(film_id),
	
       CONSTRAINT FK_starring_starring_id
       FOREIGN KEY(starring_id) REFERENCES starring(starring_id),
	
       CONSTRAINT FK_actor_dubbing_actor_dubbing_id
       FOREIGN KEY(actor_dubbing_id) REFERENCES actor_dubbing(actor_dubbing_id)   
);

-- Заполнение таблиц данными.

INSERT INTO director (name, surname)
VALUES ('Фрэнк', 'Дарабонт'),
       ('Владимир', 'Меньшов'),
       ('Оливье', 'Накаш');
	   
INSERT INTO screenwriter (name, surname)
VALUES ('Стивен', 'Кинг'),
       ('Валентин', 'Черных'),
       ('Эрик', 'Толедано');

INSERT INTO producer (name, surname)
VALUES ('Дэвид', 'Валдес'),
       ('Виталий', 'Богуславский'),
       ('Николя', 'Дюваль-Адассовски');

INSERT INTO cameraman (name, surname)
VALUES ('Дэвид', 'Тэттерсолл'),
       ('Игорь', 'Слабневич'),
       ('Матьё', 'Вадпьед');

INSERT INTO composer (name, surname)
VALUES ('Томас', 'Ньюман'),
       ('Сергей', 'Никитин'),
       ('Людовико', 'Эйнауди');

INSERT INTO artist (name, surname)
VALUES ('Теренс', 'Марш'),
       ('Саид', 'Меняльщиков'),
       ('Франсуа', 'Эммануэлли');

INSERT INTO editor (name, surname)
VALUES ('Ричард', 'Фрэнсис-Брюс'),
       ('Елена', 'Михайлова'),
       ('Дориан', 'Ригаль-Ансу');
	   
INSERT INTO country (country_name)
VALUES ('США'),
       ('СССР'),
       ('Россия'),
       ('Франция'),
       ('Италия'),
       ('Великобритания'),
       ('Южная Корея'),
       ('Япония'),
       ('Австралия'),
       ('Австрия'),
       ('Германия');

INSERT INTO genre (genre_name)
VALUES ('биография'),
       ('боевик'),
       ('вестерн'),
       ('военный'),
       ('фэнтези'),
       ('детектив'),
       ('драма'),
       ('комедия'),
       ('криминал'),
       ('мелодрама'),
       ('мультфильм'),
       ('приключения'),
       ('семейный'),
       ('триллер'),
       ('ужасы'),
       ('фантастика');

INSERT INTO film (film_name,
		  year_release,
		  country_id,
		  description,
		  slogan,
		  budget_$,
		  collect_money_$,
		  age_restrict,
		  time_min,
		  rating
		  )
VALUES ('Зелёная миля',
        1999,
        1,
        'В тюрьме для смертников появляется заключенный с божественным даром. Мистическая драма по роману Стивена Кинга',
        'Пол Эджкомб не верил в чудеса. Пока не столкнулся с одним из них',
        60000000,
        286801374,
        16,
        189,
        9.1
        ),
       ('Москва слезам не верит',
        1979,
        2,
        'Три девушки переезжают в Москву в поисках любви, дружбы и успеха. Советский хит, отмеченный «Оскаром»',
        'The Funniest, Tenderest Love Story of the Year',
        900000,
        2516245,
        16,
        150,
        8.4
        ),
       ('1 + 1',
        2011,
        4,
        'Пострадав в результате несчастного случая, богатый аристократ Филипп нанимает в помощники человека, который менее всего подходит для этой работы, – молодого жителя предместья Дрисса, только что освободившегося из тюрьмы. Несмотря на то, что Филипп прикован к инвалидному креслу, Дриссу удается привнести в размеренную жизнь аристократа дух приключений.',
        'Sometimes you have to reach into someone else''s world to find out what''s missing in your own',
        9500000,
        426588510,
        16,
        112,
        8.8
        );

INSERT INTO person (film_id,
	            director_id,
		    screenwriter_id,
		    producer_id,
		    cameraman_id,
		    composer_id,
		    artist_id,
		    editor_id)
VALUES (1, 1, 1, 1, 1, 1, 1, 1),
       (2, 2, 2, 2, 2, 2, 2, 2),
       (3, 3, 3, 3, 3, 3, 3, 3);
       
INSERT INTO viewer (film_id,
	            usa,
	            russia,
	            france,
	            italy,
	            japan,
	            belgian,
	            germany
	            )
VALUES (1, 26000000, 96000, 1714080, 1742730, 	113926, 313321, 2100000),
       (2, 400000, 84400000, null, null, null, null, null),
       (3, 2582237, 87286, 19440920, 2495738, 1170000, 961820, 9108101);
	   
INSERT INTO film_genre (film_id, genre_id)
VALUES (1, 7),
       (1, 5),
       (1, 9),
       (2, 7),
       (2, 8),
       (2, 10),
       (3, 7),
       (3, 8),
       (3, 1);

INSERT INTO starring (name, surname)
VALUES ('Том', 'Хэнкс'),
       ('Дэвид', 'Морс'),
       ('Бонни', 'Хант'),
       ('Майкл Кларк', 'Дункан'),
       ('Джеймс', 'Кромуэлл'),
       ('Майкл', 'Джитер'),
       ('Грэм', 'Грин'),
       ('Даг', 'Хатчисон'),
       ('Сэм', 'Рокуэлл'),
       ('Барри', 'Пеппер'),
       ('Вера', 'Алентова'),
       ('Ирина', 'Муравьёва'),
       ('Алексей', 'Баталов'),
       ('Раиса', 'Рязанова'),
       ('Александр', 'Фатюшин'),
       ('Борис', 'Сморчков'),
       ('Юрий', 'Васильев'),
       ('Наталья', 'Вавилова'),
       ('Виктор', 'Уральский'),
       ('Валентина', 'Ушакова'),
       ('Франсуа', 'Клюзе'),
       ('Омар', 'Си'),
       ('Анн', 'Ле Ни'),
       ('Одри', 'Флеро'),
       ('Жозефин', 'де Мо'),
       ('Клотильд', 'Молле'),
       ('Альба Гайя Крагеде', 'Беллуджи'),
       ('Сирил', 'Менди'),
       ('Салимата', 'Камате'),
       ('Абса', 'Дьяту Тур');
	   
INSERT INTO actor_dubbing (name, surname)
VALUES ('Всеволод', 'Кузнецов'),
       ('Владимир', 'Антоник'),
       ('Любовь', 'Германова'),
       ('Валентин', 'Голубенко'),
       ('Александр', 'Белявский'),
       ('Дмитрий', 'Полонский'),
       ('Александр', 'Коврижных'),
       ('Борис', 'Шувалов'),
       ('Андрей', 'Градов'),
       ('Олег', 'Вирозуб'),
       ('Владимир', 'Зайцев'),
       ('Илья', 'Исаев'),
       ('Елена', 'Соловьева'),
       ('Рамиля', 'Искандер'),
       ('Лина', 'Иванова');

INSERT INTO film_actor (film_id, starring_id, actor_dubbing_id)
VALUES (1, 1, 1),
       (1, 2, 2),
       (1, 3, 3),
       (1, 4, 4),
       (1, 5, 5),
       (1, 6, 6),
       (1, 7, 7),
       (1, 8, 8),
       (1, 9, 9),
       (1, 10, 10),
       (2, 11, null),
       (2, 12, null),
       (2, 13, null),
       (2, 14, null),
       (2, 15, null),
       (2, 16, null),
       (2, 17, null),
       (2, 18, null),
       (2, 19, null),
       (2, 20, null),
       (3, 21, 11),
       (3, 22, 12),
       (3, 23, 13),
       (3, 24, 14),
       (3, 25, 14),
       (3, 26, 14),
       (3, 27, 15),
       (3, 28, 15),
       (3, 29, 15),
       (3, 30, 15);











	   
	   
	   
