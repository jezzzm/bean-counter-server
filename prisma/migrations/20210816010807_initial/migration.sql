-- CreateTable
CREATE TABLE "GrinderMake" (
    "id" SERIAL NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "name" VARCHAR(255) NOT NULL,
    "country" VARCHAR(255),
    "description" TEXT,
    "url" TEXT,

    PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "GrinderModel" (
    "id" SERIAL NOT NULL,
    "name" VARCHAR(255) NOT NULL,
    "url" TEXT,
    "makeId" INTEGER NOT NULL,

    PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Roaster" (
    "id" SERIAL NOT NULL,
    "name" VARCHAR(255) NOT NULL,
    "location" TEXT,
    "description" TEXT,

    PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Bean" (
    "id" SERIAL NOT NULL,
    "roasterId" INTEGER NOT NULL,
    "name" VARCHAR(255) NOT NULL,
    "description" TEXT,

    PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Setting" (
    "id" SERIAL NOT NULL,
    "grinderId" INTEGER NOT NULL,
    "beanId" INTEGER NOT NULL,
    "basket" VARCHAR(255) NOT NULL,
    "dose" DOUBLE PRECISION NOT NULL,
    "grindSize" VARCHAR(255) NOT NULL,
    "comment" TEXT,

    PRIMARY KEY ("id")
);

-- AddForeignKey
ALTER TABLE "GrinderModel" ADD FOREIGN KEY ("makeId") REFERENCES "GrinderMake"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Bean" ADD FOREIGN KEY ("roasterId") REFERENCES "Roaster"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Setting" ADD FOREIGN KEY ("grinderId") REFERENCES "GrinderModel"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Setting" ADD FOREIGN KEY ("beanId") REFERENCES "Bean"("id") ON DELETE CASCADE ON UPDATE CASCADE;
