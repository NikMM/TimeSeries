library(Quandl)
library(xts)
library(forecast)
library(plyr)
library(dplyr)
library(dygraphs)
library(ggfortify)


quandl <- Quandl("BCB/7809", api_key="s-rT9xhVjJy4bu248N_U", 
                 start_date="2014-01-03", end_date=Sys.Date())
quandl$Date <- as.Date(quandl$Date, "%Y-%m-%d")

#quandl1 <- arrange(quandl, -row_number())
X <- as.xts(quandl[,-1], order.by = quandl$Date)
dowJ <-  na.locf(merge(X, seq(min(quandl$Date), max(quandl$Date), by = 1)))


tsPr2 <- dowJ


dow_ts = ts(rev(quandl[,2]), frequency = 253)
dow1_stl <-  stl(dow_ts, s.window = "periodic")


dow1 = data.frame(closing = dow_ts, lclosing = log(dow_ts)) 

difftimes = diff(dow_ts, differences =1)


