%_________________________________________________________________________________
%  H5N1 algorithm source codes version 1.0
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
addpath(genpath(fullfile(root_dir, 'utils'))); % Add utils folder (benchmark)
addpath(fullfile(root_dir, 'algorithms', 'single')); % Add single-objective algorithms

Algorithm_Name = 'SH5N1';

%% Parameters
Max_iter = 500;     % Max Iterations
nVirus = 30;        % Number of population
nFunc = 23;         % All function needed

% Initialize empty structure for results
empty.Name          = [];
empty.BestCost      = [];
empty.BestPosition  = [];
empty.CostHistory   = [];
empty.Mean          = [];
empty.STD           = [];
empty.SEM           = [];
empty.History       = [];
Results = repmat(empty,nFunc,1);
Time_store = zeros(nFunc,1);

%% Settings for running the function
Time2run = 30; % times to run the function

% Initialize history storage structure for multiple runs
empty_store.A  = [];
empty_store.B  = [];
empty_store.C  = [];
empty_store.D  = [];
History = repmat(empty_store,Time2run,1);

for F_ID = 1 : nFunc

    % Get function name
    Function_Name = (['F', num2str(F_ID)]);
    % Load details of the selected benchmark function
    [LB,UB,Dim,ObjectiveFunction] = Get_F(Function_Name);

    A = zeros(Time2run,1); % A = X*1; store the value of Best fitness for X times to run
    B = zeros(Time2run,Max_iter); % B = X*max_iter; store the value of Best fitness for X times to run
    C = zeros(Time2run,Dim); % C = X*Dim; store the value of Best fitness for X times to run
    
    % Run the function
    for run = 1 : Time2run
        tic;
        % Call SH5N1 function
        [GlobalBest_Cost, GlobalBest_Position, BestCosts] = SH5N1(nVirus, Max_iter, LB, UB, Dim, ObjectiveFunction);

        History(run).A = GlobalBest_Cost;
        History(run).B = BestCosts;
        History(run).C = GlobalBest_Position;
        
    end

    % Time caculate
    time = toc;
    for run = 1 : Time2run
        A(run)  = History(run).A;
        B(run,:)= History(run).B;
        C(run,:)= History(run).C;
    end

    % Get the best result across all runs
    [GBest_Cost, No_A] = min(A);
    Converage_curve_best = B(No_A, :);
    GBest_Position = C(No_A, :);
    
    % Calculate the average, standard deviation, and standard error of mean
    Aver_A = mean(A);
    STD_A = std(A);
    SEM_A = STD_A / sqrt(length(A));
    
    % Store the results****************************************************
    Results(F_ID).Name = Function_Name;
    Results(F_ID).BestCost = GBest_Cost;
    Results(F_ID).BestPosition = GBest_Position;
    Results(F_ID).CostHistory = Converage_curve_best;
    Results(F_ID).Mean= Aver_A;
    Results(F_ID).STD= STD_A;
    Results(F_ID).SEM = SEM_A;
    Results(F_ID).Time = time;
    Results(F_ID).History = History;
    
end
% ---- end of running the function ----%
