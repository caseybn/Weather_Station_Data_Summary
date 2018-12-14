# Define UI for weather station app
ui <- fluidPage(
  
  # App title 
  titlePanel("Elizabeth Woods Weather Station"),
  
  # Sidebar layout with input and output definitions
  sidebarLayout(
    
  # Sidebar panel for inputs
  sidebarPanel(
    #select variables to plot against Date
    selectInput("variable","Variable:",
                c("Temperature" = "T_mean",
                  "Preciptation" = "p_sum",
                  "Relative Humidity" = "RH_mean",
                  "Solar" = "s_sum",
                  "Wind" = "WS_mean")),
  
    # Input: Checkbox for whether outliers should be included
    checkboxInput("outliers", "Show outliers", TRUE)
  ),
  
  # Main panel for displaying outputs
  mainPanel(
    # Output: Formatted text for caption
    h3(textOutput("caption")),
    
    # Output: Plot of the requested variable against Date
    plotOutput("Weather Station Plot")
  )
)
)

# Define server logic to plot various variables against Date----
server <- function(input, output) {
  formulaText <- reactive({
    paste("Date ~", input$variable)
  })
output$caption <-renderText({
  formulaText()
})

output$DatePlot <- renderPlot({
  plot_ly(graph, x = ~Date, y = ~p_sum)
  })
}

shinyApp(ui, server)

#runApp("~/shinyapp") #run the app