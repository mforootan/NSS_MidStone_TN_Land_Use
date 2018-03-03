# The required databases come in this block
setwd("/Users/ghfmhf/git/NSS_project/TN_Land_Use/data")
options(stringsAsFactors = F)

library("tidyverse")
library("plyr")
library("dplyr")
library("magrittr")
library("gdata")
library("ggplot2")
library("plotly")
library("maps")
library("reshape2")
library("tidyr")
library("pdftables", lib.loc="/Library/Frameworks/R.framework/Versions/3.4/Resources/library")

# Read data for farm land acreage in counties in 2002 & 2007
land_0712_08 <- read.csv('08.csv')

'
Data Cleaning
1. Renaming columns
2. values change to lowercase
3. space to underscore
4. Removing invalid data
'

land_0712_08 <- select(land_0712_08, "Year", "Ag.District", "County", "Value") %>% 
  rename(Ag_District = Ag.District, Acre = Value) 

land_0712_08$Ag_District <- tolower(land_0712_08$Ag_District)
land_0712_08$Ag_District <- gsub(" ","_",land_0712_08$Ag_District)

land_0712_08$County <- tolower(land_0712_08$County)
land_0712_08$County <- gsub(" ","",land_0712_08$County)

land_0712_08$Acre <- gsub("\\(.*\\)|,","",land_0712_08$Acre)

land_0712_08 <- spread(land_0712_08, Year, Acre)

# Reading farm land for years 2007 and 2012
# Two separate blocks for farms and croplands
# tabula-12.csv is read from a .PDF file using Tabula
land_0712_12_raw <- read.csv('tabula-12.csv', header = F)


'Phase 1: The target dataframe for farm'

land_0712_12 <- data.frame(matrix(ncol = 5, nrow = 0))
colnames(land_0712_12) <- c("county","Farm_Land_12","Farm_Land_07","Avg_Land_12","Avg_Land_07")

'
Two IF blocks:
1. Find each line that starts with "Item" (This is the "corner" of the table split in the PDF)
The rest of the columns contain county names under that column, find the cells that start with 
"Land" and "Average". For each county, read the whole row to the end (for 2012 and 2007)
2. A condition added for not having "Other" in following row to skip "Cropland" database

'
for(i in 1:nrow(land_0712_12_raw)) {

  if ("Item" %in% land_0712_12_raw[i , 1]) {

    if (substr(land_0712_12_raw[i + 5, 1], 1, 5) != "Other") {

    for(j in 2:ncol(land_0712_12_raw)) {
      print(paste (i,j,substr(land_0712_12_raw[i + 5,1],1,5))) # Test. remove after data read was OK.

      land_vec <- c(land_0712_12_raw[i,j], land_0712_12_raw[i+5,j], land_0712_12_raw[i+6,j], land_0712_12_raw[i+7,j], land_0712_12_raw[i+8,j])
      
        land_0712_12 <- rbind(land_0712_12, land_vec)
        }
      }
    }
  }


'
This block identifies all blank rows (keeping the row #s is an array)
Then rewrites the overwritten column headers (no idea why this is happening)
'

bad_rows=c()
for(i in 1:nrow(land_0712_12)) {

  if (land_0712_12[i,1] == "" | land_0712_12[i,1] == "Tennessee" ) {

    bad_rows <- c(bad_rows, i)

      }
      
    }

land_0712_12 <- data.frame(land_0712_12[-bad_rows,])
colnames(land_0712_12) <- c("county","Farm_Land_12","Farm_Land_07","Avg_Land_12","Avg_Land_07")

'Phase 2: The target dataframe for cropland/woodland/pasture'

crop_0712_12 <- data.frame(matrix(ncol = 7, nrow = 0))
colnames(crop_0712_12) <- c("county","Crop_Cover_12","Crop_Cover_07","Woodland_12","Woodland_07","Pasture_12","Pasture_07")

'
Same two IF blocks as above, but the conditions are changed 
so this time Cropland are selected instead of skipped; plus
the rows data read from has changed. (NOTE: the raw database 
is still land_0712_12_raw)
'
for(i in 1:nrow(land_0712_12_raw)) {
  
  if ("Item" %in% land_0712_12_raw[i , 1]) {
    
    if (substr(land_0712_12_raw[i + 5, 1], 1, 5) == "Other") {
      
      for(j in 2:ncol(land_0712_12_raw)) {
        print(paste (i,j,substr(land_0712_12_raw[i + 5,1],1,5))) # Test. remove after data read was OK.
        
        crop_vec <- c(land_0712_12_raw[i,j], land_0712_12_raw[i+7,j], land_0712_12_raw[i+8,j], land_0712_12_raw[i+28,j], land_0712_12_raw[i+29,j], land_0712_12_raw[i+53,j], land_0712_12_raw[i+54,j])
        
        crop_0712_12 <- rbind(crop_0712_12, crop_vec)
      }
    }
  }
}

'Likewise, empty rows are skipped, and the column headers are rewritten'

bad_rows=c()
for(i in 1:nrow(crop_0712_12)) {
  
  if (crop_0712_12[i,1] == "" | crop_0712_12[i,1] == "Tennessee" ) {
    
    bad_rows <- c(bad_rows, i)
    
  }
  
}

crop_0712_12 <- data.frame(crop_0712_12[-bad_rows,])

colnames(crop_0712_12) <- c("county","Crop_Cover_12","Crop_Cover_07","Woodland_12","Woodland_07","Pasture_12","Pasture_07")




# Reading farm land for year 2002 from spreadsheet tabula-13

land_02_13_raw <- read.csv('tabula-13.csv', header = F)

'The target dataframe'

land_02_13 <- data.frame(matrix(ncol = 3, nrow = 0))
colnames(land_02_13) <- c("county","Farm_Land_02","Avg_Land_02")

'
Same as for 2007/2012 dataframe, same conditions applied for reading 2002
(Only one set is extracted in this instance)
'
for(i in 1:nrow(land_02_13_raw)) {
  
  if ("Item" %in% land_02_13_raw[i , 1]) {
    
    if (substr(land_02_13_raw[i + 5, 1], 1, 5) != "Other") {
      
      for(j in 2:ncol(land_02_13_raw)) {
        print(paste (i,j,substr(land_02_13_raw[i + 5,1],1,5))) # Test. remove after data read was OK.
        
        land_vec <- c(land_02_13_raw[i,j], land_02_13_raw[i+6,j], land_02_13_raw[i+8,j])
        
        land_02_13 <- rbind(land_02_13, land_vec)
      }
    }
  }
}

'Likewise, eliminate empty rows'

bad_rows=c()
for(i in 1:nrow(land_02_13)) {
  
  if (land_02_13[i,1] == "" | land_02_13[i,1] == "Tennessee" ) {
    
    bad_rows <- c(bad_rows, i)
    
  }
  
}

land_02_13 <- data.frame(land_02_13[-bad_rows,])
colnames(land_02_13) <- c("county","Farm_Land_02","Avg_Land_02")

'Read cropland/woodland/pasture data'
crop_02_13 <- data.frame(matrix(ncol = 4, nrow = 0))
colnames(crop_02_13) <- c("county","Crop_Cover_02","Woodland_02","Pasture_02")


for(i in 1:nrow(land_02_13_raw)) {
  
  if ("Item" %in% land_02_13_raw[i , 1]) {
    
    if (substr(land_02_13_raw[i + 5, 1], 1, 5) == "Other") {
      
      for(j in 2:ncol(land_02_13_raw)) {
        print(paste (i,j,substr(land_02_13_raw[i + 5,1],1,5))) # Test. remove after data read was OK.
        
        crop_vec <- c(land_02_13_raw[i,j], land_02_13_raw[i+8,j], land_02_13_raw[i+29,j], land_02_13_raw[i+54,j])
        
        crop_02_13 <- rbind(crop_02_13, crop_vec)
      }
    }
  }
}

'Remove empty rows and TN, then fixing the header'
bad_rows=c()
for(i in 1:nrow(crop_02_13)) {
  
  if (crop_02_13[i,1] == "" | crop_02_13[i,1] == "Tennessee" ) {
    
    bad_rows <- c(bad_rows, i)
    
  }
  
}

crop_02_13 <- data.frame(crop_02_13[-bad_rows,])

colnames(crop_02_13) <- c("county","Crop_Cover_02","Woodland_02","Pasture_02")


# Read data for new homes sold in counties (source https://thda.org/research-planning/home-sales-price-by-county)
homes_18 <- readxl::read_excel('18.xlsx')

'eliminate all blank rows'

bad_rows = c()
for (i in 1:nrow(homes_18)) {
  
  if (is.na(homes_18[i , 2]) == T ) {
    
    bad_rows <- c(bad_rows, i)
    
  }
  
}

homes_18 <- data.frame(homes_18[-bad_rows,])
homes_18 <- data.frame(homes_18[-c(2,3),])

'
This FOR block will rename the dataframe column to a meaningful string:
the last two digits of the year is appended to column title "Home Sold" or 
"Median Price"
'

count_array <- c()
price_array <- c()

for (i in 2:11) {
  
 count_array <- c(count_array, paste("Homes_Sold", 
                                     substr(homes_18[1, i] ,
                                            nchar(homes_18[1, i])-3 ,
                                             nchar(homes_18[1, i]))))

 price_array <- c(price_array, paste("Median_Price",
                                     substr(homes_18[1, i] ,
                                            nchar(homes_18[1, i])-3 ,
                                            nchar(homes_18[1, i]))))
 
 
   print (i) # Test line
}

ren_array <- c("County",count_array," ",price_array)
ren_array <-  gsub(" ","_",ren_array)

colnames(homes_18) <- ren_array
homes_18 <- data.frame(homes_18[-c(1),])
homes_18 <- data.frame(homes_18[,-c(12)])

# Create a table of ZIP codes

TN_zip <- readxl::read_excel('zip_code_database.xlsx') %>% 
  filter(state == "TN") %>% 
  select(zip, county, latitude, longitude)

TN_zip$county <- gsub(" County", "", TN_zip$county)
TN_zip$county <- tolower(TN_zip$county)

'Keep one zip code & lat/long per county'

TN_data <- merge(TN_zip, land_0712_08, by.x = 'county', by.y = 'County', all.y = F, all.x = F) 
TN_pin <- TN_data[!duplicated(TN_data$county),] %>% 
  select(-c(zip,`2007`,`2012`))
'For consistency, change the county names to Name Case'
TN_pin$county <- paste (toupper(substr(TN_pin$county, 1, 1)), substr(TN_pin$county, 2, nchar(TN_pin$county)))
TN_pin$county <- gsub(" ", "", TN_pin$county)



# reading in county plot points for map
county_df = map_data("county")
county_df <- county_df[(county_df["region"] == "tennessee"),]

# changing column name for join
colnames(county_df)[colnames(county_df)=="subregion"] <- "county"

# plotting
ggplot(county_df, aes(long, lat, group = group)) +
  geom_polygon(color = "yellow") +
  coord_fixed(ratio = 1/1)


save(land_02_13, land_0712_08, land_0712_12, crop_02_13, crop_0712_12, homes_18, TN_pin, county_df, file = "TN_LU_1.Rda")