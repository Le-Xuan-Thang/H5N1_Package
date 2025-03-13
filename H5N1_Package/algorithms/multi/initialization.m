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

function Positions = initialization(nVirus, dim, ub, lb)
% initialization - Initialize the first population of viruses for multi-objective optimization
%
% Syntax:
%   Positions = initialization(nVirus, dim, ub, lb)
%
% Inputs:
%   nVirus  - Number of viruses in the population
%   dim     - Number of dimensions (decision variables)
%   ub      - Upper bound of variables (scalar or vector)
%   lb      - Lower bound of variables (scalar or vector)
%
% Outputs:
%   Positions - Matrix of initialized positions (nVirus × dim)
%
% Description:
%   This function creates an initial population of viruses with random positions
%   within the specified bounds. If scalar bounds are provided, they are
%   replicated for all dimensions. The function ensures all positions are
%   within the specified bounds.

    % Check if the boundaries are scalar or vector
    if size(lb,2) == 1
        lb = repmat(lb,1,dim);
        ub = repmat(ub,1,dim);
    end
    
    % Initialize population using uniform random distribution
    Positions = zeros(nVirus, dim);
    for i = 1:dim
        Positions(:,i) = lb(i) + (ub(i) - lb(i)) .* rand(nVirus, 1);
    end
    
    % Apply boundary constraints
    Positions = max(min(Positions, ub), lb);
end