%% COST CHARACTERISTICS, LOAD PATTERN AND GENERATOR REAL POWER LIMITS;
clear all
clc
func.PCostFunction=@(x) GENCOST(x);  
para.FC = 2;                      %% Fuel Cost
para.T=9;                         %% Total Time
para.TC=350;                      %% Transition Cost
para.k=2;                         %% Strating state 

%%        |Number |FLAPC| NO-LOAD |IHR| MIN | MAX |
para.F1 = [1    23.54     213   10440  25   80 
           2    20.34    585.62   9000   60   250
           3    19.74   684.74   8730   75   300
           4    28.00      252    11900  20   60]; 
       
       
%% Enter the load Pattern:
para.LP = [450; 530; 600; 540; 400; 280; 290; 500; 300]; 
out=MAIN(para,func);
gen=out.gen;

%% Plotting the solution: 

for i=1:para.T
    
    [a,b,c,d]= gen(i).p.previous;
    A=[a,b,c,d];
    hold on;
   
   plot(gen(i).c,A(2), 'k-o',...
        'MarkerSize',10,...
        'MarkerFaceColor','b',...
        'LineWidth',1.0) ;
     hold on;
    axis equal;
    %grid on;
    
[a,b,c,d]= gen(i).p.new;
 B=[a,b,c,d];
    
 
    for j=1:length(B)
     
    if A(2)~=B(j)
        
   plot(gen(i).c,B(j),'k-o',...
        'MarkerSize',10,...
        'MarkerFaceColor','w',...
        'LineWidth',1.0);
    hold on;
    end
    end
    
    xlabel('Time in Hour');
    ylabel('State Of the System');
    
    legend('Best State','Feasible States');
    axis equal;
    grid on;
    
end
 plot(0,1,'k-o',...
        'MarkerSize',10,...
        'MarkerFaceColor','w',...
        'LineWidth',1.0);
