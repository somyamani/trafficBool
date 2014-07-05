% read nc string, sorting string and build G from them

comp=['k' 'l' 'm' 'n' 'o' 'p' 'q' 'r' 's' 't'];
ves= ['a' 'b' 'c' 'd' 'e' 'f' 'g' 'h' 'i' 'j'];
fid=fopen('4_activators_budding.txt');
T=textscan(fid,'%s','delimiter',char(10));
T2=cell(50,1);% stores each of the 50 fomulae as a cell
for ii=1:50
% there are 3 coats
formula=[];
for jj=1:3
% 10 variables
dnf=T{1}{9*(ii-1)+jj*2+2}(17:end);
Ncstr=T{1}{9*(ii-1)+jj*2+1};
sorting=[];
for kk=1:10
srt=sprintf('Nc[%d]',kk-1);
if (Ncstr(strfind(Ncstr,srt)+length(srt))=='''')
x1=[comp(kk),'*',(Ncstr(strfind(Ncstr,srt):strfind(Ncstr,srt)+length(srt)))];
x2=[comp(kk),'''','+',(Ncstr(strfind(Ncstr,srt):strfind(Ncstr,srt)+(length(srt)-1)))];
else
x1=[comp(kk),'*',(Ncstr(strfind(Ncstr,srt):strfind(Ncstr,srt)+(length(srt)-1)))];
x2=[comp(kk),'''','+',(Ncstr(strfind(Ncstr,srt):strfind(Ncstr,srt)+(length(srt)-1))),''''];
end
x=['(',ves(kk),'''','+',x1,')','*','(',ves(kk),'+',x2,')'];
if kk>1
sorting=[sorting,'*',x];   
else
sorting=x;
end
end    
coati=['(',dnf,')','*',sorting];  
if jj>1
formula=[formula,'+',coati];
else
    formula=coati;
end
end    
T2{ii}=formula;
end