library(shiny)
library(ggvis)
library(knitr)

shinyUI(navbarPage("Auto Characteristics",
    
    tabPanel("Application", sidebarLayout(
        sidebarPanel(selectInput("x_var", label = "Choose an X axis value", choices = axis_names,
            selected = "weight"),
            
            selectInput("y_var", label = "Choose an Y axis value", choices = axis_names,
                selected = "mpg"),
            
            sliderInput("year", "Model year", min = 70, max = 82, step = 1, pre = "19", value = c(70,82), sep=""),
            
            checkboxGroupInput(inputId = "origin", label = "Origin of car", 
                               choices = list("American" = 1, "European" = 2, "Japanese" = 3),
                               selected = c(1,2,3), inline = TRUE)
            ),
        
        mainPanel(ggvisOutput("plot"))
        )),
    tabPanel("Documentation", 
             HTML(readLines("documentation.html")))
    ))