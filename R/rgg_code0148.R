require( corrgram )

data(baseball)

vars2 <- c("Assists","Atbat","Errors","Hits","Homer","logSal",
           "Putouts","RBI","Runs","Walks","Years")

# Reverse diagonal, use points in lower part
corrgram(baseball[,vars2], order=TRUE, row1attop=FALSE,
         main="Baseball correlation ellipses",
         upper.panel=panel.ellipse, 
		 lower.panel=panel.pts, 
		 diag.panel=panel.minmax)
