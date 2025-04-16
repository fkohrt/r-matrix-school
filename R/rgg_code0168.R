## Ben Bolker, 14 Nov 2011, with assistance from Baptiste Auguie

require(png)
require(grid)

## get background, convert it to colour matrix
download.file("http://upload.wikimedia.org/wikipedia/commons/e/e1/Tie-dye.png",
              dest="tiedye.png")
r <- readPNG("tiedye.png")
rmat <- matrix(rgb(r[,,1],r[,,2],r[,,3],alpha=0.4),
               nrow=dim(r)[1])

## generate rounded-corners mask
png("mask.png",width=ncol(r), height=nrow(r), res=1)
grid.roundrect(gp=gpar(fill="black"))
dev.off()
m <- readPNG("mask.png", native=FALSE)
mask <- matrix(rgb(m[,,1],m[,,2],m[,,3]),
               nrow=dim(m)[1])

## apply mask
rmat[mask == "#FFFFFF"] <- "#FFFFFF"

## function from Baptiste Auguie to generate 'shadowed' points in grid
shadow.points <- function(x, y, size=unit(1, "char"),
                          default.units="native", ...) {
 if(!is.unit(x)) {x <- unit(x, default.units) } 
 if(!is.unit(y)) { y <- unit(y, default.units) }
 grid::grid.points(x+0.2*size, y-0.2*size, size=size, gp=gpar(col="black"), pch=20) 
 grid::grid.points(x, y, size=size, default.units=default.units, ...)
} 

set.seed(101)

## 
grid.newpage()
pushViewport(plotViewport(),
             viewport(xscale=c(0, 10), yscale=c(0, 10)))
## background
grid.raster(rmat,x=unit(0,"native"),y=unit(0,"native"),
            width=1,height=1,just=c(0,0))
## box
grid.roundrect()

## axes (short to avoid filling corners)
grid.xaxis(at=seq(2,8,by=2))
grid.yaxis(at=seq(2,8,by=2))

## points
shadow.points(x=rnorm(10,mean=5),y=rnorm(10,mean=5),pch=20,
            gp=gpar(col="cyan"))

