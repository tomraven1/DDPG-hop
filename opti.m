rng(6454) 
global test_check
test_check=0;

ini=zeros(1,1);
 ini(1)=pi/2;

ub(1)=pi/1.1;
lb(1)=pi/20;
velx=randn*3;
posy=1+abs(randn*3);

for kk=1:10000
    tic
%  dens=abs(1-abs(randn/5));
if kk<10000
 % dens=0.001+rand/5;
 dens=1;
  %dens=0.001;
elseif kk<4000
     dens=0.5+rand/2;
else
    
    dens=rand;
end

velx=randn*3;
posy=1+abs(randn*3);

steps=2;


%options = gaoptimset('UseParallel',true,'FitnessLimit',0.0001);
f = @(x)evalu(x,velx,posy,dens,steps);
%options = gaoptimset('display','diagnose','Generations',10,'InitialPopulation',x(1:5),'UseParallel',true);
%[x,fval] = ga(f,1,[],[],[],[],lb,ub,[],options);


 options = optimoptions('patternsearch','Display','iter','UseParallel',true,'MaxIterations',30,'FunctionTolerance',0.0001);
 [x,fval] = patternsearch(f,ini,[],[],[],[],lb,ub,[],options);
fval
toc
[a,ydim]=evalu(x,velx,posy,dens,steps);
velxall(kk)=velx;
posyall(kk)=posy;
densall(kk)=dens;

xall(kk)=x;
fvalall(kk)=fval;

len=length(ydim);
kk
ydimall(1:len,1,kk)=ydim(:,1)';
ydimall(1:len,2,kk)=ydim(:,3)';

%ini=x;
end
% y=@(v) 8.58*v.^5-1.6*v.^4-6.1*v.^3+3.8*v.^2-4.8*v.^1-2.03*v.^0.1+7.1*v.^0.5+9.3;
% v1=0:0.001:1;
% plot(v1,y(v1))

%save new_data_human_dens.mat


