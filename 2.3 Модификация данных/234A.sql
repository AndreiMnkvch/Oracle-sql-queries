MERGE INTO "genres"
USING ( SELECT (N'Politics') AS "g_name"
        FROM DUAL
        UNION
        SELECT (N'Psychology') AS "g_name"
        FROM DUAL
        UNION
        SELECT (N'History') AS "g_name"
        FROM DUAL) "new_genres"
    ON ("genres"."g_name" = "new_genres"."g_name")
WHEN NOT MATCHED THEN 
    INSERT ("g_name")
    VALUES ("new_genres"."g_name")