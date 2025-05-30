% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/model-within.R
\name{log_mlik_all}
\alias{log_mlik_all}
\title{Fit models and compute the log marginal likelihood for all clusters}
\usage{
log_mlik_all(
  membership,
  stdata,
  stnames = c("geometry", "time"),
  correction = TRUE,
  detailed = FALSE,
  ...
)
}
\arguments{
\item{membership}{Integer, character or factor vector indicating the cluster membership
for each spatial unit.}

\item{stdata}{A stars object with spatial-temporal dimensions defined in \code{stnames}, and
including predictors and response variables.}

\item{stnames}{The names of the \code{spatial} and \code{temporal} dimensions of the \code{stdata}
object.}

\item{correction}{Logical value indicating whether a correction for dispersion.}

\item{detailed}{Logical value indicating whether to return the INLA model instead of
the log marginal likelihood. The argument \code{correction} is not applied in this
case.}

\item{...}{Arguments passed to the \code{inla} function (eg. \code{family}, \code{formula} and \code{E}).}
}
\value{
A numeric vector containing the log marginal likelihood for each cluster or the
the fitted INLA model for each cluster when \code{detailed = TRUE}.
}
\description{
Fit the specified INLA model to each cluster and compute the log marginal likelihood
for each cluster specified in the membership vector.
}
\examples{


\donttest{
library(sfclust)
library(stars)

dims <- st_dimensions(
  geometry = st_sfc(lapply(1:5, function(i) st_point(c(i, i)))),
  time = seq(as.Date("2024-01-01"), by = "1 day", length.out = 3)
)
stdata <- st_as_stars(
  cases = array(rpois(15, 100 * exp(1)), dim = c(5, 3)),
  temperature = array(runif(15, 15, 20), dim = c(5, 3)),
  expected = array(100, dim = c(5, 3)),
  dimensions = dims
)

log_mlik_all(c(1, 1, 1, 2, 2), stdata,
  formula = cases ~ temperature, family = "poisson", E = expected)

models = log_mlik_all(c(1, 1, 1, 2, 2), stdata, detailed = TRUE,
  formula = cases ~ temperature, family = "poisson", E = expected)
lapply(models, summary)
}

}
