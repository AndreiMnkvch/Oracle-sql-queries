ALTER TABLE "subscribers" 
ADD ("s_last_visit" DATE DEFAULT NULL NULL);
-- ������������� ������: 
UPDATE "subscribers" "outer" 
SET "s_last_visit" = (  SELECT "last_visit" 
                        FROM "subscribers" 
                        LEFT JOIN (SELECT "sb_subscriber", 
                                            MAX("sb_start") AS "last_visit" 
                                    FROM "subscriptions" 
                                    GROUP BY "sb_subscriber") "prepared_data" 
                        ON "s_id" = "sb_subscriber" 
                        WHERE "outer"."s_id" = "sb_subscriber");
                        
                        
CREATE TRIGGER "last_visit_on_scs_ins_upd_del" 
AFTER INSERT OR UPDATE OR DELETE 
ON "subscriptions" 
    BEGIN
    UPDATE "subscribers" "outer" 
    SET "s_last_visit" = (  SELECT "last_visit" 
                            FROM "subscribers" 
                            LEFT JOIN (SELECT   "sb_subscriber", 
                                                MAX("sb_start") AS "last_visit" 
                                        FROM "subscriptions" 
                                        GROUP BY "sb_subscriber") "prepared_data" 
                            ON "s_id" = "sb_subscriber" 
                            WHERE "outer"."s_id" = "sb_subscriber"); 
    END;

ALTER TRIGGER "TRG_subscriptions_sb_id" DISABLE;
-- ���������� ������ ����� �������� � ��������������� 6 -- (����� �� ������� �� ��� � ����������): 
INSERT INTO "subscriptions" 
            ("sb_id",
            "sb_subscriber", 
            "sb_book",
            "sb_start",
            "sb_finish",
            "sb_is_active")
    VALUES (200,
            6,
            30,
            TO_DATE('2019-01-12', 'YYYY-MM-DD'),
            TO_DATE('2019-02-12', 'YYYY-MM-DD'),
            'N');
-- ��������� �������������� �������� � ������ ��� -- ����������� ������ � 6 �� 1: 
UPDATE "subscriptions" 
SET "sb_subscriber" = 1 
WHERE "sb_id" = 200;
-- ��� ���� ������ �����  -- (������������� �������� = 6): 
INSERT INTO "subscriptions" 
            ("sb_id",
            "sb_subscriber",
            "sb_book",
            "sb_start",
            "sb_finish",
            "sb_is_active")
    VALUES (201,
            6,
            30,
            TO_DATE('2020-01-12', 'YYYY-MM-DD'),
            TO_DATE('2020-02-12', 'YYYY-MM-DD'),
            'N');
-- ��������� �������� ���� ����� ������������������ -- ������ ����� (������� ���������� � ������� �.�. -- �� ������� �.�.): 
UPDATE "subscriptions" 
SET "sb_start" = TO_DATE('2021-02-24', 'YYYY-MM-DD') 
WHERE "sb_id" = 200; 
-- �������� ���� ������������������ ������: 
DELETE 
FROM "subscriptions" 
WHERE "sb_id" = 200;
-- �������� ������������ ������ ������� �.�.: 
DELETE 
FROM "subscriptions" 
WHERE "sb_id" = 201;

DELETE 
FROM "books" 
WHERE "b_id" = 30;

/*������������� ��� �������� ����� �� "books" ��������� � �������������� ������,
� ����� ��� ������ �������� ����������� ���� "s_last_visit".
*/
ALTER TRIGGER "TRG_subscriptions_sb_id" ENABLE;
