%----------------------------------------

%*File Name : GP_example.m

%*Date : 04-04-2018

%*Author: Juan Garcia

%*Email: jggarcia@sfu.ca

%*Last Modified: dom 08 abr 2018 12:37:02 PDT

%*Purpose:

%*Modifications:

%----------------------------------------

close all
clear all

A=readtable('inputOutputTableSource1.csv');

section=3;

cols=[3,4,6];
A=A(A{:,5}==-1,:);
A=A(A{:,2}==section,:);
data=A(:,cols);
data{:,1}=data{:,1}/0.4;
data{:,2}=data{:,2}/max(data{:,2});
data{:,3}=data{:,3}/max(data{:,3});

gprMdl=fitrgp(data,'deposition');

[x,y]=meshgrid(0:0.05:1);
X_new=[x(:) y(:)];

[yhat,~,ysd]=predict(gprMdl,X_new);

yhat=reshape(yhat,size(x));
ysd1=reshape(ysd(:,1),size(x));
ysd2=reshape(ysd(:,2),size(x));


plot3(data{:,1},data{:,2},data{:,3},'.','markerSize',50,'color','black');
hold on 
surf(x,y,yhat,'FaceColor','blue');
surf(x,y,ysd1,'FaceColor',[0 1 1]);
surf(x,y,ysd2,'FaceColor',[1 0 1]);

fontsize=24;
xlabel('\gamma','FontSize',fontsize);
ylabel('L','FontSize',fontsize);
zlabel('deposition','FontSize',fontsize);

title('GP regression for the Deposition','FontSize',fontsize);

legend({'Simulation data','GP prediction','Lower 95%','Upper 95%'},'FontSize',18);
