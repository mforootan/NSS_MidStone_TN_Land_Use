#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(shinythemes)


# Define UI for application that draws a histogram
shinyUI(
  fluidPage(theme = shinytheme("cerulean"),
  
    navbarPage("Land Use Change in Tennessee- Massih Forootan",
               
               
               tabPanel("Overview",
                        
                        
                        p("Tennessee is turning on to be one of the most attractive markets for real estate in US, with having 
                          two major cities among the ", a(href="https://www.cbsnews.com/media/the-10-hottest-real-estate-markets-in-2017/11/","top ten US markets"),
                          "and still among the ",a(href="https://www.usatoday.com/story/money/personalfinance/real-estate/2018/02/05/10-states-predicted-have-strong-housing-markets-2018-february-2-2018-josh-smith-here-10-states-predi/305381002/].","hot market candidates for 2018."), 
                          "Some ",a (href="http://www.farmlandinfo.org/statistics/tennessee","statistics"), "suggest an increasing trend in converting agricultural lands into developed ones, which is likely to result in change in the socioeconomical status of the state."),
                        img(src = "for_sale.jpg"),
                        br(),br(),
                        p("This app is designed to visualize the changes in residential properties, as well as agricultural land among counties of Tennessee. 
                          It can be used to investigate if the changes in residential properties within counties correlates with that of different land types, 
                          either individually or combined.")
                        ),
               

               # Tab "Overview" ends
               
               
               tabPanel("Source Data",
                        p(tags$b("A."), "The agricultural land data was collected from", a(href="https://www.agcensus.usda.gov/Publications/2012/Full_Report/Volume_1,_Chapter_2_County_Level/Tennessee/",
                          "USDA Census of Agriculture"), ". According to this cencus, land types are defined as follow:"),
                        tags$ol (
                      tags$li(tags$b("Farmland:"), "Any place from which $1,000 or more of agricultural products were 
                          produced and sold, or normally would have been sold, during the census year."),br(),
                        
                      tags$li(tags$b("Cropland:"), "This category includes cropland harvested, other pasture and grazing land that could have 
                          been used for crops without additional improvements , cropland on which all 
                          crops failed or were abandoned, cropland in cultivated summer fallow, and cropland idle or used for cover crops or 
                          soil improvement but not harvested and not pastured or grazed."),br(),
                        
                        tags$li(tags$b("Woodland:"), "This category includes natural or planted woodlots or timber tracts, cutover and deforested land with young 
                          growth which has or will have value for wood products and woodland pastured. Land covered by sagebrush or mesquite 
                          was reported as Permanent pastureland and rangeland or other land."),br(),
                        
                        tags$li(tags$b("Pasture:"), "This land use category encompasses grazable land that does not qualify as woodland pasture or cropland pasture. It 
                          may be irrigated or dry land. In some areas, it can be a high quality pasture that could not be cropped 
                          without improvements. In other areas, it is barely able to be grazed and is only marginally better than 
                          wasteland.")
                        ),
                        p("The data were available in PDF format. Therefore, it was extracted from PDFs and imported into spreadsheets
                          using", a(href="https://github.com/tabulapdf/tabula/releases/download/v1.2.0/tabula-mac-1.2.0.zip","Tabula,"), "then merged wherever broken 
                          over pages, and finally cleaned headers adjusted using R scripts."),br(),
                        p(tags$b("B."), "The data for homes sold (available in XLSX format) was collected from", a(href="https://thda.org/research-planning/home-sales-price-by-county","Tennessee Home Development Agency."),
                          " Median and average sales prices of new and existing homes are compiled from actual and up-to-date information pertaining to residential, 
                          single-family home sales in counties."), br(),br(),
                        
                        p("The time span for residential properties and agricultural lands were 2007-2016 and 2002-2012, respectively. It was 
                          presumed that the housing market lags behind land market; namely change in land use (home sale) will not occur immediately after land sale.")
                        ),   # tab "Source Data" ends                   
               
               
               tabPanel("Interactive App",

                    
                    # Sidebar with a slider input for number of bins 
                    sidebarLayout(
                      sidebarPanel(
                        
 
                        selectInput("selCOUNTY", label = h5("Select County"),
                                    choices = droplist,
                                    selected = 1), br(),
                        p("In Fig. 1, the", tags$b("red"), "mark highlights 2008, when the",  a(href = "https://www.britannica.com/topic/Financial-Crisis-of-2008-The-1484264", "financial crash"), "hit the real estate market."),
                        p("The time span left to the", tags$b("blue"), "mark overlaps the land type bar chart in Fig. 2.")

                      ),
                      
                      # Show a plot of the generated distribution
                      mainPanel(
                        plotOutput("lineHOME"),
                        br(),br(),
                        plotlyOutput("barLANDS")
                         
                      ) # mainPanel end
                    ) # sidebarLayout end
               ) # Interactive App tab ends
    ) # navbarPage end
  ) # fluidPage end
) # shinyUI end
