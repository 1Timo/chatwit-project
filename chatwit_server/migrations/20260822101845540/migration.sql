BEGIN;

--
-- ACTION DROP TABLE
--
DROP TABLE "chat_messages" CASCADE;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "chat_messages" (
    "id" bigserial PRIMARY KEY,
    "senderId" text NOT NULL,
    "senderName" text NOT NULL,
    "receiverId" text NOT NULL,
    "text" text,
    "createdAt" timestamp without time zone NOT NULL
);


--
-- MIGRATION VERSION FOR chatwit
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('chatwit', '20260822101845540', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260822101845540', "timestamp" = now();

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
