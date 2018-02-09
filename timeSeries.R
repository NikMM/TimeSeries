library(Quandl)


quandl <- Quandl("BCB/7809", api_key="s-rT9xhVjJy4bu248N_U", 
                 start_date="2010-01-03", end_date=Sys.Date())
quandl$Date <- as.Date(quandl$Date, "%Y-%m-%d")

#quandl1 <- arrange(quandl, -row_number())
X <- as.xts(quandl[,-1], order.by = quandl$Date)
dowJ <-  na.locf(merge(X, seq(min(quandl$Date), max(quandl$Date), by = 1)))
