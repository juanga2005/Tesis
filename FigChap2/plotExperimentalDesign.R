#Script to do the plots for the experimental design

library(DiceKriging)
xtrainGood=seq(0,1,by=0.25)
xtrainBad=c(0,0.1,0.2,0.3,1)


ytrainGood=cos(2*pi*xtrainGood)
ytrainBad=cos(2*pi*xtrainBad)

Xtest=seq(0,1,by=0.01)
ytrue=cos(2*pi*Xtest)
#Creating the GP
modelGood=km(design=data.frame(x=xtrainGood),response=data.frame(y=ytrainGood))#covtype='exp')#,nugget.estim=T)
modelBad=km(design=data.frame(x=xtrainBad),response=data.frame(y=ytrainBad))#,covtype='gauss',nugget.estim=T)

pGood=predict(modelGood,newdata=data.frame(x=Xtest),type='UK')
pBad=predict(modelBad,newdata=data.frame(x=Xtest),type='UK')

exact=expression(paste(M(x),'=',cos(2*pi*x)))
approx=expression(hat(M)(x))
jpeg('partitionComparison.jpg',width=1200,height=800)
par(mfrow=c(1,2))
#Good Plot
plot(xtrainGood,ytrainGood,pch=16,ylim=c(-1.7,2.1),lwd=2,cex=2,xlab='',ylab='')
lines(Xtest,pGood$mean,lwd=2)
lines(Xtest,pGood$upper95,lty=2,col='blue',lwd=2)
lines(Xtest,ytrue,lty=4,col='red',lwd=3)
lines(Xtest,pGood$lower95,lty=2,col='blue',lwd=2)
legend('topleft',c('Training Set',approx,exact,'95% Confidence Region'),pch=c(16,NA,NA,NA),
lty=c(NA,1,4,2),col=c('black','black','red','blue'),cex=1.5,lwd=2)
title(main='Interpolation Using a Maximin Design',xlab='x',ylab='y',cex.lab=1.5,cex.main=2)
#Bad Plots
plot(xtrainBad,ytrainBad,pch=16, ylim=c(-1.7,2.1),lwd=2,cex=2,xlab='',ylab='')
lines(Xtest,pBad$mean,lwd=2)
lines(Xtest,pBad$upper95,lty=2,col='blue',lwd=2)
lines(Xtest,ytrue,lty=4,col='red',lwd=3)
lines(Xtest,pBad$lower95,lty=2,col='blue',lwd=2)
legend('topleft',c('Training Set',approx,exact,'95% Confidence Region'),pch=c(16,NA,NA,NA),
lty=c(NA,1,4,2),col=c('black','black','red','blue'),cex=1.5,lwd=2)
title(main='Interpolation Using an Arbitrary Partition',xlab='x',ylab='y',cex.lab=1.5,cex.main=2)
dev.off()
