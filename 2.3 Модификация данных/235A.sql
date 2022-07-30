ALTER TRIGGER “library”.“TRG_subscribers_s_id” DISABLE; 
MERGE INTO “library”.”subscribers” “destination”
USING “huge_library”.”subscribers” “source” 
ON ( “destination”.”s_id” = “source”.”s_id” )
WHEN MATCHED THEN 
UPDATE SET “destination”.”s_name” = concat(“destination”.”s_name”, N’ [ old]’)
WHEN NOT MATCHED THEN 
      INSERT    (“s_id”,
                ”s_name”)
       VALUES   (“source”.”s_id”,
                “source”.”s_name”)

ALTER TRIGGER “library”.“TRG_subscribers_s_id” ENABLE;

UPDATE "subscribers"
SET "s_name" = (
    SELECT
        CASE
            WHEN "x" > 5 THEN
                (
                    SELECT
                        "s_name" || ' ['
                                    || "x"
                                       || '] [RED]'
                    FROM
                        "DUAL"
                )
            WHEN "x" >= 3
                 AND "x" <= 5 THEN
                (
                    SELECT
                        "s_name" || ' ['
                                    || "x"
                                       || '] [YELLOW]'
                    FROM
                        "DUAL"
                )
            ELSE
                (
                    SELECT
                        "s_name" || ' ['
                                    || "x"
                                       || '] [GREEN]'
                    FROM
                        "DUAL"
                )
        END
    FROM
        (
            SELECT
                "s_id",
                COUNT("sb_subscriber") AS "x"
            FROM
                     "subscribers" left
                JOIN (
                    SELECT
                        "sb_subscriber"
                    FROM
                        "subscriptions"
                    WHERE
                        "sb_is_active" = 'Y'
                ) ON "s_id" = "sb_subscriber"
            GROUP BY
                "s_id"
        ) "prepared_data"
    WHERE
        "subscribers"."s_id" = "prepared_data"."s_id"
)