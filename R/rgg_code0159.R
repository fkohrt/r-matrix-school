library(IDPmisc)
require(SwissAir)
data(AirQual)

ipairs(AirQual[,c("ad.O3","lu.O3","sz.O3")],
       ztransf=function(x){x[x<1] <- 1; log2(x)})
