CREATE OR REPLACE PROCEDURE ROW_COUNT(table_name IN VARCHAR2, rows_in_table OUT NUMBER )
AS 
iso_level_query  NVARCHAR2(150) := 'ALTER SESSION SET ISOLATION_LEVEL = SERIALIZABLE';
count_query NVARCHAR2(150) := 'SELECT COUNT(1) FROM "' || table_name || '" ';
BEGIN 
EXECUTE IMMEDIATE iso_level_query;
EXECUTE IMMEDIATE count_query INTO rows_in_table;
END;

-- TO EXECUTE PROCEDURE USE THE FOLLOWING CODE 
declare rows_count number(30); 
begin
ROW_COUNT('subscriptions', rows_count);
DBMS_OUTPUT.PUT_LINE(rows_count);
end;
--MAKE SURE THAT SERVEROUPUT HAS TURNED ON.
SET SERVEROUTPUT ON;