-- noinspection SqlNoDataSourceInspectionForFile

--
-- Created by SQL::Translator::Producer::SQLite
-- Created on Wed May 15 14:54:30 2019
-- 

;
BEGIN TRANSACTION;
--
-- Table: "posts"
--
CREATE TABLE "posts" (
  "id" INTEGER PRIMARY KEY NOT NULL,
  "author" text NOT NULL,
  "title" text NOT NULL,
  "content" text NOT NULL,
  "date_published" datetime NOT NULL
);
COMMIT;
