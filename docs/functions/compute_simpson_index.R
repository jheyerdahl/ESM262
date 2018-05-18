compute_simpson_index = function(species) {
  
  # turn input vector of fishes into a factor
  species = as.factor(species)
  
  # compute top 
  # first do (n*(n-1))
  # note how R does matrix multiplication
  top = (summary(as.factor(species))-1)*summary(as.factor(species))
  # now sum
  top = sum(top)
  
  # compute bottom
  bot = sum(summary(species))
  bot = bot*(bot-1)
  # compute the simpson index
  
  diversity = 1.0 - top/bot
  
  # return the value
  return(diversity)
}