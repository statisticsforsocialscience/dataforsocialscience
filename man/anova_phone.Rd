% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/datasets.r
\docType{data}
\name{anova_phone}
\alias{anova_phone}
\title{A dataset containing artificial data to demonstrate variance of analysis visually}
\format{
An object of class \code{"data.frame"}
\describe{
\item{whatsapp}{How many whatsapp messages a user sends}
\item{textmessage}{How many text messages a users sends}
\item{phone}{What type of phone the user uses.}
\item{user}{The user name.}
\item{gender}{The gender of the user}
\item{age}{The age of the user.}
}
}
\source{
Data was self generated.
}
\usage{
data(anova_phone)
}
\description{
This data set contains the completely faked data on phone usage. It has nice properties for variance analyses.
}
\examples{
library(ggplot2)
\donttest{ggplot(anova_phone) + aes(phone, whatsapp, color = phone) +
       geom_point()}
}
\keyword{datasets}
