#Loading required Packages

install.packages("xts")
install.packages("zoo")
install.packages("TTR")
install.packages('quantmod')
install.packages("broom")

library(xts)

library(zoo)
library(TTR)
library(quantmod)

library(ggplot2)
library(magrittr)

library(broom)

#set data and get data

start = as.Date("2020-01-01") 
end = as.Date("2021-01-22")

getSymbols(c("AAPL", "GOOGL", "MSFT","^GSPC"), src = "yahoo", from = start, to = end)

stocks = as.xts(data.frame(A = AAPL[, "AAPL.Adjusted"], B = GOOGL[, "GOOGL.Adjusted"], 
                           C = MSFT[, "MSFT.Adjusted"], E = GSPC[,"GSPC.Adjusted"]))

names(stocks) = c("Apple", "Google", "Microsoft","S&P 500")
index(stocks) = as.Date(index(stocks))

#plot1 without facet

stocks_series = tidy(stocks) %>% 
  
  ggplot(aes(x=index,y=value, color=series)) +
  labs(title = "Top Three US Tech Comany and S&P 500: Daily Stock Prices January 2020 - January 2021",
       
       subtitle = "End of Day Adjusted Prices",
       caption = " Source: Yahoo Finance") +
  
  xlab("Date") + ylab("Price") +
  scale_color_manual(values = c("Red", "Black", "DarkBlue","Orange"))+
  geom_line()

stocks_series


#plot2 with facet

stocks_series2 = tidy(stocks) %>% 
  
  ggplot(aes(x=index,y=value, color=series)) + 
  geom_line() +
  facet_grid(series~.,scales = "free") + 
  labs(title = "Top Three US Tech Comany and S&P 500: Daily Stock Prices January 2020 - January 2021",
                                              
                                              subtitle = "End of Day Adjusted Prices",
                                              caption = " Source: Yahoo Finance") +
  
  xlab("Date") + ylab("Price") +
  scale_color_manual(values = c("Red", "Black", "DarkBlue","Orange"))

stocks_series2



