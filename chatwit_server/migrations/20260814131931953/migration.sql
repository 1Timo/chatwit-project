BEGIN;

--
-- ACTION ALTER TABLE
--
ALTER TABLE "user_registration" ADD COLUMN "occupation" text;
ALTER TABLE "user_registration" ADD COLUMN "backgroundUrl" text;

--
-- MIGRATION VERSION FOR chatwit
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('chatwit', '20260814131931953', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260814131931953', "timestamp" = now();

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
