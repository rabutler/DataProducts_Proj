---
title: "instructions"
author: "Alan Butler"
date: "Wednesday, December 10, 2014"
output: html_document
---

## Background

In water resources management, and likely in other applications, simulation models can be used to quantify the chances that some future event may happen based on a number of different assumptions. In this "what-if" type of approach, hundreds or thousands of simulations may be performed before changing the assumptions on one or more of the inputs; this creates multiple **scenarios**. Then, many more simulations are completed, and the results can be compare accross scenarios. 

In this example, the levels of two hypothetical reservoirs are compared. The levels can be compared in terms of the storage, i.e., volume of water the reservoirs contain, or the elevations of the reservoirs. The elevations/storages are important for water supply issues, that is, users (for example cities) that rely on the water stored in the reservoirs are interested in knowing how full (or empty) the reservoirs may be in the future.

This example provides several alternatives, which are commonly used in the water resources industry, for different ways to compare the different reservoir elevations/storages over the next 10 years for two reservoirs. In this example, the scenarios are hypothetical, but in reality they could be comparing different management actions, differenty hydrologic assumptions, or different water demand assumptions. 

Results are reported as "percent of traces". Each "trace" is a single unique simulation for one particular scenario. Reporting percent of traces makes it appropriate to compare scenarios with a different number of simulations, and this can commonly be though of as the probability of an event occurring. 

## Instructions

#### <span style='color:red'>Please alow aproximately 30 seconds for the data to initially load after clicking to the first plot page.</span>

### Percentile Plot page
1. Familiarize yourself with the range of storage and elevations for the two reservoirs by looking at different percentiles.
1. Select which scenarios you want to compare, the reservoirs, and the month to compare elevations for. The annual minimum elevation or annual maximum elevation can be selected rather than looking at a specific month. 
1. Select the percentiles and finally the years.

### Threshold Risks page

The thresholds risks page displays (1) the chances of a reeservoir falling below a given threshold in each year (plot) and (2) the percent of traces that fall below the threshold anytime during the time window (table). These types of figures are commonly used to understand the particular risk of reaching important reservoir elevations. Any threshold can be entered, but only certain ranges of numbers are applicable for each reservoir, depending on which variable is selected. These ranges are noted on the plot page.

## Future Work

As this project demonstrates the capabilities of using Shiny to viualize the simulation results, there are ample areas to expand this work. Several areas are described below.

* The variables could be expanded to include both more reservoirs, and addtional variables for each reservoir.
* More complex statistics could be added. For example, conditional chances: if the reservoir reaches _X_ elevation in year 1, what are the chances it reaches _Y_ elevation in year 2.
* The choices for most sliders, check boxes, etc. are currently "hard coded". Most of these should be made to be reacitve to the data set before being utilized in any real-world application.
    * The "Scenarios" selection is currently the only choices that are reactive to the data set.
