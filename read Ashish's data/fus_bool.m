% inputs: compartment  compositions (each column is a compartment composition), boolean formula for fusion (string)
% output: fusion rules for the compartment (row of the fusion matrix)



function f=fus_bool(comp, booleqn)
n=size(comp,1);
f=false(size(comp,2),2^n);
ves=vecdec2binarray(0:2^n-1,n);
for jj=1:size(comp,2)
inp=[ves;repmat(comp(:,jj),1,2^n)];
ev=evBool2(inp,booleqn);
f(jj,:)=ev;

end



