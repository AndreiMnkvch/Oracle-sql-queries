Insert all
     Into     "authors"
                 ("a_name")
    Values (N'Yuval Harari')
      Into    "authors"
                 ("a_name")
       Values (N'Vasily Yan')
       Into     "authors"
                  ("a_name")
        Values (N'Paolo Coelho')
        Into    "authors"
                 ("a_name")
        Values (N'Lev Tolstoy')
        Into     "authors"
                    ("a_name")
        Values (N'Mark Twain')
Select 1 from "DUAL";
Insert all
    Into        "books"
                ("b_name",
                "b_year",
                "b_quantity")
    Values      (N'Sapiens: A Brief History of Humankind',
                2011,
                1)

    Into        "books"
                ("b_name",
                "b_year",
                "b_quantity")
    Values      (N'Homo Deus: A Brief History of Tomorrow',
                2015,
                1)
    
    Into        "books"
                ("b_name",
                "b_year",
                "b_quantity")
    Values      (N'Genghis Khan',
                1939,
                1)
    
    Into        "books"
                ("b_name",
                "b_year",
                "b_quantity")
    Values      (N'Baty',
                1942,
                1)
    
    Into        "books"
                ("b_name",
                "b_year",
                "b_quantity")
    Values      (N'The Alchemist',
                1988,
                1)
    
    Into        "books"
                ("b_name",
                "b_year",
                "b_quantity")
    Values      (N'Eleven Minutes',
                2003,
                1)
    
    Into        "books"
                ("b_name",
                "b_year",
                "b_quantity")
    Values      (N'War and Peace',
                1867,
                1)
    
    Into        "books"
                ("b_name",
                "b_year",
                "b_quantity")
    Values      (N'Anna Karenina',
                1878,
                1)
    
    Into        "books"
                ("b_name",
                "b_year",
                "b_quantity")
    Values      (N'A Tramp Abroad',
                1880,
                1)
    
    Into        "books"
                ("b_name",
                "b_year",
                "b_quantity")
    Values      (N'The Mysterious Stranger',
                1916,
                1)
Select 1 from "DUAL";
Insert all 
    Into        "genres"
                ("g_name")
    Values      (N'Non-fiction')
    Into        "genres"
                ("g_name")
    Values      (N'Novel')
    Into        "genres"
                ("g_name")
    Values      (N'Fiction')
Select 1 from "DUAL";
Insert all 
    Into        "m2m_books_authors"
                ("b_id", "a_id")
    Values      (9,
                8)
    Into        "m2m_books_authors"
                ("b_id", "a_id")
    Values      (10,
                8)
    Into        "m2m_books_authors"
                ("b_id", "a_id")
    Values      (11,
                9)
    Into        "m2m_books_authors"
                ("b_id", "a_id")
    Values      (12,
                9)
    Into        "m2m_books_authors"
                ("b_id", "a_id")
    Values      (13,
                10)
    Into        "m2m_books_authors"
                ("b_id", "a_id")
    Values      (14,
                10)
    Into        "m2m_books_authors"
                ("b_id", "a_id")
    Values      (15,
                11)
    Into        "m2m_books_authors"
                ("b_id", "a_id")
    Values      (16,
                11)
    Into        "m2m_books_authors"
                ("b_id", "a_id")
    Values      (17,
                12)
    Into        "m2m_books_authors"
                ("b_id", "a_id")
    Values      (18,
                12)
Select 1 from "DUAL";
Insert all 
    Into        "m2m_books_genres"
                ("b_id", "g_id")
    Values      (9,
                7)
    Into        "m2m_books_genres"
                ("b_id", "g_id")
    Values      (10,
                7)
    Into        "m2m_books_genres"
                ("b_id", "g_id")
    Values      (11,
                8)
    Into        "m2m_books_genres"
                ("b_id", "g_id")
    Values      (12,
                8)
    Into        "m2m_books_genres"
                ("b_id", "g_id")
    Values      (13,
                8)
    Into        "m2m_books_genres"
                ("b_id", "g_id")
    Values      (14,
                8)
    Into        "m2m_books_genres"
                ("b_id", "g_id")
    Values      (15,
                8)
    Into        "m2m_books_genres"
                ("b_id", "g_id")
    Values      (16,
                8)
    Into        "m2m_books_genres"
                ("b_id", "g_id")
    Values      (14,
                9)
    Into        "m2m_books_genres"
                ("b_id", "g_id")
    Values      (17,
                9)
    Into        "m2m_books_genres"
                ("b_id", "g_id")
    Values      (18,
                9)
    Into        "m2m_books_genres"
                ("b_id", "g_id")
    Values      (15,
                5)
SELECT 1 FROM "DUAL";