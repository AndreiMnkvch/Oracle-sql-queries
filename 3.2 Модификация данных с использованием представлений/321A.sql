CREATE VIEW "books_upper_case" AS
SELECT  "b_id",
        UPPER("b_name")AS "b_name",
        "b_quantity", 
        "b_year"
FROM "books";

SELECT * FROM "books_upper_case";

CREATE OR REPLACE TRIGGER "books_upper_case_ins"
INSTEAD OF INSERT ON "books_upper_case"
FOR EACH ROW 
BEGIN 
INSERT INTO     "books"
                ("b_id", 
                "b_name", 
                "b_quantity", 
                "b_year")
VALUES         (:new."b_id", 
                :new."b_name", 
                :new."b_quantity", 
                :new."b_year");
END;


CREATE OR REPLACE TRIGGER "books_upper_case_upd"
INSTEAD OF UPDATE ON "books_upper_case"
FOR EACH ROW 
BEGIN 
UPDATE "books"
SET     "b_id"=:new."b_id",
        "b_name"= :new."b_name",
        "b_year"=:new."b_year",
        "b_quantity"= :new."b_quantity"
WHERE "b_id" = :old."b_id";
END;
INSERT INTO "books_upper_case"
            ("b_name",
            "b_quantity",
            "b_year")
    VALUES  (N'test_book2',
            1,
            1997 );
            
UPDATE "books_upper_case"
SET "b_quantity" = 99
WHERE "b_name" = (N'TEST_BOOK2');

DELETE "books_upper_case"
WHERE "b_name" = (N'TEST_BOOK'); 