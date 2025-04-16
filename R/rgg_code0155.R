# A list of popular names for colors from packages
# RColorBrewer, colorRamps, grDevices
# 7 07 2009
#
# this figure is taken from the book
# ,,Przewodnik po pakiecie R''  http://www.biecek.pl/R/R.pdf
# author: Przemyslaw Biecek,    przemyslaw.biecek(at)gmail.com

library(RColorBrewer)
library(colorRamps)

#
# make sure that output device is large enough
#
# png("colorNames.png",width=1600,height=1000)
layout(rbind(c(1,2), c(3,2)),widths=c(2,3.5),heights=c(2,1))

par(mar=c(0,5,1,0), cex.lab=1.4, cex.axis=1.4, cex.main=1.4, cex.sub=1.4)
display.brewer.all()
mtext("Color names for colors from the RColorBrewer package",3,line=-1,cex=2)


par(mar=c(0,0,0,0), cex.lab=1.4, cex.axis=1.4, cex.main=1.4, cex.sub=1.4)
colorNames = colors()
plot.new()
for (j in 1:60) {
        for (i in 1:11) {
          kolor = colorNames[(i-1)*60+j]
                rect(i/11,j/60,(i-1)/11,(j-1)/60,col=kolor)
                text((i-0.5)/11,(j-0.5)/60,kolor,col=ifelse(mean(col2rgb(kolor))<120,"white","black"))
        }
}
mtext("Color names for colors(grDevices)",3,line=-2,cex=2)


par(mar=c(3,0,3,0), cex.lab=1.4, cex.axis=1.4, cex.main=1.4, cex.sub=1.4)
plot.new()
mtext("Color names for grDevices and colorRamps packages",3,cex=2)

#
# this could be done in a more elegant way
#
colorLists = list(rainbow, heat.colors, terrain.colors, topo.colors, cm.colors, blue2red, blue2green, green2red, blue2yellow, cyan2yellow, magenta2green)

colorsSampels = NULL
for (i in seq_along(colorLists)) {
 colorsSampels[[i]] = colorLists[[i]](100)
}

for (i in 2:100) {
   for (j in seq_along(colorLists)) {
      rect(i/100,j/11 - 0.01,(i-1)/100,(j-1)/11,col=(colorsSampels[[j]])[i], border=NA)
   }
}
text(0.5,((1:11)-0.5)/11,c("rainbow(grDevices)", "heat.colors(grDevices)", "terrain.colors(grDevices)", "topo.colors(grDevices)", "cm.colors(grDevices)", "blue2red(colorRamps)", "blue2green(colorRamps)", "green2red(colorRamps)", "blue2yellow(colorRamps)", "cyan2yellow(colorRamps)", "magenta2green(colorRamps)"),cex=1.4, adj=c(0.5,0.5))

# dev.off()
