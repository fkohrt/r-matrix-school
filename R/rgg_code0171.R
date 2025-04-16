library(mapplots)
data(landings)
data(coast)
xlim <- c(-15, 0)
ylim <- c(50, 56)
xyz <- make.xyz(landings$Lon, landings$Lat, landings$LiveWeight, landings$Species)
col <- paste0(substring(rainbow(5),1,7), "70") # make colours transparent
basemap(xlim, ylim, main = 'Species composition of gadoid landings')
draw.shape(coast, col='cornsilk')
draw.barplot2D(xyz$x, xyz$y, xyz$z, width = 0.8, height = 0.4, col=col)
legend('topright', colnames(xyz$z), fill=col, bg='lightblue', inset=0.02)

# same with scaled grid cells
basemap(xlim, ylim, main = 'Species composition of gadoid landings')
draw.shape(coast, col='cornsilk')
draw.barplot2D(xyz$x, xyz$y, xyz$z, width = 0.8, height = 0.4, col=col, scale=T)
legend('topright', colnames(xyz$z), fill=col, bg='lightblue', inset=0.02)
