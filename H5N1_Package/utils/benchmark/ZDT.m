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
%
%   Reference:
%   E. Zitzler, K. Deb, and L. Thiele, "Comparison of Multiobjective Evolutionary Algorithms: 
%   Empirical Results," Evolutionary Computation, vol. 8, no. 2, pp. 173-195, 2000.
%   DOI: 10.1162/106365600568202
%____________________________________________________________________________________

function [f, ps] = ZDT(x, Problem_Name)
% ZDT - Implementation of ZDT benchmark problems for multi-objective optimization
%
% Syntax:
%   [f, ps] = ZDT(x, Problem_Name)
%
% Inputs:
%   x           - Decision variable vector
%   Problem_Name - Name of the ZDT problem ('ZDT1', 'ZDT2', 'ZDT3')
%
% Outputs:
%   f  - Vector of objective values [f1; f2]
%   ps - Decision variable vector (same as input x)
%
% Description:
%   This function implements the ZDT (Zitzler-Deb-Thiele) test problems.
%   Currently supports:
%   - ZDT1: Convex Pareto-optimal front
%   - ZDT2: Non-convex Pareto-optimal front
%   - ZDT3: Discontinuous Pareto-optimal front

    switch Problem_Name
        case 'ZDT1'
            [f, ps] = ZDT1(x);
        case 'ZDT2'
            [f, ps] = ZDT2(x);
        case 'ZDT3'
            [f, ps] = ZDT3(x);
        otherwise
            error('Invalid ZDT problem name. Available problems: ZDT1, ZDT2, ZDT3')
    end
end

%% ZDT1 Implementation
function [f, ps] = ZDT1(x)
% ZDT1 - First test problem from the ZDT test suite
%
% Description:
%   Characteristics:
%   - Convex Pareto-optimal front
%   - Uniform distribution of solutions
%   - No local Pareto-optimal fronts

    nVar = numel(x);
    g = 1 + 9*sum(x(2:end))/(nVar-1);
    
    % First objective
    F1 = x(1);
    
    % Second objective
    F2 = g*(1-sqrt(F1/g));
    
    f = [F1; F2];
    ps = x;
end

%% ZDT2 Implementation
function [f, ps] = ZDT2(x)
% ZDT2 - Second test problem from the ZDT test suite
%
% Description:
%   Characteristics:
%   - Non-convex Pareto-optimal front
%   - Uniform distribution of solutions
%   - No local Pareto-optimal fronts

    nVar = numel(x);
    g = 1 + 9*sum(x(2:end))/(nVar-1);
    
    % First objective
    F1 = x(1);
    
    % Second objective
    F2 = g*(1-power(F1/g,2));
    
    f = [F1; F2];
    ps = x;
end

%% ZDT3 Implementation
function [f, ps] = ZDT3(x)
% ZDT3 - Third test problem from the ZDT test suite
%
% Description:
%   Characteristics:
%   - Disconnected Pareto-optimal front
%   - Uniform distribution of solutions
%   - No local Pareto-optimal fronts

    nVar = numel(x);
    g = 1 + 9*sum(x(2:end))/(nVar-1);
    
    % First objective
    F1 = x(1);
    
    % Second objective with sine function causing discontinuity
    F2 = g*(1-sqrt(F1/g)-F1/g*sin(10*pi()*F1));
    
    f = [F1; F2];
    ps = x;
end