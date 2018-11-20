function z= GENCOST(F,B,FC)
k=0;
inx=F>0;

for i=1:4
    k=k+(F(i)*B(i,4)*FC)/1000 + inx(i)*B(i,3);
end

z=k;

end