#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#
library(shinydashboard)
library(shiny)
library(plotly)
# Define UI for application that draws a histogram
shinyUI(dashboardPage(
      dashboardHeader(title = "Air Passengers"),
      dashboardSidebar(
            menuItem(
                  "Prediction",
                  tabName = "dashboard",
                  icon = icon("cog", lib = "glyphicon")
            ),
            menuItem(
                  "How to use it?",
                  tabName = "education",
                  icon = icon("education", lib = "glyphicon")
            )
      ),
      dashboardBody(tabItems(
            tabItem(tabName = "dashboard",
                    fluidRow(box(
                          plotlyOutput("arima")
                    ),
                    box(plotlyOutput(
                          "hw"
                    ))),
                    fluidRow(box(
                          sliderInput(
                                "periods",
                                "Months to Forecast:",
                                min = 12,
                                max = 360,
                                value = 36
                          )
                    ), box(
                          sliderInput(
                                "confint",
                                "Confidence Interval(%):",
                                min = 90,
                                max = 99.5,
                                value = 95
                          )
                    ))),
            tabItem(
                  tabName = "education",
                  h2("How to use this application"),
                  br(),
                  h4(
                        "This application uses Air Passenger data set and make predictions using Arima and Holton-Wilt algorithms"
                  ),
                  p(
                        "Click on Prediction Menu and use the slides to select the months to forecast and the confidence interval of the predictions. Both plots will reload with new data. This process can take time. Be patien, please!"
                  ),
                  
                  tags$a(href = "https://github.com/jmpenyas/Developing-Data-Products-Project", "You can find the source here"),
                  br(),
                  tags$a(href = "https://github.com/jmpenyas/Developing-Data-Products-Project", "Here you can find the presentation of the application."),
                  class = "active"
            )
      ))
))