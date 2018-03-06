
setwd("/Users/ghfmhf/git/NSS_project/TN_Land_Use/")

load("data/TN_LU_2.Rda")
# Has loaded six datasets
# TN_crop
# TN_farm
# TN_wood
# TN_pasture
# TN_home
# TN_pin

library(shiny)

droplist <- as.list(TN_pin$county)

shinyUI(fluidPage(
  
  navbarPage("Land Use Change in Tennessee- Massih Forootan",
      
              tabPanel("Overview",
                     
                       # -------------------------- My introductory script will land here
img(src = "for_sale.jpg"),
                       
p("Tennessee is turning on to be one of the most attractive markets for real estate in US, with having 
two major cities among the top ten US markets,"), div(a("https://www.cbsnews.com/media/the-10-hottest-real-estate-markets-in-2017/11/")),
 div("and still among the hot market candidates for 2018"),div(a(" [https://www.usatoday.com/story/money/personalfinance/real-estate/2018/02/05/10-states-predicted-have-strong-housing-markets-2018-february-2-2018-josh-smith-here-10-states-predi/305381002/].")), 
div("Statistics witness a trend increase in converting farmlands into developed land, which will possibly result in changing the socioeconomical status of the state."),
p("This app is designed to visualize the changes in agricultural lands, as well as residential properties among different counties of Tennessee. It can be used to investigate if there is any preference among different counties, and if it's significantly impacting the status of the lands.")
                      ),
             
             
             tabPanel("Source Data",
# -------------------------- Information about the data will be copied here
p("The agricultural land data was collected from USDA Census of Agriculture
https://www.agcensus.usda.gov/Publications/2012/Full_Report/Volume_1,_Chapter_2_County_Level/Tennessee/"),

p("Farm: The census definition of a farm is any place from which $1,000 or more of agricultural products were 
  produced and sold, or normally would have been sold, during the census year."),

p("Cropland: This category includes cropland harvested, other pasture and grazing land that could have 
  been used for crops without additional improvements , cropland on which all 
  crops failed or were abandoned, cropland in cultivated summer fallow, and cropland idle or used for cover crops or 
  soil improvement but not harvested and not pastured or grazed."),

p("Woodland: This category includes natural or planted woodlots or timber tracts, cutover and deforested land with young 
  growth which has or will have value for wood products and woodland pastured. Land covered by sagebrush or mesquite 
  was reported as Permanent pastureland and rangeland or other land."),

p("Pasture: This land use category encompasses grazable land that does not qualify as woodland pasture or cropland pasture. It 
  may be irrigated or dry land. In some areas, it can be a high quality pasture that could not be cropped 
  without improvements. In other areas, it is barely able to be grazed and is only marginally better than 
  wasteland."), 

p("The data for homes sold was collected from Tennessee Home Development Agency (https://thda.org/research-planning/home-sales-price-by-county)
  Median and average sales prices of new and existing homes given below are compiled from actual and up-to-date information pertaining to residential, 
  single-family home sales in these counties."), 

p("While the homes sold data was available as spreadsheet, the agriculture data were in PDF format. Therefore, the PDFs were downloaded and the data was extracted
  using Tabula (https://github.com/tabulapdf/tabula/releases/download/v1.2.0/tabula-mac-1.2.0.zip), then the data was cleaned using R scripts")),                      
                      
             
             
             
             tabPanel("Interactive App",

                       
  # Application title
                      titlePanel("Select two counties and land details (See Source Data tab for definitions)"),
  
  # Checkboxes to define what data to be displayed
                          
                      fluidRow(column(2, 
  
                          checkboxInput("chkFARM", label = "Farmland", value = TRUE),
                          hr()
                        ), column(2,
                          checkboxInput("chkCROP", label = "Cropland", value = TRUE),
                          hr()
                        ), column(2,
                          checkboxInput("chkWOOD", label = "Woodland", value = TRUE),
                          hr()
                        ), column(2,
                          checkboxInput("chkPAST", label = "Pasture", value = TRUE),
                          hr()

                        ), column (4,
                                   checkboxGroupInput("chkLAND", 
                                                      h6("Select Land Type (See Source Data tab for definitions)"), 
                                                      choices = list("Farmland" = 1, 
                                                                     "Cropland" = 2, 
                                                                     "Woodland" = 3,
                                                                     "Pasture" = 4),
                                                      selected = 1)
                                   )
                        
                        ),
                      
                      
  # Two columns, left one for county drop down and the other for graphs
                      fluidRow(column(3,
                                      # A dropdown list containing county names
                                      selectInput("selCOUNTY", label = h6("Select County"),
                                                  choices = droplist,
                                                  selected = 1)
                               )
                              ),
                                column(3,
                                      # Home sales plot
                                      # plotOutput()
                                      textOutput("selected_var")
                                      )
                        )
) # NavBar End
) # FluidPage End
) # ShinyUI End