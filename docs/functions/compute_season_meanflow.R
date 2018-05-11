#' Compute seasonal mean flows
#'
#' This function computes winter and summer flows from a record
#’ @param str data frame with columns month and streamflow 
compute_seasonal_meanflow = function(str) {
  
  str$season = ifelse( str$month %in% c(1,2,3,10,11,12),"winter","summer")
  
  tmp = subset(str, str$season=="winter")
  mean.winter = mean(tmp$streamflow)
  
  tmp = subset(str, str$season=="summer")
  mean.summer = mean(tmp$streamflow)
  return(list(summer=mean.summer, winter=mean.winter))
}