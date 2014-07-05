% generate G using formula

densG=zeros(1,50);
v=vecdec2binarray(0:2^10-1,10);
for jj=1:50
    eqnG=T2{jj};
G=false(2^10);
for ii=1:2^10
c=v(:,ii);    
inp=[v;repmat(c,1,2^10)];
G(:,ii)=evBool2(inp, eqnG)';
end
densG(jj)=sum(sum(G))/(length(G)^2);
disp(jj);
end