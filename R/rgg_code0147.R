library(corrgram)
vars2 <- c("Assists","Atbat","Errors","Hits","Homer","logSal",
           "Putouts","RBI","Runs","Walks","Years")
corrgram(baseball[,vars2], order=TRUE,
         main="Baseball correlation ellipses",
         panel=panel.ellipse, text.panel=panel.txt, diag.panel=panel.minmax)
