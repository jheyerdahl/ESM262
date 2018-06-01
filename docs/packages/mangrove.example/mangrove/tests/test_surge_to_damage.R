test_that("surge_to_damage_works", {
expect_that(surge_to_damage(0, 900,40,20), equals(0))
})

test_that("surge_to_damage_works", {
expect_that(surge_to_damage(100, 0,K=0,base=20), equals(20))
})

test_that("surge_to_damage_works", {
expect_that((surge_to_damage(1000, 900,40,20) < 0), is_true())
})

