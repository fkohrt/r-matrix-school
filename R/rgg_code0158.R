library(IDPmisc)
require(SwissAir)
data(AirQual)

ilagplot(AirQual[,c("ad.O3")],set.lags = 1:4,
         ztransf=function(x){x[x<1] <- 1; log2(x)})
