#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(forecast)
library(ggplot2)
library(plotly)
# Define server logic required to draw a histogram
shinyServer(function(input, output) {
      data("AirPassengers")
      arimaModel <-  auto.arima(AirPassengers)
      
      plotArima <-
            
            reactive({
                  predArima <- forecast(arimaModel,
                                        level = c(input$confint),
                                        h = input$periods)
                  
                  ggplotly(autoplot(predArima))
                  
            })
      predHw <- reactive({
            modelHw <-
                  hw(
                        AirPassengers,
                        initial = "optimal",
                        h = input$periods,
                        level = c(input$confint)
                  )
            ggplotly(autoplot(modelHw))
      })
      output$arima <- renderPlotly(plotArima())
      output$hw <- renderPlotly(predHw())
      
})
