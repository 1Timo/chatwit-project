BEGIN;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "stories" (
    "id" bigserial PRIMARY KEY,
    "userId" text NOT NULL,
    "userName" text,
    "profileImageUrl" text,
    "mediaUrl" text NOT NULL,
    "mediaType" text NOT NULL,
    "createdAt" timestamp without time zone NOT NULL,
    "expiresAt" timestamp without time zone NOT NULL
);


--
-- MIGRATION VERSION FOR chatwit
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('chatwit', '20260814200234815', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260814200234815', "timestamp" = now();

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
