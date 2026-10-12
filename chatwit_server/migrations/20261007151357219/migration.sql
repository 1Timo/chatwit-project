BEGIN;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "call_signal_event" (
    "id" bigserial PRIMARY KEY,
    "roomId" text NOT NULL,
    "fromUserId" text NOT NULL,
    "toUserId" text NOT NULL,
    "type" text NOT NULL,
    "payload" text,
    "createdAt" timestamp without time zone NOT NULL
);

--
-- ACTION CREATE TABLE
--
CREATE TABLE "hashtag" (
    "id" bigserial PRIMARY KEY,
    "tag" text NOT NULL,
    "postId" bigint NOT NULL,
    "createdAt" timestamp without time zone NOT NULL
);

--
-- ACTION CREATE TABLE
--
CREATE TABLE "mention" (
    "id" bigserial PRIMARY KEY,
    "userId" text NOT NULL,
    "postId" bigint NOT NULL,
    "createdAt" timestamp without time zone NOT NULL
);

--
-- ACTION CREATE TABLE
--
CREATE TABLE "poll" (
    "id" bigserial PRIMARY KEY,
    "question" text NOT NULL,
    "options" text NOT NULL,
    "createdByUserId" text NOT NULL,
    "createdAt" timestamp without time zone NOT NULL,
    "totalVotes" bigint NOT NULL DEFAULT 0,
    "isClosed" boolean NOT NULL DEFAULT false,
    "expiresAt" timestamp without time zone
);

--
-- ACTION CREATE TABLE
--
CREATE TABLE "poll_vote" (
    "id" bigserial PRIMARY KEY,
    "pollId" bigint NOT NULL,
    "userId" text NOT NULL,
    "optionIndex" bigint NOT NULL,
    "createdAt" timestamp without time zone NOT NULL
);

--
-- ACTION CREATE TABLE
--
CREATE TABLE "user_notification" (
    "id" bigserial PRIMARY KEY,
    "userId" text NOT NULL,
    "title" text NOT NULL,
    "body" text NOT NULL,
    "type" text NOT NULL,
    "relatedUserId" text,
    "relatedPostId" bigint,
    "isRead" boolean NOT NULL DEFAULT false,
    "createdAt" timestamp without time zone NOT NULL
);

--
-- ACTION CREATE TABLE
--
CREATE TABLE "user_preference" (
    "id" bigserial PRIMARY KEY,
    "userId" text NOT NULL,
    "categories" text NOT NULL,
    "createdAt" timestamp without time zone NOT NULL,
    "updatedAt" timestamp without time zone NOT NULL
);

--
-- ACTION CREATE TABLE
--
CREATE TABLE "voice_recording" (
    "id" bigserial PRIMARY KEY,
    "callRoomId" text NOT NULL,
    "fromUserId" text NOT NULL,
    "toUserId" text NOT NULL,
    "recordingUrl" text NOT NULL,
    "duration" bigint NOT NULL,
    "createdAt" timestamp without time zone NOT NULL
);


--
-- MIGRATION VERSION FOR chatwit
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('chatwit', '20261007151357219', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20261007151357219', "timestamp" = now();

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
