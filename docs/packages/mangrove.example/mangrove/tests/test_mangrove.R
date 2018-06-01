
test_that("compute_climatebased_surge_works", {

slr = c(0,0,0)
ssf = c(0,0,0)
climate = as.data.frame(cbind(slr,ssf))
expect_that(max(compute_climatebased_surge(baseline.surge=c(10),climate, 3)),
	equals(10))
})
