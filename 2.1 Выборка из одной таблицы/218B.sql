SELECT "sb_subscriber"
FROM (SELECT "sb_subscriber",
              RANK() OVER (ORDER BY "books_read" desc) AS "rn"
      FROM (SELECT COUNT("sb_finish") AS "books_read",
            "sb_subscriber"
            FROM "subscriptions"
            GROUP BY "sb_subscriber"))
WHERE "rn" = 1        