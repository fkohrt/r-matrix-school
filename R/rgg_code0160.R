## load required packages

library(IDPmisc)
library(SwissAir) # data for the example

## prepare the data

st <- 6.5*30*48
x.at <- seq(st,nrow(AirQual),48)

## draw graph

longtsPlot(
           y1 = AirQual[,c("ad.O3","ad.NOx")],
           y2 = AirQual$ad.T,
           names1 = c("O3","NOx"), names2 = "Temp",
           startP = st, upf = 3*48, fpp = 3,
           x.at = x.at, x.ann = substr(AirQual$start,1,6)[x.at],
           x.tick = seq(st,nrow(AirQual),12),
           y1.at = c(0,100), y1.tick = seq(0,150,50),
           y2.at = c(10,30), y2.tick = seq(10,30,10),
           y1lab="[ppb]", y2lab="[C]",
           y1lim = c(0,140), y2lim = c(10,30), xpd = TRUE,
           col2 = "red", type = "l",
           mar=c(1.2,3.2,1.2,3.2),main="2004-07-13 till 2004-07-22"
           )
