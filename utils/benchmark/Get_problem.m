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

%% Function
function [VarMin, VarMax, nVar, nObj, CostFunction] = Get_problem(name, dim)
% Get_problem - Get problem configuration for benchmark functions
%
% Syntax:
%   [VarMin, VarMax, nVar, nObj, CostFunction] = Get_problem(name, dim)
%
% Inputs:
%   name - Name of the benchmark problem (e.g., 'ZDT1', 'ZDT2', etc.)
%   dim  - Number of decision variables (problem dimension)
%
% Outputs:
%   VarMin       - Lower bounds for variables
%   VarMax       - Upper bounds for variables
%   nVar         - Number of variables (dimension)
%   nObj         - Number of objectives
%   CostFunction - Handle to the objective function
%
% Description:
%   This function returns the configuration for various benchmark problems.
%   Currently supports:
%   - ZDT test suite (ZDT1, ZDT2, ZDT3, ZDT4, ZDT5, ZDT6)
%   Each problem has specific bounds and number of objectives.

    % Get variable bounds from xboundary function
    xrange = xboundary(name, dim);
    VarMin = xrange(:,1)';
    VarMax = xrange(:,2)';
    nVar = dim;
    
    % Set cost function handle
    CostFunction = str2func('ZDT');
    
    % Set number of objectives based on problem
    switch name
        case {'ZDT5'}
            nObj = 3;
        otherwise
            nObj = 2;
    end
end