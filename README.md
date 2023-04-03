# US-Temperature-Choropleth

## How to Run Shiny App

##  ✨ The Shiny App ✨
To run the app I made using shiny, run these lines of code in your favorite R compiler IDE and it will pull up a pop-up window in your current browser. In order to run this, you need to make sure you have the correct packages installed (ggplot2, tidyr, dplyr, sp, shiny, maps). You can install the correct versions of these packages by running the following line of code in your R IDE. If you already have these packages installed, it is still worth running this line to make sure all your packages are up to date.
```
install.packages(c("ggplot2", "tidyr", "dplyr", "sp", "shiny", "maps"))
```

Once the packages are installed, you can run the following lines to run the shiny app.
```
library(shiny) #import shiny library
runGitHub("StudentPerfromanceAnalysis", "EliBrignac") #run my app
```
