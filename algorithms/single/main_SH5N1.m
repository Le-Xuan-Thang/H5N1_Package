%_________________________________________________________________________________
%  H5N1 algorithm source codes version 1.0.1
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
%
%   Description:
%   This is the main script for running the Single-objective H5N1 (SH5N1) algorithm.
%   It performs multiple runs of the algorithm on different benchmark functions
%   and collects statistical results including best cost, mean, standard deviation,
%   and convergence history.
%____________________________________________________________________________________

% Clear workspace and command window
clc;
clear;
close all;

% Get root directory and set up paths
root_dir = fileparts(fileparts(fileparts(mfilename('fullpath'))));
addpath(genpath(fullfile(root_dir, 'utils')));        % Add utils folder (benchmark, metrics, etc.)
addpath(fullfile(root_dir, 'algorithms', 'single'));  % Add single-objective algorithms

Algorithm_Name = 'SH5N1';

%% Algorithm Parameters
Max_iter = 500;     % Maximum number of iterations
nVirus = 30;        % Population size (number of viruses)
nFunc = 23;         % Number of benchmark functions to test
Time2run = 30;      % Number of independent runs for statistical analysis

%% Initialize Results Storage
% Structure for storing final results
empty.Name = [];           % Function name
empty.BestCost = [];      % Best cost found
empty.BestPosition = [];   % Best solution found
empty.CostHistory = [];    % Convergence history
empty.Mean = [];          % Mean of best costs
empty.STD = [];           % Standard deviation
empty.SEM = [];           % Standard error of mean
empty.History = [];       % Detailed history of all runs
Results = repmat(empty, nFunc, 1);

% Structure for storing run histories
empty_store.A = [];       % Best fitness values
empty_store.B = [];       % Convergence histories
empty_store.C = [];       % Best positions
empty_store.D = [];       % Reserved for additional metrics
History = repmat(empty_store, Time2run, 1);

%% Main Loop - Run Algorithm on Each Benchmark Function
for F_ID = 1:nFunc
    % Get function details
    Function_Name = ['F', num2str(F_ID)];
    [LB, UB, Dim, ObjectiveFunction] = Get_F(Function_Name);
    
    % Initialize storage for current function
    A = zeros(Time2run, 1);      % Best fitness values
    B = zeros(Time2run, Max_iter); % Convergence histories
    C = zeros(Time2run, Dim);    % Best positions
    
    % Multiple independent runs
    tic; % Start timing
    for run = 1:Time2run
        % Run SH5N1 algorithm
        [GlobalBest_Cost, GlobalBest_Position, BestCosts] = ...
            SH5N1(nVirus, Max_iter, LB, UB, Dim, ObjectiveFunction);
        
        % Store results of this run
        History(run).A = GlobalBest_Cost;
        History(run).B = BestCosts;
        History(run).C = GlobalBest_Position;
    end
    time = toc; % End timing
    
    % Collect results from all runs
    for run = 1:Time2run
        A(run) = History(run).A;
        B(run,:) = History(run).B;
        C(run,:) = History(run).C;
    end
    
    % Find best result and calculate statistics
    [GBest_Cost, Best_Run_Index] = min(A);
    Converage_curve_best = B(Best_Run_Index, :);
    GBest_Position = C(Best_Run_Index, :);
    
    % Calculate statistical measures
    Aver_A = mean(A);
    STD_A = std(A);
    SEM_A = STD_A / sqrt(length(A));
    
    % Store results for current function
    Results(F_ID).Name = Function_Name;
    Results(F_ID).BestCost = GBest_Cost;
    Results(F_ID).BestPosition = GBest_Position;
    Results(F_ID).CostHistory = Converage_curve_best;
    Results(F_ID).Mean = Aver_A;
    Results(F_ID).STD = STD_A;
    Results(F_ID).SEM = SEM_A;
    Results(F_ID).Time = time;
    Results(F_ID).History = History;
    
    % Display progress
    fprintf('Function %s completed. Best Cost = %.4e\n', Function_Name, GBest_Cost);
end

% Save results
save('SH5N1_Results.mat', 'Results', 'Algorithm_Name');
fprintf('\nOptimization completed. Results saved to SH5N1_Results.mat\n');
