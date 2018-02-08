library(shiny)
library(shinydashboard)

header <-  dashboardHeader()
bar <- dashboardSidebar()
body <- dashboardBody()

dashboardPage(header, bar, body)




