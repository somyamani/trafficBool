% store rule numbers, [e,s,t]
rng('shuffle');
X=zeros(10,5);

actf=4;
actg=3;

for kk=1:10
    
xg=randi(50);
xf=randi(1000);

% decide on rules
% fusion
load(sprintf('F_10_5_%dact',actf));
eqns=T2{1};% T2 is a cell array of 1000 cells, each containing an equation
eqn=eqns(xf);% the xth equation is chosen
eqnF=eqn{1};
% budding
load(sprintf('G_10_5_%dact',actg));
eqnG=T2{xg};% T2 is 50 cells, each containing an equation


Nsys=10;
Nslice=10;
Ncomp=10;
numstates=1000;

cs=getcellstate_layer(Nsys,Nslice,Ncomp,numstates);% list of cell states for which fraction of e,s,t are to be checked
ves=vecdec2binarray(0:2^10-1,10);

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

X(kk,:)=[xg,xf,e,s,t];
disp(kk);
end