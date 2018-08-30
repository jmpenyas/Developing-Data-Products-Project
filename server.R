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
# Define server logic required  that forecast the airpassengers.
shinyServer(function(input, output) {
      # Loading Air Passengers data set
      data("AirPassengers")
      # Defining arima model
      arimaModel <-  auto.arima(AirPassengers)
      # Defining arima forecast plot reading sliders info
      plotArima <-
            
            reactive({
                  predArima <- forecast(arimaModel,
                                        level = c(input$confint),
                                        h = input$periods)
                  
                  ggplotly(autoplot(predArima))
                  
            })
      # Defining Horton Wilt forecast plot reading sliders info
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
      # Getting the decomposition of the time series
      decPlot <- reactive({
            decomp <- decompose(AirPassengers, type = "multiplicative")
            autoplot(decomp)  
      })

      # Outputting the plots to show them at the UI
      output$arima <- renderPlotly(plotArima())
      output$hw <- renderPlotly(predHw())
      output$decomp <- renderPlotly(decPlot())
      
})
