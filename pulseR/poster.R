library(pulseR)
# put math here
formulas <- MeanFormulas(
  total      = mu,
  labelled   = mu * (1 - exp(-d * 22)) * exp(-d * time),
  unlabelled = mu * (1 - exp(-d * time) * (1 - exp(-d * 22)))
)
# define the fractions
formulaIndexes <- list(
  total_fraction = 'total',
  pull_down      = c('labelled', 'unlabelled'))
lbNormFactors <- list(
  total_fraction = .1,
  pull_down      = c(.1,.00001))
ubNormFactors <- list(
  total_fraction = 10,
  pull_down      = c(10, .3))
opts <- setBoundaries(list(
  mu   = c(.1, 1e8),
  d    = c(1e-4, 9),
  size = c(1,1e6)),
  normFactors = list(lbNormFactors, ubNormFactors)
)
# let conditions be in a data.frame (sample, fraction, time)  
pd <- PulseData(counts, conditions, formulas, formulaIndexes,
  groups = ~ fraction + time)
result <- fitModel(pd, initParValues, opts)