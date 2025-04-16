library(maps)
library(lattice)

# Number of different murder rate intervals.
nint=6

# Vector of murder rates for each state.
murder.rate.vec=state.x77[,5]

# Divide murder rate into nint (partially overlapping)
# intervals with approx. equal number of states in each.
murder.rate <- equal.count(murder.rate.vec, number = nint)

# Get the entire US map for use later.
us.map <- map("state", plot = FALSE, fill = TRUE)

# Calculate the range of the map (with extra margins).
xl <- extendrange(us.map$range[1:2])
yl <- extendrange(us.map$range[3:4])

# Plot a multi-panel map of all the states, and colour
# the states that have the selected murder rate.
print( xyplot(y~x | murder.rate, data = state.center, 
	xlim = xl, ylim = yl, scales = list(draw=FALSE), 
	aspect = "iso", 
	xlab = NULL, ylab = NULL, 
	strip = strip.custom(var.name="Murder rate", sep=": ", 
		strip.names=TRUE, strip.levels=TRUE),
	panel = function(..., subscripts) {
	  	# Plot the entire US map.
		panel.polygon(us.map$x,us.map$y) 
         
		# Select the states to plot.
		murder.states=map("state", regions=state.name[subscripts], 
			plot=FALSE, fill=TRUE) 
         
		# Plot the states.
		panel.polygon(murder.states$x, murder.states$y, 
		 	col = trellis.par.get("superpose.line")$col) 
    } ) )

