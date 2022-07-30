CREATE OR REPLACE PROCEDURE DOUBLE_BOOKS_QUANTITY
AS 
avg_quantity NUMBER(5,3);
BEGIN
UPDATE "books"
SET "b_quantity" = "b_quantity" * 2;
 
SELECT AVG("b_quantity") INTO avg_quantity
FROM "books";
IF (avg_quantity > 50.0)
THEN
DBMS_OUTPUT.PUT_LINE('Sorry'||', average books quantity : ' || avg_quantity || ' > 50,0 ');
DBMS_OUTPUT.PUT_LINE('ROLLBACK');
ROLLBACK;
ELSE 
COMMIT;
DBMS_OUTPUT.PUT_LINE('Books quantity doubled successfully. COMMIT');
END IF;
END;

EXEC DOUBLE_BOOKS_QUANTITY()