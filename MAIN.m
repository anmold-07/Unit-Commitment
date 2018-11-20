function out = MAIN(para,func)
FC=para.FC;
F1=para.F1;
LP=para.LP;
k=para.k;
T=para.T;
TC=para.TC;
PCostFunction=func.PCostFunction;

%% SORTED FLAPC MATRIX:

B = FLAPC(F1);      %% Calling the function FLAPC to get a sorted matrix

POSS =  [ B(1,6)
          B(1,6)+B(2,6)
          B(1,6)+B(2,6)+B(3,6)
          B(1,6)+B(2,6)+B(3,6)+B(4,6)];     %% POSSIBILITY MATRIX
      
 %% GENERATOR INITILIZATION:
 
gen.p=[];
gen.t=[];
gen.TIME=[];
gen.c=[];
gen.p.pp=[];
gen.p.Pc=[];
gen.p.previous=[];
gen.p.new=[];
gen.p.Sc=[];
gen.p.Tc=[];
gen.p=repmat(gen.p, 4, 1);
gen=repmat(gen, T, 1);

%% MAIN LOOP: DYNAMIC AND FLAPC:

tempc=0;
o=0;

for i=1:T
    gen(i).c=o;
    gen(i).TIME=o+1;
    I=find(POSS>=LP(i));
    gen(i).t=POSS>=LP(i);     
   
    for j=1:length(I)
    
    switch(I(j)) 
        
        case 1
        gen(i).p(1).new=1;
        G1=LP(i);
        gen(i).p(1).pp=[G1 0 0 0];
        gen(i).p(1).Pc=GENCOST(gen(i).p(1).pp,B,2)+tempc;
        gen(i).p(1).previous=k;
        
        if gen(i).p(1).previous==gen(i).p(1).new
            gen(i).p(1).Sc=0;
        else 
            gen(i).p(1).Sc=TC;
        end
        gen(i).p(1).Tc=gen(i).p(1).Pc+gen(i).p(1).Sc;    
        
        case 2  
        gen(i).p(2).new=2;    
        G1=B(1,5);
        G2=B(2,5);
        temp=LP(i)-(G1+G2);        % LEFT OUT TO BE ALLOCATED
        temp1=B(1,6)-B(1,5);       % MAX CAPABILITY
        
        if temp1<temp
            G1=G1+temp1;
            temp2=(temp-temp1);    % LEFT OUT TO BE ALLOCATED
            temp3=B(2,6)-B(2,5);   % MAX CAPABILITY
            
            if temp3<temp2
                G2=G2+temp3;
                
            else 
                G2=G2+temp2;
            end    
            
        else 
            G1=G1+temp; 
        end
        gen(i).p(2).pp=[G1 G2 0 0];
        gen(i).p(2).Pc=GENCOST(gen(i).p(2).pp,B,FC)+tempc;
        gen(i).p(2).previous=k;
        
        if gen(i).p(2).previous==gen(i).p(2).new
            gen(i).p(2).Sc=0;
        else 
            gen(i).p(2).Sc=TC;
        end
        gen(i).p(2).Tc=gen(i).p(2).Pc+gen(i).p(2).Sc;   
        
        case 3
        gen(i).p(3).new=3; 
        G1=B(1,5);
        G2=B(2,5);
        G3=B(3,5);
        temp=LP(i)-(G1+G2+G3);      % LEFT OUT TO BE ALLOCATED
        temp1=B(1,6)-B(1,5);        % MAX CAPABILITY
            
        if temp1<temp
            G1=G1+temp1;
            temp2=(temp-temp1);     % LEFT OUT TO BE ALLOCATED
            temp3=B(2,6)-B(2,5);    % MAX CAPABILITY
            
            if temp3<temp2               
            G2=G2+temp3;
            temp4=(temp2-temp3);    % LEFT OUT TO BE ALLOCATED
            temp5=B(3,6)-B(3,5);    % MAX CAPABILITY
            
                if temp5<temp4
                G3=G3+temp5;
                
                else
                G3=G3+temp4;    
                end
                
            else
            G2=G2+temp2;
            end
            
        else
        G1=G1+temp;
        end
       gen(i).p(3).pp=[G1 G2 G3 0];
       gen(i).p(3).Pc=GENCOST(gen(i).p(3).pp,B,FC)+tempc;
       gen(i).p(3).previous=k;
       
       if gen(i).p(3).previous==gen(i).p(3).new
            gen(i).p(3).Sc=0;
        else 
            gen(i).p(3).Sc=TC;
       end    
       gen(i).p(3).Tc=gen(i).p(3).Pc+gen(i).p(3).Sc;   
       
        case 4
        gen(i).p(4).new=4;     
        G1=B(1,5);
        G2=B(2,5);
        G3=B(3,5);
        G4=B(4,5);
        temp=LP(i)-(G1+G2+G3+G4);   % LEFT OUT TO BE ALLOCATED
        temp1=B(1,6)-B(1,5);        % MAX CAPABILITY
            
        if temp1<temp
            G1=G1+temp1;
            temp2=(temp-temp1);     % LEFT OUT TO BE ALLOCATED
            temp3=B(2,6)-B(2,5);    % MAX CAPABILITY
            
            if temp3<temp2
            G2=G2+temp3;
            temp4=(temp2-temp3);    % LEFT OUT TO BE ALLOCATED
            temp5=B(3,6)-B(3,5);    % MAX CAPABILITY
            
               if temp5<temp4
               G3=G3+temp5;
               temp6=(temp4-temp5);   % LEFT OUT TO BE ALLOCATED
               temp7=B(4,6)-B(4,5);  % MAX CAPABILITY
               
                  if temp7<temp6
                  G4=G4+temp7;
                  else
                  G4=G4+temp6;
                  end
               
               else 
               G3=G3+temp4;
               end
               
            else
            G2=G2+temp2;
            end
            
        else
        G1=G1+temp;  
        end
                
        gen(i).p(4).pp=[G1 G2 G3 G4];
        gen(i).p(4).Pc=GENCOST(gen(i).p(4).pp,B,FC)+tempc;
        gen(i).p(4).previous=k;
        
        if gen(i).p(4).previous==gen(i).p(4).new
            gen(i).p(4).Sc=0;
        else 
            gen(i).p(4).Sc=TC;
        end
        gen(i).p(4).Tc=gen(i).p(4).Pc+gen(i).p(4).Sc;   
    end
   
    
    end
    [a,b,c,d]= gen(i).p.Tc;
    A=[a,b,c,d];
    
    if length(A)==4
        [tempc,order]=min(A);
       
        k=order;
        
    else if length(A)==3
        
        [tempc,order]=min(A);
        k=order+1;
        
     else if length(A)==2
            
        [tempc,order]=min(A);
        k=order+2;
        
         else if length(A)==1
        
        [tempc,order]=min(A);
        k=order+2;  
        
             end
         end
        end
    end
    
    
    out.gen=gen;
    o=o+1;
end

end





