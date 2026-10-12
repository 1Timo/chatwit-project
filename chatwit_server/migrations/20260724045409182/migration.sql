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
    "senderId" bigint NOT NULL,
    "senderName" text NOT NULL,
    "receiverId" bigint NOT NULL,
    "text" text,
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP
);

--
-- ACTION CREATE TABLE
--
CREATE TABLE "comment" (
    "id" bigserial PRIMARY KEY,
    "postId" bigint NOT NULL,
    "userId" text NOT NULL,
    "userName" text NOT NULL,
    "text" text NOT NULL,
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP
);

--
-- ACTION CREATE TABLE
--
CREATE TABLE "follow" (
    "id" bigserial PRIMARY KEY,
    "followerId" bigint NOT NULL,
    "followerName" text NOT NULL,
    "followingId" bigint NOT NULL,
    "followingName" text NOT NULL,
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Indexes
CREATE UNIQUE INDEX "follow_follower_following_idx" ON "follow" USING btree ("followerId", "followingId");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "like" (
    "id" bigserial PRIMARY KEY,
    "postId" bigint NOT NULL,
    "userId" text NOT NULL,
    "userName" text NOT NULL,
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Indexes
CREATE UNIQUE INDEX "like_post_user_idx" ON "like" USING btree ("postId", "userId");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "post" (
    "id" bigserial PRIMARY KEY,
    "userId" text NOT NULL,
    "userName" text NOT NULL,
    "text" text,
    "imageUrl" text,
    "videoUrl" text,
    "createdAt" timestamp without time zone NOT NULL
);


--
-- MIGRATION VERSION FOR chatwit
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('chatwit', '20260724045409182', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260724045409182', "timestamp" = now();

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
