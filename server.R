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
library(plotly)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
   
  # Generates the line plot for residential data reading from ui.R
  output$lineHOME <- renderPlot({
    
    homes_county <- TN_home %>%
      filter(Metric == "Homes_Sold", County == input$selCOUNTY)
    
    homes_bar <- TN_home %>%
      filter(Metric == "Homes_Sold", County == input$selCOUNTY, Year ==c("2007","2012"))
    
    ggplot(homes_county, aes(x=as.numeric(Year), y=as.numeric(value), group=1)) +
      geom_vline(xintercept = 2012, color = "dodgerblue3") +
      geom_vline(xintercept = 2008, color = "indianred1", size = 6) +
      
      geom_line(color="darkgreen", shape = 1) +
      geom_area(fill=alpha('darkgreen',0.2)) +
    
      theme_few(base_size = 12, base_family = "")+
      theme(axis.text.x = element_text(colour="black",size=16,hjust=.5,vjust=.5,face="plain"),
            axis.text.y = element_text(colour="black",size=16,hjust=1,vjust=0,face="plain"),
            axis.title.x = element_text(colour="black",size=14,hjust=.5,vjust=0,face="plain"),
            axis.title.y = element_text(colour="black",size=14,hjust=.5,vjust=.5,face="plain")
            
            )+
      
      xlab("Fig 1. Number of new homes sold over time in county (Tennessee Home Development Agency).")+
      scale_x_continuous(breaks = c(2007:2016)) +
      scale_y_continuous("# of New Homes Sold")

    
  })
  
  # Redoing the column bars using plotly
  
  output$barLANDS <- renderPlotly({
    
    lands_all <- filter(TN_land_type, county == input$selCOUNTY)
    
    tn_test_f <- filter(lands_all, `Land Type` == "Farmland")
    tn_test_fa <- as.array(tn_test_f$Acre)
    tn_test_c <- filter(lands_all, `Land Type` == "Cropland")
    tn_test_ca <- as.array(tn_test_c$Acre)
    tn_test_w <- filter(lands_all, `Land Type` == "Woodland")
    tn_test_wa <- as.array(tn_test_w$Acre)
    tn_test_p <- filter(lands_all, `Land Type` == "Pasture")
    tn_test_pa <- as.array(tn_test_p$Acre)
    
    tn_test_x <- as.array(tn_test_f$Year)
    tn_test_df <- data.frame(tn_test_x, tn_test_fa ,tn_test_pa, tn_test_ca, tn_test_wa)
    
    plotly::plot_ly(tn_test_df, x = ~tn_test_x, y = ~tn_test_fa, name ='Farmland', type = 'bar') %>%
      add_trace(y = ~tn_test_ca, name = 'Cropland') %>%
      add_trace(y = ~tn_test_wa , name = 'Woodland') %>%
      add_trace(y = ~tn_test_pa, name = 'Pasture') %>%
      layout(yaxis = list(title = 'Area (acre)'), barmode = 'stack', xaxis = list(title = 'Fig 2. Area of different land types over time (USDA).'))
    
  })
    
  })
  

