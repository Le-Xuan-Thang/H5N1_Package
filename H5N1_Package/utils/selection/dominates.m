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
%   S. Mirjalili, A.H. Gandomi, S.Z. Mirjalili, S. Saremi, H. Faris, S.M. Mirjalili,
%   Salp Swarm Algorithm: A bio-inspired optimizer for engineering design problems
%   Advances in Engineering Software
%   DOI: http://dx.doi.org/10.1016/j.advengsoft.2017.07.002
%____________________________________________________________________________________

function dominates = dominates(x, y)
% dominates - Check if one solution dominates another in multi-objective optimization
%
% Syntax:
%   dominates = dominates(x, y)
%
% Inputs:
%   x - Vector of objective values for first solution
%   y - Vector of objective values for second solution
%
% Outputs:
%   dominates - Boolean indicating if x dominates y
%
% Description:
%   This function determines if solution x dominates solution y in a 
%   minimization context. For solution x to dominate solution y:
%   1. x must be no worse than y in all objectives (x <= y)
%   2. x must be strictly better than y in at least one objective (x < y)
%
%   For minimization problems:
%   - Lower values are considered better
%   - Returns true if x dominates y, false otherwise

    % Check dominance conditions
    dominates = all(x <= y) && any(x < y);
end