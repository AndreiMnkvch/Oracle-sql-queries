CREATE OR REPLACE PROCEDURE SET_CURRENT_DATE(table_name IN VARCHAR2)
AS
date_columns_query VARCHAR2(1000);
update_query VARCHAR2(1000);
one_column VARCHAR2(30);
ref_cursor SYS_REFCURSOR;
BEGIN
date_columns_query :=  'SELECT COLUMN_NAME FROM ALL_TAB_COLUMNS
                        WHERE OWNER = USER  
                        AND TABLE_NAME=''table_name_placeholder'' 
                        AND DATA_TYPE = ''DATE''';
date_columns_query := REPLACE(date_columns_query, 'table_name_placeholder', table_name);

OPEN ref_cursor FOR date_columns_query;
LOOP
FETCH ref_cursor INTO one_column;
EXIT WHEN ref_cursor%NOTFOUND;
update_query := 'UPDATE "'|| table_name || '"
                SET "' || one_column || '" = TRUNC(SYSDATE)';
EXECUTE IMMEDIATE update_query;
END LOOP;
CLOSE ref_cursor;
END;

-- to execute this procedure use next code.
DECLARE 
BEGIN
SET_CURRENT_DATE('date_test_table');
END;

                
                
  


