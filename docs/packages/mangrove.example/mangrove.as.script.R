
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

surge.damage.p1 = c(.1662, .1662-0.5*.1662, .1662+0.5*.1662)
GDP.per.decade = c(74487,131735,246193,399111,554739,726272,913712)

mangrove.atten = c(0.1,0.4,0.7)
sw.height = c(1,1.89,3)

decades = c(90,00,10,20,30,50)
ndecades =  length(decades)

discount=0.01

surge.noadapt = compute_climatebased_surge(baseline.surge.by.return, climate.scenario, ndecades)
surge.mangrove = mangrove_adjustment_to_surge(surge.noadapt, mean(mangrove.atten))

boxplot(surge.noadapt, surge.mangrove, names=c("No Adaption", "Mangrove"), ylab=c("Surge (m)"), col=c("blue","green"))

# look at sensitivity for different values of the mangrove attenuation coefficient
surge.mangroveK = array(dim=c(dim(surge.noadapt), length(mangrove.atten)))
for (i in 1:length(mangrove.atten)) {
surge.mangroveK[,,,i]= mangrove_adjustment_to_surge(surge.noadapt, mangrove.atten[i])
}

boxplot(surge.noadapt, surge.mangrove, surge.mangroveK, names=c("No Adaption", "Mangrove", "Mangrove-Many Ks"), ylab=c("Surge (m)"), col=c("blue","green","lightgreen"))

surge.mangrove.meanK = apply(surge.mangroveK, c(1,2,3), mean)

boxplot(surge.noadapt, surge.mangrove, surge.mangroveK, surge.mangrove.meanK,
names=c("No Adaption", "Mangrove\nMeanK", "Mangrove\nMany Ks","Mean Mangrove"), ylab=c("Surge (m)"), col=c("blue","green","lightgreen","lawngreen"))


# lets say we only wanted to look at  first climate scenario but separate out different mangrove types

boxplot(as.vector(surge.noadapt[,,1]), surge.mangroveK[,,1,1], surge.mangroveK[,,1,2], surge.mangroveK[,,1,3], names=c("No Adaption", "Mangrove 1","Mangrove 2", "Mangrove 3"), 
ylab=c("Surge (m)"), col=c("blue","green","lightgreen","lawngreen"))

# lets say we only wanted to look at  2nd decade all climate scenarios and mangrove with average K
boxplot(as.vector(surge.noadapt[,2,]), as.vector(surge.mangrove.meanK[,2,]), names=c("No Adaption", "Mangrove Mean K"), 
ylab=c("Surge (m)"), col=c("yellow","red"))

# compute damages
damages.noadapt = surge_to_damage(surge.noadapt, surge.min=0.2, base=10000, K=7000)
damages.mangrove.meanK = surge_to_damage(surge.mangrove.meanK, surge.min=0.2, base=10000, K=7000)
damages.mangrove.K = surge_to_damage(surge.mangroveK, surge.min=0.2, base=10000, K=7000)
boxplot(damages.noadapt, damages.mangrove.meanK, names=c("No Adaption", "Mangrove"), ylab="Damages ($1000s)", col=c("yellow","red"))

# estimate damages in each decade accounting for the probability of each surge height
MLE.damages.noadapt.bydecade = apply(damages.noadapt, c(2,3), weighted.mean, w=return.prob)*10
MLE.damages.mangrove.meanK.bydecade = apply(damages.mangrove.meanK, c(2,3), weighted.mean, w=return.prob)*10
MLE.damages.mangrove.K.bydecade = apply(damages.mangrove.K, c(2,3,4), weighted.mean, w=return.prob)*10
boxplot(as.vector(MLE.damages.noadapt.bydecade), as.vector(MLE.damages.mangrove.meanK.bydecade), 
MLE.damages.mangrove.K.bydecade, names=c("No Adaption", "Mangrove","All K Mangrove"), ylab="Damages ($1000s)", col=c("yellow","red","pink"))

# graph damages by decades
boxplot(t(MLE.damages.noadapt.bydecade), ylab="Damages ($1000s)", xlab="Decade", main="No Adaption")
# make prettier names
rownames(MLE.damages.noadapt.bydecade) = as.character(decades)
colnames(MLE.damages.noadapt.bydecade) = scen.names
rownames(MLE.damages.mangrove.meanK.bydecade) = as.character(decades)
colnames(MLE.damages.mangrove.meanK.bydecade) = scen.names
boxplot(t(MLE.damages.noadapt.bydecade), ylab="Damages ($1000s)", xlab="Decade", main="No Adaption")

# graph by climate scenario
boxplot((MLE.damages.noadapt.bydecade), ylab="Damages ($1000s)", xlab="Scenario", main="No Adaption")
boxplot((MLE.damages.mangrove.meanK.bydecade), ylab="Damages ($1000s)", xlab="Scenario", main="Mangrove")


# translate damages to NPV
damages.noadapt.NPV = MLE.damages.noadapt.bydecade
damages.mangrove.K.NPV = MLE.damages.mangrove.K.bydecade
damages.mangrove.meanK.NPV = MLE.damages.mangrove.meanK.bydecade

for (i in 1:length(decades))  {
	damages.noadapt.NPV[i,] = compute_NPV(MLE.damages.noadapt.bydecade[i,],discount=discount, time=10*(i-1))
	damages.mangrove.meanK.NPV[i,] = compute_NPV(MLE.damages.mangrove.meanK.bydecade[i,],discount=discount, time=10*(i-1))
		for (j in 1:length(mangrove.atten)) {
			damages.mangrove.K.NPV[i,,j] = compute_NPV(MLE.damages.mangrove.K.bydecade[i,,j],discount=discount, time=10*(i-1))
	}
}

# plot net present value by decade
boxplot(t(damages.noadapt.NPV), ylab="Damages ($1000s) - 2010 Dollars", xlab="Decade", main="No Adaption")
boxplot(t(damages.mangrove.meanK.NPV), ylab="Damages ($1000s) - 2010 Dollars", xlab="Decade", main="Mangrove")

total.damage.noadapt.NPV = apply(damages.noadapt.NPV, c(2), sum)	
total.damage.mangrove.meanK.NPV = apply(MLE.damages.mangrove.meanK.bydecade, c(2), sum)	
total.damage.mangrove.K.NPV = apply(MLE.damages.mangrove.K.bydecade, c(2,3), sum)	

# plot total damages (NPV) by climate scenario
barplot(total.damage.mangrove.meanK.NPV, ylab="Total Damage Estimate - With Adaptation")

# now for all options
barplot(rbind(total.damage.noadapt.NPV ,total.damage.mangrove.meanK.NPV), beside=T, col=c("blue","red"))
legend("topright", legend=c("no adapt","mangrove"), col=c("blue","red"), pch=22)

# or include climate scenario in a box plot
boxplot(total.damage.noadapt.NPV, total.damage.mangrove.meanK.NPV, total.damage.mangrove.K.NPV,
names=c("No Adaption", "Mangrove","All K Mangrove"), ylab="Damages ($1000s)", col=c("blue","red","pink"))

mean(total.damage.noadapt.NPV)
mean(total.damage.mangrove.meanK.NPV)
mean(total.damage.mangrove.K.NPV)


