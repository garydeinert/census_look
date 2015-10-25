library(shiny)
library(maps)
library(mapproj)
library(RColorBrewer)
library(plyr)
data(countyMapEnv)
data(county.fips)
data(stateMapEnv)
data(unemp)

shinyServer(function(input, output) {

      getdata <- eventReactive(input$action,{
            working_db <- NULL
            states.shown <- input$states
            unemp_county <- county.fips$polyname[match(unemp$fips,county.fips$fips)]      ## develop df
            unemp <- cbind(unemp,unemp_county)
            unemp <- unemp[complete.cases(unemp),]
            unemp$unemp_county <- as.character(unemp$unemp_county)
            unemp$state <- sapply(strsplit(unemp$unemp_county,","),"[",1)
            unemp$count <- 1

            working_db <- unemp[unemp$state %in% states.shown,]
                                
      }) 
      
      getrange <- eventReactive (input$action,{
            input$pct
      })
      
      gettitle <- eventReactive (input$action,{
            input$titletext
      })
      
      getstates <- eventReactive (input$action, {
            input$states
      })
      
        output$distPlot <- renderPlot({ 

            plot_db <- getdata()
            pct_range <- getrange()
            map.title <- gettitle()
            states <- getstates()
            
            states.shown <- input$states
            colors <- brewer.pal(6,"PuBuGn") 
                        
            plot_db$colorBuckets <- as.numeric(cut(plot_db$unemp, c(0, 3, 6, 9, 12, 15, 100)))
            plot_db$colorBuckets[plot_db$unemp < (pct_range[1])]=100
            plot_db$colorBuckets[plot_db$unemp > (pct_range[2])]=100            
            
            map("county", regions = states, col = colors[plot_db$colorBuckets], 
                fill = TRUE,resolution = 0,lty = 0, projection = "polyconic")
            title(map.title)
            leg.txt <- c("<3%", "3-6%", "6-9%", "9-12%", "12-15%", "15+%")
            legend("bottomright", leg.txt, horiz = FALSE, fill = colors)
            
            ## Add border around each county
            map("county", regions = states, col = "darkgrey", fill = FALSE, add = TRUE, 
                lty = 1, lwd = 0.2, projection = "polyconic")
            
##            browser()                         ## use only when troubleshooting

      })
      
      output$summary_df <- renderTable({

            table_db <- getdata()
            
            avg_unemp <- aggregate(unemp ~ state, data=table_db,mean)
            total <- aggregate(pop ~ state, data=table_db,sum)
            counties <- aggregate(count ~ state, data=table_db,sum)
            summary_df <- cbind(avg_unemp,total$pop,counties$count)
 
      })

      output$summary_help <- renderPrint ({
            print("This is a very simple application that displays 
                  unemployment figures for the 48 contiguous US states.")
      })

})
