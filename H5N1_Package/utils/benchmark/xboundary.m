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

function range = xboundary(name, dim)
% xboundary - Get variable boundaries for benchmark problems
%
% Syntax:
%   range = xboundary(name, dim)
%
% Inputs:
%   name - Name of the benchmark problem (e.g., 'ZDT1', 'ZDT2', etc.)
%   dim  - Number of decision variables (problem dimension)
%
% Outputs:
%   range - Matrix of size [dim × 2] containing lower and upper bounds
%          Column 1: Lower bounds
%          Column 2: Upper bounds
%
% Description:
%   This function returns the variable boundaries for various benchmark problems.
%   Currently supports:
%   - ZDT test suite (ZDT1, ZDT2, ZDT3, ZDT4, ZDT5)
%   All variables are bounded between [0,1] for these problems.

    % Initialize range matrix
    range = ones(dim, 2);
    
    % Set boundaries based on problem type
    switch name
        case {'ZDT1', 'ZDT2', 'ZDT3', 'ZDT4', 'ZDT5'}
            range(:,1) = 0;  % Lower bound
            range(:,2) = 1;  % Upper bound
    end
end