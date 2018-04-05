###########################################

#File Name : plot_experimental_design.R

#Date : 04-04-2018

#Author: Juan Garcia

#Email: jggarcia@sfu.ca

#Last Modified: mié 04 abr 2018 23:27:48 PDT

#Purpose:

#Modifications:

###########################################


A=read.table('designScaled128.txt')
names(A)=c('gamma','z_i','z_0','L','z_cut')

png('experimental_design128.png')
plot(A)
dev.off()
