/*
  Warnings:

  - The `unitOfMeasure` column on the `Asset` table would be dropped and recreated. This will lead to data loss if there is data in the column.

*/
-- CreateEnum
CREATE TYPE "UnitOfMeasure" AS ENUM ('PCS', 'MG', 'G', 'KG', 'MM', 'M', 'ML', 'L');

-- AlterTable
ALTER TABLE "Asset" DROP COLUMN "unitOfMeasure",
ADD COLUMN     "unitOfMeasure" "UnitOfMeasure";
