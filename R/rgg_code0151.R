
# a simple mixture of
# - N( 0, 1) with weight .4
# - N( 3, 1) with weight .6
x <- rnorm( 1000 , 
	mean = sample( c(0, 3), size = 1000, prob = c(.4, .6),  replace = TRUE ) ) 

# axis labels always horizontal
# margin smaller than default
par( las = 1, mar = c(3,3,4,1)+.1 )  

# calculate histogram (but do not display)
h <- hist( x, plot = FALSE, breaks = 15 )

# calculate density estimation
d <- density( x ) 

# just set the scene and axes
plot( h , border = NA, freq = FALSE, xlab = "", ylab = "", 
	main= "Use of clipping and translucency" ) 

# grab the limits of the region
usr <- par( "usr" )
ncolors <- 100
dy <- ( usr[4] - usr[3] ) / ncolors

# create the colors
colors <- colorRampPalette( c("yellow","orange","red") )(ncolors)

# horizontal line
abline( h = axTicks(2) , col = "gray", lwd = .5 )

# for each color, clip into a region and redraw the histogram with that color
for( i in 1:ncolors){
  clip( usr[1], usr[2], usr[3] + (i-1) * dy, usr[3] + i*dy )
  plot( h, add = TRUE, axes = FALSE, ylab = "", xlab = "", 
  	col = colors[i], border = NA, freq = FALSE)
}
# reset the clipping area. See ?clip
do.call( clip, as.list( usr) )

# just to get the boxes right
plot( h, add = TRUE, lwd = .5 , freq = FALSE, xlab = "", 
	ylab = "", axes = FALSE )

# adds a tick and translucent line to display the density estimate
lines( d, lwd = 4, col = "#22222288" )

# add a rug (also using translucency)
rug( x, col = "#00000088" ) 

# box around the plot
box()


