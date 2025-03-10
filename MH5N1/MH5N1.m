%_________________________________________________________________________________
%  MH5N1 algorithm source codes version 1.0
%
%  Developed in MATLAB R2022a
%
%  Author and developer: Le Xuan Thang
%
%         e-Mail: lexuanthang.official@gmail.com
%                 lexuanthang.official@outlook.com
%         website: https://lexuanthang.vn
%
%   Main paper: Le, T.X., Bui, T.T. and Tran, H.N. (2025), "The H5N1 algorithm: a viral-inspired optimization for solving real-world engineering problems", Engineering Computations 
%   DOI:https://doi.org/10.1108/EC-05-2024-0472
%____________________________________________________________________________________
function [Store,M]=MH5N1(nVirus,Max_iter,lb,ub,dim,ObjectiveFunction,nObj,Problem_Name)
% MH5N1 - Metaheuristic optimization algorithm for multi-objective problems
% [Store,M]=MH5N1(nVirus,Max_iter,lb,ub,dim,ObjectiveFunction,nObj,Problem_Name)

% Inputs:
% nVirus: size of the virus population
% Max_iter: maximum number of iterations
% lb: lower bounds for decision variables
% ub: upper bounds for decision variables
% dim: number of decision variables
% ObjectiveFunction: handle to the function that computes the cost of a candidate solution

% Outputs:
% GlobalBest_Cost: cost of the best solution found
% GlobalBest_Position: decision variable values of the best solution found
% BestCosts: vector containing the cost of the best solution in each iteration

if size(lb,2) == 1
    lb = repmat(lb,1,dim);
    ub = repmat(ub,1,dim);
end

% setting up parameter for H5N1 algorithms
P1 = 0.8; % Probability of attaching to a bird, poultry
P2 = 0.85; % Probability of survival after infection

w = 1;
wmin = 0.001;
wmax = 1;
p = 0;
m_virus = zeros(nVirus,dim);                       % mutate for virus population
m_virusBest = zeros(nVirus,dim);                   % mutate for virus Best population
ro = (0:1:nVirus-1);                               % rotating index array
R = rand(nVirus,dim);                              % matrix of normalization random number for all
v = rand(nVirus,1);                                % vector of normalization random number for mutate

%% Initialize the virus population randomly
virusCost = zeros(nVirus,nObj);                        
virusPosition = initialization(nVirus,dim,ub,lb);

% Evaluate the objective function for each individual
for i = 1:nVirus
    virusCost(i,:) = ObjectiveFunction(virusPosition(i, :),Problem_Name);
end

% Initialize the best cost and position
virusBestCost = virusCost;
virusBestPosition = virusPosition;

% Initialize the archive
ArchiveMaxSize = 100; % Maximum number of solutions to store
Archive_X = zeros(ArchiveMaxSize,dim); % Store the optimal position = Size store * dimensions
Archive_F = ones(ArchiveMaxSize,nObj)*inf; % Store the fitness of the solution = Size store * objective number

% Initialize the global best cost and position
GlobalBest_Position = zeros(1,dim); % Store the optimal position = Size store * dimensions
GlobalBest_Cost = ones(1,nObj)*inf; % Store the fitness of the solution = Size store * objective number

% Initialize the number of solutions stored after each run
Archive_member_no = 0; 

%% value store for visualization

% Store the virus population
empty.virusPosition = [];
empty.virusCost = [];
empty.virusBestPosition = [];
empty.virusBestCost = [];
empty.GlobalBest_Position = [];
empty.GlobalBest_Cost = [];
empty.Archive_member_no = [];
empty.Archive_F = [];
empty.Archive_X = [];
Store = repmat(empty,Max_iter,1);

%% Main loop
iter = 0;

while iter < Max_iter
    iter = iter+1;
    %=========================update the ranking=========================%

    for i=1:nVirus %Calculate all the objective values first
        virusCost(i,:)=ObjectiveFunction(virusPosition(i,:),Problem_Name);
        if dominates(virusCost(i,:),virusBestCost(i,:))
            virusBestCost(i,:)=virusCost(i,:);
            virusBestPosition(i,:)=virusPosition(i,:);

        elseif dominates(virusBestCost(i,:),virusCost(i,:))
            % Do nothing
        else
            if rand < 0.5
                virusBestCost(i,:) = virusCost(i,:);
            end

        end
    end
    %=========================end update the ranking======================%
    try
        [Archive_X, Archive_F, Archive_member_no] = UpdateArchive(Archive_X, Archive_F, virusPosition, virusCost, Archive_member_no);
    catch
        Archive_X = [virusBestPosition(1:end-1,:);GlobalBest_Position];
        Archive_F = [virusBestCost(1:end-1,:);GlobalBest_Cost];
    end
    %=========================Handle Full Archive======================%

    if Archive_member_no > ArchiveMaxSize
        Archive_mem_ranks = RankingProcess(Archive_F, ArchiveMaxSize, nObj);
        [Archive_X, Archive_F, Archive_mem_ranks, Archive_member_no] = HandleFullArchive(Archive_X, Archive_F, Archive_member_no, Archive_mem_ranks, ArchiveMaxSize);
    else
        Archive_mem_ranks = RankingProcess(Archive_F, ArchiveMaxSize, nObj);
    end
    %=========================end Handle Full Archive======================%

    % to improve coverage
    index = RouletteWheelSelection(1./Archive_mem_ranks);
    if index == -1
        index = 1;
    end

    GlobalBest_Cost = Archive_F(index,:);
    GlobalBest_Position = Archive_X(index,:);

    %=========================parameter caculate=========================%
    c = exp(-4*iter/Max_iter)*rand(); % Eq. 3-9
    p = 1 ./ (1 + exp(-10*(iter/Max_iter-0.5))) + rand()*(1-p); % Eq. 3-10
    wd = wmin + (wmax-wmin)*exp(-(iter/Max_iter)); % Eq. 3-8 (part 2)

    % Determine the probability of attaching to a bird
    P_attack =  rand(nVirus, 1);
    % Determine the probability of survival after infection
    P_survival = rand(nVirus, 1);

    sigma = randperm(3);               % index pointer array
    a1    = randperm(nVirus);          % Eq. 3-1
    rt1   = rem(ro+sigma(1),nVirus);   % Eq. 3-2
    a2    = a1(rt1+1);                 % Eq. 3-3
    rt2   = rem(ro+sigma(2),nVirus);   % Eq. 3-4
    a3    = a2(rt2+1);                 % Eq. 3-5

    pmp1 = virusBestPosition(a1,:);    % permutate population 1
    pmp2 = virusBestPosition(a2,:);    % permutate population 2
    pmp3 = virusBestPosition(a3,:);    % permutate population 3

    v  = v(a3,:);                 % permutate coefficient
    sm = rand(nVirus,dim);        % stochastic for mutate
    %=====================end parameter caculate=========================%

    % Update the virus population using the infected fitness
    for i = 1:nVirus
        m_virus(i,:) = sm (i,:) < v(i,1);                    % all random numbers < vm are 1, 0 otherwise
        m_virusBest(i,:) = m_virus (i,:) < v(i,1);              % inverse mutate virus to virusBest

        % Move the individual virus according to the probability of survival
        % Check if the virus attaches to poultry or human
        if P_attack(i) < P1

            % Calculate the probability of survival of the poultry
            if P_survival(i) < P2 % % Good enviroment / the poultry survives

                % Get direction
                direction = GlobalBest_Position - virusPosition(i,:);
                virusPosition(i,:) = pmp3(i,:)+ R(i,:).*direction; % Eq. 3-6 (part 1)

            else % Bad enviroment / the poultry can not survive

                xold = GlobalBest_Position ;                                                        % Eq. 3-7 (part 1)       
                xnew = virusPosition(i,:) + R(i,:).*(GlobalBest_Position - virusBestPosition(i,:)); % Eq. 3-7 (part 2)
                virusPosition(i,:) = 1/2*c*w*(xnew+xold)*rand();                                    % Eq. 3-7 (part 3)
                virusCost(i,:) = ObjectiveFunction(virusPosition(i,:),Problem_Name);

                ps = rand();
                % Update the global best position and cost Eq. 3-12
                if ps < p && dominates(virusCost(i,:),GlobalBest_Cost)
                    GlobalBest_Position = virusPosition(i,:);
                    GlobalBest_Cost = virusCost(i,:);
                end
            end

        % attack to human
        else
            if P_survival(i) < P2 % Good enviroment /the human survives

                % Get direction
                direction = GlobalBest_Position - virusPosition(i,:);
                virusPosition(i,:) = virusPosition(i,:)  + (R(i,:).*(pmp1(i,:)-pmp2(i,:)) ...
                + R(i,:).*direction)/2; % Eq. 3-6 (part 2)

            else % Bad enviroment / the human can not survive
                xold = GlobalBest_Position ;                                                        % Eq. 3-7 (part 1)
                xnew = virusPosition(i,:) + R(i,:).*(GlobalBest_Position-virusBestPosition(i,:));   % Eq. 3-7 (part 2)
                virusPosition(i,:) = 1/2*c*w*(xnew+xold)*rand();                                    % Eq. 3-7 (part 3)
                virusCost(i,:) = ObjectiveFunction(virusPosition(i,:),Problem_Name);

                ps = rand();
                if ps < p && dominates(virusCost(i,:),GlobalBest_Cost)
                    GlobalBest_Position = virusPosition(i,:);
                    GlobalBest_Cost = virusCost(i,:);
                end

            end
        end
    end

    % Mutate
    virusPosition = virusPosition.*m_virus + virusBestPosition.*m_virusBest; % Eq. 3-11

    %% CheckBoundary / Clip the position to the search space
    changeRows =  virusPosition > ub;
    virusPosition(changeRows) =  pmp1(changeRows);
    changeRows =  virusPosition < lb;
    virusPosition(changeRows) = pmp2(changeRows);

    w = w * wd; % Eq. 3-8 (part 1)

    %% Show Iteration Information

    fprintf('Number of Rep Members at Iteration %4.0f is: %3.0f \n',iter, Archive_member_no)

    % Store the information
    Store(iter).virusPosition = virusPosition;
    Store(iter).virusCost = virusCost;
    Store(iter).virusBestPosition = virusBestPosition;
    Store(iter).virusBestCost = virusBestCost;
    Store(iter).GlobalBest_Position = GlobalBest_Position;
    Store(iter).GlobalBest_Cost = GlobalBest_Cost;
    Store(iter).Archive_member_no = Archive_member_no;
    Store(iter).Archive_F = Archive_F;
    Store(iter).Archive_X = Archive_X;

    M = evaluation_iter(Archive_F,ArchiveMaxSize,ObjectiveFunction,nObj,Problem_Name);

end

end

%% Reference Point, Pareto Front, Set
function [M] = evaluation_iter(Archive_F,ArchiveMaxSize,ObjectiveFunction,nObj,Problem_Name)
    M_empty.IGD = [];
    M = repmat(M_empty,1,1);

    % Archive_member_no = ArchiveMaxSize;
    x=linspace(0,1,ArchiveMaxSize);
    y = x;
    L=size(x,2);

    if nObj == 2
        True_Pareto = zeros(L,nObj);
        for i=1:L
            True_Pareto(i,:)=ObjectiveFunction([x(i) 0 0 0],Problem_Name);
        end
    elseif nObj == 3
        True_Pareto = zeros(L,nObj);
        for i=1:L
            for j=1:nObj
                Z=ObjectiveFunction([x(i) y(j) 0 0],Problem_Name);
                True_Pareto(i,j) = Z(3);
            end
        end

    end
    % Calculate the metrics for the archive
    M.IGD=IGD(Archive_F,True_Pareto);
end