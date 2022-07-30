CREATE VIEW "m2m_books_authors_with_text" AS
SELECT  "b_name" AS "b_id",
        "a_name" AS "a_id"
FROM "m2m_books_authors"
    JOIN "books" USING("b_id")
    JOIN "authors" USING ("a_id");

SELECT * FROM "m2m_books_authors_with_text";

---string to separate code visually

CREATE OR REPLACE TRIGGER "m2m_books_authors_with_text_ins"
INSTEAD OF INSERT ON  "m2m_books_authors_with_text"
FOR EACH ROW 
BEGIN 
IF (( REGEXP_INSTR(:new."b_id" ,'[^0-9]') > 0)
OR (REGEXP_INSTR(:new."a_id", '[^0-9]')>0))
THEN
     RAISE_APPLICATION_ERROR(-20001,
'Use digital identifiers for b_id and a_id.
Do not use books names or authors names.');
ROLLBACK;
END IF;
INSERT INTO "m2m_books_authors"
                ("b_id",
                "a_id")
   VALUES      (:new."b_id",
                :new."a_id");
END;

---string to separate code visually


CREATE OR REPLACE TRIGGER "m2m_books_authors_with_text_upd"
INSTEAD OF UPDATE  ON "m2m_books_authors_with_text"
FOR  EACH ROW
BEGIN 
IF (( old."b_id" != new."b_id")
    AND (REGEXP_INSTR(:new."b_id", '[^0-9]')>0)
    OR  (old."a_id" != new."a_id") AND
    (REGEXP_INSTR(:new."a_id", '[^0-9]')>0))
THEN
     RAISE_APPLICATION_ERROR(-20001,
'Use digital identifiers for b_id and a_id.
Do not use books names or authors names.');
ROLLBACK;
END IF;
    
 

UPDATE m2m_books_authors
SET( b_id = new.b_id,
        a_id = new.a_id)