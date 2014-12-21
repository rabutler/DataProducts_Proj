library(reshape2)

readMyTable <- function()
{
  X <- read.table('fullData.txt',header = T)
  X
}

# qq is the quantiles to compute and plot
plotPercentiles <- function(X, scen, slot, res, month, qq, yy)
{

  if(length(scen) == 0 | length(qq) == 0){
    NULL
  } else{
    X <- X[X$Reservoir %in% res & X$Year %in% yy[1]:yy[2] & X$Scenario %in% scen,]  
    X <- X[X$Variable == slot,]
    if(month == 'MinAnn'){
      X <- ddply(X, .(Scenario,Trace,Year,Reservoir),summarize, Value = min(Value))
    } else if(month == 'MaxAnn'){
      X <- ddply(X, .(Scenario,Trace,Year,Reservoir),summarize, Value = max(Value))       
    } else{
      X <- X[X$Month == month,]
    }
    X <- ddply(X, .(Scenario,Reservoir,Year), function(x) quantile(x$Value, as.numeric(qq)))
    X <- melt(X, id.vars = .(Scenario,Reservoir,Year), measure.vars = 4:(length(qq)+3), 
              variable.name = 'Percentile')
    if(slot == 'Pool Elevation'){
      ff <- facet_grid(Reservoir~.,scales = 'free')
      uu <- '[feet]'
    } else{
      ff <- facet_grid(.~Reservoir)
      X$value <- X$value/1000000 # convert to MAF
      uu <- '[million acre-ft]'
    }
    gg <- ggplot(X, aes(Year, value, color = Percentile, linetype = Scenario)) + geom_line(size=1) +
        ff + ylab(uu) + 
          scale_x_continuous(minor_breaks = 1990:3000, breaks = 1990:3000) + 
          theme(panel.grid.minor = element_line(color = 'white', size = .6),
            panel.grid.major = element_line(color = 'white', size = .6))
   
   gg
  }
}

# X is dataframe
# slot is the a vector of strings to plot; will subset out of the slot heading
# of the data frame
# parameters to pass are scen, var,res , month, thresh, firstYear, lastYear
plotRisk <- function(X, scen, slot, res,month,thresh, yy)
{
  if(length(scen) == 0){
    NULL
  } else{
    # limit to correct reservoir, years, slot, and month
    tt <- thresh  
  
    X <- X[X$Reservoir %in% res & X$Year %in% yy[1]:yy[2] & X$Scenario %in% scen,]  
    X <- X[X$Variable == slot,]
    if(month == 'MinAnn'){
      X <- ddply(X, .(Scenario,Trace,Year,Reservoir),summarize, Value = min(Value))
    } else if(month == 'MaxAnn'){
      X <- ddply(X, .(Scenario,Trace,Year,Reservoir),summarize, Value = max(Value))       
    } else{
      X <- X[X$Month == month,]
    }
    X$Thresh <- thresh
    X <- ddply(X,.(Scenario,Trace,Year,Reservoir),summarize, vv = Value <= Thresh)
    xx <- ddply(X,.(Scenario,Trace,Reservoir),summarize,tt = max(vv))
    xx <- ddply(xx,.(Scenario,Reservoir),summarize,'Percent of Traces [%]' = mean(tt)*100)
    X <- ddply(X,.(Scenario,Year,Reservoir),summarize,Value = mean(vv) * 100)
    
    gg <- ggplot(X, aes(Year, Value, color = Scenario)) + geom_line(size=1) +
      ylab('[%]') +
      scale_x_continuous(minor_breaks = 1990:3000, breaks = 1990:3000) + 
      theme(panel.grid.minor = element_line(color = 'white', size = .6),
        panel.grid.major = element_line(color = 'white', size = .6))
    
    rr <- list()
    rr$plot <- gg
    rr$table <- xx
    rr
  }
}
