/*
  Warnings:

  - Added the required column `updatedAt` to the `Bean` table without a default value. This is not possible if the table is not empty.
  - Added the required column `updatedAt` to the `GrinderModel` table without a default value. This is not possible if the table is not empty.
  - Added the required column `updatedAt` to the `Roaster` table without a default value. This is not possible if the table is not empty.
  - Added the required column `updatedAt` to the `Setting` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE "Bean" ADD COLUMN     "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
ADD COLUMN     "updatedAt" TIMESTAMP(3) NOT NULL;

-- AlterTable
ALTER TABLE "GrinderModel" ADD COLUMN     "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
ADD COLUMN     "updatedAt" TIMESTAMP(3) NOT NULL;

-- AlterTable
ALTER TABLE "Roaster" ADD COLUMN     "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
ADD COLUMN     "updatedAt" TIMESTAMP(3) NOT NULL;

-- AlterTable
ALTER TABLE "Setting" ADD COLUMN     "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
ADD COLUMN     "updatedAt" TIMESTAMP(3) NOT NULL;
