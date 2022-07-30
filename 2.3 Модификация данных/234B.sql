ALTER TRIGGER “library”.“TRG_subscribers_s_id” DISABLE;

MERGE INTO “library”.”subscribers” “destination”
using “huge_library”.”subscribers” “source”
ON ( “destination”.”s_id” = “source”.”s_id”)
WHEN MATCHED THEN
UPDATE 
SET “destination”.”s_name” =Concat(“destination”.”s_name”, N’ [ old]’)
WHEN NOT MATCHED THEN 
      INSERT    (“s_id”,
                ”s_name”)
       VALUES   (“source”.”s_id”,
                “source”.”s_name”)

ALTER TRIGGER “library”.“TRG_subscribers_s_id” ENABLE;