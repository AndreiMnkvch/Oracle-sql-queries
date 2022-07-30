CREATE OR REPLACE PROCEDURE GET_DEPENDENT_TABLES_AND_FK(src_table_name IN VARCHAR2)
AS
query_text VARCHAR2(1000);
ref_curs SYS_REFCURSOR;
result_table VARCHAR2(30);
result_for_key VARCHAR2(30);
BEGIN
query_text :=   
               'SELECT TABLE_NAME, CONSTRAINT_NAME
                FROM ALL_CONSTRAINTS
                WHERE OWNER = USER
                AND CONSTRAINT_TYPE=''R''
                AND R_CONSTRAINT_NAME=   (  SELECT CONSTRAINT_NAME 
                                            FROM ALL_CONSTRAINTS
                                            WHERE TABLE_NAME=''src_table_name_placeholder''
                                            AND OWNER = USER
                                            AND CONSTRAINT_TYPE=''P'')';               
query_text := REPLACE(query_text, 'src_table_name_placeholder', src_table_name);
OPEN ref_curs FOR query_text;
LOOP
FETCH ref_curs INTO result_table, result_for_key;
EXIT WHEN ref_curs%NOTFOUND;
DBMS_OUTPUT.PUT_LINE('Table '||result_table ||' depends on ' || src_table_name|| ' and its foreign key is ' ||  result_for_key||'.');
END LOOP;
END;


DECLARE
BEGIN
GET_DEPENDENT_TABLES_AND_FK('genres');
END;



SET SERVEROUTPUT ON;