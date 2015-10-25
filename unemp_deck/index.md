---
title       : Unemployment Dataset Map Generator
subtitle    : Shown by county in continental US
author      : Gary W. Deinert
job         : 
framework   : io2012        # {io2012, html5slides, shower, dzslides, ...}
highlighter : highlight.js  # {highlight.js, prettify, highlight}
hitheme     : tomorrow      # 
widgets     : []            # {mathjax, quiz, bootstrap}
mode        : selfcontained # {standalone, draft}
knit        : slidify::knit2slides

--- .class #id 


## Unemployment Dataset Mapping Project


### Learning to create shiny interactive maps with the 'maps' package and the 'unemp' dataset

--- 

## Program designed to provide user interactivity in three areas:
### - Choose the state(s) to view
### - Select the range of unemployment as % of population, using UI slider
### - Make your own map title

---


## Packages:
### - shiny          presenter package
### - maps           create the county-by-county and state maps for US
### - mapproj        needed for certain coordinate handling for maps pkg
### - RColorBrewer   selected map color package
### - plyr           dataframe manipulation

## Datasets:
### - countyMapEnv   geographical coordinates for county boundaries
### - county.fips    link Federal Info Processing Std code to county names
### - stateMapEnv    geographical coordinates for state boundaries
### - unemp          provides the actual unemployment figures

---


## R code overview
## - Reactive functions:  
###   getdata(), getrange(), gettitle(), getstates()
####   All initiated by single "Update" button at User Interface
## - Non-reactive functions:
####  - distPlot() - Generates the map for selected states, % range, user title
####  - summarydf() - Summarize population, avg unemployment, and county count

---

## Specific R code example: generate the map



### Assume UI selected: states = ohio,west virginia,pennsylvania; range=8%-20%;
###          title = "OH-PA-WV Over 8% Unemployment"

```r
      map("county", regions = states.shown, col = colors[working_db$colorBuckets], 
            fill = TRUE,resolution = 0,lty = 0, projection = "polyconic")
      title(map.title)
      leg.txt <- c("<3%", "3-6%", "6-9%", "9-12%", "12-15%", "15+%")
      legend("bottomright", leg.txt, horiz = FALSE, fill = colors)
            
      ## Add border around each county
     map("county", regions = states.shown, col = "darkgrey", fill = FALSE, add = TRUE, 
            lty = 1, lwd = 0.2, projection = "polyconic")
```

![plot of chunk unnamed-chunk-2](assets/fig/unnamed-chunk-2-1.png) 

---

## Create the datatable

```r
avg_unemp <- aggregate(unemp ~ state, data=working_db,mean)
total <- aggregate(pop ~ state, data=working_db,sum)
counties <- aggregate(count ~ state, data=working_db,sum)
summary_df <- cbind(avg_unemp,total$pop,counties$count)

summary_df
```

```
##           state     unemp total$pop counties$count
## 1          ohio 10.714773   5876843             88
## 2  pennsylvania  8.728358   6351110             67
## 3 west virginia  9.114545    791448             55
```

---

## Results

![plot of chunk unnamed-chunk-4](assets/fig/unnamed-chunk-4-1.png) 

```
##           state     unemp total$pop counties$count
## 1          ohio 10.714773   5876843             88
## 2  pennsylvania  8.728358   6351110             67
## 3 west virginia  9.114545    791448             55
```

---

## Meeting project objectives
### 1. Shiny application with supporting documentation.
####   a) Link to application: https://garys-data.shinyapps.io/census_look
####   b) Supporting documentation: included "helppage.html" as a 2nd tab panel, 
####         PLUS have helpText() above user input box on sidebar panel
### 2. Some form of input. We have four: 
####         a) User-designated chart title (textInput), 
####         b) range of unemployment % slider (sliderInput),
####         c) choose what states to see / calculate (selectizeInput),
####         d) update button when selections chosen (actionButton)
### 3. Some operation on the ui input in server.R.  Multiple. Some of them:
####         a) re-generation of the working database based on selected states
####         b) renewing the working databased to include only UI within selected range
####         c) mapping/plotting of the selected states
####         d) aggregating state unemployment average for display table
####         e) summarizing total state population for display table
####         f) count of counties in user-selected region, displayed within state summary

---

## Project Learnings
### - Using and publising to shiny
### - Using and publishing on slidify
### - Reactivity:
####   - Have ANY non-reactive vars in your reactive function, it doesn't react right
####   - Reactive functions return a single value. Keep them clean. 
### - Using browser() to troubleshoot within shiny.  (Critical.)
### - Use of panels, tabsets, user inputs
### - Integration of HTML functions into shiny projects
### - Working within projects: 
####  My last class in data science series, first time working with projects
### - Creating a user-friendly project -- this is great stuff!


