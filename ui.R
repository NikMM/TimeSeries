library(shiny)
library(shinydashboard)
library(dygraphs)
library(markdown)

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
                              
                              conditionalPanel(
                                condition = "input.tabset2 == 4",
                                
                                conditionalPanel(
                                  condition = "input.predSelect == 'arima'",
                                  includeMarkdown("content/prediction.md")
                                ),
                                
                                conditionalPanel(
                                  condition = "input.predSelect == 'ets'",
                                  includeMarkdown("content/predictionEt.md")
                                ),                
                                
                                conditionalPanel(
                                  condition = "input.predSelect == 'naive'",
                                  includeMarkdown("content/predictionNa.md")
                                ),   
                                
                                conditionalPanel(
                                  condition = "input.predSelect == 'rwdrift'",
                                  includeMarkdown("content/predictionRw.md")
                                )
                              ), 
                              
                                plotOutput("plotArima", height = 300))
                          

                          
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
                          
                          
                        ))),
               
               box(width = 4, #title = "", collapsible = T, 
                   
                   #   verbatimTextOutput("tabset2Selected"), br(),  
     
                   conditionalPanel(
                     condition = "input.tabset2 == 1",
                     includeMarkdown("content/timeSeries.md")
                   ), 
                   
                   conditionalPanel(
                     condition = "input.tabset2 == 2",
                     includeMarkdown("content/description.md")
                   ), 
                   
                   conditionalPanel(
                     condition = "input.tabset2 == 3",
                     includeMarkdown("content/autocorrelation.md")
                   ),
                   
                   conditionalPanel(
                     condition = "input.tabset2 == 4",
                     box(width = 12, solidHeader = TRUE, 
                         inputPanel( 
                           selectInput("predSelect", "Метод:",  
                                       c("Arima" = "arima",
                                         "ETS" = "ets",
                                         "Naive" = "naive",
                                         "Rwdrift" = "rwdrift")),
                           sliderInput("arPeriod", "Длина прогноза:",
                                       min = 10, max = 250,
                                       value = 100),
                           sliderInput("dovInt", "Дов. интервал:", width = '300px', 1, 99, 
                                       value = c(75, 95))
                         ))
                     
                   )
                   

                   
               
        )
                
                           )),
    
    
    
    ## textdata
    
    tabItem(tabName = "textData",
            fluidRow(
              tabBox(width = 12, id = "tabset4",
                     side = "left", height = "250px",
                     selected = "Индекс",
                     tabPanel(title = "Индекс", dataTableOutput("table")),
                     tabPanel(title = "Новости", value=77,
                              conditionalPanel( 'input.tabset4 == 77'
                                               
                                                
                                                ),
                              
                              DT::dataTableOutput("table1")
                     )
              )
              
            )
    )
    
    
    
    ))

dashboardPage(header, bar, body)




