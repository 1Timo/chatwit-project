BEGIN;

--
-- ACTION ALTER TABLE
--
ALTER TABLE "chat_messages" ALTER COLUMN "createdAt" DROP DEFAULT;
--
-- ACTION ALTER TABLE
--
ALTER TABLE "comment" DROP COLUMN "userName";
ALTER TABLE "comment" ADD COLUMN "username" text;
ALTER TABLE "comment" ALTER COLUMN "createdAt" DROP DEFAULT;
--
-- ACTION ALTER TABLE
--
DROP INDEX "like_post_user_idx";
ALTER TABLE "like" DROP COLUMN "userName";
ALTER TABLE "like" ADD COLUMN "username" text;
ALTER TABLE "like" ALTER COLUMN "createdAt" DROP DEFAULT;
--
-- ACTION ALTER TABLE
--
ALTER TABLE "post" ALTER COLUMN "userName" DROP NOT NULL;

--
-- MIGRATION VERSION FOR chatwit
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('chatwit', '20260724192013812', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260724192013812', "timestamp" = now();

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
