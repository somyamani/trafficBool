% e,s,t for budding and fusion rules made with boolean equations


Nsys=10;
Nslice=10;
Ncomp=10;
numstates=1000;

cs=getcellstate_layer(Nsys,Nslice,Ncomp,numstates);% list of cell states for which fraction of e,s,t are to be checked

ves=vecdec2binarray(0:2^10-1,10);
% decide on rules
% fusion
x=randi(1000);
load('F_10_5_3act');
eqns=T2{1};% T2 is a cell array of 1000 cells, each containing an equation

eqn=eqns(x);% the xth equation is chosen
eqnF=eqn{1};
% budding
x=randi(50);
load('G_10_5_2act');
eqnG=T2{x};% T2 is 50 cells, each containing an equation



e=0;
s=0;
t=0;
for ii=1:numstates
cs1=cs(ii,:);
comp=find(cs1);
compC=vecdec2binarray(comp-1,Nsys);
Gsub=bud_bool(compC,eqnG);
Fsub=fus_bool(compC,eqnF);
[cs2,typ]= update4(cs1,{Gsub},{Fsub},Nslice,Ncomp);
if typ{1}==1
    s=s+1;
elseif typ{1}==2
    t=t+1;
else
    e=e+1;
end

end
