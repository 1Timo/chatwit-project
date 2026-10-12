BEGIN;

--
-- ACTION ALTER TABLE
--
ALTER TABLE "comment" ADD COLUMN "videoUrl" text;
--
-- ACTION ALTER TABLE
--
ALTER TABLE "post" ADD COLUMN "category" text;
--
-- ACTION CREATE TABLE
--
CREATE TABLE "user_interaction" (
    "id" bigserial PRIMARY KEY,
    "userId" text NOT NULL,
    "category" text NOT NULL,
    "score" bigint NOT NULL,
    "createdAt" timestamp without time zone NOT NULL
);

-- Indexes
CREATE INDEX "user_category_idx" ON "user_interaction" USING btree ("userId", "category");


--
-- MIGRATION VERSION FOR chatwit
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('chatwit', '20260817092454174', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260817092454174', "timestamp" = now();

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
