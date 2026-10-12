BEGIN;

--
-- ACTION ALTER TABLE
--
ALTER TABLE "post" ADD COLUMN "location" text;
--
-- ACTION CREATE TABLE
--
CREATE TABLE "post_interaction" (
    "id" bigserial PRIMARY KEY,
    "userId" text NOT NULL,
    "postId" bigint NOT NULL,
    "interactionType" text NOT NULL,
    "createdAt" timestamp without time zone NOT NULL
);

-- Indexes
CREATE INDEX "post_interaction_user_post_idx" ON "post_interaction" USING btree ("userId", "postId", "interactionType");

--
-- ACTION ALTER TABLE
--
DROP INDEX "user_category_idx";
ALTER TABLE "user_interaction" ADD COLUMN "targetUserId" text;
ALTER TABLE "user_interaction" ALTER COLUMN "category" DROP NOT NULL;
CREATE INDEX "user_interaction_idx" ON "user_interaction" USING btree ("userId", "createdAt");

--
-- MIGRATION VERSION FOR chatwit
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('chatwit', '20260819070600724', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260819070600724', "timestamp" = now();

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
