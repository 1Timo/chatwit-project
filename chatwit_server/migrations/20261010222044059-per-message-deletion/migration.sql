BEGIN;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "message_visibility" (
    "id" bigserial PRIMARY KEY,
    "userId" text NOT NULL,
    "messageId" bigint NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "message_visibility_user_message_idx" ON "message_visibility" USING btree ("userId", "messageId");


--
-- MIGRATION VERSION FOR chatwit
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('chatwit', '20261010222044059-per-message-deletion', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20261010222044059-per-message-deletion', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod', '20260824182259319', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260824182259319', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod_auth_idp
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod_auth_idp', '20260924105404509', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260924105404509', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod_auth_core
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod_auth_core', '20260924105232991', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260924105232991', "timestamp" = now();


COMMIT;
