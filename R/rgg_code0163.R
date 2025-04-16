require(beeswarm)
data(breast)

beeswarm(time_survival ~ event_survival, data = breast,
        method = 'swarm',
        pch = 16, pwcol = as.numeric(ER),
        xlab = '', ylab = 'Follow-up time (months)',
        labels = c('Censored', 'Metastasis'))

boxplot(time_survival ~ event_survival,
        data = breast, add = T,
        names = c("",""), col="#0000ff22")
