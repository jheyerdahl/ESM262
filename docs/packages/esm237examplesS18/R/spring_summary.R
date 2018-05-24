
#' Summary information about spring climate
#'
#' computes summary information about spring temperature and precipitation
#' @param clim_data  data frame with columns tmax, tmin (C)
#'	rain (precip in mm), year, month (integer), day
#' @param months (as integer) to include in spring; default 4,5,6
#' @return returns a list containing, mean spring temperature (mean_springT, (C))
#' year with lowest spring temperature (coldest_spring (year))
#' mean spring precipitation (mean_springP (mm))
#' spring (as year) with highest precip (wettest_spring (year))


spring_summary = function(clim_data, spring_months = c(4:6), springout=FALSE) {

  spring = subset(clim_data, clim_data$month %in% spring_months)
  springT = (spring$tmax+spring$tmin)/2.0
  all.springT = aggregate(springT, by =list(spring$year), mean)
  mean_springT = mean(c(spring$tmax, spring$tmin))
  lowyear = spring$year[which.min(spring$tmin)]
  spring_precip = as.data.frame(matrix(nrow=unique(spring$year), ncol=2))
  colnames(spring_precip)=c("precip","year")

  spring_precip = aggregate(spring$rain, by=list(spring$year), sum)


  colnames(spring_precip) = c("year","precip")
  mean_spring_precip = mean(spring_precip$precip)
  wettest_spring = spring_precip$year[which.max(spring_precip$precip)]

  if (springout)
  return(list(mean_springT = mean_springT, coldest_spring=lowyear,
              mean_springP=mean_spring_precip,wettest_spring=wettest_spring,
			all.springP = spring_precip, all.springT = all.springT ))
  else
    return(list(mean_springT = mean_springT, coldest_spring=lowyear,
                mean_springP=mean_spring_precip,wettest_spring=wettest_spring ))

}
