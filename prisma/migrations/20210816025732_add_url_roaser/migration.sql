/*
  Warnings:

  - You are about to drop the column `location` on the `Roaster` table. All the data in the column will be lost.

*/
-- AlterTable
ALTER TABLE "Roaster" DROP COLUMN "location",
ADD COLUMN     "country" TEXT,
ADD COLUMN     "url" TEXT;
