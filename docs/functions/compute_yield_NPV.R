#' compute annual yield NPV
#'
#' Function to compute yeild of different fruits as a function of annual temperature and precipitation
#' @param T annual temperature (C)
#' @param P annual precipitation (mm)
#' @param ts slope on temperature
#' @param tp slope on precipitation
#' @param intercept  (kg)
#' @param irr  Y or  N (default N)
#’ @param discount (default=0.02)
#’ @price price $ (default=2)
#' @return total yield in kg and NPV of yield


compute_yield_NPV = function(T, P, ts, tp, intercept, irr="N", discount=0.02, price=2)
  {
  
  if ((length(T) != length(P)) & (irr=="N") ) {
    return("annual precip and annual T are not the same length")
  }
  yield = rep(0, times=length(T))
  yieldnpv = rep(0, times=length(T))
  for (i in 1:length(T)) {
    if (irr=="N"){
      yield[i] = tp*P[i] + ts*T[i] + intercept
      yieldnpv[i] = compute_NPV(yield[i]*price, discount, i)
    }
    else {
      yield[i] = ts*T[i] + intercept
      yieldnpv[i] = compute_NPV(yield[i]*price, discount, i)
    }
  }  
  
  return(list(totalyield=sum(yield), profit=sum(yieldnpv)))
}