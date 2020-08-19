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

%env = rlPredefinedEnv("CartPole-Continuous")


obsInfo = getObservationInfo(env);
numObservations = obsInfo.Dimension(1);
numObs=obsInfo.Dimension(1);
actInfo = getActionInfo(env);
numActions = actInfo.Dimension(1);
numAct=actInfo.Dimension(1);
%rng(0)
% 
% statePath = imageInputLayer([numObservations 1 1],'Normalization','none','Name','state');
% actionPath = imageInputLayer([numActions 1 1],'Normalization','none','Name','action');
% commonPath = [concatenationLayer(1,2,'Name','concat')
%              quadraticLayer('Name','quadratic')
%              fullyConnectedLayer(1,'Name','StateValue','BiasLearnRateFactor',0,'Bias',0)];
% 
% criticNetwork = layerGraph(statePath);
% criticNetwork = addLayers(criticNetwork,actionPath);
% criticNetwork = addLayers(criticNetwork,commonPath);
% 
% criticNetwork = connectLayers(criticNetwork,'state','concat/in1');
% criticNetwork = connectLayers(criticNetwork,'action','concat/in2');
% 
% criticOpts = rlRepresentationOptions('LearnRate',5e-3,'GradientThreshold',1);
% 
% critic = rlQValueRepresentation(criticNetwork,obsInfo,actInfo,'Observation',{'state'},'Action',{'action'},criticOpts);
% 
% actorNetwork = [
%     imageInputLayer([numObservations 1 1],'Normalization','none','Name','state')
%      fullyConnectedLayer(30,'Name','fc1')
%     reluLayer('Name','relu1')
%     fullyConnectedLayer(numActions,'Name','action','BiasLearnRateFactor',0,'Bias',0)];
% 
% actorOpts = rlRepresentationOptions('LearnRate',1e-04,'GradientThreshold',1);
% 
% actor = rlDeterministicActorRepresentation(actorNetwork,obsInfo,actInfo,'Observation',{'state'},'Action',{'action'},actorOpts);
% 
% agentOpts = rlDDPGAgentOptions(...
%     'SampleTime',1,...
%     'TargetSmoothFactor',1e-3,...
%     'ExperienceBufferLength',1e6,...
%     'DiscountFactor',0.9,...
%     'MiniBatchSize',32);
% agentOpts.NoiseOptions.Variance = 0.1;
% agentOpts.NoiseOptions.VarianceDecayRate = 1e-6;
% agent = rlDDPGAgent(actor,critic,agentOpts);
% 
% trainOpts = rlTrainingOptions(...
%     'MaxEpisodes', 5000, ...
%     'MaxStepsPerEpisode', 5, ...
%     'Verbose', false, ...
%     'Plots','training-progress',...
%     'StopTrainingCriteria','AverageReward',...
%     'UseParallel',true,...
%     'StopTrainingValue',455);
% 
%  trainingStats = train(agent,env,trainOpts);
 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% hiddenLayerSize = 50; 
% 
% observationPath = [
%     imageInputLayer([numObs 1 1],'Normalization','none','Name','observation')
%     fullyConnectedLayer(hiddenLayerSize,'Name','fc1')
%     reluLayer('Name','relu1')
%     fullyConnectedLayer(hiddenLayerSize,'Name','fc2')
%     additionLayer(2,'Name','add')
%     reluLayer('Name','relu2')
%     fullyConnectedLayer(hiddenLayerSize,'Name','fc3')
%     reluLayer('Name','relu3')
%     fullyConnectedLayer(1,'Name','fc4')];
% actionPath = [
%     imageInputLayer([numAct 1 1],'Normalization','none','Name','action')
%     fullyConnectedLayer(hiddenLayerSize,'Name','fc5')];
% 
% % create the layerGraph
% criticNetwork = layerGraph(observationPath);
% criticNetwork = addLayers(criticNetwork,actionPath);
% 
% % connect actionPath to obervationPath
% criticNetwork = connectLayers(criticNetwork,'fc5','add/in2');
% 
% criticOptions = rlRepresentationOptions('LearnRate',1e-03*10,'GradientThreshold',1,'UseDevice',"cpu");
% 
% critic = rlQValueRepresentation(criticNetwork,ObservationInfo,ActionInfo,...
%     'Observation',{'observation'},'Action',{'action'},criticOptions);
% 
% actorNetwork = [
%     imageInputLayer([numObs 1 1],'Normalization','none','Name','observation2')
%     fullyConnectedLayer(hiddenLayerSize,'Name','fc1')
%     reluLayer('Name','relu1')
%     fullyConnectedLayer(hiddenLayerSize,'Name','fc2')
%     reluLayer('Name','relu2')
%     fullyConnectedLayer(hiddenLayerSize,'Name','fc3')
%     reluLayer('Name','relu3')
%     fullyConnectedLayer(numAct,'Name','fc4')
%     tanhLayer('Name','tanh1')];
% 
% actorOptions = rlRepresentationOptions('LearnRate',1e-04*10,'GradientThreshold',1,'UseDevice',"cpu");
% 
% actor = rlDeterministicActorRepresentation(actorNetwork,ObservationInfo,ActionInfo,...
%     'Observation',{'observation2'},'Action',{'tanh1'},actorOptions);
% 
% agentOptions = rlDDPGAgentOptions(...
%     'SampleTime',1,...
%     'TargetSmoothFactor',1e-3,...
%     'ExperienceBufferLength',1e6 ,...
%     'DiscountFactor',0.9,...
%     'MiniBatchSize',512);
% agentOptions.NoiseOptions.Variance = 1e-1*10;
% agentOptions.NoiseOptions.VarianceDecayRate = 1e-6;
% 
% agent = rlDDPGAgent(actor,critic,agentOptions);
% 
% maxepisodes = 20000;
% maxsteps = 10;
% trainingOptions = rlTrainingOptions(...
%     'MaxEpisodes',maxepisodes,...
%     'MaxStepsPerEpisode',maxsteps,...
%     'StopOnError',"on",...
%     'Verbose',false,...
%     'Plots',"training-progress",...
%     'StopTrainingCriteria',"AverageReward",...
%     'StopTrainingValue',415,...
%     'ScoreAveragingWindowLength',10,...
%     'SaveAgentCriteria',"EpisodeReward",...
%     'UseParallel',true,...
%     'SaveAgentValue',415); 
% 
% trainingStats = train(agent,env,trainingOptions);
% 
% 
% simOptions = rlSimulationOptions('MaxSteps',10);
% experience = sim(env,agent,simOptions);
% 
% 
% 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% actorNetwork = [
%     imageInputLayer([numObservations 1 1],'Normalization','none','Name','state')
%     fullyConnectedLayer(30,'Name','fc1')
%     %tanhLayer('Name','tanh1')
%     fullyConnectedLayer(2,'Name','fc')
%     softmaxLayer('Name','actionProb')
%     ];
% 
% actorOpts = rlRepresentationOptions('LearnRate',1e-2*1,'GradientThreshold',1);
% actor = rlStochasticActorRepresentation(actorNetwork,obsInfo,actInfo,'Observation',{'state'},actorOpts);
% 
% %opt = rlPGAgentOptions('EntropyLossWeight',1);
% agent = rlPGAgent(actor);
% 
% trainOpts = rlTrainingOptions(...
%     'MaxEpisodes', 1000, ...
%     'MaxStepsPerEpisode', 5, ...
%     'Verbose', false, ...
%     'Plots','training-progress',...
%     'StopTrainingCriteria','AverageReward',...
%     'StopTrainingValue',1905,...
%     'ScoreAveragingWindowLength',1000); 
% trainingStats = train(agent,env,trainOpts);
% simOptions = rlSimulationOptions('MaxSteps',10);
% experience = sim(env,agent,simOptions);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

statePath = [
    imageInputLayer([numObs 1 1],'Normalization','none','Name','observation')
    fullyConnectedLayer(50,'Name','CriticStateFC1')
    reluLayer('Name', 'CriticRelu1')
    fullyConnectedLayer(50,'Name','CriticStateFC2')];
actionPath = [
    imageInputLayer([numAct 1 1],'Normalization','none','Name','action')
    fullyConnectedLayer(50,'Name','CriticActionFC1','BiasLearnRateFactor',0)];
commonPath = [
    additionLayer(2,'Name','add')
    reluLayer('Name','CriticCommonRelu')
    fullyConnectedLayer(1,'Name','CriticOutput')];

criticNetwork = layerGraph();
criticNetwork = addLayers(criticNetwork,statePath);
criticNetwork = addLayers(criticNetwork,actionPath);
criticNetwork = addLayers(criticNetwork,commonPath);
    
criticNetwork = connectLayers(criticNetwork,'CriticStateFC2','add/in1');
criticNetwork = connectLayers(criticNetwork,'CriticActionFC1','add/in2');
criticOpts = rlRepresentationOptions('LearnRate',1e-03*10,'GradientThreshold',10);
obsInfo = getObservationInfo(env);
actInfo = getActionInfo(env);
critic = rlQValueRepresentation(criticNetwork,obsInfo,actInfo,'Observation',{'observation'},'Action',{'action'},criticOpts);


actorNetwork = [
    imageInputLayer([numObs 1 1],'Normalization','none','Name','observation')
    fullyConnectedLayer(50,'Name','ActorFC1')
    reluLayer('Name','ActorRelu1')
    fullyConnectedLayer(50,'Name','ActorFC2')
    reluLayer('Name','ActorRelu2')
    fullyConnectedLayer(numAct,'Name','ActorFC3')
    tanhLayer('Name','ActorTanh')
    scalingLayer('Name','ActorScaling','Scale',max(actInfo.UpperLimit))];

actorOpts = rlRepresentationOptions('LearnRate',1e-04*10,'GradientThreshold',10);

actor = rlDeterministicActorRepresentation(actorNetwork,obsInfo,actInfo,'Observation',{'observation'},'Action',{'ActorScaling'},actorOpts);

agentOpts = rlDDPGAgentOptions(...
    'SampleTime',1,...
    'TargetSmoothFactor',1e-3,...
    'ExperienceBufferLength',1e6,...
    'DiscountFactor',0.6,...
    'NumStepsToLookAhead',1,...
    'ResetExperienceBufferBeforeTraining',0,...
    'SaveExperienceBufferWithAgent',1,...
    'MiniBatchSize',32);
agentOpts.NoiseOptions.Variance = 0.6*1;
agentOpts.NoiseOptions.VarianceDecayRate = 1e-5*100;

agent = rlDDPGAgent(actor,critic,agentOpts);

maxepisodes = 30000;
maxsteps =5;
trainOpts = rlTrainingOptions(...
    'MaxEpisodes',maxepisodes,...
    'MaxStepsPerEpisode',maxsteps,...
    'ScoreAveragingWindowLength',5,...
    'Verbose',false,...
    'Plots','training-progress',...
    'StopTrainingCriteria','AverageReward',...
    'StopTrainingValue',4440,...
    'SaveAgentCriteria','EpisodeReward',...
    'UseParallel',true,...
    'SaveAgentValue',440);


agent.AgentOptions.NoiseOptions.Variance = 0.6*0.001;
agent.AgentOptions.NoiseOptions.VarianceDecayRate = 1e-5*100;

trainingStats = train(agent,env,trainOpts);

simOptions = rlSimulationOptions('MaxSteps',10);

experience = sim(env,agent,simOptions);

% 
% 
% boundedline([1:length(trainingStats.EpisodeReward)], movmean(trainingStats.EpisodeReward,100), trainingStats.EpisodeReward, 'alpha','r');
% 
% 
% h1 = histcounts(trainingStats.EpisodeSteps(1:1000),'Normalization', 'probability');
% h2 = histcounts(trainingStats.EpisodeSteps(1:1000),'Normalization', 'probability');
% h3 = histcounts(trainingStats.EpisodeSteps(1:1000) ,'Normalization', 'probability');
% 
% figure
% bar([1:5],[h1; h2; h3]')
% 
