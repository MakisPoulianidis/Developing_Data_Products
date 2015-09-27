##################################################################
## title: "Predict Fuel Consumption in Miles per Gallon" server.R#
## author: "Bankbintje"                                          #
## date: 27 september 2015                                       #
##################################################################


library(shiny)
library(datasets)
data=mtcars
mtcars$am <- as.factor(mtcars$am)
# Fit the model using cyl, hp, wt and am as predictors
fit <- (lm(formula = mpg ~ cyl + hp + wt + am, data = mtcars))

shinyServer(
        function(input, output) {
                
                # Set the outputs
                output$cyl <- renderPrint({ input$cyl })
                output$hp <- renderPrint({ input$hp })
                output$wt <- renderPrint({ input$wt })
                output$am <- renderPrint({ input$am })
                
                # Get the fitted value
                fit.mpg <- reactive({
                newdata <- data.frame(cyl=as.numeric(input$cyl),
                                      hp=input$hp,
                                      wt=input$wt/1000,
                                      am=input$am)
                                predict(fit, newdata, interval="prediction")[1]
                })
                
                # Get the lower bound value
                lwr.mpg <- reactive({
                        newdata <- data.frame(cyl=as.numeric(input$cyl),
                                              hp=input$hp,
                                              wt=input$wt/1000,
                                              am=input$am)
                        predict(fit, newdata, interval="prediction")[2]
                })
                
                # Get the upper bound value
                upr.mpg <- reactive({
                        newdata <- data.frame(cyl=as.numeric(input$cyl),
                                              hp=input$hp,
                                              wt=input$wt/1000,
                                              am=input$am)
                        predict(fit, newdata, interval="prediction")[3]
                })
                
                                
                output$fit.mpg <- fit.mpg
                output$lwr.mpg <- lwr.mpg
                output$upr.mpg <- upr.mpg
                
                inputValues <- reactive({
                        # Create a data frame for using in the HTML table
                        data.frame(
                                Name = c("Horsepower",
                                         "Car Weight (lb)",
                                         "Number of Cylinders",
                                        "Transmission Type
                                        0 = Automatic
                                        1 = Manual"),
                                Value = as.character(c(input$hp, 
                                                       input$wt,
                                                       input$cyl,
                                                     input$am)),
                                stringsAsFactors=FALSE)
                                })
                
                # Show the values using an HTML table
                output$values <- renderTable({
                        inputValues()
                }) 
                }
)
