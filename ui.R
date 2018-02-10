library(shiny)
library(shinydashboard)

header <-  dashboardHeader(titleWidth = 180, title = "")
bar <- dashboardSidebar(width = 180,
          sidebarMenu( br(),
              menuItem("Временной ряд", tabName = "timeSerie", icon = icon("line-chart")),
              #menuItem("Анализ текста", tabName = "textMining", icon = icon("list")),
              menuItem("Набор данных", tabName = "textData", icon = icon("table"))))

body <- dashboardBody(
        tags$head(
          tags$link(rel = "stylesheet", type = "text/css", href = "custom.css")
          ),
        
        
        tabItems(
          
          
    ## Временной ряд
    
    tabItem(tabName = "timeSerie",
           
       fluidRow(
        tabBox(width = 8,  id = "tabset2",
               tabPanel("Временной ряд", value=1,
                        dygraphOutput("dygraphFirst")),
               
               tabPanel("Декомпозиция", value=2,
                        plotOutput("plotSTL", height = '500px'),
                        p("Выше показаны: исходный временной ряд, сезонность, тренд, ошибка."), 
                        p("Наличие плавно растущего тренда и сезонного фактора, - колебания примерно постоянны с течением времени, говорят о не стационарности данного ряда.")
               ),
               
               tabPanel("Автокорреляция", value=3,
                        helpText("АКФ и ЧАКФ исходного ряда"),
                        plotOutput("plotAcfV"),
                        plotOutput("plotPacfV"),
                        helpText("Временной ряд после взятия разности"),
                        plotOutput("plotDiff")
                        # helpText("АКФ и ЧАКФ"),
                        # plotOutput("plotAcfD"),
                        # plotOutput("plotPacfD")
                        
               ),
               
               tabPanel("Прогноз", value=4,
                        
                        fluidRow(
                          box(width = 12,  solidHeader = TRUE,
                                plotOutput("plotArima", height = 300)),
                          
                          box(width = 5, solidHeader = TRUE, 
                               inputPanel( 
                                 selectInput("predSelect", "Метод:",  
                                             c("Arima" = "arima",
                                               "ETS" = "ets",
                                               "Naive" = "naive",
                                               "Rwdrift" = "rwdrift")),
                                 sliderInput("arPeriod", "Длина прогноза:",
                                             min = 10, max = 250,
                                             value = 100),
                                 sliderInput("dovInt", "Дов. интервал %:", width = '300px', 1, 99, 
                                             value = c(75, 95))
                               ))
                          
                          # box(width = 7, solidHeader = T,
                          #      br(),
                          # downloadButton(outputId = 'downloadArima',
                          #                label = "Скачать", icon = icon("download"))
                      
                          # box( width = 5,  solidHeader = TRUE, 
                          # inputPanel(
                          # sliderInput("dovInt", "Доверительный интервал %:", 1, 99, 
                          #             value = c(75, 95)),
                          # ),
                          # ), 
                          
                          
                        ))
        )
               
                          
               
                           
                           ))))

dashboardPage(header, bar, body)




