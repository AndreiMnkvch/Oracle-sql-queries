/*Задание 5.1.1.TSK.A: создать хранимую функцию, получающую на вход идентификатор
читателя и возвращающую список идентификаторов книг, которые он уже прочитал и
вернул в библиотеку.*/
--CREATE  OR REPLACE TYPE "c_list_type" IS VARRAY(10) OF NUMBER(10);


/*CREATE OR REPLACE FUNCTION GET_READ_BOOKS_BY_SUBSCRIBER(subscriber_id IN NUMBER)
RETURN "c_list_type"
AS*/

--TODO 1) PIPLINED SOLUTION,2)VARRAY, 3)FIGURE OUT HOW EXISTING SULUTION WORKS



DROP TYPE "c_list_table";
DROP TYPE "c_list_type";

CREATE OR REPLACE TYPE "c_list_type" AS OBJECT (
"sb_book" NUMBER);
CREATE OR REPLACE TYPE "c_list_table" AS TABLE OF "c_list_type";

CREATE OR REPLACE FUNCTION GET_READ_BOOKS_IDS(subscriber_id IN NUMBER)
RETURN "c_list_table"
AS
--TYPE c_list_type IS VARRAY(10) OF NUMBER(10);
result_list "c_list_table" := "c_list_table"();
CURSOR curs_booksids IS
SELECT DISTINCT "sb_book"
FROM "subscriptions"
WHERE "sb_is_active"='N' AND "sb_subscriber" =  subscriber_id;
counter integer := 0;
BEGIN 
    FOR n in curs_booksids LOOP
        counter := counter + 1;
        result_list.extend;
        result_list(counter) := "c_list_type"(n."sb_book");
    END LOOP;
RETURN result_list;
END;
SELECT * FROM TABLE(GET_READ_BOOKS_IDS(1));