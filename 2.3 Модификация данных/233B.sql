ALTER TABLE "m2m_books_genres"
DROP CONSTRAINT "FK_m2m_books_genres_books";
ALTER TABLE "m2m_books_genres" ADD CONSTRAINT "FK_m2m_books_genres_books" FOREIGN KEY ("b_id")
	  REFERENCES "books" ("b_id") ON DELETE CASCADE ENABLE;
DELETE FROM "books"
WHERE "b_id" IN (
                    SELECT "b_id"
                    FROM "m2m_books_genres"
                    WHERE "g_id" =( Select "g_id"
                                    FROM "genres"
                                    WHERE "g_name"=N'Classic'))
