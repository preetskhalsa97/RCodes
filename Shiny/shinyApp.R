#it's IMP that the name of the app is app.R, otherwise it won't be recognized as a shiny app

"""
we can write ui and server in separate files-> ui.R and server.R ==> put them in the same folder, R will recognie the shiny app
If we use this method thoug#h, we don't need to have shinyApp(ui=ui,server=server) 
"""

#creating an empty app 
library(shiny)
library(ggplot2)
library(dplyr)
ui=fluidPage()
server=function(input,output){} 
shinyApp(ui=ui,server=server) #MUST BE THE LAST LINE OF THE SHINY APP

#loading the dataset 
#right after library line, read it and store it in a variable, eg. bcl = read.csv("bcl-data.csv", stringsAsFactors = FALSE)

#Now, add elements to UI

ui=fluidPage("BC Liquor Store", "prices") #simply put this text on the app, text appearing in contigous blocks 

#Add HTML to the fluidPage and it renders accordingly 

ui=fluidPage(
  h1("My app"),
  "BC",
  "Liquor",
  br(),
  "Store",
  strong("prices")
)

"""
any named argument you pass to an HTML function becomes an attribute of the HTML element,
and any unnamed argument will be a child of the element. That means that you can, for example, 
create blue text with div('this is blue', style = 'color: blue;').
"""

#TITLE PANEL- title on the page as well as the browser tab
ui=fluidPage(
  titlePanel("BC Liquor Store prices")
)
# titlePanel(title, windowTitle = title)  ==> complete documentation 

#sidebar layout-  It provides a simple two-column layout with a smaller sidebar and a larger main panel.

ui=fluidPage((
  titlePanel("BC Liquor Store prices"), #REMEMBER: arguments in fluidPage() need to be separated by COMMAS
  sidebarLayout(
    sidebarPanel("our inputs will go here"),
    mainPanel("the results will go here")
  )
)

# GRID LAYOUT gives much more control 

#ADDING INPUTS TO UI
# All input functions have the same first two arguments: inputId and label==> Give unique IDs to each input 

#SLIDER INPUT
ui <- fluidPage(
  titlePanel("BC Liquor Store prices"),
  sidebarLayout(
    sidebarPanel(
      sliderInput("priceInput", "Price", 0, 100, c(25, 40), pre = "$"),
      radioButtons("typeInput", "Product type",
                  choices = c("BEER", "REFRESHMENT", "SPIRITS", "WINE"),
                  selected = "WINE"),
      selectInput("countryInput", "Country",
                  choices = c("CANADA", "FRANCE", "ITALY"))
    ),
    mainPanel("the results will go here")
  )
)

#DECLARING POSITION AND ID OF THE OUTPUT==> PLACEHOLDER
#output will be constructed in the server later

ui <- fluidPage(
  titlePanel("BC Liquor Store prices"),
  sidebarLayout(
    sidebarPanel(
      sliderInput("priceInput", "Price", 0, 100, c(25, 40), pre = "$"),
      radioButtons("typeInput", "Product type",
                  choices = c("BEER", "REFRESHMENT", "SPIRITS", "WINE"),
                  selected = "WINE"),
      selectInput("countryInput", "Country",
                  choices = c("CANADA", "FRANCE", "ITALY"))
    ),
    mainPanel(plotOutput("coolplot"),br(),br(),tableOutput("result"))
  )
)

"""
Implementing server logic to create output
"""
# server=function(input,output){} ==> Both input and output are list- like objects 

"""
Rules to build an outputin shiny:

    1. Save the output object into the output list (remember the app template - every server function has an output argument)
    2. Build the object with a render* function, where * is the type of output
    3. Acces
    input values using the input list (every server function has an input argument) <only if output depends on input>

In order to attach an R object to an output with ID x, we assign the R object to output$x.

Since coolplot was defined as a plotOutput, 
we must use the renderPlot function, and we must create a plot inside the renderPlot function.
"""
server=function(input,output){output$coolplot = renderPlot({
  plot(rnorm(100))
})}

#using USER INPUT to generate OUTPUT 

server=function(input,output){output$coolplot = renderPlot({
  plot(rnorm(input$priceInput[1]))
})} 

#filtering the relevant data and plotting it, remember to import dplyr 

server=function(input,output){output$coolplot <- renderPlot({
  filtered <-
    bcl %>%
    filter(Price >= input$priceInput[1],
           Price <= input$priceInput[2],
           Type == input$typeInput,
           Country == input$countryInput
    )
  ggplot(filtered, aes(Alcohol_Content)) +
    geom_histogram()
})


