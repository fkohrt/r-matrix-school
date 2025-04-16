   

## Purpose: Display image profiles using R
## Image profiles are used in marketing to show
## the position of research objects related to
## items which are measured in pair of opposites
## the data mostly comes from questionaires
##
## This is a non-interactive version of a originally
## interactive R-script just to demonstrate the idea
## of the script
## The interactive scripts hve been developed as part
## of a marketing book. They are available free on
## the website http://www.reymann.eu
## Look for "Wettbewerbsanalysen" and the download files
## in the sections of the chapters
## The scripts are available in german only in the moment but
## if there is interest, I will produce english versions
## as well.
## The interactive scripts use csv-files for the input-data
## and ask for some details on the command-line
##
## (c) Detlev Reymann 2009
## detlev@reymann.eu
## last modified 01.02.2009
##
## The scripting is far away from being perfect, especially
## regarding the construction of the caption.
## Hints on improving the script are very welcome!

## Set the minimum and maximum values for the x-axis
Minimum <- 1;
Maximum <- 5;
## Highlight one of the lines
## usually the brand or enterprise the research is made for
Highlight <- 3;

## Data to be used,
## in the interactive version read from a csv-file
#############################################################
## first the values for the 11 items as a vector
Data <- matrix(c(1.5,2.0,3.0,3.7,4.1,2.5,4.0,5.0,2.8,4.2,2.5,1.2,2.6,1.4,4.0,4.3,1.6,4.0,3.5,2.4,4.8,1.6,4.8,3.7,2.0,3.9,2.7,1.6,3.8,1.3,4.7,2.6,4.3,2.6,1.3,2.4,1.1,4.1,2.1,4.8,1.2,1.6,1.4,3.6),4,11);
## the text describing the objects to be compared
Names <- c("Brand 1", "Brand 2", "Brand 3", "Brand 4");
## the text displayed on the left of the graph
TextLeft <- c("modern","expensive","exiting","interesting","complete","friendly","tasteful","rich in content","healthy","has taste","mediterranean");
## text displayed right
TextRight <- c("oldfashioned","cheap","boring","uninteresting","uncomplete","unfriendly","not tasteful","without content","unhealthy","has no taste","northern");
#############################################################
## output
## the interactive version asks whether output should be a
## png-, eps-, pdf-file or on the screen
##
## here only screen-output

###############################################################
## Now let us configure the graphics output
## 
## Outer margin:
par(oma=c(0, 0, 0, 0));
    
## letter size
# par(ps=14);   
    
## create new window for output
plot.new()

## first discover text largest in size to set dimensions
## for text and graph
j <- 1;
TextWidth <- 0;
while(length(TextLeft) > j) {
   if (strwidth(TextLeft[j]) > TextWidth) {
    TextWidth <-strwidth(TextLeft[j])
   }
   j <- j+1;
}
j <- 1;
while(length(TextRight) > j) {
   if (strwidth(TextRight[j]) > TextWidth) {
    TextWidth <-strwidth(TextRight[j])
   }
   j <- j+1;
}

## I found this multiplication factor just by trail and error
## has to be adjusted for longer text!!
TextWidth <- 30*TextWidth;

## Define area for drawing the graph
## Text is not part of the graph
## par(mar=c(bottom, left, top, right))
par(mar=c(0.5, TextWidth, 0.5, TextWidth));
        
## calculating the size for the caption
## three names in one line
lineHeigth <- 0.66
CaptionHeigth <- -((NROW(Names)%%3)+1)*lineHeigth;
plot.window(xlim=c(Minimum, Maximum), ylim=c(CaptionHeigth, length(TextLeft)))

## Set ticks for x-axis
ticks <- seq(Minimum, Maximum, 1);
    
## configure Y-axis
## first height
y <- 1:length(TextLeft);

## draw a dotted line for each item
segments(Minimum, y, Maximum, y, lty="dotted")

## now drawing the graph itself:
## a different symbol and color for each object
## first setting the initial values not to be black
Symbol <- 1;
Colour <- 2;
## because the base colour is black
par(pch=Symbol, col=Colour);
## Each point has to be drawn seperately and then to be
## connectet with lines
## otherwise we would have a standard graph x-axis orientated
Object <- 1;
## Object equals the brand, the enterprise, the person or whatever
## might be compared in the research
while(Object <= NROW(Data)) {
    ## in most cases we want one of the objects to be highlighted
    ## in the graph, my own brand, the reference object etc.
    if (Highlight == Object) par(lwd=3, lty="dashed")
    else par(lwd=1, lty=1);     
    ## draw lines and symbols for each object
    Column <- 1;    
    Value <- 0;
    ValueBefore <- 0;
    while(Column <= NCOL(Data)) {
        Value <- Data[Object,Column];
        points(Value, Column);
        if(Column > 1) {
            ## connect with lines   
            lines(c(ValueBefore, Value), c(Column-1, Column));      
        }
        Column <- Column+1;
        ValueBefore <- Value;
    }
    Symbol <- Symbol+1;
    Colour <- Colour +1;
    par(pch=Symbol, col=Colour);
    ## End for each object
    Object <- Object +1;
}
## reset colour and line-stile
par(pch=1, col=1, lty=1, lwd=1);

## Draw a line for the average/neutral value
NeutralValue <- (Maximum + Minimum)/2;
lines(c(NeutralValue, NeutralValue), c(1, NCOL(Data)));
    
## reset colour and line-stile
par(pch=1, col=1, lty=1, lwd=1);
## Display Text on the left
mtext(TextLeft, at=y, adj=1, side=2, las=2)
## Display Text on the right
mtext(TextRight, at=y, adj=0, side=4, las=2)
## draw x-achsis
par(cex.axis=0.5, mex=0.5)
axis(1, at=ticks, labels=abs(ticks), pos=0.5)
###########################################
## Caption
## This is really only a bad "hack"
## Would be very happy about improvements!
## any ideas from R-Professionals?
###########################################
par(ps=8);

Object <- 1;
Column <- 1;
## We print outside of the drawing area
## therefore negativ values:
if (NROW(Data) < 7) { Line <- -3 } else { Line <- -4};
## for each object
Symbol <- 1;
Colour <- 2;
par(col=Colour);
while(Object <= NROW(Data)) {
    mtext( Names[Object], side= 1, outer=TRUE, li= Line, adj= 0.025 + (Column-1)*0.4);
    Object <- Object + 1;
    Column <- Column +1;
    Symbol <- Symbol+1;
    Colour <- Colour +1;
    par(pch=Symbol, col=Colour);
    if(Column == 4) {
        Column = 1;
        Line <- Line + 1;
    }   
}
## Improvised seperating line
Line = -6
if (NROW(Data) < 7) Line <- Line +1
## reset colours to draw a black line
par(ps=24, pch=1, col=1, lty=1, lwd=1);
mtext( "_____________________________________________________________________________", side= 1, outer=TRUE, li= Line, adj= 0.05);
##
## that's it!

