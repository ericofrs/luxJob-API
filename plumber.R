library(plumber)
library(tidyverse)
library(usethis)
source("auth_helper.R")

#* @apiTitle Basic Plumber API with Authentication
#* @apiDescription This is a simple API to demonstrate the use of plumber.
#* @apiVersion 1.0.0
#* @apiContact pierrick.kinif@datagrowth.io
#* @apiLicense MIT

#* Health check
#* @get /health
function() {
  list(status = "ok")
}

#* Echo the parameter that was sent in
#* @param msg:string  The message to echo back.
#* @get /echo
function(
    res,
    req,
    msg="type your message here"
){
  auth_helper(
    res,
    req,
    function() {
      list(msg = paste0("The message is: '", msg, "'"))
    }
  )
}

#* Plot out data from the iris dataset - without error handling
#* @param spec:string If provided, filter the data to only this species (e.g. 'setosa')
#* @get /plot
#* @serializer png
function(
    res,
    req,
    spec
){
  auth_helper(
    res,
    req,
    function() {
      title <- paste0("Only the '", spec, "' Species")
      myData <- subset(iris, Species == spec)
      plot(myData$Sepal.Length, myData$Petal.Length,
           main = title, xlab = "Sepal Length", ylab = "Petal Length")
    }
  )
}

# function(
#   res,
#   req,
#   spec
#   ){
#   auth_helper(
#     res,
#     req,
#     
#     # myData <- iris,
#     # title <- "All Species",
#     
#     # Filter if the species was specified
#     # if (!missing(spec)) {
#       title <- paste0("Only the '", spec, "' Species"),
#       myData <- subset(iris, Species == spec),
#     # }
#     plot(myData$Sepal.Length, myData$Petal.Length,
#          main = title, xlab = "Sepal Length", ylab = "Petal Length")
#   )
# }