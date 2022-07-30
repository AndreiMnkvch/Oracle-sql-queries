ALTER TABLE "subscriptions" MODIFY CONSTRAINT "PK_subscriptions" DISABLE;
INSERT ALL
    INTO "subscriptions"
        ("sb_id",
        "sb_subscriber",
        "sb_book",
        "sb_start",
        "sb_finish",
        "sb_is_active")
VALUES (NULL,
        5,
        6,
        TO_DATE('2016-01-20','YYYY-MM-DD'),
        TO_DATE('2016-02-20','YYYY-MM-DD'),
        'N')
INTO "subscriptions"
        ("sb_id",
        "sb_subscriber",
            "sb_book",
            "sb_start",
            "sb_finish",
            "sb_is_active")
VALUES (NULL,
        6,
        6,
        TO_DATE('2016-01-20','YYYY-MM-DD'),
        TO_DATE('2016-02-20','YYYY-MM-DD'),
        'N')
INTO "subscriptions"
        ("sb_id",
        "sb_subscriber",
        "sb_book",
        "sb_start",
        "sb_finish",
        "sb_is_active")
VALUES (NULL,
        7,
        6,
        TO_DATE('2016-01-20','YYYY-MM-DD'),
        TO_DATE('2016-02-20','YYYY-MM-DD'),
        'N')
SELECT 1 FROM DUAL;
ALTER TABLE "subscriptions" MODIFY CONSTRAINT "PK_subscriptions" ENABLE;