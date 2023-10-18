# Data_Exploration
This project is basically Explorating the dataset on NashvilleHousing, 
The concentration centers on making few changes and manipulation to make 
data more presentable for usage using different sql functions 

Processes involved for DataExploration includes:
1. Conversion of SaleDate column from a Timestamp to Date format
2. Using the ISNULL function to fill empty addresses column and updating dataset :
Observation made from the dataset is that parcelID and propertyaddress has similar values linked
to each other and so therefore, this two column will be used to fill each other incase of a null value
3. Creating different column for addresses and separating its values (OwnerAddress and PropertyAddress) into Address, City and State
4. Correcting and Updating the SoldAsVacant column from 'Y' and 'N' to 'Yes' and 'No'
5. Locating and Removing duplicates values with the help of CTE(common table expression, row_number() and partition by function
6. In conclusion of this data Exploration, unused coumn were deleted/dropped and column dropped includes : The timestamp column, taxdistrict inclusive and likewise addresses column(property and owneraddress) which has been splitted into individual columns
