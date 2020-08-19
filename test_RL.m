len=60;
simOptions = rlSimulationOptions('MaxSteps',len);
global vel
global err
err=0;
vel=0;
global  ydim_all yevdim_all xtdim_all init
ydim_all=[];
yevdim_all=[];
xtdim_all=[];
init=0;
experience = sim(env,agent,simOptions);

action=squeeze(experience.Action.CartPoleAction.Data);
state=squeeze(experience.Observation.RobotStates.Data);
State=state(:,1);


% for i=1:len
% [a,ydim,junk,tedim,xtdim,yevdim,conv,c_step]=evalu(action(:,i),State(1),State(2),State(3),4);
% 
% [a,b]=findpeaks(ydim(1:end,3));
%   State(1)=ydim(b(1),2);
%     State(2)=ydim(b(1),3);
%     if i>1
%         ydim(:,1)=ydim(:,1)+ydim_all(end,1);
%         yevdim(:,1)=yevdim(:,1)+ydim_all(end,1);
%         xtdim(:,1)=xtdim(:,1)+ydim_all(end,1);
%     end
%     ydim_all=[ydim_all ; ydim(1:b(1),:)];
%      yevdim_all=[yevdim_all ; yevdim(1:2,:)];
%       xtdim_all=[xtdim_all ; xtdim(1,:)];
% end

%plotEvo(ydim_all,yevdim_all,xtdim_all)

% subplot(2,3,1)
% 
% plot(state(1,:))
% hold on
% yyaxis right
% plot(state(2,:))
% 
% subplot(2,3,4)
% 
% plot(action(1,:)*180/(pi/2))
% hold on
% yyaxis right
% plot(action(2,:))


% 
% h1=plot(ydim_all(:,1),ydim_all(:,3))
% hold on
% h11=plot(ydim_all2(:,1),ydim_all2(:,3))
% hold on
% grid on
% h2=plot(xtdim_all(),0,'ks');
% h3=plot(yevdim_all(:,1),yevdim_all(:,3),'rs');
% h2=plot(xtdim_all2(),0,'ks');
% h3=plot(yevdim_all2(:,1),yevdim_all2(:,3),'rs');
% for i=1:length(xtdim_all)
%     h3=line([xtdim_all(i) yevdim_all(2*i-1,1)],[0 yevdim_all(2*i-1,3)],'Color','red')
%     h3=line([xtdim_all(i) yevdim_all(2*i,1)],[0 yevdim_all(2*i,3)],'Color','black')
%         h3=line([xtdim_all2(i) yevdim_all2(2*i-1,1)],[0 yevdim_all2(2*i-1,3)],'Color','red')
%     h3=line([xtdim_all2(i) yevdim_all2(2*i,1)],[0 yevdim_all2(2*i,3)],'Color','black')
%     
% end
% legend([h1,h11],{'First','Second'})
