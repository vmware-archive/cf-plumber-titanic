options(device='cairo')

library(plumber)
pr <- plumb("titanic-api.R")
PORT <- as.numeric( Sys.getenv('PORT') )
message (PORT)
pr$run(host="0.0.0.0",port=PORT)



