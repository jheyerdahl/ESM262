#' fisheries_summary
#'
#' return revenue and catch information for different locations
#' @param prices a table with price for each fish
#' @param catches a table with number of fish caught, location in columns, fish in rows
#' @param plot  plot results default FALSE
#' @return list with
#' \describe{
#' \item{dominant_fish_location}{dominant fish by location}
#' \item{revenue_location}{revenue by location}
#' \item{total}{ total revenue over all location}
#' \item{p}{ggplot plot}
#' }
fisheries_summary = function(prices, catches, plot=FALSE) {


   # turn into a data frame so that we can add a row of fish names
  catches = as.data.frame(catches)
  nloc = ncol(catches)
  # add the names
  catches$fish = rownames(catches)

  # here's one way
  dominant = catches$fish[apply(catches[,1:nloc],2, which.max)]


  # here's a way with a for loop
  dominant = rep(0, n=nloc)
    for (i in 1:nloc) {
      mxrow = which.max(catches[,i])
      dominant[i]=catches$fish[mxrow]

    }

  # lets add the location for reporting back to the user
   dominant = as.data.frame(dominant)
   dominant$location = colnames(catches[,1:nloc])

  # reorganize data
  catches_reordered = gather(catches, key="location", value="size", -fish)

  # add the prices
   catches_reordered = left_join(catches_reordered, prices)

  # calculate the revenue
   catches_reordered = catches_reordered %>% mutate(revenue = price*size)
   revenue_location = catches_reordered %>% group_by(location) %>% summarize_at(vars(revenue), sum)

  # total revenue
   totalr = sum(catches_reordered$revenue)

   if (plot) {
     lb = sprintf("The total revenue is %d dollars", totalr)
     p = ggplot(revenue_location, aes(location, revenue, fill=location))+geom_col()+
     labs(y="revenue in dollars")+annotate("text", x=2, y=60000, label=lb, col="red")
   }
   else p=NULL

  return(list(dominant_fish_location=dominant, revenue_location=revenue_location, totalr=totalr, plot=p))
}
