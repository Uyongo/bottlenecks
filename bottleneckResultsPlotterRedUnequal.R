#This algorithm plots the results obtained with the simpleSimulator function. 

library(Deriv)

lineWidth <- 2

#Obtaining the data-frames for the drawing of the graphs. 
#Severe constraint at step three with only two, instead of four, workers. Only
#step four is prolonged for the benefit of step three:
f2Df <- lapply(0:9, function(x) simpleSimulator(numberOfRepetitions = 1000,
                                                durationDisp = 10 - x,
                                                durationFinCheck = 10 + x, 
                                                numberDispensers = 2)[1]) %>% 
  bind_rows() %>% 
  mutate(diffThroughpQueue = meanThroughput - meanQueue, 
         propQueue = meanQueue/meanThroughput)


###################
#Drawing of curves:
#Throughput times in scenario 1:
plot(f2Df$durationFinCheck, f2Df$meanThroughput, col = 'grey', 
     type = 'l', lwd = 1,  ylim = c(0, 300), xlim = c(10, 20), 
     main = 'average throughput (solid line) and queue (dashed \nline) times in process with initial bottleneck', 
     xlab = 'duration of fourth step in the process \n(time added above 10 min. is removed from third step) [minutes]', 
     ylab = 'mean throughput and waiting times [minutes]')
#Fitting polynomial model to the data:
throughputFitS <- lm(meanThroughput ~ poly(durationFinCheck, 
                                           degree = 5, 
                                           raw = TRUE), 
                     f2Df)
cTS <- coef(throughputFitS)
throughputFunctS <- function (x) cTS[1] + cTS[2] * x + cTS[3] * x^2 + 
  cTS[4] * x^3 + cTS[5] * x^4 + cTS[6] * x^5
xValues <- seq(10, 20, length.out = 20)
lines(xValues,
      throughputFunctS(xValues), 
      col = '#f5334a', lwd = lineWidth, lty = 'solid')
#Finding and highlighting the local minimum:
throughputFunctS1 <- Deriv(throughputFunctS) #first derivation of throughputFunctS
locMinTS <- uniroot(throughputFunctS1, interval = c(10, 20))$root[1]
abline(v = locMinTS, col = 'grey', lwd = 1, lty = 'dashed')
abline(h = throughputFunctS(locMinTS), col = 'grey', lwd = 1, lty = 'dashed')
#Waiting times in scenario 1:
lines(f2Df$durationFinCheck, f2Df$meanQueue, col = 'grey', lty = 'dashed')
#Fitting polynomial model to data:
waitingFitS <- lm(meanQueue ~ poly(durationFinCheck, 
                                        degree = 5, 
                                        raw = TRUE), 
                  f2Df)
cWS <- coef(waitingFitS)
waitingFunctS <- function (x) cWS[1] + cWS[2] * x + cWS[3] * x^2 + 
  cWS[4] * x^3 + cWS[5] * x^4 + cWS[6] * x^5
lines(xValues,
      waitingFunctS(xValues), 
      col = '#f5334a', lwd = lineWidth, lty = 'dashed')
#Finding and highlighting the local minimum:
waitingFunctS1 <- Deriv(waitingFunctS)
locMinWS <- uniroot(waitingFunctS1, interval = c(10, 20))$root[1]
abline(v = locMinWS, col = 'grey', lwd = 1, lty = 'dashed')
abline(h = waitingFunctS(locMinWS), col = 'grey', lwd = 1, lty = 'dashed')

###############################
initialThroughputRed <- throughputFunctS(10) %>% round(digits = 1)
minThroughputRed <- throughputFunctS(locMinTS) %>% round(digits = 1)
percentReduction <- (100 - (throughputFunctS(locMinTS)/throughputFunctS(10)) *
  100) %>% round(digits = 0)

resultDf <- data.frame(metric = c('minimum throughput time (red)',
                                  'initial throughput time (red)',
                                  'reduction of throughput time (red)',
                                  'duration of fourth step at minimum (red)'),
           value = c(paste0(minThroughputRed %>% as.character(), ' min.'),
                     paste0(initialThroughputRed %>% as.character(), ' min.'),
                     paste0(percentReduction %>% as.character(), ' %'),
                     paste0(locMinTS %>% round(digits = 1) %>% as.character(),
                            ' min.'))
           )

print(resultDf)



                        
