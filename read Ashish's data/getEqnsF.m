% decide on which expression to use ... choose randomly


var=['a','b','c','d','e','f','g','h','i','j','k','l','m','n','o','p','q','r','s','t'];


x=randi(1000);
load('G_10_5_2act');
eqns=T2{1};% T2 is a cell array of 1000 cells, each containing an equation

eqn=eqns(x);% the xth equation is chosen
eqn=eqn{1};

clauses=textscan(eqn,'%s','delimiter','+');% a cell array of cells, each containing a clause
clauses=clauses{1};

comp=rand(1,10)>0.5;
ves=rand(1,10)>0.5;

inp=[ves,comp];



for ii=1:length(clauses)
[C,ia,ib]=intersect(clauses{ii},var);% all variables in the clause
neg=find(clauses{ii}=='''')-1;% negative variables
[C2,ia2,ib2]=intersect(ia,neg);
pos=ia;
pos(ia2)=[];% positive variables

ev=prod(inp(pos))*prod(1-inp(neg));
if ev==1
    break;
end

end






