# server.R
library(shiny)
library(reshape2)
nba_stats <- read.csv("C:/Users/glevine/Dropbox/R_projects/bball_app/nba_full_dataset.csv")
sample_nba <- nba_stats[order(nba_stats$Player, nba_stats$year),]
palette(c("blue", "red", "green"))

shinyServer(function(input, output) {

  
  output$text1 <- renderText({
    paste(input$player1, " vs ", input$player2, "; comparing ",  input$stat, sep = "")
    
  })
  
    output$plot <- renderPlot({
     
      sample_nba1 <- sample_nba[!is.na(sample_nba[[input$stat]]),]
      mean_stat<- aggregate(list(grp.mean = sample_nba1[[input$stat]]), list(year = sample_nba1$year), mean)      
         
      
     use_data <- sample_nba1[which(sample_nba1$Player == input$player1 | sample_nba1$Player == input$player2),]
          
     use_data$flag <- ifelse(use_data$Player == input$player1, 1, 2)
     use_data <- use_data[order(use_data$flag, use_data$year),]
     
     myvars <- c("flag", "year", input$stat)
     
     use_data <- use_data[myvars]
     
     wide <- reshape(data = use_data, v.names = input$stat, idvar = "year", timevar = "flag", direction = "wide")
     wide <- wide[order(wide$year),]
     
     min_year <- min(wide$year)
     max_year <- max(wide$year)
     
     blank <- as.data.frame(seq(min_year,max_year, 1)) 
     colnames(blank) <- "year"
     
     final_data <- merge(blank, wide, all.x =  TRUE)
     final_data2 <- merge(final_data, mean_stat, all.x = TRUE)
     
     
     par(oma = c(4, 1, 1, 1))
     
     plot(final_data2$year, final_data2[,2], xlab = "Year", ylab = input$stat, main = paste(input$player1, " vs ", input$player2, "; ", "Comparing ", input$stat, sep = ""),
          ylim = c(min(final_data2[,2], final_data2[,3], final_data2[,4], na.rm = TRUE) ,max(final_data2[,2], final_data2[,3], final_data2[,4], na.rm = TRUE)), type = "l", col = "red", xaxt = "n", lwd = 2)
      points(final_data2$year, final_data2[,2],pch = 20, col = "red")
     axis(1, at = min_year:max_year)
     lines(final_data2$year, final_data2[,3], type = "l", col = "blue", lwd = 2)
     points(final_data2$year, final_data2[,3],pch = 20, col = "blue")
     lines(final_data2$year, final_data2$grp.mean, type = "l", pch = 22, col = "green", lwd = 2)
     points(final_data2$year, final_data2$grp.mean,pch = 20, col = "green")
     
     par(fig = c(0, 1, 0, 1), oma = c(0, 0, 0, 0), mar = c(0, 0, 0, 0), new = TRUE)
     plot(0, 0, type = "n", bty = "n", xaxt = "n", yaxt = "n")
     legend("bottom", c(input$player1,input$player2,"League Average"), xpd = TRUE, horiz = TRUE, inset = c(0,0), bty = "n",fill=c("red", "blue", "green"))

        
      
    })
    
  })
  
  

