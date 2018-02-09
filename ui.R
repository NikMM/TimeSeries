library(shiny)
library(shinydashboard)
library(ggplot2)
library(dygraphs)

header <-  dashboardHeader(titleWidth = 180, title = "")
bar <- dashboardSidebar(width = 180,
          sidebarMenu( br(),
              menuItem("Временной ряд", tabName = "timeSerie", icon = icon("line-chart")),
              #menuItem("Анализ текста", tabName = "textMining", icon = icon("list")),
              menuItem("Набор данных", tabName = "textData", icon = icon("table"))))

body <- dashboardBody(
        tags$head(
          tags$link(rel = "stylesheet", type = "text/css", href = "custom.css")
          )
  
  
)

dashboardPage(header, bar, body)




