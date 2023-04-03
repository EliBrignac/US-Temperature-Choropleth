# US-Temperature-Choropleth

<img width="957" alt="PictureOfApp" src="https://user-images.githubusercontent.com/94129362/229424755-98dca2fa-d658-41d6-82d0-fc52c59a9d96.png">
Image of the app

##  🗺️ Display The Choropleth 🗺️
To run the app I made using shiny, run these lines of code in your favorite R compiler IDE and it will pull up a pop-up window in your current browser. In order to run this, you need to make sure you have the correct versions of these packages installed: ggplot2, tidyr, dplyr, sp, shiny, maps. You can install the correct versions of these packages by running the following line of code in your R IDE. If you already have these packages installed, it is still worth running this line to make sure all your packages are up to date. This may prompt you to reload your R IDE.
```
install.packages(c("ggplot2", "tidyr", "dplyr", "sp", "shiny", "maps"))
```

Once the packages are installed, you can run the following lines to run the shiny app.
```
library(shiny) #import shiny library
runGitHub("US-Temperature-Choropleth", "EliBrignac") #run my app
```

## Description

This is a Choropleth of US temperature data from 1900-2012. I got the data from kaggle.com which can be found at this [LINK](https://www.kaggle.com/datasets/berkeleyearth/climate-change-earth-surface-temperature-data?select=GlobalLandTemperaturesByState.csv).
I first filtered this data by only including US states, and reformating the date column (dt) to MM/DD/YYY instead of YYYY-MM-DD because some dates weren't formated the same way.

The file titled `Format_the_data.R` formats the data in the way I want it and then saves it to a csv file called `USAverageTemps1900-2012.csv`.
in addition to the `Format_the_data.R` file, there is a bit of data formating that happens in the `app.R` file before the app is run.




