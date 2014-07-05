% inputs: compartment  compositions (each column is a compartment composition), boolean formula for budding (string)
% output: budding rules for the compartment (column of the budding matrix)



function g=bud_bool(comp, booleqn)
n=size(comp,1);
g=false(2^n,size(comp,2));

ves=vecdec2binarray(0:2^n-1,n);
for jj=1:size(comp,2)
inp=[ves;repmat(comp(:,jj),1,2^n)];
ev=evBool2(inp,booleqn);
g(:,jj)=ev';

end























