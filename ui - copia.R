#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(plotly)
# Define UI for application that draws a histogram
shinyUI(fluidPage(
      tags$style(".well {background-color:skyblue;}"),
      # Application title
      titlePanel("Air Passengers Prediction"),
      
      # Sidebar with a slider inpupt for number of bins
      sidebarLayout(
            sidebarPanel(
                  sliderInput(
                        "periods",
                        "Number of Months to Forecast:",
                        min = 12,
                        max = 360,
                        value = 36
                  ),
                  sliderInput(
                        "confint",
                        "Confidence Interval(%):",
                        min = 90,
                        max = 99.5,
                        value = 95
                  ),
                  submitButton("Prediction")
            ),
            
            # Show a plot of the generated distribution
            mainPanel(tabsetPanel(
                  type = "tabs",
                  tabPanel("Arima", plotlyOutput("arima")),
                  tabPanel("Holt-Winters", plotlyOutput("hw"))
                  
            ))
      )
))
