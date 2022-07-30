--������� 7.1.1.TSK.B: �������� ������ ��� ������ ����� ��������� �������� 
--������� ������, ������� ���� ������������ ������� (��������, ���� ���������� 
--�������� ����������, ������� ���� ��� ��������), � ������� � ������� ������ 
--�������� � ������� �������� �� ����� ����� �������.
WITH "tree" 
AS (
SELECT  "sp_id",
        "sp_parent",
        "sp_name",
        LEVEL,
        ROW_NUMBER() OVER( PARTITION BY LEVEL ORDER BY "sp_id" ) AS "rn"
FROM "site_pages"
START WITH "sp_id" = 1
CONNECT BY PRIOR "sp_id" = "sp_parent"
    )
    
SELECT  "sp_id",
        "sp_parent",
        "sp_name"
FROM "tree"
WHERE "rn"<=1;
