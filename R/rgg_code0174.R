###Code for plotting scatterplots with smiley faces and rainbows or grumpy faces and rainclouds.

###Dodgy coding by Rob Knell 2013

###Loads the plotrix library. This is not part of the base R installation so you might need to install it.
require(plotrix)	

###Smile - draws your data plotted as smiley faces with a lovely rainbow in the background if you want it.
###Arguments: X,Y, two data vectors
###xlab  Label for x axis
###ylab  Label for y axis
###emotion defaults to "happy", other possible value is "grumpy"
###if emotion is happy then happy faces and a lovely rainbow, if it is grumpy then grumpy faces and dark clouds
###size  Relative size of faces
###face	 Colour of faces. Defaults to yellow.
###background   Background colour. Defaults to sky blue
###rainbow.gap  adjusts the gap between different colours of the rainbow. If it has gaps then make this smaller.
###rainbow.size adjusts the widths of the different colours of the rainbow. If it doesn't look right then fiddle with this a little too. 
### If you don't want a rainbow then set rainbow.size to zero.



smile <- function(X,Y,xlab="X",size=1,ylab="Y",emotion="happy",face="yellow",background="lightskyblue1",rainbow.gap=1,rainbow.size=1,cloud="grey35"){
	
  ####SET UP PLOT BACKGROUND
  
  
	plot(X,Y,type="n",axes="F",xlab=xlab,ylab=ylab)		###Draw graph without axes or data points
	
	lim <- par("usr")
	fig.dim<-par("fin")
	rect(lim[1],lim[3],lim[2],lim[4],border=background,col=background)   ###Draw a nice pretty background
	axis(1) ## add axes back
	axis(2)
	box()   ## and the plot frame
	rangeX<-lim[2]-lim[1]						###Range of X
	rangeY<-(lim[4]-lim[3])*fig.dim[1]/fig.dim[2]						###Range of Y
	
	
	if (emotion=="happy"){
    
    ####HAPPY RAINBOW
    
		poly<-lm(Y~X+I(X^2))						###Fit polynomial
		A<-poly$coefficients[1]						###Get the coefficients
		B1<-poly$coefficients[2]
		B2<-poly$coefficients[3]
		X1<-seq(lim[1],lim[2],length=200)			###Dummy X variable
		Y1<-A+B1*X1+B2*(X1^2)						###Predicted values
		points(X1,Y1+rangeY/50*3*rainbow.gap,type="l",lwd=rainbow.size*7,col="red")		###Draw the rainbow
		points(X1,Y1+rangeY/50*2*rainbow.gap,type="l",lwd=rainbow.size*7,col="orange")
		points(X1,Y1+rangeY/50*rainbow.gap,type="l",lwd=rainbow.size*7,col="yellow")
		points(X1,Y1,type="l",lwd=rainbow.size*7,col="green")
		points(X1,Y1-rangeY/50*rainbow.gap,type="l",lwd=rainbow.size*7,col="blue")
		points(X1,Y1-rangeY/50*2*rainbow.gap,type="l",lwd=rainbow.size*7,col="mediumpurple2")
		points(X1,Y1-rangeY/50*3*rainbow.gap,type="l",lwd=rainbow.size*7,col="purple")
	}
	
	if (emotion=="grumpy") {
		
    ####GRUMPY CLOUDS
    
		cloud1.x<-c(0.2,0.15,0.28,0.12,0.05,0.07,0.38,0,0.06)	#vector of adjustments for circle positions for x-coords of cloud 1
		cloud1.y<-c(0.5,0.48,0.46,0.55,0.53,0.59,0.45,0.55,0.44)	##vector of adjustments for circle positions for y-coords of cloud 1
		cloud1.radius<-c(0.08,0.07,0.05,0.08,0.06,0.09,0.03,0.12,0.05)    ##vector of adjustments for circle radius of cloud 1
		
		for (i in 1:length(cloud1.x)){
		draw.circle(lim[1]+rangeX*cloud1.x[i],lim[3]+rangeY*cloud1.y[i],radius=rangeX*cloud1.radius[i],col=cloud,border=cloud)}	#draw cloud 1
		cloud2.x<-c(0.94,0.8,0.85,0.72,0.65,0.54)	#vector of adjustments for circle positions for x-coords of cloud 2
		cloud2.y<-c(0.8,0.77,0.76,0.745,0.73,0.72)	##vector of adjustments for circle positions for y-coords of cloud 1
		cloud2.radius<-c(0.11,0.08,0.06,0.06,0.04,0.03)    ##vector of adjustments for circle radius of cloud 1
		
		for (i in 1:length(cloud2.x)){
		draw.circle(lim[1]+rangeX*cloud2.x[i],lim[3]+rangeY*cloud2.y[i],radius=rangeX*cloud2.radius[i],col=cloud,border=cloud)}	#draw cloud 2
		
    ####GRUMPY RAIN
    
    rainx1<-seq(lim[1],lim[1]+rangeX,length=40)*rnorm(40,1,0.05)   ###rain bottom left x coordinates
    rainy1<-runif(40,lim[3],lim[3]+rangeY)        ###rain bottom left y coordinates
    
    rainYlengths<-runif(40,0.05,0.3)*rangeY      ###change in y-variable for rain upper right coordinates
    
    rainx2<-rainx1+rainYlengths/1.5   ###Upper right rain coordinates
    rainy2<-rainy1+rainYlengths
    
    arrows(rainx1,rainy1,rainx2,rainy2,length=0,lwd=0.75)
    
	}
	
  if(emotion=="happy"){
  
	for(i in 1:length(X)){						###Draws the circles
		draw.circle(X[i],Y[i],radius=(rangeX/25)*size,col=face,border="black")
		points(X[i]+rangeX*size/45,Y[i]+rangeY*size/45,pch=16,cex=0.6*size)  ###Right eye
		points(X[i]-rangeX*size/45,Y[i]+rangeY*size/45,pch=16,cex=0.6*size)  ###Left eye
		draw.arc(X[i],Y[i],radius=(rangeX/40)*size,deg1=185,deg2=355,lwd=1.5*size)    ###Draw smile
	        }
	}

  
	
	if (emotion=="grumpy") 	{	##Draw grumpy eyes and eyebrows
    
	  for(i in 1:length(X)){
    
	  draw.circle(X[i],Y[i],radius=(rangeX/25)*size,col=face,border="black")  
		points(X[i]+rangeX*size/60,Y[i]+rangeY*size/60,pch=16,cex=0.6*size)	###Right eye
		points(X[i]-rangeX*size/60,Y[i]+rangeY*size/60,pch=16,cex=0.6*size)		###Left eye
   	arrows(X[i]+rangeX*size/45,Y[i]+rangeY*size/35,X[i]+rangeX*size/80,Y[i]+rangeY*size/40,lwd=1.5*size,length=0)     ##Right eyebrow
	  arrows(X[i]-rangeX*size/45,Y[i]+rangeY*size/35,X[i]-rangeX*size/80,Y[i]+rangeY*size/40,lwd=1.5*size,length=0)		 ##Left eyebrow
	  draw.arc(X[i],Y[i]-rangeY*size/22,radius=(rangeX/42)*size,deg1=50,deg2=130,lwd=1.5*size)  	###Draw grumpy mouth	
	  }
	}
  

}

X1<-runif(20,0,100)
Y1<-runif(20,0,100)
Y2<-2*X1-0.01*X1^2+rnorm(20,0,10)
# happy version : smile(X1,Y2,rainbow.gap=0.75)
# grumpy version: 
smile(X1,Y1,emotion="grumpy",face="green")
