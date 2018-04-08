%----------------------------------------

%*File Name : GP_explanation.m

%*Date : 04-04-2018

%*Author: Juan Garcia

%*Email: jggarcia@sfu.ca

%*Last Modified: dom 08 abr 2018 12:26:58 PDT

%*Purpose:

%*Modifications:

%----------------------------------------



close all;
clear all;

x_star=pi;
x=[0,0.5,0.7,pi/2,3*pi/2,5,5.5,6,2*pi];
y=sin(x);
z=zeros(size(x));



gp=fitrgp(x',y');


x_full=linspace(0,2*pi,100);
yhat=predict(gp,x_full');

[yhat_star,y_std]=predict(gp,x_star);
y_std=y_std*4.5;

prob_density=@(x) 1/(sqrt(2*pi)*y_std)*exp(-0.5*(x-yhat_star).^2./y_std^2);
z2=linspace(-1,1,100);



plot3(x,y,z,'.','MarkerSize',50,'Color','green');zlim([0,1]);xlabel('x');ylabel('y');
hold on;
plot3(x_full,yhat,0*yhat,'LineWidth',2,'Color','black');
plot3(x_star,sin(x_star),0,'*','MarkerSize',40);
m=max(prob_density(z2))*1.2;
plot3(0*z2+x_star,z2,prob_density(z2)/m,'LineWidth',2,'color','red');
grid on
%set(gca,'xtick',[]);
set(gca,'xticklabel',[]);
%set(gca,'ytick',[]);
set(gca,'yticklabel',[]);
%set(gca,'ztick',[]);
set(gca,'zticklabel',[]);
%ax=gca;
%ax.Visible='off';
title('Gaussian Process as Interpolator','FontSize',24)
legend({'Data','GP prediction','Test point','Gaussian at test point'},'FontSize',18);
whitebg('white');
