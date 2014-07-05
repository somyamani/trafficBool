% getF


load('F_10_5_4act');
eqns=T2{1};% T2 is a cell array of 1000 cells, each containing an equation
densF=zeros(1,1000);
v=vecdec2binarray(0:2^10-1,10);
for jj=1:1000

eqnF=eqns{jj};% the ii th equation is chosen
F=false(2^10);
for ii=1:2^10
c=v(:,ii);    
inp=[v;repmat(c,1,2^10)];
F(ii,:)=evBool2(inp, eqnF);
end
densF(jj)=sum(sum(F))/(length(F)^2);
disp(jj);


end