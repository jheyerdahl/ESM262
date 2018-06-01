# parameter definitions

# baseline surge heights and associated return intervals
baseline.surge.by.return = c(0.13, 0.28, 0.48, 0.63, 0.83, 0.98)
return_intervals = c(1,2,5,10,25,50)
# turn into probability of surge
return.prob =  1/return_intervals

# build climate change scenarios

# names of scenarios - including baseline
scen.names = c("base","A1B1","A2","B1","B2")

# storm intensity increase per decade for each scenarios
ssf  = c(0,4.30, 3.60, 2.10, 3.60)
ssf.perdecade = ssf/10

# sea level rise per decade for each scenario
slr = c(0,0.59,0.51,0.38,0.43)
slr.perdecade = slr/10

# put together for climate scenario
climate.scenario = data.frame(slr=slr, ssf=ssf)
rownames(climate.scenario)=scen.names

# list of possible mangrove attenuation; assume all equally likely
mangrove.atten = c(0.1,0.4,0.7)

# decide on number (and names) of decades to look at
decades = c(90,00,10,20,30,50)
ndecades =  length(decades)
discount=0.02

#run the model
adaptation_comparison (baseline.surge.by.return, return.prob, climate.scenario,
                       mangrove.atten, decades, discount, plot.allK=T) 


