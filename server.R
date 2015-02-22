library(shiny)
library(ISLR)
library(ggvis)

data <- transform(Auto, originName = originNames[origin])

shinyServer(function(input, output){
    get_tooltip <- function(x){
        if(is.null(x)) return(NULL)
        x$name
    }
    
    ggvisPlot <- reactive({
        xvar <- prop("x", as.symbol(input$x_var))
        yvar <- prop("y", as.symbol(input$y_var))
        
        x_name <- names(axis_names)[axis_names == input$x_var]
        y_name <- names(axis_names)[axis_names == input$y_var] 
        
        x_range <- c(min(data[[input$x_var]]), max(data[[input$x_var]]))
        y_range <- c(min(data[[input$y_var]]), max(data[[input$y_var]]))
        
        data1 <- subset(data, year < input$year[2] & year > input$year[1] & origin %in% input$origin)
      
        data1 %>%
            ggvis(x = xvar, y = yvar) %>%
            layer_points(size := 50, size.hover := 200, fill = ~factor(originName),
                fillOpacity := 0.5, fillOpacity.hover := 0.7, key := ~name) %>%
            add_tooltip(get_tooltip, "hover")%>%
            add_axis("x", title = x_name) %>%
            add_axis("y", title = y_name) %>%
            scale_numeric("x", domain = x_range) %>%
            scale_numeric("y", domain = y_range) %>%
            scale_ordinal("fill", range = fill_range, domain = fill_domain)%>% 
            add_legend("fill", title = "Origin of car") %>%         
            set_options(width = 500, height = 500)
    })
    
    bind_shiny(ggvisPlot, "plot")
})