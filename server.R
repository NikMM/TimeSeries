library(shiny)
library(dygraphs)


source("timeSeries.R")


shinyServer(function(input, output) { 
  
 
   # Временной ряд 
  
    output$dygraphFirst <- renderDygraph({
      dygraph(dowJ, main = "График динамики индекса DJIA")  %>%
        dyRangeSelector() %>% 
        dyLimit(as.numeric(dowJ[1,]), color = "red") %>%
        dySeries(label = "Цена") 
       
    })
  
  
  
  })







