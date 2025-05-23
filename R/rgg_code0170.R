library(maps)
library(maptools)
library(rgdal)

# need this for handling "paste" extra spaces
trim.trailing <- function (x) sub("\\s+$", "", x)

# read track data as plain lines so we can use the top 2 tag lines in the plot
# get track data from Unisys
trackData = readLines(url("http://weather.unisys.com/hurricane/atlantic/2012/SANDY/track.dat"))

# wrap the strings we just read in a textConnection so read.table can parse it
wx = read.table(textConnection(trackData), skip=3,fill=TRUE)

# join last two columns (type of storm) that read.table didn't parse as one
# and give the data frame real column names
wx$V7 = trim.trailing(paste(wx$V7,wx$V8," "))
wx$V8 = NULL
colnames(wx) = c("Advisory","Latitude","Longitude","Time","WindSpeed","Pressure","Status")

# just need strings, not levels
wx$Pressure = unlist(strsplit(toString(wx$Pressure),", "))

# annotate the name with forecast (+12/+24/etc) projections
wx$Advisory = unlist(strsplit(toString(wx$Advisory),", "))
wx$a = ""
wx$a[grep("\\+",wx$Advisory)] = wx$Advisory[grep("\\+",wx$Advisory)]
wx$Status = trim.trailing(paste(wx$Status,wx$a," "))

# cheap way to make past plots one color and forecast plots another
wx$color = "red"
wx$color[grep("\\+",wx$Advisory)] = "orange"

# find current readings (the one just before the forecast data)
currLoc = (grep("\\+",wx$Advisory)[1] - 1)

# curr location gets a black diamond
wx$color[currLoc] = "black"

# only want part of the map
xlim=c(-85,-60)
ylim=c(30,50)

# plot the map itself
map("state", interior = FALSE, xlim=xlim, ylim=ylim)
map("state", boundary = FALSE, col="gray", add = TRUE,xlim=xlim,ylim=ylim)

# Read & plot coarse state names
states = read.csv("http://dl.dropbox.com/s/8f9wv19w5j4l0st/states-capitols.csv")
text(x=states$Longitude,y=states$Latitude,states$State,col="#BFB093",cex=0.33,font=1,adj=c(1,0))

# plot the track with diamonds and colors
lines(x=wx$Longitude,y=wx$Latitude,col="black",cex=0.75)
points(x=wx$Longitude,y=wx$Latitude,col=wx$color,bg=wx$color,pch=23,cex=0.75)

# get the forecast "cone" from the KML that google's crisis map provides
# NOTE: you need curl & unzip (with funzip) on your system
# NOTE: Google didn't uniquely name the cone(s) they provide, so this will break
#       post-Sandy. I suggest saving the last KML & track files out out if you
#       want to save this for posterity. I'll try to make them work with the 
#       NHC KML files eventually, but those were tossing some errors and I've not
#       time to work through them right now.

# these get the cone(s) and makes them into strings that getKMLcoordinates can process

# 3-day cone
# this was originally using the Google data, but we have to use the static NHC data now which is on the 5-day cone
#coneKML3 = paste(unlist(system("curl -s -o - http://mw1.google.com/mw-weather/maps_hurricanes/three_day_cone.kmz | funzip", intern = TRUE)),collapse="")

# 5-day cone
# had to switch to the NHC code data
#coneKML5 = paste(unlist(system("curl -s -o - http://mw1.google.com/mw-weather/maps_hurricanes/five_day_cone.kmz | funzip", intern = TRUE)),collapse="")
coneKML5 = paste(unlist(system("curl -s -o - http://www.nhc.noaa.gov/storm_graphics/api/AL182012_031adv_CONE.kmz | funzip", intern = TRUE)),collapse="")

# process the coneKML and make a data frame (lat/long/elevation coords) out of it
coords = getKMLcoordinates(textConnection(coneKML5),ignoreAltitude=TRUE)
coords = data.frame(SpatialPoints(coords[1], CRS('+proj=longlat')))

# this plots the cone and leaves the track visible
polygon(coords$X1,coords$X2, pch=16, border="red", col='#FF000033',cex=0.25)

# process the coneKML and make a data frame (lat/long/elevation coords) out of it
#coords = getKMLcoordinates(textConnection(coneKML3))

# this plots the cone and leaves the track visible
#polygon(coords$X1,coords$X2, pch=16, border="red", col='#FF000033',cex=0.25)

# annotate it with the current & projects strength status + forecast
text(x=wx$Longitude,y=wx$Latitude,col='#0A2140',labels=wx$Status,adj=c(-.15),cex=0.4,font=2)

# Annotate with track file date & storm name
text(x=-84.5,y=49.5,trackData[1],col="#037F8C",cex=0.65,font=2,adj=c(0,0))
text(x=-84.5,y=49.0,trackData[2],col="#037F8C",cex=0.65,font=2,adj=c(0,0))

# Annotate with data at current position
text(x=-70.0,y=40.0,sprintf("Current Location: [%3.1f, %3.1f]",wx$Longitude[currLoc],wx$Latitude[currLoc]),col="#037F8C",cex=0.65,font=2,adj=c(0,0))
text(x=-70.0,y=39.5,sprintf("Wind Speed: %3d mph",wx$WindSpeed[currLoc]),col="#037F8C",cex=0.65,font=2,adj=c(0,0))
text(x=-70.0,y=39.0,sprintf("Pressure: %s mmHg",wx$Pressure[currLoc]),col="#037F8C",cex=0.65,font=2,adj=c(0,0))

# Annotate with plot date/time
text(x=-68.5,y=30.25,sprintf("Plotted at: %s",Sys.time()),col="#037F8C",cex=0.65,font=1,adj=c(0,0))

# no one puts Sandy in a box (well, we do)
box()

trackKML = paste(unlist(system("curl -s -o - http://www.nhc.noaa.gov/storm_graphics/api/AL182012_031adv_TRACK.kmz | funzip", intern = TRUE)),collapse="")

# process the coneKML and make a data frame (lat/long/elevation coords) out of it
coords = getKMLcoordinates(textConnection(trackKML),ignoreAltitude=TRUE)
coords = data.frame(SpatialPoints(coords, CRS('+proj=longlat')))

# this plots the cone and leaves the track visible
polygon(coords$X1,coords$X2, pch=16, border="red", col='#FF000033',cex=0.25)

