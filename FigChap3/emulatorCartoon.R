#Script to do a cartoon of the process of emulation

library(DiceKriging)

Xtrain=seq(-1,1,length=6)
ytrain=-Xtrain^6+1.5*Xtrain^4+1
#ytrain=exp(-Xtrain^2)

xtest=seq(-1,1,by=0.01)
#y=-Xtest^3+1.5*Xtest+1
#y=exp(-Xtest^2)
y=-Xtest^6+1.5*Xtest^4+1

#Doing the fitting 

model=km(design=data.frame(x=Xtrain),response=data.frame(y=ytrain),nugget.estim=T)

p=predict(model,newdata=data.frame(x=Xtest),type='UK')



#points
loc=0
pM=1



#Here starts the plotting
jpeg('emulatorApproximation.jpg')#,height=800,width=1400)
plot(Xtest,y,type='l',lty=1,lwd=2,xaxt='n',yaxt='n',xlab='',ylab='',ylim=c(min(y)-0.1,max(y)))
title(main='Emulator Approximation',xlab='b',cex.lab=3)
title(ylab=expression(u(bold(x),b)),cex.lab=2,line=0)
#####################
lines(Xtest,p$mean,lty=2,lwd=2,col='red')
points(Xtrain,ytrain,pch=8,cex=2)
legend('bottomleft',c(expression(u(bold(x),b)),expression(hat(u)(bold(x),b)),'Training Set'),pch=c(NA,NA,8),lty=c(1,2,NA)
,col=c('black','red','black'))

axis(1,at=loc,labels=expression(tilde(b)))
points(0,1,pch=16,cex=1)
points(0,p$mean[100]-0.002,pch=15,col='red')


#Adding the arrows and text
arrows(0,1,0,1.1,length=0.1,lwd=2)
text(0,1.13,label=expression(paste(u(bold(x),tilde(b)))))

arrows(0,p$mean[100]-0.002,0,p$mean[100]-0.055,length=0.1,lwd=2,col='red')
text(0,p$mean[100]-0.075,label=expression(paste(widehat(u)(bold(x),tilde(b)))))
dev.off()
