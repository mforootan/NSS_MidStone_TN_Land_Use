#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(ggthemes)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
   
  # Generates the line plot for residential data reading from ui.R
  output$lineHOME <- renderPlot({
    
    homes_county <- TN_home %>%
      filter(Metric == "Homes_Sold", County == input$selCOUNTY)
    
    homes_bar <- TN_home %>%
      filter(Metric == "Homes_Sold", County == input$selCOUNTY, Year ==c("2007","2012"))
    
    ggplot(homes_county, aes(x=as.numeric(Year), y=as.numeric(value), group=1)) +
      # geom_segment(homes_bar, mapping = aes(x=as.numeric(Year), y=as.numeric(value), xend=as.numeric(Year), yend=0), size = 5, color="red")+
      geom_vline(xintercept = c(2007,2012), color = "yellow") +
      geom_vline(xintercept = 2008, color = "pink", size = 6) +
      
      geom_point() +
      geom_line() +
    theme(axis.text.x = element_text(colour="grey20",size=20,hjust=.5,vjust=.5,face="plain"),
            axis.text.y = element_text(colour="grey20",size=20,hjust=1,vjust=0,face="plain"),
            axis.title.x = element_text(colour="grey20",size=20,hjust=.5,vjust=0,face="plain"),
            axis.title.y = element_text(colour="grey20",size=20,hjust=.5,vjust=.5,face="plain"))+
            xlab("")+
      theme_dark(base_size = 12, base_family = "")+
      scale_x_continuous(breaks = c(2007:2016)) +
      scale_y_continuous("Home Sold")

    
  })
  
  # Generates the column bars for land data reading from ui.R
  
  output$barLAND <- renderPlot({
    
    lands_type <- filter(TN_land_type, county == input$selCOUNTY)
    
    ggplot(lands_type,aes(lands_type$Year, lands_type$Acre, fill=`Land Type`)) +
      geom_bar(stat = "identity") +
      geom_text(aes(label= Acre), size=4,  position = position_stack(vjust=0.9)) +
      theme(axis.text.x = element_text(colour="grey20",size=20,hjust=.5,vjust=.5,face="plain"),
            axis.text.y = element_text(colour="grey20",size=20,hjust=1,vjust=0,face="plain"),  
            axis.title.x = element_text(colour="grey20",size=20,hjust=.5,vjust=0,face="plain"),
            axis.title.y = element_text(colour="grey20",size=20,hjust=.5,vjust=.5,face="plain"),
            legend.text=element_text(size=15),
            legend.title = element_text(size = 15))+
      xlab("")+
      
      scale_y_discrete("Acre")
    
    
  })
 
  })
  

