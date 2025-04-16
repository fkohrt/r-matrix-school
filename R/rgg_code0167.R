## box-and-whisker plot of FFT power spectrum by frequency/period
## vary these parameters -- r as per logistic map
## see http://en.wikipedia.org/wiki/Logistic_map for details
logmap = function(n, r, x0=0.5) { ret = rep(x0,n); for (ii in 2:n) {
ret[ii] = r*ret[ii-1]*(1-ret[ii-1])}; return(ret)}
rfrom = 3.4
rto = 3.7
rsteps=200
seqlen=1e4

require(plyr)
require(ggplot2)

mytimeseries = aaply(seq(from=rfrom, to=rto, length.out=rsteps), 1,
function(x) {
        logmap(seqlen, x)
})

## you can plug in any array here for mytimeseries
## each row is a timeseries
logspec = adply( mytimeseries, 1, function(x) {
        ## change spec.pgram parameters as per goals
        ret = spectrum(x, taper=0, demean=T, pad=0, fast=T, plot=F)
        return( data.frame(freq=ret$freq, spec=ret$spec))
})

## boxplot stats at each unique frequency
logspec.bw = ddply(logspec, 'freq', function(x) {
            ret = boxplot.stats(log10(x$spec));
            ## sometimes $out is empty, bind NA to keep dimensions correct
            return(data.frame(t(10^ret$stats), out=c(NA,10^ret$out)))
})

## plot -- outliers are dots
## be careful with spacing of hard returns -- ggplot has odd rules
## as close to default "spectrum" plot as possible

ggplot(logspec.bw, aes(x=1/(freq)))  +  geom_ribbon(aes(ymin=X1,
ymax=X5), alpha=0.35, fill='green')  +
        geom_ribbon(aes(ymin=X2, ymax=X4), alpha=0.5, fill='blue') +
geom_line(aes(y=X3))  +
        geom_point(aes(y=out), color='darkred') +
        scale_x_continuous( trans=c('inverse'), name='Period')  +
        scale_y_continuous(name='Power', trans='log10') +
        opts(title = 'Power Spectra: Boxplot Distribution of Coefficients')

