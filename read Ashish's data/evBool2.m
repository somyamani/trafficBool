% evaluate any boolean function
% inputs: inp: each column of inp is an input for the equation; eqn 
% output: row vector with evaluation of the equation at each input
function x= evBool2(inp, booleqn)
var=['a','b','c','d','e','f','g','h','i','j','k','l','m','n','o','p','q','r','s','t'];
x=ones(1,size(inp,2));


% first break into clauses
% apply evbool on each clause

f1=strfind(booleqn,'(');
f3=strfind(booleqn,'+');
if isempty(f1)==0
f2=strfind(booleqn,')');
f12=sort([f1,f2]);
f3n=repmat(f3',1,length(f12));
f12n=repmat(f12,length(f3),1);
numpar=sum(f3n-f12n>0,2);
div=[0,f3(mod(numpar,2)==0),length(booleqn)+1];% all boundaries of clauses ( '+'s, start and end of eqn)
else
div=[0,f3,length(booleqn)+1];% all boundaries of clauses ( '+'s, start and end of eqn)       
end

numclause=length(div)-1;

if numclause>1
   xclause=false(numclause,length(x));
for ii=1:numclause
ci=booleqn((div(ii)+1):(div(ii+1)-1));
xclause(ii,:)=evBool2(inp,ci)>0;
end
x=sum(xclause,1)>0;
else
% if only 1 clause found, proceed to evaluate it

while isempty(booleqn)==0
f1=find(booleqn=='(');
if isempty(f1)==0
f2=find(booleqn==')');
% when a '(' is hit, find the next ')' so that there are an even number of ( or ) inside and send this equation to evBool2 
f3=sort([f1(2:end),f2]);
f3n=repmat(f3,length(f2),1);
f2n=repmat(f2',1,length(f3));
numpar=find(mod(sum(f2n-f3n>0,2),1)==0,1);
eb=f2(numpar);
c=booleqn(1:f1(1)-2);
ev1=(evBool2(inp,booleqn(f1(1)+1:eb-1)));

else
    c=booleqn;     
    ev1=ones(size(x));
    eb=length(booleqn);
end
% find x for the eqn upto the first (
% split c again into the parts containing coat variables and those not
% containing coats
c1=c;
[ct sp ep]=regexp(c1,'Nc[\w*]','match','start','end'); % ct gives the identity of the coat, sp is the start pos, ep is the end pos
f=(c1(ep+1)=='''');% all negated coats
ep=ep+f;
% find the evaluation of the coat terms ... inputs for
% coat variables are all ones
% if any f, xc is all zeros
if any(f)
    xc=zeros(size(x));
else
    xc=ones(size(x));
end
removind=[];
for zz=1:length(sp)
removind=[removind,sp(zz):ep(zz)];
end
c([removind])=[];% all coats removed
[C,ia,ib]=intersect(c,var);% all variables in the clause
% here check for Nc variables
negat=find(c=='''')-1;% negative variables
[C2,ia2,ib2]=intersect(ia,negat);
pos=ib;
pos(ia2)=[];% positive variables
neg=ib(ia2);
if isempty(neg)
xn=ones(size(x));
else
xn=prod(1-inp(neg,:),1);
end

if isempty(pos)
xp=ones(size(x));
else
xp=prod(inp(pos,:),1);
end



x=x.*xp.*xn.*xc.*ev1;

booleqn(1:eb)=[];
end




end

