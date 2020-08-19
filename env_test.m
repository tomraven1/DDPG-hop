%global vel err
%vel=0;
%err=0;

ObservationInfo = rlNumericSpec([3 1]);
ObservationInfo.Name = 'Robot States';
ObservationInfo.Description = 'velx, posy, dens';


ActionInfo = rlNumericSpec([2 1],'LowerLimit',[pi/10 0 ]','UpperLimit',[pi/1.2 2 ]');
%ActionInfo = rlNumericSpec([2 1],'LowerLimit',[pi/3 0 ]','UpperLimit',[pi/1.5 2 ]');
ActionInfo.Name = 'CartPole Action';

%type myResetFunction.m
%type myStepFunction.m

env = rlFunctionEnv(ObservationInfo,ActionInfo,'myStepFunction','myResetFunction');

for i=1:5000
    
    act=rand(2,1).*[pi/1.2 - pi/10 ; 2]+ [pi/10;0];
    InitialObs = reset(env);
    [NextObs,Reward(i),IsDone,LoggedSignals] = step(env,act);
    act_all(:,i)=act;
    height(i)=NextObs(2);
    i
end

% 
for j=1:6
    hold on
    load (['rew_vel_0' num2str((j-1)*2) '.mat'])
    subplot(1,6,j)
    
    scatter(act_all(1,:),act_all(2,:),10,Reward*10,'filled')
    axis tight

    colormap('HSV')
end



