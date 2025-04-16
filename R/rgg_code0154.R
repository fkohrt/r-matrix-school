layout(rbind(c(1,2,3), c(4,5,3)),widths=c(2,2,1),heights=c(2,2))





plot(1,col="white",xlab="",ylab="",main="polygon()",xaxt="n",yaxt="n",type="n",xlim=c(0.5,7.5),ylim=c(-0.5,2.5),cex.main=2.5)

polygon(c(1,1:7,7),c(0,1,2,1,2,1,2,1,0),col="red",lwd=3)

polygon(c(1,7,7),c(0,0,1),col="yellow",lwd=3, angle=90, density=7)

polygon(c(1,7,7),c(0,0,1),col="yellow",lwd=3, angle=45, density=7)





plot(1,col="white",xlab="",ylab="",main="segments()",xaxt="n",yaxt="n",type="n",xlim=c(0,6),ylim=c(0,26),cex.main=2.5)

segments(1/(2:25),2:25,2 + 1/(25:2),25:2,heat.colors(24),lwd=3)

segments(2 + 1/(2:25),2:25,4-1/(2:25),2:25,rev(heat.colors(24)),lwd=3)

segments(4 - 1/(2:25),2:25,6-1/(2:25),25:2,rev(heat.colors(24)),lwd=3)





kol=rainbow(6)



plot(1,col="white",xlab="",ylab="",main="symbols()",xaxt="n",yaxt="n",type="n",xlim=c(0.5,1.5),ylim=c(0.5,6.5),cex.main=2.5)

symbols(0.8,1, circles=0.2,add=T, bg=kol[1], lwd=3, inches=F)

symbols(1.2,2, squares=0.3,add=T, bg=kol[2], lwd=3, inches=F)

symbols(0.8,3, rectangles=as.matrix(t(c(0.2,1)/2)),add=T, bg=kol[3], lwd=3, inches=F)

symbols(1.2,4, stars=as.matrix(t(c(0.5,0.1,0.5,0.1,0.5,0.1,0.5,0.1,0.5,0.1)/2)),add=T, bg=kol[4], lwd=3, inches=F)

symbols(0.8,5, thermometers=as.matrix(t(c(0.1,0.45,0.8))),add=T, bg=kol[5], lwd=3, inches=F)

symbols(1.2,6, boxplots=as.matrix(t(c(0.1,0.2,0.3,0.8,0.9))),add=T, bg=kol[6], lwd=3, inches=F)



text(c(1.2,0.8,1.2,0.8,1.2,0.8),1:6,c("circles","squares","rectangles","stars","thermometers","boxplots"),cex=1.8)







plot(1,col="white",xlab="",ylab="",main="arrows()",xaxt="n",yaxt="n",type="n",xlim=c(0.8,6.8),ylim=c(0.5,11),cex.main=2.5)

for (i in 1:10) {

	arrows(1,i,2+4*i^2/100,i,angle=(11-i)*3,lwd=3,length=i/10, code=1+(i%%3))

	arrows(6.5,1,2+4*i^2/100 + 0.5,i,angle=10,lwd=1,length=0.1+i/10)

}





plot(1,col="white",xlab="",ylab="",main="curve(), abline(), points(), lines()",xaxt="n",yaxt="n",type="n",xlim=c(-pi,pi),ylim=c(-pi,pi),cex.main=2.5)

arrows(c(-3,0),c(0,-3),c(3,0),c(0,3),lwd=3)

curve(sin,-pi,pi,add=T,lwd=3,col="red")

curve(cos,-pi,pi,add=T,lwd=3,col="green")

curve(tan,-pi/2,pi/2,add=T,lwd=3,col="blue")

abline(0,-1,lwd=3,lty=2,col="grey80")

abline(0,1,lwd=3,lty=2,col="grey80")

abline(1,0,lwd=3,lty=2,col="grey80")

abline(-1,0,lwd=3,lty=2,col="grey80")



points(3.2*cos(pi*(1:50)/25),3.2*sin(pi*(1:50)/25), pch=19)
