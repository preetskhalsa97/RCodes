library(shiny)
library(ggplot2)
library(dplyr)

bcl = read.csv("bcl-data.csv", stringsAsFactors = FALSE)
ui = fluidPage(
  titlePanel("BC Liquor Store prices"),
  sidebarLayout(
    sidebarPanel(
      sliderInput("priceInput", "Price", 0, 100, c(25, 40), pre = "$"),
      radioButtons("typeInput", "Product type",
                   choices = c("BEER", "REFRESHMENT", "SPIRITS", "WINE"),
                   selected = "WINE"),
      selectInput("countryInput", "Country",
                  choices = c("CANADA", "FRANCE", "ITALY")),
      selectInput("mycolour","Colour",
                   choices=c("red","blue","green")),
      numericInput("mynumber", "Number", 10, min = 1, max = 100)
    ),
    mainPanel(plotOutput("coolplot"),
              br(),
              br(),
              tableOutput("result"),
              br(),
              br(),
              plotOutput("someoutput"))
  )
)
server=function(input,output){
  filtered <- reactive({
    bcl %>%
      filter(Price >= input$priceInput[1],
             Price <= input$priceInput[2],
             Type == input$typeInput,
             Country == input$countryInput
      )
  })
  output$coolplot <- renderPlot({
  ggplot(filtered(), aes(Alcohol_Content)) +
    geom_histogram()
})
output$result <- renderTable({
  filtered()
})
output$someoutput <- renderPlot({
  col <- input$mycolour
  num <- input$mynumber
  plot(rnorm(num), col = col)
})
#observe({ print(input$priceInput) }) #prints in the CONSOLE 

} 
shinyApp(ui=ui,server=server)
