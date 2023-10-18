# Data_Exploration
This project is basically Explorating the dataset on NashvilleHousing, 
The concentration centers on making few changes and manipulation to make 
data more presentable for usage using different sql functions 

Processes involved for DataExploration includes:
1. Conversion of SaleDate column from a Timestamp to Date format
2. Using the ISNULL function to fill empty addresses column and updating dataset
3. Creating different column for addresses and separating its values (OwnerAddress and PropertyAddress) into Address, City and State
4. Correcting and Updating the SoldAsVacant column from 'Y' and 'N' to 'Yes' and 'No'
5. Locating and Removing duplicates values with the help of CTE(common table expression, row_number() and partition by function
6. For the last changes made, unused columns were deleted/dropped
