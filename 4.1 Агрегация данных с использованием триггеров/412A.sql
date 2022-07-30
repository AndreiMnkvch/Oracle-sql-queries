ALTER TABLE "genres"
ADD ("g_books" NUMBER(10) DEFAULT 0 NOT NULL);
-- Инициализация данных:
UPDATE "genres" "outer"
-- Модификация таблицы:
SET "g_books" =
          NVL((SELECT COUNT("b_id") AS    "g_has_books"
          FROM   "m2m_books_genres"
          WHERE "outer"."g_id" = "g_id"
          GROUP  BY "g_id"), 0);
--Здесь нет необходимости что-то менять, т.к. счетчик "g_books" только увеливается.
CREATE OR REPLACE TRIGGER "g_has_bks_on_m2m_b_g_ins"
AFTER INSERT ON "m2m_books_genres"
FOR EACH ROW
     BEGIN
UPDATE "genres"
SET "g_books" = "g_books" + 1
WHERE "g_id" = :new."g_id";
END;

CREATE OR REPLACE TRIGGER "g_has_bks_on_m2m_b_g_upd"
AFTER UPDATE
ON "m2m_books_genres"
FOR EACH ROW
   BEGIN
-- Здесь происходит проверка счетчика старого жанра на положительное значение. 
IF (:old."g_books">0) 
THEN    
UPDATE "genres"
SET "g_books" = "g_books" + 1
WHERE "g_id" = :new."g_id";
UPDATE "genres"
SET "g_books" = "g_books" - 1
WHERE "g_id" = :old."g_id";
ELSE 
RAISE_APPLICATION_ERROR( -20111, 'can''t be a negative number');
END IF;
END;

CREATE OR REPLACE TRIGGER "g_has_bks_on_m2m_b_g_del"
AFTER DELETE
ON "m2m_books_genres"
FOR EACH ROW
 BEGIN
-- Здесь происходит проверка счетчика старого жанра на положительное значение.
IF (:old."g_books" >0) 
THEN 
UPDATE "genres"
SET "g_books" = "g_books" - 1
WHERE "g_id" = :old."g_id";
ELSE 
RAISE_APPLICATION_ERROR('g_books "g_books" can'/t be a negative number')
END IF;
END;