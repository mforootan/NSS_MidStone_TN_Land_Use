
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
  
  