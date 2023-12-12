#This algorithm plots the results obtained with the simpleSimulator function. 

library(Deriv)

lineWidth <- 2

#Obtaining the data-frames for the drawing of the graphs.
#Severe constraint at step three with only two, instead of four, workers. All
#remaining steps are prolonged for the benefit of step three:
e3Df <- lapply(0:9, function(x) simpleSimulator(numberOfRepetitions = 1000,
                                                durationVerif = 10 + x/3,
                                                durationLabel = 10 + x/3,
                                                durationDisp = 10 - x,
                                                durationFinCheck = 10 + x/3,
                                                numberDispensers = 3)[1]) %>%
  bind_rows() %>%
  mutate(diffThroughpQueue = meanThroughput - meanQueue,
         propQueue = meanQueue/meanThroughput)

###################
#Drawing of curves:
plot(e3Df$durationFinCheck, e3Df$meanThroughput, col = 'grey', 
     type = 'l', lwd = 1,  ylim = c(0, 300), xlim = c(10, 13), 
     main = 'average throughput and queue times\n in process with initial bottleneck', 
     xlab = 'duration of steps 1, 2, and 4 in the process [minutes]', 
     ylab = 'mean throughput and waiting times [minutes]')
#Fitting polynomial model to the data:
throughputFitM <- lm(meanThroughput ~ poly(durationFinCheck, 
                                           degree = 5, 
                                           raw = TRUE), 
                     e3Df)
cTM <- coef(throughputFitM)
throughputFunctM <- function (x) cTM[1] + cTM[2] * x + cTM[3] * x^2 + 
  cTM[4] * x^3 + cTM[5] * x^4 + cTM[6] * x^5
xValues <- seq(10, 13, length.out = 20)
lines(xValues,
      throughputFunctM(xValues), 
      col = '#c133f5', lwd = lineWidth, lty = 'solid')
#Finding and highlighting the local minimum:
throughputFunctM1 <- Deriv(throughputFunctM) #first derivation of throughputFunctS
locMinTM <- uniroot(throughputFunctM1, interval = c(10, 13))$root[1]
abline(v = locMinTM, col = 'grey', lwd = 1, lty = 'dashed')
abline(h = throughputFunctM(locMinTM), col = 'grey', lwd = 1, lty = 'dashed')
#Waiting times:
lines(e3Df$durationFinCheck, e3Df$meanQueue, col = 'grey', lty = 'dashed')
#Fitting polynomial model to data:
waitingFitM <- lm(meanQueue ~ poly(durationFinCheck, 
                                        degree = 5, 
                                        raw = TRUE), 
                  e3Df)
cWM <- coef(waitingFitM)
waitingFunctM <- function (x) cWM[1] + cWM[2] * x + cWM[3] * x^2 + 
  cWM[4] * x^3 + cWM[5] * x^4 + cWM[6] * x^5
lines(xValues,
      waitingFunctM(xValues), 
      col = '#c133f5', lwd = lineWidth, lty = 'dashed')
#Finding and highlighting the local minimum:
waitingFunctM1 <- Deriv(waitingFunctM)
locMinWM <- uniroot(waitingFunctM1, interval = c(10, 13))$root[1]
abline(v = locMinWM, col = 'grey', lwd = 1, lty = 'dashed')
abline(h = waitingFunctM(locMinWM), col = 'grey', lwd = 1, lty = 'dashed')

####################################################

initialThroughputRed <- throughputFunctM(10) %>% round(digits = 1)
minThroughputRed <- throughputFunctM(locMinTM) %>% round(digits = 1)
percentReduction <- (100 - (throughputFunctM(locMinTM)/throughputFunctM(10)) *
                       100) %>% round(digits = 0)

resultDf <- data.frame(metric = c('minimum throughput time (purple)',
                                  'initial throughput time (purple)',
                                  'reduction of throughput time (purple)',
                                  'duration of steps 1, 2, and 4 at minimum (purple)'),
                       value = c(paste0(minThroughputRed %>% as.character(), ' min.'),
                                 paste0(initialThroughputRed %>% as.character(), ' min.'),
                                 paste0(percentReduction %>% as.character(), ' %'),
                                 paste0(locMinTM %>% round(digits = 1) %>% as.character(),
                                        ' min.'))
)

print(resultDf)




                        
