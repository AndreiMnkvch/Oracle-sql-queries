CREATE TYPE "tree_node" AS OBJECT("id" VARCHAR(32767));
CREATE TYPE "tree_nodes_collection" AS TABLE OF "tree_node";

CREATE OR REPLACE FUNCTION GET_ALL_CHILDS_DEEP(deep_level NUMBER, parent_id NUMBER)
RETURN "tree_nodes_collection"
AS
result_collection "tree_nodes_collection" := "tree_nodes_collection"();
BEGIN 
WITH "tree" ("sp_id","sp_parent","lvl")
AS (
    SELECT  "sp_id",
            "sp_parent",
            LEVEL
    FROM "site_pages"
    START WITH "sp_id" = parent_id
    CONNECT BY PRIOR "sp_id" = "sp_parent"
    )

SELECT "tree_node"(TO_CHAR("sp_id"))
BULK COLLECT INTO result_collection
FROM "tree"
WHERE "lvl" < deep_level AND "sp_id" != parent_id;
RETURN result_collection;
END;

SELECT * FROM TABLE(CAST(GET_ALL_CHILDS_DEEP(3, 1) AS "tree_nodes_collection"));