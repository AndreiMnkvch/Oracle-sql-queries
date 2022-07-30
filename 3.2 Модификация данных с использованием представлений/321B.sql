CREATE VIEW "subscriptions_wcd_and_status" AS
SELECT  "sb_id",
        "sb_book",
        "sb_subscriber",
        TO_CHAR("sb_start", 'YYYY-MM-DD') || ' - ' || 
        TO_CHAR("sb_finish", 'YYYY-MM-DD') || ' - '||
        CASE 
            WHEN "sb_is_active" = 'Y' 
                THEN (  SELECT N'IN_USE' FROM "DUAL")
            ELSE   
                (SELECT N'RETURNED' FROM "DUAL") 
        END
AS "status"
FROM "subscriptions";

DROP VIEW "subscriptions_wcd_and_status";
SELECT * FROM "subscriptions_wcd_and_status"