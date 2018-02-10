library(shiny)
library(dygraphs)
library(ggplot2)
library(ggseas)
library(datasets)
library(ggfortify)


source("timeSeries.R")


shinyServer(function(input, output) { 
  
    output$tabset2Selected <- renderText({
      input$tabset2
    }) 
 
   # Временной ряд 
  
    output$dygraphFirst <- renderDygraph({
      dygraph(dowJ, main = "График динамики индекса DJIA")  %>%
        dyRangeSelector() %>% 
        dyLimit(as.numeric(dowJ[1,]), color = "red") %>%
        dySeries(label = "Цена") 
       
    })
  
    # Декомпозиция
    
    output$plotSTL <- renderPlot({
      ap_df <- tsdf(dow_ts)
      ggsdc(ap_df, aes(x = x, y = y), method = "stl", s.window = "periodic", 
            frequency=253, start=c(2014, 2), facet.titles = c("Исходный временной ряд", 
                                                              "Тренд", "Сезонность", 
                                                              "Ошибка")) +
        geom_line(color="grey43") +
        ylab(" ")
     
    })   
    
    
    output$plotDiff <- renderPlot({
      autoplot(difftimes) 
    })
    
    output$plotAcfV <- renderPlot({
      autoplot(acf(quandl$Value, lag.max=100),  main = "")
    })
    
    output$plotPacfV <- renderPlot({
      autoplot(pacf(quandl$Value,lag.max=100),  main = "")
      
    })
    
    # Прогноз 
    
    predArima <- reactive(autoplot(forecast(dow1_stl, method= input$predSelect, 
                                            h =  input$arPeriod, 
                                            level=input$dovInt), 
                                   ylab="Цена",xlab=""))
    
    output$plotArima <- renderPlot(predArima())
    
    
    # downloadButton('downloadArima ', 'Download')
    output$downloadArima <- downloadHandler(
      filename = function() {
        # paste("Pred-", Sys.Date(), ".csv", sep="")
        paste("Pred",gsub("-",Sys.Date()), ".csv", sep="")
      },
      content = function(file) {
        write.csv(predArima(), file)
        dev.off()
      }
    )
    
    
    output$table <- renderDataTable({
      quandl
    })
    
    output$table1 <- DT::renderDataTable({
      quandl
      DT::datatable(quandl[, input$opts, drop = FALSE])
    })
    
    
    
    
    
    

  
  
  
  })







