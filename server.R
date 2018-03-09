#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
   
  # Generates the line plot for residential data reading from ui.R
  output$lineHOME <- renderPlot({
    
    homes_county <- TN_home %>%
      filter(Metric == "Homes_Sold", County == input$selCOUNTY)
    ggplot(homes_county, aes(x=as.numeric(Year), y=as.numeric(value), group=1)) +
      geom_point() +
      geom_line() +
      scale_x_continuous("Year") +
      scale_y_continuous("Home Sold")

    
  })
  
  # Generates the column bars for land data reading from ui.R
  
  output$barLAND <- renderPlot({
    
    lands_type <- filter(TN_land_type, county == input$selCOUNTY)
    
    ggplot(lands_type,aes(lands_type$Year, lands_type$Acre, fill=`Land Type`)) +
      geom_bar(stat = "identity") +
      geom_text(aes(label= Acre), size=2,  position = position_stack(vjust=0.9)) +
      scale_x_discrete("Year") +
      scale_y_discrete("Acre")
    
    
  })
  
  output$selected_var <- renderText({ 
    paste("You have selected this",
    input$chkLAND,
    input$selCOUNTY)
    
  })
})
