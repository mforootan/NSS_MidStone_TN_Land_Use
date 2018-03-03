#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#
setwd("/Users/ghfmhf/git/NSS_project/TN_Land_Use/")

library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  navbarPage("Land Use Change in Tennessee- Massih Forootan",
      
              tabPanel("Overview"
                      
# -------------------------- My introductory script will land here
                      
                      ),
             
             
             tabPanel("Source Data"
                      
# -------------------------- Information about the data will be copied here
                      
                      ),
             
             
             
             tabPanel("Interactive App",

                       
  # Application title
                      titlePanel("Select two counties and land details (See Source Data tab for definitions)"),
  
  # Checkboxes to define what data to be displayed
                          
                      fluidRow(column(3, 
  
                          checkboxInput("chkFARM", label = "Farmland", value = TRUE),
                          hr()
                        ), column(3,
                          checkboxInput("chkCROP", label = "Cropland", value = TRUE),
                          hr()
                        ), column(3,
                          checkboxInput("chkWOOD", label = "Woodland", value = TRUE),
                          hr()
                        ), column(3,
                          checkboxInput("chkPAST", label = "Pasture", value = TRUE),
                          hr()

                        )),
                      
                      
  # Two columns, each for one county set of graphs
                      fluidRow(column(6,
                                      # A dropdown list containing county names
                                      selectInput("select", label = h3("Select box"),
                                                  choices = list("Choice 1" = 1, "Choice 2" = 2, "Choice 3" = 3),
                                                  selected = 1)
                                      ),
                               column(6,
                                      # A dropdown list containing county names
                                      selectInput("select", label = h3("Select box"),
                                                  choices = list("Choice 1" = 1, "Choice 2" = 2, "Choice 3" = 3),
                                                  selected = 1)
                               )
                              )
                        )
) # NavBar End
) # FluidPage End
) # ShinyUI End