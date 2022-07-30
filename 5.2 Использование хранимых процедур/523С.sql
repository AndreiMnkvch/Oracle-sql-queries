CREATE OR REPLACE PROCEDURE DROP_VIEWS_ROW_COUNT_LT_10
AS
view_name VARCHAR2(50);
view_rows_count NUMBER(10);
count_query VARCHAR2(1000);
CURSOR curs IS
SELECT VIEW_NAME AS "view_name"
FROM USER_VIEWS;

BEGIN 

FOR one_row IN curs
LOOP
DBMS_OUTPUT.PUT_LINE(view_name);
count_query := 'SELECT COUNT(1)
FROM "'|| one_row."view_name" ||'" ';
EXECUTE IMMEDIATE count_query INTO view_rows_count;
IF ( view_rows_count < 10)
THEN 
EXECUTE IMMEDIATE 'DROP VIEW "' || one_row."view_name" || '" ';
DBMS_OUTPUT.PUT_LINE('View ' || one_row."view_name" || ' dropped');
END IF;
END LOOP;
END;

EXEC DROP_VIEWS_ROW_COUNT_LT_10;
SET SERVEROUTPUT ON;