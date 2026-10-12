BEGIN;

--
-- ACTION DROP TABLE
--
DROP TABLE "comment" CASCADE;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "comment" (
    "id" bigserial PRIMARY KEY,
    "postId" bigint NOT NULL,
    "userId" text NOT NULL,
    "userName" text NOT NULL,
    "text" text,
    "imageUrl" text,
    "createdAt" timestamp without time zone NOT NULL
);

--
-- ACTION DROP TABLE
--
DROP TABLE "user_registration" CASCADE;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "user_registration" (
    "id" bigserial PRIMARY KEY,
    "authUserId" uuid NOT NULL,
    "firstName" text NOT NULL,
    "surname" text NOT NULL,
    "middleName" text,
    "username" text NOT NULL,
    "dateOfBirth" timestamp without time zone NOT NULL,
    "gender" text NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "auth_user_id_unique_idx" ON "user_registration" USING btree ("authUserId");
CREATE UNIQUE INDEX "username_unique_idx" ON "user_registration" USING btree ("username");

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "user_registration"
    ADD CONSTRAINT "user_registration_fk_0"
    FOREIGN KEY("authUserId")
    REFERENCES "serverpod_auth_core_user"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;


--
-- MIGRATION VERSION FOR chatwit
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('chatwit', '20260730131020890', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260730131020890', "timestamp" = now();

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
