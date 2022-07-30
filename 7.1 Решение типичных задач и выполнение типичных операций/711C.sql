--������� 7.1.1.TSK.C: �������� �������, ������������ ������ ���������������
--������ �� ���� �� ����� ������ � �������� ������� (��������, ���������������
--���� ������ �� ���� �� �������� ��������� � �������� ����������).

CREATE OR REPLACE FUNCTION GET_PATH_FROM_ROOT(start_node NUMBER)
RETURN VARCHAR
AS
result_string VARCHAR(150);
BEGIN
SELECT "path" INTO result_string
FROM (
SELECT SYS_CONNECT_BY_PATH("sp_name",'/') AS "path"
FROM "site_pages"
CONNECT BY PRIOR "sp_id" = "sp_parent")
WHERE "path" LIKE '/Main%/'|| start_node || '';
RETURN result_string;
END;

SET SERVEROUTPUT ON;
BEGIN 
DBMS_OUTPUT.PUT_LINE(GET_PATH_FROM_ROOT('Statistics'));
END;
