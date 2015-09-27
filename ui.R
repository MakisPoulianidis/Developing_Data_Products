##################################################################
## title: "Predict Fuel Consumption in Miles per Gallon" ui.R    #
## author: "Bankbintje"                                          #
## date: 27 september 2015                                       #
##################################################################

library(shiny)

# Define UI for dataset viewer application
shinyUI(
        pageWithSidebar(
                # Application title
                headerPanel("Predict Fuel Consumption in Miles per Gallon"),
                
                sidebarPanel(
                        
                        h3('Inputs'),
                        
                        sliderInput("hp", label = h5("Horsepower"), min = 50, 
                                    max = 350, value = 10),
                        
                        
                        sliderInput("wt", label = h5("Car Weight (in lb)"), min = 1500, 
                                    max = 5500, value = 100),
                        
                        radioButtons("cyl", label = h5("Number of Cylinders"),
                                     choices = list("4" = 4, "6" = 6, "8" = 8), 
                                     selected = 6),
                        
                        
                        radioButtons("am", label = h5("Transmission Type"),
                                    choices = list("0 = Automatic" = 0, "1 = Manual" = 1), 
                                    selected = 1),
                        
                        submitButton('Submit')
                ),
                mainPanel(
                        h6('This app predicts fuel consumption using a linear regression model based on the mtcars dataset. It uses horsepower, car weight, number of cylinders and transmission type as predictors and returns the fitted fuel consumption in mpg - including the lower and upper bound values.'),
                        hr(),
                        h5('How to use this app:'),
                        h6('(1) Enter the values in the sidebarPanel on the left'),
                        h6('(2) Hit the <Submit> button'),
                        h6('(3) Read the predicted fuel consumption below'),
                        hr(),
                        h5('You have entered the following values:'),
                        tableOutput("values"),
                        hr(),
                        h4('Predictions'),
                        h5('Fuel consumption in mpg - Predicted:'),
                        verbatimTextOutput("fit.mpg"),
                        h5('Fuel consumption in mpg - Lower Bound:'),
                        verbatimTextOutput("lwr.mpg"),
                        h5('Fuel consumption in mpg - Upper Bound:'),
                        verbatimTextOutput("upr.mpg")
                )
        )
)

