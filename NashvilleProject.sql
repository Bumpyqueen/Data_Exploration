/* DATA EXPLORATION PROJECT ON NASHVILLE HOUSING DATA 
 CLEANING THE NASHVILLEHOUSING DATA IN SQL
*/
-- CONVERTING SALEDATE COLUMN FROM A TIMESTAMP TO DATE FORMAT
SELECT *
FROM NashvilleHousing

SELECT SaleDate, CAST(SaleDate AS DATE) AS NewSaleDate
FROM NashvilleHousing

ALTER TABLE NashvilleHousing
ADD NewSaleDate DATE

UPDATE NashvilleHousing
SET NewSaleDate = CAST(SaleDate AS DATE) 

------------------------------------------------------------------------------------------------
/* Observation made from the dataset below is that parcelID and propertyaddress has a repetition of values and it is linked
to each other and so therefore, this two column will be used to fill each other incase of a null value
*/
-- USING THE ISNULL FUNCTION TO FILL EMPTY ADRESSES COLUMN AND UPDATNG DATASET

-- PROPERTYADDRESS
SELECT nash.ParcelID, nash.PropertyAddress, vil.ParcelID, vil.PropertyAddress
FROM NashvilleHousing nash
JOIN NashvilleHousing vil
ON nash.ParcelID = vil.ParcelID
--AND nash.UniqueID != vil.UniqueID
WHERE nash.PropertyAddress IS NULL AND vil.PropertyAddress IS NOT NULL

UPDATE nash
SET PropertyAddress = ISNULL(nash.PropertyAddress, vil.propertyaddress)
FROM NashvilleHousing nash
JOIN NashvilleHousing vil
ON nash.ParcelID = vil.ParcelID
WHERE nash.PropertyAddress IS NULL AND vil.PropertyAddress IS NOT NULL

----------------------------------------------------------------------------------------
/*
 CREATING DIFFERENT COLUMN FOR ADDRESSES AND SEPARATING ITS VALUES (OwnerAddress and PropertyAddress)
 INTO ADDRESS, CITY, AND STATE 
 */

SELECT *
FROM NashvilleHousing

--PROPERTYADDRESS
SELECT PropertyAddress,
       parsename(replace(PropertyAddress, ',', '.'), 2) AS NewPropertyAddress,
	   parsename(replace(PropertyAddress, ',', '.'), 1) AS NewPropertyCity
FROM NashvilleHousing

ALTER TABLE NashvilleHousing
ADD NewPropertyAddress VARCHAR (50)

UPDATE NashvilleHousing
SET NewPropertyAddress = parsename(replace(PropertyAddress, ',', '.'), 2)

ALTER TABLE NashvilleHousing
ADD NewPropertyCity VARCHAR (50)

UPDATE NashvilleHousing
SET NewPropertyCity =  parsename(replace(PropertyAddress, ',', '.'), 1)

-- OWNERADDRESS
SELECT OwnerAddress,
       parsename(replace(OwnerAddress, ',', '.'), 3) AS NewOwnerAddress,
	   parsename(replace(OwnerAddress, ',', '.'), 2) AS NewOwnerCity,
	   parsename(replace(OwnerAddress, ',', '.'), 1) AS NewOwnerState
FROM NashvilleHousing

--CREATING TABLES
ALTER TABLE NashVilleHousing
ADD NewOwnerAddress VARCHAR (50)

ALTER TABLE NashVilleHousing
ADD NewOwnerCity VARCHAR (50)

ALTER TABLE NashVilleHousing
ADD NewOwnerState VARCHAR (50)

--UPDATING TABLE
UPDATE NashvilleHousing
SET NewOwnerAddress = parsename(replace(OwnerAddress, ',', '.'), 3)

UPDATE NashvilleHousing
SET NewOwnerCity = parsename(replace(OwnerAddress, ',', '.'), 2)

UPDATE NashvilleHousing
SET NewOwnerState = parsename(replace(OwnerAddress, ',', '.'), 1)

-----------------------------------------------------------------------------
--CORRECTING AND UPDATING THE SoldAsVacant COLUMN FROM 'Y' AND 'N' TO 'YES' AND 'NO'

SELECT SoldAsVacant, COUNT(SoldAsVacant) AS NewSoldAsVacant
FROM NashvilleHousing
GROUP BY SoldAsVacant
ORDER BY NewSoldAsVacant DESC

SELECT SoldAsVacant,
  CASE
    WHEN SoldAsVacant = 'Y' THEN 'Yes'
	WHEN SoldAsVacant = 'N' THEN 'No'
	ELSE SoldAsVacant
	END AS NewSoldAsVacant
FROM NashvilleHousing

UPDATE NashvilleHousing
SET SoldAsVacant = CASE
    WHEN SoldAsVacant = 'Y' THEN 'Yes'
	WHEN SoldAsVacant = 'N' THEN 'No'
	ELSE SoldAsVacant
	END 
-----------------------------------------------------------------------------------------
	-- REMOVING DUPLICATES DATA USING CTE, ROW NUMBER AND PARTITION BY FUNCTION

WITH DuplicateValues AS
(SELECT *,
       ROW_NUMBER() OVER 
	         (PARTITION BY ParcelId,
			               LandUse,
						   PropertyAddress,
						   SalePrice,
						   LegalReference,
						   OwnerName,
						   NewSaleDate,
						   OwnerAddress
						   ORDER BY ParcelID) AS RowNumber        
FROM NashvilleHousing) 
--SELECT * FROM DuplicateValues WHERE RowNumber > 1
DELETE FROM DuplicateValues
WHERE RowNumber >1

--------------------------------------------------------------------------------------
/*IN CONCLUSION OF THIS DATA EXPLORATION, UNUSED COLUMNS WILL BE DELETED 
AFTER THE TIMESTAMP WAS CONVERTED INTO DATE COLUMN, THE TIMESTAMP COLUMN WILL BE DROPPED, TAXDISTRICT INCLUSIVE AND LIKEWISE 
ADDRESSES(PROPERTYADDRESS AND OWNERADDRESS) WHICH HAS BEEN SPLITTED INTO INDVIDUAL COLUMNS 
*/
ALTER TABLE NashvilleHousing
DROP COLUMN SaleDate

ALTER TABLE NashvilleHousing
DROP COLUMN PropertyAddress, OwnerAddress, TaxDistrict
	
SELECT *
FROM NashvilleHousing

