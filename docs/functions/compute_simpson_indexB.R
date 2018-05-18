compute_simpson_indexB = function(species) {
  
  # turn input vector of fishes into a factor
  species = as.factor(species)
  
  # use simple simpson form
  tmp = (summary(species)/sum(summary(species))) ** 2
  diversity = 1.0-sum(tmp)
  
  # return the value
  return(diversity)
}