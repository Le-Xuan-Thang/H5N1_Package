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

function Positions = initialization(SearchAgents_no, dim, ub, lb)
% initialization - Initialize the first population of search agents
%
% Syntax:
%   Positions = initialization(SearchAgents_no, dim, ub, lb)
%
% Inputs:
%   SearchAgents_no - Number of search agents
%   dim            - Number of dimensions
%   ub             - Upper bound of variables
%   lb             - Lower bound of variables
%
% Outputs:
%   Positions      - Matrix of initialized positions

    Boundary_no = size(ub,1); % number of boundaries

    % If the boundaries of all variables are equal and user enter a single
    % number for both ub and lb
    if Boundary_no == 1
        Positions = rand(SearchAgents_no,dim).*(ub-lb)+lb;
    end

    % If each variable has a different lb and ub
    if Boundary_no > 1
        for i = 1:dim
            ub_i = ub(i);
            lb_i = lb(i);
            Positions(:,i) = rand(SearchAgents_no,1).*(ub_i-lb_i)+lb_i;
        end
    end
end