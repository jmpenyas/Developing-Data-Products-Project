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
# Define UI for application that forecasts the airpassengers.
# It uses dashboard elements from shinydashboard package not the default fluidpages from shiny
shinyUI(dashboardPage(
      dashboardHeader(title = "Air Passengers"),
      dashboardSidebar(
            # Dashboard Items from the sidebar
            menuItem(
                  "Prediction",
                  tabName = "dashboard",
                  icon = icon("cog", lib = "glyphicon")
            ),
            menuItem(
                  "Series Decomposition",
                  tabName = "decom",
                  icon = icon("bar-chart-o")
            ),
            menuItem(
                  "How to use it?",
                  tabName = "education",
                  icon = icon("education", lib = "glyphicon")
            )
      ),
      dashboardBody(tabItems(
            # Tabs related to the menu items of the sidebar
            tabItem(tabName = "dashboard",
                    # Arima Plot
                    fluidRow(box(
                          plotlyOutput("arima")
                    ),
                    #Horton WiltPlot
                    box(plotlyOutput(
                          "hw"
                    ))),
                    # Sliders. They have been put on the tab as the dashboard menu items don't work properly if one of them has items as sliders or input boxes.
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
            # Time series Decomposition plot
            tabItem(tabName = "decom", fluidRow(
                  plotlyOutput("decomp")
            )),
            # Small guide with links to presentation and source code
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
                  p(
                        "Click on Series Decomposition Menu to see the decomposition plot of the AirPassengers time series."
                  ),                  
                  tags$a(href = "http://rpubs.com/jmpenyas/415567", "You can find the source here"),
                  br(),
                  tags$a(href = "https://github.com/jmpenyas/Developing-Data-Products-Project", "Here you can find the presentation of the application."),
                  class = "active"
            )
      ))
))