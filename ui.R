library(shiny)

shinyUI(fluidPage(
  titlePanel("Individual Player Stats"),
  
  sidebarLayout(
    sidebarPanel(
      helpText("Select the First Player"),
            
      selectInput("player1", label = h3("Player 1"), choices = levels(factor(sample_nba$Player)), selected = "Draymond Green"),
      
      helpText("Select the Second Player"),
      
      selectInput("player2", label = h3("Player 2"), choices = levels(factor(sample_nba$Player)), selected = "Stephen Curry"),
    
      
      helpText("Select a Statistic to Compare"),
      
      selectInput("stat", label = h3("Statistic"), choices = names(sample_nba)[!names(sample_nba) %in% c("X", "Player", "Pos", "Age", "Tm", "year", "grp.mean")], selected = "PER"),
      
      img(src = "nba_image.png", height = 75, width = 75)
      
      
    ),
    
    mainPanel(
      
      plotOutput("plot")
    
    )
    )
  ))