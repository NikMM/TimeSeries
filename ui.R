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
                        
               )
               
                          
                           
                           )))))

dashboardPage(header, bar, body)




