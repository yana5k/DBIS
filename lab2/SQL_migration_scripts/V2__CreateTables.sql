CREATE TABLE IF NOT EXISTS "Regions"
(
    RegionName text COLLATE pg_catalog."default",
    CONSTRAINT "Regions_pkey" PRIMARY KEY (RegionName)
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE "Regions"
    OWNER to postgres;
----------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS "Areas"
(
    AreaName text COLLATE pg_catalog."default",
    RegionName text COLLATE pg_catalog."default",
    CONSTRAINT "Area_pkey" PRIMARY KEY (AreaName),
    CONSTRAINT "RegionNameFK" FOREIGN KEY (RegionName)
        REFERENCES "Regions" (RegionName) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE "Areas"
    OWNER to postgres;
----------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS "ClassLanguage"
(
    LangName text COLLATE pg_catalog."default",
    CONSTRAINT "ClassLanguage_pkey" PRIMARY KEY (LangName)
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE "ClassLanguage"
    OWNER to postgres;
----------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS "ClassProfile"
(
    ProfileName text COLLATE pg_catalog."default",
    CONSTRAINT "ClassProfile_pkey" PRIMARY KEY (ProfileName)
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE "ClassProfile"
    OWNER to postgres;
----------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS "TestDPA"
(
    name text COLLATE pg_catalog."default",
    CONSTRAINT "TestDPA_pkey" PRIMARY KEY (name)
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE "TestDPA"
    OWNER to postgres;
----------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS "RegistrationType"
(
    name text COLLATE pg_catalog."default",
    CONSTRAINT "RegistrationTypeName_pkey" PRIMARY KEY (name)
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE "RegistrationType"
    OWNER to postgres;
----------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS "Genders"
(
    name text COLLATE pg_catalog."default",
    CONSTRAINT "Genders_pkey" PRIMARY KEY (name)
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE "Genders"
    OWNER to postgres;
----------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS "TerritoriesType"
(
    name text COLLATE pg_catalog."default",
    CONSTRAINT "TerritoriesType_pkey" PRIMARY KEY (name)
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE "TerritoriesType"
    OWNER to postgres;
----------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS "Territories"
(
    name text COLLATE pg_catalog."default",
    tertype text COLLATE pg_catalog."default",
    AreaName text COLLATE pg_catalog."default",
    CONSTRAINT "Territories_pkey" PRIMARY KEY (name),
    CONSTRAINT "TerAreaFk" FOREIGN KEY (AreaName)
        REFERENCES "Areas" (AreaName) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT "TerTypeFk" FOREIGN KEY (tertype)
        REFERENCES "TerritoriesType" (name) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE "Territories"
    OWNER to postgres;
----------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS "School"
(
    name text COLLATE pg_catalog."default" NOT NULL,
    Territory text COLLATE pg_catalog."default",
    Category text COLLATE pg_catalog."default",
    Parent text COLLATE pg_catalog."default",
    CONSTRAINT "School_pkey" PRIMARY KEY (name),
    CONSTRAINT "SchoolTerritoriesFK" FOREIGN KEY (Territory)
        REFERENCES "Territories" (name) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE "School"
    OWNER to postgres;
----------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS "TestStatus"
(
    name text COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT "TestStatus_pkey" PRIMARY KEY (name)
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE "TestStatus"
    OWNER to postgres;
----------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS "TestSubject"
(
    Subject text COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT "Test_sub_pkey" PRIMARY KEY (Subject)
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE "TestSubject"
    OWNER to postgres;
----------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS "TestYear"
(
    TestingYear smallint NOT NULL,
    CONSTRAINT "TestYear_pkey" PRIMARY KEY (TestingYear)
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE "TestYear"
    OWNER to postgres;
----------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS "TestLanguage"
(
    LangName text NOT NULL,
    CONSTRAINT "Testlang_pkey" PRIMARY KEY (LangName)
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE "TestLanguage"
    OWNER to postgres;
----------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS "Student"
(
    outid text COLLATE pg_catalog."default" NOT NULL,
    birthday smallint,
    gender text COLLATE pg_catalog."default",
    Territory text COLLATE pg_catalog."default",
    ProfileName text COLLATE pg_catalog."default",
    ClassLangName text COLLATE pg_catalog."default",
    School text COLLATE pg_catalog."default",
    RegistrationType text COLLATE pg_catalog."default",
    CONSTRAINT "Student_pkey" PRIMARY KEY (outid),
    CONSTRAINT "CProfileStidentFk" FOREIGN KEY (ProfileName)
        REFERENCES "ClassProfile" (ProfileName) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT "ClassLangNamefk" FOREIGN KEY (ClassLangName)
        REFERENCES "ClassLanguage" (LangName) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT "RegistrTypeFk" FOREIGN KEY (RegistrationType)
        REFERENCES "RegistrationType" (name) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT "SchoolStudentFk" FOREIGN KEY (School)
        REFERENCES "School" (name) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT "GendersFk" FOREIGN KEY (gender)
        REFERENCES "Genders" (name) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT "TerStudentFk" FOREIGN KEY (Territory)
        REFERENCES "Territories" (name) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE "Student"
    OWNER to postgres;

----------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS "ZnoTest"
(
    StudentID text COLLATE pg_catalog."default" NOT NULL,
    Subject text COLLATE pg_catalog."default" NOT NULL,
    TestingYear smallint NOT NULL,
	TestLanguage text COLLATE pg_catalog."default",
    TestStatus text COLLATE pg_catalog."default",
    Ball_100 numeric,
    Ball_12 numeric,
    Ball_Test numeric,
    AdaptScale numeric,
    TestDPA text COLLATE pg_catalog."default",
    School text COLLATE pg_catalog."default",
    CONSTRAINT "ZnoTest_pkey1" PRIMARY KEY (StudentID, Subject, TestingYear),
    CONSTRAINT "StudentZnoTestFk" FOREIGN KEY (StudentID)
        REFERENCES "Student" (outid) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT "DpaNameFk" FOREIGN KEY (TestDPA)
        REFERENCES "TestDPA" (name) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT "ZnoTestSchoolFk" FOREIGN KEY (School)
        REFERENCES "School" (name) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT "ZnoTestStatusFk" FOREIGN KEY (TestStatus)
        REFERENCES "TestStatus" (name) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT "ZnoTestSubjectFk" FOREIGN KEY (Subject)
        REFERENCES "TestSubject" (Subject) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT "ZnoTestTestingYearFk" FOREIGN KEY (TestingYear)
        REFERENCES "TestYear" (TestingYear) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
	CONSTRAINT "ZnoTestLangFk" FOREIGN KEY (TestLanguage)
        REFERENCES "TestLanguage" (LangName) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE "ZnoTest"
    OWNER to postgres;