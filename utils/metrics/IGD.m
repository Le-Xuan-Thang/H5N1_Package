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

function Score = IGD(ObjPF, truePF)
% IGD - Calculate Inverted Generational Distance metric
%
% Syntax:
%   Score = IGD(ObjPF, truePF)
%
% Inputs:
%   ObjPF   - Matrix of objective values for obtained Pareto front
%   truePF  - Matrix of objective values for true Pareto front
%
% Outputs:
%   Score   - IGD metric value (lower is better)
%
% Description:
%   This function calculates the Inverted Generational Distance (IGD) metric,
%   which measures how well the obtained Pareto front approximates the true
%   Pareto front. The steps are:
%   1. Normalize both fronts using true Pareto front bounds
%   2. For each point in true front, find minimum distance to obtained front
%   3. Calculate average of these minimum distances
%
% Reference:
%   C. A. Coello Coello and N. C. Cortes, "Solving multiobjective optimization
%   problems using an artificial immune system", Genetic Programming and
%   Evolvable Machines, 2005, 6(2): 163-190.

    % Parameter for IGD calculation
    q = 2;
    
    % STEP 1. Obtain the maximum and minimum values of the Pareto front
    m1 = size(ObjPF, 1);
    m = size(truePF, 1);
    maxVals = max(truePF);
    minVals = min(truePF);

    % STEP 2. Get the normalized front
    normalizedPF = (ObjPF - repmat(minVals, m1, 1)) ./ repmat(maxVals - minVals, m1, 1);
    normalizedTruePF = (truePF - repmat(minVals, m, 1)) ./ repmat(maxVals - minVals, m, 1);

    % STEP 3. Sum the distances between each point of the front and the nearest point in the true Pareto front
    Score = 0;
    for i = 1:m
        diff = repmat(normalizedTruePF(i,:), m1, 1) - normalizedPF;
        dist = sqrt(sum(diff.^2, 2));         
        Score = Score + min(dist)^q;
    end
    Score = Score^(1.0/q)/m;
end