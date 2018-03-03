library("gdata")
library("ggplot2")
library("plotly")

options(stringsAsFactors = FALSE)
load("TN_LU_1.Rda")

# Extracting Farm Data

TN_farm_12 <- data.frame(land_0712_12$county, land_0712_12$Farm_Land_07, land_0712_12$Farm_Land_12)
colnames(TN_farm_12) <- (c('county','2007','2012'))

TN_farm_13 <- data.frame(land_02_13$county, land_02_13$Farm_Land_02)
colnames(TN_farm_13) <- (c('county','2002'))

TN_farm_all <- merge(TN_farm_13, TN_farm_12, by='county')

TN_farm <- reshape::melt(TN_farm_all, id = "county")
colnames(TN_farm) <- c('County','Year','Farmland')

# Extracting Cropland Data

TN_crop_12 <- data.frame(crop_0712_12$county, crop_0712_12$Crop_Cover_07, crop_0712_12$Crop_Cover_12)
colnames(TN_crop_12) <- (c('county','2007','2012'))

TN_crop_13 <- data.frame(crop_02_13$county, crop_02_13$Crop_Cover_02)
colnames(TN_crop_13) <- (c('county','2002'))

TN_crop_all <- merge(TN_crop_13, TN_crop_12, by='county')

TN_crop <- reshape::melt(TN_crop_all, id = "county")
colnames(TN_crop) <- c('County','Year','Cropland')


# Extracting Woodland Data

TN_wood_12 <- data.frame(crop_0712_12$county, crop_0712_12$Woodland_07, crop_0712_12$Woodland_12)
colnames(TN_wood_12) <- (c('county','2007','2012'))

TN_wood_13 <- data.frame(crop_02_13$county, crop_02_13$Woodland_02)
colnames(TN_wood_13) <- (c('county','2002'))

TN_wood_all <- merge(TN_wood_13, TN_wood_12, by='county')

TN_wood <- reshape::melt(TN_wood_all, id = "county")
colnames(TN_wood) <- c('County','Year','Woodland')


# Extracting Pasture Data

TN_pasture_12 <- data.frame(crop_0712_12$county, crop_0712_12$Pasture_07, crop_0712_12$Pasture_12)
colnames(TN_pasture_12) <- (c('county','2007','2012'))

TN_pasture_13 <- data.frame(crop_02_13$county, crop_02_13$Pasture_02)
colnames(TN_pasture_13) <- (c('county','2002'))

TN_pasture_all <- merge(TN_pasture_13, TN_pasture_12, by='county')

TN_pasture <- reshape::melt(TN_pasture_all, id = "county")
colnames(TN_pasture) <- c('County','Year','Pasture')


# Melting Home sale file

TN_home <- reshape::melt(homes_18, id= "County")
TN_home$variable <- as.character(TN_home$variable)
for (i in 1:nrow(TN_home)) {
  TN_home[i,4] <- substr(TN_home[i,2], 1, nchar(TN_home[i,2])-5)
  TN_home[i,5] <- substr(TN_home[i,2], nchar(TN_home[i,2])-3, nchar(TN_home[i,2]))
  
}

colnames(TN_home) <- c('County','variable','value','Metric', 'Year')
TN_home <- select(TN_home,'County','value','Metric', 'Year')

save(TN_home, TN_pasture, TN_wood, TN_crop, TN_farm, file = "TN_LU_2.Rda")

# Graphs for Visual test

ggplot(TN_farm, aes(y=Farmland, x=Year)) +geom_bar(stat = "identity")+facet_wrap(~County)
ggplot(TN_crop, aes(y=Cropland, x=Year)) +geom_bar(stat = "identity")+facet_wrap(~County)
ggplot(TN_pasture, aes(y=Pasture, x=Year)) +geom_bar(stat = "identity")+facet_wrap(~County)
ggplot(TN_wood, aes(y=Woodland, x=Year)) +geom_bar(stat = "identity")+facet_wrap(~County)

homes_s <- TN_home %>% 
  filter(Metric == "Homes_Sold")

homes_p <- TN_home %>% 
  filter(Metric == "Median_Price")

ggplot(homes_s, aes(x=Year, y=value, group=1)) +geom_point() + geom_line() +facet_wrap(~County)

