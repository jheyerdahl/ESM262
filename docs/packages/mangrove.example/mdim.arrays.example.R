# soil moisture at points for 5 different farms
# and 4 different plots within each farm, 
# one from avocado, one from apple, one from orange
# one from almond - so 4 fruits

# store soil moisture at 2 depths 
# ( 25cm, 0.5m)

soilm = array(dim=c(5,4,2))
dim(soilm)
soilm
for (i in 1:5) {
  for (j in 1:4) {
    value = runif(min=0.2,max=0.5,n=2)
    soilm[i,j,]=value
  }
}
soilm


# overall whole area and all depths
# easiest!
averagesoilm = mean(soilm)
averagesoilm

#lets say we want to keep the grid, but average 
# over the two depths - average over the 3rd dimension

averagegrid = apply(soilm, c(1,2),mean)
averagegrid

# now lets say we want to also find the average for each farm
# keep the first dimension (5-farms) but average over others
averagefarm = apply(soilm, c(1), mean)
averagefarm

# average by fruit
averagefruit = apply(soilm, c(2), mean)

# average by  soil moisture depth
averagedepth = apply(soilm, c(3), mean)

# you can use other functions as well
sumfruit = apply(soilm, c(2), sum)

# including your own!
isdrought = function(sm, thresh) {
  n = length(sm)
  drought=TRUE
  for (i in 1:n) {
    if (sm[i] > thresh) drought=FALSE
  }
  return(drought)
}
soilm
#local drought
apply(soilm, c(1,2), isdrought, thresh=0.4)

#farm drought
apply(soilm, c(1), isdrought, thresh=0.5)

#total area drought
isdrought(soilm, thresh=0.3)
isdrought(soilm, thresh=0.7)