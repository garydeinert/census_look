library(shiny)
library(markdown)
show.states <- c("alabama","arizona","arkansas","california","colorado","connecticut",
                 "delaware","florida","georgia","idaho","illinois","indiana","iowa",
                 "kansas","kentucky","louisiana","maine","maryland","massachusetts",
                 "michigan","minnesota","mississippi","missouri","montana","nebraska",
                 "nevada","new hampshire","new jersey","new mexico","new york",
                 "north carolina","north dakota","ohio","oklahoma","oregon","pennsylvania",
                 "rhode island","south carolina","south dakota","tennessee","texas",
                 "utah","vermont","virginia","washington","west virginia","wisconsin",
                 "wyoming")

shinyUI(fluidPage(

  titlePanel("US Unemployment Data"),

  sidebarLayout(
    sidebarPanel(
      helpText("Welcome to the US Unemployment Dataset Viewer.",
            "To create or update a chart, enter the desired title,",
            "% range of unemployment to view by county, and which",
            "state(s) you choose to view.  Press Update to generate your chart."),
      textInput("titletext", label = h3("Edit Chart Title"), value = "US Unemployment By County"),
      sliderInput("pct",label="Select counties within unemployment % range of:", 
                   min=0, max=24, step=2, value=c(4,12)),
      selectizeInput("states","Show these state(s):",choices=show.states, multiple=TRUE),
      actionButton("action", label = "Update")
       ),
       
## Show a plot of the generated distribution
    mainPanel(
      tabsetPanel (       
            tabPanel("Display", 
                  plotOutput("distPlot"),
                  tableOutput("summary_df")),
            tabPanel("Help", includeHTML("helppage.html"))
    ))
))
)

