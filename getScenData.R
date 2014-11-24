
#source('C:/alan/GeneralCode/getDataFromRdf.R')
source('C:/alan/GeneralCode/generalPlotting.R')
#source('C:/alan/CRSS/code/get5YrTable.R')
library(reshape2)
library(plyr)
library(ggplot2)
library(RWDataPlot)

# gather all necessary data into two files: 1 for monthly data, and the other for annualized
scenFolders = c('CRSS.Oct2014/Scenario/DNF,2007Dems,IG/',
	'CRSS.Oct2014/Scenario/VIC,2007Dems,IG/',
	'CRSS.DCP/Scenario/DNF,CT,IG,Baseline',
	'CRSS.DCP/Scenario/VIC_CT,CT,IG,Baseline')
newScenNum <- 1
scenNames = c('Baseline','Scenario A', 'Scenario B', 'Scenario C')
		
resPath = 'C:/alan/CRSS/'
dataPath = 'C:/alan/code/testShiny/'
#figPath = 'C:/alan/CRSS/CRSS.Oct2014/figs/'
#figTitle <- 'critStats_CRSSOct2014.pdf'
slotAggList <- 'C:/alan/code/testShiny/slotList.csv'
yy <- 2015:2026

# plot options
legLoc <- 'bottom'
legendTitle <- ''
nC <- 4 # number of columns in legend
yL <- c(0,100)

if(TRUE){
	# annual data
	print('getting annual data')
	flush.console()

	srA <- createSlotAggList(slotAggList)
	getDataForAllScens(scenFolders, scenNames, srA, resPath, paste(dataPath,'critStats.txt',sep = ''))
}
