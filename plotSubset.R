
readMyTable <- function()
{
  X <- read.table('trimData.txt',header = T)
  X
}

# X is datafram
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
    
    gg <- ggplot(X, aes(Year, Value, color = Scenario)) + geom_line(size=1)
    
    rr <- list()
    rr$plot <- gg
    rr$table <- xx
    rr
  }
}
