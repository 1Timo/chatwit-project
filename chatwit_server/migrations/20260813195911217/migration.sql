BEGIN;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "bookmark" (
    "id" bigserial PRIMARY KEY,
    "userId" text NOT NULL,
    "postId" bigint NOT NULL,
    "createdAt" timestamp without time zone NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "bookmark_user_post_idx" ON "bookmark" USING btree ("userId", "postId");


--
-- MIGRATION VERSION FOR chatwit
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('chatwit', '20260813195911217', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260813195911217', "timestamp" = now();

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
