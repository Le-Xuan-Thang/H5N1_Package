%_________________________________________________________________________________
%  MH5N1 algorithm source codes version 1.0
%
%  Developed in MATLAB R2022a
%
%  Author and programmer: Le Xuan Thang
%
%         e-Mail: lexuanthang.official@gmail.com
%                 lexuanthang.official@outlook.com
%         website: https://lexuanthang.vn
%
%   Main paper: Le, T.X., Bui, T.T. and Tran, H.N. (2025), "The H5N1 algorithm: a viral-inspired optimization for solving real-world engineering problems", Engineering Computations 
%   DOI:https://doi.org/10.1108/EC-05-2024-0472
%____________________________________________________________________________________
% Empty the workspace
clc
clear
close all

% Get root directory
root_dir = fileparts(fileparts(fileparts(mfilename('fullpath'))));

% Add all necessary paths
addpath(genpath(fullfile(root_dir, 'utils'))); % Add utils folder (archive, selection, benchmark, metrics)
addpath(fullfile(root_dir, 'algorithms', 'multi')); % Add multi-objective algorithms

Algorithm_Name = 'MH5N1';

%% Parameters
Max_iter = 100; % Max Iterations
nPop = 60; % Number of population
nFunc = 3; % All function needed

% Initialize empty structure for results
empty.Name          = [];
empty.Best          = [];
empty.Median        = [];
empty.Worst         = [];
empty.Mean          = [];
empty.BestPF        = [];
empty.BestPS       = [];
empty.STD           = [];
empty.SEM           = [];
empty.Time          = [];
empty.History       = [];
Results = repmat(empty,nFunc,1);
Time_store = zeros(nFunc,1);

%% For standard and best value in 30 times run the function
Time2run = 1; % times to run the function

% Initialize empty structure for history
empty_store.A  = [];
empty_store.B  = [];
History = repmat(empty_store,Time2run,1);

% PROBLEMS= ['ZDT1 '; 'ZDT2 '; 'ZDT3 '; 'ZDT4 '; 'ZDT5 '];
PROBLEMS= ['ZDT1 '; 'ZDT2 '; 'ZDT3 '];
DIMX    = [30 30 30];
NOP     = [100 100 100]; 
PROPERTY= ['b-'; 'b-'; 'b-'];
Archive_no = [100 100 100 ];

% Main loop
for F_ID = 1 : nFunc
    
    Test_Suite = 'ZDT';
    Problem_Name = deblank(PROBLEMS(F_ID,:));
    %Create Store for save all result of functions
    [VarMin,VarMax,nVar,nObj,ObjectiveFunction] = Get_problem(Problem_Name,DIMX(F_ID));
    A = zeros(Time2run,1); % A = X*1; store the value of Best fitness for X times to run
    run = 0;

    % Number of independent runs
    K = Time2run;
    
    while run < Time2run
        run = run+1;

        % Call MH5N1 function
        tic;
        [Store,M] = MH5N1(nPop,Max_iter,VarMin,VarMax,nVar,ObjectiveFunction,nObj,Problem_Name);

        History(run).A = M;
        History(run).B = Store;

    end

    % Time caculate
    time = toc;
    for ii_times = 1 : run
        A(ii_times) = History(ii_times).A.IGD;
    end

    % Get the best result across all runs
    [Best_A,No_A] = sort(A);
    Median = Best_A(round(length(A)/2));
    Worst = Best_A(end);
    
    % Calculate the metrics
    Average = mean(A);
    STD_A = std(A);
    SEM_A = STD_A / sqrt(length(A));

    % Get the best pareto front and pareto set
    Best_PF = History(No_A(1)).B(end).Archive_F;
    BestPS = History(No_A(1)).B(end).Archive_X;

    % Print the results
    disp(num2str(F_ID));
    fprintf('\nFunction F%d\nBest = %.4f\nMedian = %.4f\nWorst = %.4f\nAverage = %.4f\nSTD = %.4f\nSEM = %.4f\n', ...
        F_ID, Best_A, Median, Worst, Average, STD_A, SEM_A);

    % Store the results
    Results(F_ID).Name = Problem_Name;

    Results(F_ID).Best = Best_A;
    Results(F_ID).Median = Median;
    Results(F_ID).Worst = Worst;
    Results(F_ID).Mean= Average;
    Results(F_ID).STD= STD_A;
    Results(F_ID).SEM = SEM_A;
    Results(F_ID).Time = time;

    Results(F_ID).BestPF = Best_PF;
    Results(F_ID).BestPS = BestPS;
    
    Results(F_ID).History = History;

    %% Get True pareto front
    [x,y]      = xyboundary(Problem_Name, Archive_no(F_ID));
    L = size(x,2);
    k = zeros(1,nVar);
    o = 0;
    % Caculate for true pareto front
    for i=1:L
        k(1) = x(i);

        if nObj == 2
            [True_ParetoFront(i,:), True_ParetoSet(i,:)] =ObjectiveFunction(k,Problem_Name);
        else
            for j = 1:L
                o = o + 1 ;
                k(2) = y(j);
                [Z1, Z2] =ObjectiveFunction(k,Problem_Name);
                True_ParetoFront(o,:) = Z1';
                True_ParetoSet(o,:) = Z2;
            end
        end
    end
    % Caculate for Obtained pareto front
    x =  BestPS(:,1)';
    y =  BestPS(:,2)';
    L = size(x,2);
    k = zeros(1,nVar);
    o = 0;
    for i=1:L
        k(1) = x(i);

        if nObj == 2
            [~, Best_Obtained_PS(i,:)] =ObjectiveFunction(k,Problem_Name);
        else
            for j = 1:L
                o = o + 1 ;
                k(2) = y(j);
                [~, Z2] =ObjectiveFunction(k,Problem_Name);
                
                Best_Obtained_PS(o,:) = Z2;
            end
        end
    end
    %=====================================================================%

%% Visualization
    figure(F_ID)
%     subplot(1,2,1)
    if size(True_ParetoFront(i,:),2) == 2
        % True pareto front
        plot(True_ParetoFront(:,1),True_ParetoFront(:,2),deblank(PROPERTY(F_ID,:)),LineWidth=1.5)
        hold on
        % Obtained front
        scatter(Best_PF(:,1),Best_PF(:,2),SizeData=150,MarkerEdgeColor="black",MarkerFaceColor="yellow",LineWidth=2);
        
        title(Problem_Name,Interpreter='latex')
        xlabel('$F1$',Interpreter='latex');
        ylabel('$F2$',Interpreter='latex');
        grid off;
        legend("True PF", "Solution PF", 'Location', 'southwest',Interpreter='latex')
        hold off
    else
        plot3(True_ParetoFront(:,1),True_ParetoFront(:,2), True_ParetoFront(:,3),deblank(PROPERTY(F_ID,:)),LineWidth=1.5)
        box on
        hold on
        scatter3(Best_PF(:,1),Best_PF(:,2),Best_PF(:,3),SizeData=150,MarkerEdgeColor="black",MarkerFaceColor="yellow",LineWidth=2);
        title(Problem_Name,Interpreter='latex')
        ax = gca;
        ax.BoxStyle = 'full';
        ax.LineWidth = 1.5;
        title(Problem_Name,Interpreter='latex')
        xlabel('$F1$',Interpreter='latex');
        ylabel('$F2$',Interpreter='latex');
        zlabel('$F3$',Interpreter='latex');
        hold off
    end

clear True_ParetoFront True_ParetoSet
end