download_Rcpp_releases <- function(){
    # download archived versions
    url <- "http://cran.r-project.org/src/contrib/Archive/Rcpp/"
    rx <- '^.*(Rcpp_.*?gz).*?right">([^\\s>]*?)\\s.*?right">\\s?([^>]*?)<.*$'
    lines <- readLines( url )
    archives <- gsub( rx, "\\1", grep( rx, lines, value = TRUE) )
    sapply( archives, function(.) download.file(sprintf( "%s%s" , url, .),.) )

    # download the last version
    download.file(
        "http://cran.r-project.org/src/contrib/Rcpp_0.8.9.tar.gz",
        "Rcpp_0.8.9.tar.gz" )

    invisible(NULL)
}
# uncomment to download
# download_Rcpp_releases()

getFiles <- function(){
    headers <- sapply(
        list.files( "Rcpp/inst/include", pattern = ".h$", recursive = TRUE, full = TRUE ),
        readLines )

    impl <- sapply(
        list.files( "Rcpp/src", pattern = ".c(pp)?$", recursive = TRUE, full = TRUE ),
        readLines )

    Rd <- sapply(
        list.files( "Rcpp/man", pattern = ".Rd$", recursive = TRUE, full = TRUE ),
        readLines )

    R <- sapply(
        list.files( "Rcpp/R", pattern = ".R$", recursive = TRUE, full = TRUE ),
        readLines )

    unit.tests <- if( file.exists( "Rcpp/inst/unitTests" ) ){
        sapply(
        list.files( "Rcpp/inst/unitTests", pattern = "(.R|.cpp)$", recursive = TRUE, full = TRUE ),
        readLines )
    }

    Rnw <- sapply(
        list.files( "Rcpp/inst/doc", pattern = ".Rnw$", recursive = TRUE, full = TRUE ),
        readLines )

    c( headers, impl, Rd, R, unit.tests )
}

archives <- list.files( pattern = "tar.gz$" )
version <- sub( "^.*_(.*)[.]tar.*$", "\\1", archives )
rx <- "(.*)[.](.*)[.](.*)$"
major <- as.numeric( sub( rx, "\\1", version ) )
minor <- as.numeric( sub( rx, "\\2", version ) )
release <- as.numeric( sub( rx, "\\3", version ) )
number <- major * 10000 + minor * 100 + release

nlines <- sapply( archives, function(x){
    system( sprintf( "tar zxf %s", x ) )

    allfiles <- getFiles()

    res <- sum( sapply( allfiles, length ) )
    unlink( "Rcpp", recursive = TRUE )
    res
})
names(nlines) <- version

releaseDate <- function(
    urls = "http://cran.r-project.org/src/contrib/Archive/Rcpp/",
    pattern = "" ){

    rx <- '^.*(Rcpp_.*?gz).*?right">([^\\s>]*?)\\s.*?right">\\s?([^>]*?)<.*$'
    data <- do.call( rbind, lapply( urls, function( url ){
        txt <- grep( rx, readLines( url ), value = TRUE, perl = TRUE )
        parts <- sub( rx, "\\1--\\2--\\3", txt, perl = TRUE )
        do.call( rbind, strsplit( parts, "--" ) )
    } ) )
    colnames( data ) <- c("version", "date", "size")

    data <- within( as.data.frame( data ), {
        version <- sub( "^Rcpp_(.*)[.]tar[.]gz.*$", "\\1", version )
        date    <- as.Date( date, format = "%d-%b-%Y" )
        size    <- local({
            K <- grepl( "K$", size)
            x <- numeric( length( size ) )
            x[ K ]  <- as.numeric(sub( "K", "", size[K] )) / 1024
            x[ !K ] <- as.numeric(sub( "M", "", size[!K] ))
            x
        } )
    } )
    data[ grepl( pattern, data$version ), ]
}
lct <- Sys.getlocale("LC_TIME"); Sys.setlocale("LC_TIME", "C")
releases <- rbind(
        releaseDate(),
        data.frame( version = "0.8.9", date = as.Date( "2010-11-28" ), size = 1.9 )
        )
dates <- releases$date

require( png )
png( "nlines_rcpp.png", width = 1000, height = 700 )
im <- readPNG( "sugar.png", native = TRUE )

plot( dates, nlines, type = "l", axes = FALSE, lwd = 10, col = "black",
    xlim = range(dates), xaxs = "i", xpd = NA, xlab = "", ylab = "" )
usr <- par()[["usr"]]
rasterImage( im,  min( dates), usr[3], max(dates), usr[4] )
abline( h = seq(0,70000, by = 5000), col = "gray" )
polygon(
    c(dates, rev(dates) ),
    c(nlines, rep(80000, length(nlines) ) ),
    col = "#FFFFFFDD" )
box()

lines( dates, nlines, lwd = 10, col = "black", xpd = NA )
lines( dates, nlines, lwd = 5, col = "orange", xpd = NA )

axis( side = 3, dates, names(nlines), las = 2 )
axis( side = 2, seq(0,70000, by = 5000), las = 2 )

years <- seq.Date( as.Date( "2008/01/01"), as.Date( "2011/01/01"), by = "year" )
text( years, rep(68000, length(years)), format( years, "%Y") , cex = 3, col = "gray", font = 2 )

months <- seq.Date( as.Date( "2008/01/01"), as.Date( "2011/01/01"), by = "month" )
axis( 1, months, substr( month.abb[ as.integer( format( months, "%m" ) ) ], 1, 1 ) )

dev.off()
