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
    % Check if solution x dominates solution y in a minimization context
    % Returns true if x dominates y, false otherwise
    
    % x dominates y if:
    % 1. x is not worse than y in all objectives
    % 2. x is strictly better than y in at least one objective
    
    % For minimization problems:
    % - Lower values are better
    % - x dominates y if x <= y for all objectives and x < y for at least one
    
    dominates = all(x <= y) && any(x < y);
end