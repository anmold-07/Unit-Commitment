function z = FLAPC(A)

[temp, order] = sort(A(:,2)) ;
 z = A(order,:);

end