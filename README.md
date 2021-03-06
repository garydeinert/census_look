# census_look
Data Products Unemployment Mapping Project

Final course project for "Developing Data Products", a Coursera offering for the last course of the Data Science Specialization.
This particular project investigates the use of Shiny, Shinyapps.io, and Slidify to create an interactive presentation.  

My project choice was to have 4 interactive user choices: update map title, choose range of unemployment to investigate, and choose which state(s) to display in the map and corresponding summary statistics.  The 4th interactive element was an "Update" action button that enabled reactive page update.

Packages used included shiny, plyr, maps, and mapproj.  Data was from the "unemp" dataset and county titles from the "county.fips" data.  

Relevant files for review:
census_look/server.R, census_look/ui.R, final_unemp/index.Rmd, final_unemp/index.html

Please do NOT use any files from the "unemp_deck" data.  This has gotten corrupted and I still need to figure out how to get rid of it.  Thanks.  

