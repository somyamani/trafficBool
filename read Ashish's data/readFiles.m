fid=fopen('formulae');
T=textscan(fid,'%s','commentstyle','##','delimiter',{'[',']','F-matrix','G-matrix'});
% T=textscan(fid,'%s','commentstyle','##','delimiter',{'[',']'});

a=T{1}(3);% read whatever part of T (index) is required 

f2=a{1};

T2=textscan(f2,'%s','delimiter',',');

save('F_10_5_2act.mat','T2');% change filename according to what it contains