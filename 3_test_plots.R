library(plotly)
# test plots      
land_test <- TN_land %>%
  filter(county == "Davidson")
ggplot(land_test, aes(x=Year, y=Farmland)) +geom_col()




homes_test <- TN_home %>%
  filter(Metric == "Homes_Sold", County == "Davidson")
ggplot(homes_test, aes(x=Year, y=as.numeric(value), group=1)) 
+geom_point() 
+geom_line()
+scale_x_discrete()
+scale_y_discrete()
+labs(x="Year", y="Homes Sold")

tn_test2 <- filter(TN_land_type, county == "Davidson")

ggplot(tn_test2,aes(Year, Acres), yaxt ="n")+
  geom_col(aes(fill=`Land Type`), position = position_stack())+
  geom_text(label=paste(tn_test2$Acres,"ac"), size=2, position = "stack",vjust=2)+
  theme(axis.text.y = element_blank(), axis.ticks.y = element_blank(), panel.grid.major = element_blank(), panel.grid.minor = element_blank())
  

tn_test2 <- filter(TN_land_type, county == "Anderson")

ggplot(tn_test2,aes(x=Year, y=Acre, fill=`Land Type`))+ 
  geom_bar(stat = "identity") +
  geom_text(aes(label= Acre), size=2,  position = position_stack(vjust=0.9))
  
tn_test_f <- filter(tn_test2, `Land Type` == "Farmland")
tn_test_c <- filter(tn_test2, `Land Type` == "Cropland")
tn_test_w <- filter(tn_test2, `Land Type` == "Woodland")
tn_test_p <- filter(tn_test2, `Land Type` == "Pasture")
tn_test_fa <- as.array(tn_test_f$Acre)
tn_test_wa <- as.array(tn_test_w$Acre)
tn_test_ca <- as.array(tn_test_c$Acre)
tn_test_pa <- as.array(tn_test_p$Acre)
tn_test_x <- as.array(tn_test_f$Year)
tn_test_df <- data.frame(tn_test_x, tn_test_fa ,tn_test_pa, tn_test_ca, tn_test_wa)

plotly::plot_ly(tn_test_df, x = ~tn_test_x, y = ~tn_test_fa, name ='Farmland', type = 'bar') %>%
  add_trace(y = ~tn_test_ca, name = 'Cropland') %>%
  add_trace(y = ~tn_test_wa , name = 'Woodland') %>%
  add_trace(y = ~tn_test_pa, name = 'Pasture') %>%
  layout(yaxis = list(title = 'Acre'), barmode = 'stack')

