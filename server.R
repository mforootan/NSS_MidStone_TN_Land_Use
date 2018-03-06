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
   
  output$distPlot <- renderPlot({
    
    # generate bins based on input$bins from ui.R
    homes_county <- TN_home %>%
      filter(Metric == "Homes_Sold", County == input$selCOUNTY)
    ggplot2::ggplot(homes_test, aes(x=Year, y=value, group=1)) +geom_point() + geom_line()
    
    
  })
 
  
  output$selected_var <- renderText({ 
    paste("You have selected this",
    input$chkLAND,
    input$selCOUNTY)
  })
})
