library(beeswarm)
library(ggplot2)
library(plyr)
data(breast)
beeswarm <- beeswarm(time_survival ~ event_survival, 
                     data = breast, method = 'swarm', 
                     pwcol = ER)[, c(1, 2, 4, 6)]
colnames(beeswarm) <- c("x", "y", "ER", "event_survival") 


beeswarm.plot <- ggplot(beeswarm, aes(x, y)) +
  xlab("") +
  scale_y_continuous(expression("Follow-up time (months)"))
beeswarm.plot2 <- beeswarm.plot + geom_boxplot(aes(x, y,
                                                   group = round_any(x, 1, round)), outlier.shape = NA)
beeswarm.plot3 <- beeswarm.plot2 + geom_point(aes(colour = ER)) +
  scale_colour_manual(values = c("black", "red")) + 
  scale_x_continuous(breaks = c(1:2), 
                     labels = c("Censored", "Metastasis"), expand = c(0, 0.5))
