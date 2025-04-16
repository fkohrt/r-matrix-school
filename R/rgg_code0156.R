

par(cex.lab=1.4, cex.axis=1.4, cex.main=1.4, cex.sub=1.4)



layout(rbind(c(1,2,3), c(4,5,3)),widths=c(2,2,1),heights=c(2,2))



plot(c(1,3.5),c(1,6),col="white",xlab="",ylab="",main="lend=, ljoin=",xaxt="n",yaxt="n",cex.main=2.5)



lines(c(1.5,3),c(1,1),type="l",lwd=15,lend=0)

lines(c(1.5,3),c(2,2),type="l",lwd=15,lend=1)



lines(c(1,1.5,2),c(4,3,4),type="l",lwd=15,ljoin=0)

lines(c(1,1.5,2),c(4,3,4)+1,type="l",lwd=15,ljoin=1)

lines(c(1,1.5,2),c(4,3,4)+2,type="l",lwd=15,ljoin=2)

lines(c(1,1.5,2)+1.5,c(3,4,3),type="l",lwd=15,ljoin=0)

lines(c(1,1.5,2)+1.5,c(3,4,3)+1,type="l",lwd=15,ljoin=1)

lines(c(1,1.5,2)+1.5,c(3,4,3)+2,type="l",lwd=15,ljoin=2)

text(2.25,c(1.5,2.5,3.5,4.5,5.5),c("lend=0", "lend=1", "ljoin=0", "ljoin=1", "ljoin=2"),cex=2)





plot(c(0,3),c(0,3),col="white",xlab="",ylab="",main="xpd=, adj=",xaxt="n",yaxt="n",cex.main=2.5)

par(xpd=TRUE)

abline(3,-0.3)

par(xpd=FALSE)

abline(2.5,-0.3)

par(xpd=NA)

abline(3.5,-0.3)

text(2.3,c(2,2.5,3),c("xpd=FALSE", "xpd=TRUE", "xpd=NA"),cex=2)



text(0.9,  0.5,"text()\n adj=c(1,1)",adj=c(1,1),cex=2)

text(1.5,0.5,"text()\n adj=c(0.5,1)",adj=c(0.5,1),cex=2)

text(2.1,  0.5,"text()\n adj=c(0,1)",adj=c(0,1),cex=2)

text(0.9,  1.2,"text()\n adj=c(1,0.5)",adj=c(1,0.5),cex=2)

text(1.5,1.2,"text()\n adj=c(0.5,1)",adj=c(0.5,1),cex=2)

text(2.1,  1.2,"text()\n adj=c(0,0)",adj=c(0,0),cex=2)

points(c(0.9,1.5,2.1,0.9,1.5,2.1),c(0.5,0.5,0.5,1.2,1.2,1.2),pch=3,cex=2)





plot(c(1,3),c(1,10),col="white",xlab="",ylab="",main="",xaxt="n",yaxt="n",cex.main=2.5)

text(2,2,expression(cos(x)^2 + sin(x)^2),cex=2.5)

text(1.2,1.5,expression(ln(x/y)),cex=1.4)

text(2.7,1.1,expression(x^5 - 4*x^3),cex=1.8)

text(2.4,2.7,expression(exp(cos(x^2)-x)), cex=1.8)



mtext(side=2,adj=0.07,"expression()",line=1, cex=1.66)

mtext(side=2,adj=0.6,"axis()",line=1, cex=1.66)

mtext(side=2,adj=0.975,"legend()",line=1, cex=1.66)



legend("top", c(expression(x),expression(x^2),expression(x^3),expression(x^4)), fill=c("red","orangered","orange","yellow"),ncol=2,title="legend()",cex=2.5)



axis(4,0.5+seq(4,8,0.5))

axis(1,seq(1.5,2.8,0.3),pos=4.5,labels=c("przed","chwile przed","w trakcie","chwile po","po"), las=3, cex=2)

axis(2,5:8,las=1,pos=1.2,col="green",lwd=3, cex=2)



curve(4.6+(x-1.4)^1,1.4,2.8,add=T,lwd=3,col="red")

curve(4.6+(x-1.4)^2,1.4,2.8,add=T,lwd=3,col="orangered")

curve(4.6+(x-1.4)^3,1.4,2.8,add=T,lwd=3,col="orange")

curve(4.6+(x-1.4)^4,1.4,2.8,add=T,lwd=3,col="yellow")





plot(c(-1,1),c(-1,1),col="white",xlab="",ylab="",main="srt=",xaxt="n",yaxt="n",cex.main=2.5)



for(i in 0:17) {

	text(0.7*cos(pi*i/9),0.7*sin(pi*i/9),paste("srt =",i*20),srt=i*20,cex=2)

}





par(pin=c(4,3))

plot(c(10,20),c(0,10),col="white",xlab="",ylab="",main="",xaxt="n",yaxt="n",ylim=c(0,9.6),cex.main=2.5)

title(main="main - tytul wykresu",sub="sub - podtytul wykresu",xlab="xlab - etykieta osi x", ylab="ylab - etykieta osi y",cex.lab=1.8,cex.main=1.8,cex.sub=1.8)

title(main="main, line=3",line=3, cex=1.5)

title(main="main, line=5",line=5, cex=1.5)

mtext("mtext(), adj=0.5 line=2",4,adj=0.5,line=2.5, cex=1.2)

mtext("mtext(), adj=1 line=3",4,adj=1,line=4.5, cex=1.2)

mtext("mtext(), adj=0 line=1",4,adj=0,line=0.5, cex=1.2)

mtext("side 1",1,col="red",line=-2,cex=2)

mtext("side 2",2,col="red",line=-2,cex=2)

mtext("side 3",3,col="red",line=-2,cex=2)

mtext("side 4",4,col="red",line=-2,cex=2)

text(13,3,"family\n serif",family="serif",cex=2)

text(17,3,"family\n sans",family="sans",cex=2)

text(13,7,"family\n mono",family="mono",cex=2)

text(17,7,"family\n symbol",family="symbol",cex=2)

