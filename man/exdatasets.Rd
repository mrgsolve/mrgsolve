% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/datasets.R
\docType{data}
\name{exdatasets}
\alias{exdatasets}
\alias{exidata}
\alias{extran1}
\alias{extran2}
\alias{extran3}
\alias{exTheoph}
\alias{exBoot}
\title{Example input data sets.}
\usage{
data(exidata)

data(extran1)

data(extran2)

data(extran3)

data(exTheoph)

data(exBoot)
}
\description{
Example input data sets.
}
\details{
\itemize{
 \item \code{exidata} holds individual-level parameters and other data items, one per row
 \item \code{extran1} is a "condensed" data set
 \item \code{extran2} is a full dataset
 \item \code{extran3} is a full dataset with parameters
 \item \code{exTheoph} is the theophylline data set, ready for input into \code{mrgsolve}
 \item \code{exBoot} a set of bootstrap parameter estimates

}
}
\examples{

mod <- mrgsolve:::house() \%>\% update(end=240) \%>\% Req(CP)

## Full data set
data(exTheoph)
out <- mod \%>\% data_set(exTheoph) \%>\% mrgsim
out
plot(out)

## Condensed: mrgsolve fills in the observations
data(extran1)
out <- mod \%>\% data_set(extran1) \%>\% mrgsim
out
plot(out)

## Add a parameter to the data set
stopifnot(require(dplyr))
data <- extran1 \%>\% distinct(ID) \%>\% select(ID) \%>\%
  mutate(CL=exp(log(1.5) + rnorm(nrow(.), 0,sqrt(0.1)))) \%>\%
  left_join(extran1,.)
  
data

out <- mod \%>\% data_set(data) \%>\% carry.out(CL) \%>\%  mrgsim
out
plot(out)

## idata
data(exidata)
out <- mod \%>\% idata_set(exidata) \%>\% ev(amt=100,ii=24,addl=10) \%>\% mrgsim
plot(out, CP~time|ID)
}
\keyword{datasets}
