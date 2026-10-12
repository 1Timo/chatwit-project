BEGIN;

--
-- ACTION ALTER TABLE
--
ALTER TABLE "comment" ADD COLUMN "authorId" bigint;
ALTER TABLE "comment" ADD COLUMN "fullName" text;
ALTER TABLE "comment" ADD COLUMN "profileImageUrl" text;
--
-- ACTION ALTER TABLE
--
ALTER TABLE "post" ADD COLUMN "authorId" bigint;
--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "comment"
    ADD CONSTRAINT "comment_fk_0"
    FOREIGN KEY("authorId")
    REFERENCES "user_registration"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "post"
    ADD CONSTRAINT "post_fk_0"
    FOREIGN KEY("authorId")
    REFERENCES "user_registration"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- MIGRATION VERSION FOR chatwit
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('chatwit', '20260817224042699', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260817224042699', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod', '20260129180959368', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260129180959368', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod_auth_idp
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod_auth_idp', '20260213194423028', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260213194423028', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod_auth_core
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod_auth_core', '20260129181112269', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260129181112269', "timestamp" = now();


COMMIT;
