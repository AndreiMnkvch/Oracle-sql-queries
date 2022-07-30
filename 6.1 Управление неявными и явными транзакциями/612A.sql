--to execute next procedure make sure that PK_m2m_books_genres is disabled.
--unique restriction will be ensured by procedure itself.
--ALTER TABLE "m2m_books_genres" MODIFY CONSTRAINT "PK_m2m_books_genres" ENABLE;

CREATE OR REPLACE PROCEDURE TWO_RANDOM_GENRES
AS
CURSOR books_cursor
IS
SELECT "b_id"
FROM "books";
CURSOR genres_cursor IS
SELECT "g_id"
FROM (
SELECT "g_id"
FROM "genres"
ORDER BY DBMS_RANDOM.VALUE)
WHERE ROWNUM <= 2;
counter INT(10);

BEGIN
DBMS_OUTPUT.PUT_LINE('Commiting previous transaction.');
COMMIT;

FOR one_book IN books_cursor
LOOP
FOR one_genre IN genres_cursor
LOOP
INSERT INTO "m2m_books_genres"
                        ("b_id","g_id")
VALUES          (one_book."b_id", one_genre."g_id");
END LOOP;
END LOOP;

SELECT COUNT(1) INTO counter
FROM
(
SELECT "b_id","g_id", COUNT(1) 
FROM "m2m_books_genres"
GROUP BY "b_id","g_id"
HAVING COUNT(1)>1
);


IF (counter>0)
THEN 
DBMS_OUTPUT.PUT_LINE('Rolling transaction back');
ROLLBACK;
ELSE 
DBMS_OUTPUT.PUT_LINE('Commiting transaction');
COMMIT;
END IF;
END;

--to execute procedure use next anonymous pl/sql block.
BEGIN 
TWO_RANDOM_GENRES();
END;

SET SERVEROUTPUT ON;
