/*
  Warnings:

  - You are about to drop the column `roasterId` on the `Bean` table. All the data in the column will be lost.
  - The primary key for the `GrinderMake` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to drop the column `id` on the `GrinderMake` table. All the data in the column will be lost.
  - You are about to drop the column `makeId` on the `GrinderModel` table. All the data in the column will be lost.
  - The primary key for the `Roaster` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to drop the column `id` on the `Roaster` table. All the data in the column will be lost.
  - A unique constraint covering the columns `[roasterName,name]` on the table `Bean` will be added. If there are existing duplicate values, this will fail.
  - A unique constraint covering the columns `[makeName,name]` on the table `GrinderModel` will be added. If there are existing duplicate values, this will fail.
  - Added the required column `roasterName` to the `Bean` table without a default value. This is not possible if the table is not empty.
  - Added the required column `makeName` to the `GrinderModel` table without a default value. This is not possible if the table is not empty.

*/
-- DropForeignKey
ALTER TABLE "Bean" DROP CONSTRAINT "Bean_roasterId_fkey";

-- DropForeignKey
ALTER TABLE "GrinderModel" DROP CONSTRAINT "GrinderModel_makeId_fkey";

-- AlterTable
ALTER TABLE "Bean" DROP COLUMN "roasterId",
ADD COLUMN     "roasterName" VARCHAR(255) NOT NULL;

-- AlterTable
ALTER TABLE "GrinderMake" DROP CONSTRAINT "GrinderMake_pkey",
DROP COLUMN "id",
ADD PRIMARY KEY ("name");

-- AlterTable
ALTER TABLE "GrinderModel" DROP COLUMN "makeId",
ADD COLUMN     "makeName" VARCHAR(255) NOT NULL;

-- AlterTable
ALTER TABLE "Roaster" DROP CONSTRAINT "Roaster_pkey",
DROP COLUMN "id",
ADD PRIMARY KEY ("name");

-- CreateIndex
CREATE UNIQUE INDEX "Bean.roasterName_name_unique" ON "Bean"("roasterName", "name");

-- CreateIndex
CREATE UNIQUE INDEX "GrinderModel.makeName_name_unique" ON "GrinderModel"("makeName", "name");

-- AddForeignKey
ALTER TABLE "GrinderModel" ADD FOREIGN KEY ("makeName") REFERENCES "GrinderMake"("name") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Bean" ADD FOREIGN KEY ("roasterName") REFERENCES "Roaster"("name") ON DELETE CASCADE ON UPDATE CASCADE;
