
CREATE TABLE  "site_pages"
(
	"sp_id" NUMBER(10) NOT NULL,
	"sp_parent" NUMBER(10) NULL,
	"sp_name" NVARCHAR2(200) NULL
)
;


CREATE SEQUENCE "SEQ_site_pages_sp_id" 
	INCREMENT BY 1 
	START WITH 1 
	NOMAXVALUE 
	MINVALUE  1 
	NOCYCLE 
	NOCACHE 
	NOORDER
;


CREATE OR REPLACE TRIGGER "TRG_site_pages_sp_id" 
	BEFORE INSERT 
	ON "site_pages" 
	FOR EACH ROW 
	BEGIN 
		SELECT "SEQ_site_pages_sp_id".NEXTVAL 
		INTO :NEW."sp_id" 
		FROM DUAL; 
	END;

ALTER TABLE  "site_pages" 
 ADD CONSTRAINT "PK_site_pages"
	PRIMARY KEY ("sp_id") 
 USING INDEX
;

ALTER TABLE  "site_pages" 
 ADD CONSTRAINT "FK_site_pages_site_pages"
	FOREIGN KEY ("sp_parent") REFERENCES  "site_pages" ("sp_id")
;



Insert into "EXPLORATION"."site_pages" ("sp_id","sp_parent","sp_name") values (1,null,'Main');
Insert into "EXPLORATION"."site_pages" ("sp_id","sp_parent","sp_name") values (2,1,'For subscribers');
Insert into "EXPLORATION"."site_pages" ("sp_id","sp_parent","sp_name") values (3,1,'For sponsors');
Insert into "EXPLORATION"."site_pages" ("sp_id","sp_parent","sp_name") values (4,1,'For advertisers');
Insert into "EXPLORATION"."site_pages" ("sp_id","sp_parent","sp_name") values (5,2,'News');
Insert into "EXPLORATION"."site_pages" ("sp_id","sp_parent","sp_name") values (6,2,'Statistics');
Insert into "EXPLORATION"."site_pages" ("sp_id","sp_parent","sp_name") values (7,3,'Offers');
Insert into "EXPLORATION"."site_pages" ("sp_id","sp_parent","sp_name") values (8,3,'Success stories');
Insert into "EXPLORATION"."site_pages" ("sp_id","sp_parent","sp_name") values (9,4,'Events');
Insert into "EXPLORATION"."site_pages" ("sp_id","sp_parent","sp_name") values (10,1,'Contacts');
Insert into "EXPLORATION"."site_pages" ("sp_id","sp_parent","sp_name") values (11,3,'Documents');
Insert into "EXPLORATION"."site_pages" ("sp_id","sp_parent","sp_name") values (12,6,'Current');
Insert into "EXPLORATION"."site_pages" ("sp_id","sp_parent","sp_name") values (13,6,'Archive');
Insert into "EXPLORATION"."site_pages" ("sp_id","sp_parent","sp_name") values (14,6,'Non-official');
