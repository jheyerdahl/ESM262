# parameter definitions
baseline.surge.by.return = c(0.13, 0.28, 0.48, 0.63, 0.83, 0.98)
return_intervals = c(1,2,5,10,25,50)
return.prob =  1/return_intervals


ssf  = c(0,4.30, 3.60, 2.10, 3.60)
ssf.perdecade = ssf/10

slr = c(0,0.59,0.51,0.38,0.43)
slr.perdecade = slr/10
climate.scenario = data.frame(slr=slr, ssf=ssf)
scen.names = c("base","A1B1","A2","B1","B2")
rownames(climate.scenario)=scen.names
mangrove.atten = c(0.1,0.4,0.7)

decades = c(90,00,10,20,30,50)
ndecades =  length(decades)
discount=0.01

adaptation_comparison (baseline.surge.by.return, return.prob, climate.scenario,
                       mangrove.atten, decades, discount, plot.allK=T) 
  
