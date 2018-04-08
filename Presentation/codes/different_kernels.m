%----------------------------------------

%*File Name : different_kernels.m

%*Date : 05-04-2018

%*Author: Juan Garcia

%*Email: jggarcia@sfu.ca

%*Last Modified: jue 05 abr 2018 11:41:25 PDT

%*Purpose:

%*Modifications:

%----------------------------------------


rng default;

close all;
clear all;


x=rand(1,10)';

x_new=linspace(0,1,100)';
x=sort(x);

y=sin(2*pi*x);




gpexp2=fitrgp(x,y,'KernelFunction','squaredexponential');
gpexp=fitrgp(x,y,'KernelFunction','matern52');
gpmattern=fitrgp(x,y,'KernelFunction','matern32');


yhatexp2=predict(gpexp2,x_new);
yhatexp=predict(gpexp,x_new);
yhatmattern=predict(gpmattern,x_new);

plot(x,y,'o','Color','r','MarkerSize',10);hold on;
plot(x_new,yhatexp2);
plot(x_new,yhatexp,'--k','LineWidth',2);
plot(x_new,yhatmattern,'--*b','MarkerSize',0.2);

set(gca,'FontSize',24)
xlabel('x');ylabel('y');title('Effect of Different Kernels on the Gaussian Process Interpolation');


legend({'Data','Squared Exponential','Matern5/2','Matern3/2'})
