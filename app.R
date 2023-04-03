

#pacman::p_load(pacman, dplyr, GGally, ggplot2, ggthemes,
#                 ggvis, httr, lubridate, plotly, rio, rmarkdown, shiny,
#                stringr, tidyr, maps, shinyjs)

library(ggplot2)
library(tidyr)
library(dplyr)
library(sp)
library(shiny)
library(maps)


choose_year_month <- function(temp_data, year_, month_){
  result <- temp_data %>% filter(year == year_ & month == month_)
  return(result)
}

temp_data <- read.csv("USAverageTemps1900-2012.csv")
us_map <- map_data("state")
head(us_map)


temp_data$State <- tolower(temp_data$State)
temp_data$region <- temp_data$State

temp_data <- temp_data %>% select(-State)
head(temp_data)

temp_data$AverageTemperatureCel <- temp_data$AverageTemperature
temp_data$AverageTemperatureFar <- (temp_data$AverageTemperature * 9/5) + 32
temp_data <- temp_data %>% select(-AverageTemperature)
head(temp_data)


ui <- fluidPage(
  titlePanel("Temperature Data of the US from 1900-2012"),
  sidebarLayout(
    sidebarPanel(
      selectInput("month", label = "Select Month",
                         choices = c('Jan', 'Feb', 'Mar', 
                                     'Apr', 'May', 'Jun', 
                                     'Jul', 'Aug', 'Sep', 
                                     'Oct', 'Nov', 'Dec'),
                         selected = "Jan"),
      
      sliderInput("year", label = "Select Year",
                  min = 1900, max = 2012, value = 2000,
                  animate =
                    animationOptions(loop = TRUE)
                  ),
      
      checkboxInput("show", label = "Display Values"),
      
      radioButtons("unit", label = "Select Unit",
                   choices = c("Celcius" = "Cel",
                               "Farenheight" = "Far"))
    ),
    mainPanel(
      plotOutput("map"),
      span("This is a map of the US temperature data. It currently maps the colors 
           relative to other parts of the US which is not ideal, but I do not feel 
           like fixing it right now. How I would fix this is by adding a new column
           to the data frame called 'RelativeTemp' which would generalize the temperatures
           in the data set (appropriately place them within the range of values).
           This way, the color scale wouldn't change it's upper and lower bounds when you 
           change months, thus Maine wouldn't be dark blue when it's 63°F and the graph would
           be much easier to comprehend. I haven't fixed it yet because I am tired.
           Creating this Choropleth was a fun and interesting task in which I learned alot.
           I look forward to taking on the challenge of making more of these."),
      span("More about me: "),
      a(href="https://github.com/EliBrignac", "GitHub", target = "_blank", align = "center"),
      span(" ❤️‍🔥 ", align = "right"),
      a(href="https://www.linkedin.com/in/eli-brignac/", "LinkedIn", target = "_blank", align = "right")
      
    )
  )
)

server <- function(input, output) {

  data <- reactive({
    d <- choose_year_month(temp_data, year = input$year, month = input$month)
    #print(d)
    head(d)
    md = merge(us_map, d, by = 'region')
    head(md)
    md <- md[order(md$order),]
    label_pos <- split(md, f = md$region)
    label_pos <- lapply(label_pos, function(x) x %>% mutate(mean_long = mean(long)))
    label_pos <- lapply(label_pos, function(x) x %>% mutate(mean_lat = mean(lat)))
    md <- do.call(rbind, label_pos)
    
  })
  
  output$map <- renderPlot({
    
    map_data <- data()
    map_data <- switch (input$unit,
      "Cel" = map_data %>% mutate(temp_chosen = AverageTemperatureCel),
      "Far" = map_data %>% mutate(temp_chosen = AverageTemperatureFar))
    
    if (input$show){
      ggplot(map_data, aes(long, lat)) +
        geom_polygon(aes(group = group, fill = temp_chosen )) +
        coord_map("albers",  lat0 = 45.5, lat1 = 29.5)+
        scale_fill_gradient(low = "lightblue", high = "red", name = paste("Average Temperature |", input$unit))+
        geom_text(aes(x = mean_long, y = mean_lat, label = round(temp_chosen, 1)), size = 4)
    }
    else{
    ggplot(map_data, aes(long, lat)) +
      geom_polygon(aes(group = group, fill = temp_chosen )) +
      coord_map("albers",  lat0 = 45.5, lat1 = 29.5)+
      scale_fill_gradient(low = "lightblue", high = "red", name = paste("Average Temperature |", input$unit))
      }
  })
  
}

#Run the app 
shinyApp(ui = ui, server = server)

