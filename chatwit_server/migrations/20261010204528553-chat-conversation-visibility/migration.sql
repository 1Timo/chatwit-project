BEGIN;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "conversation_visibility" (
    "id" bigserial PRIMARY KEY,
    "userId" text NOT NULL,
    "otherUserId" text NOT NULL,
    "hiddenBefore" timestamp without time zone NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "conversation_visibility_user_other_idx" ON "conversation_visibility" USING btree ("userId", "otherUserId");


--
-- MIGRATION VERSION FOR chatwit
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('chatwit', '20261010204528553-chat-conversation-visibility', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20261010204528553-chat-conversation-visibility', "timestamp" = now();

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
