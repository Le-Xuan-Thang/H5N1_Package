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
%   Q. Zhang et al., "Multiobjective Optimization Test Instances for the CEC 2009 
%   Special Session and Competition," Technical Report CES-487, 2009.
%____________________________________________________________________________________

function [x, y] = xyboundary(name, Archive_member_no)
% xyboundary - Generate boundary points for Pareto front visualization
%
% Syntax:
%   [x, y] = xyboundary(name, Archive_member_no)
%
% Inputs:
%   name             - Name of the test problem ('UF5', 'UF6', 'UF9', etc.)
%   Archive_member_no - Number of points to generate
%
% Outputs:
%   x - x-coordinates of boundary points
%   y - y-coordinates of boundary points
%
% Description:
%   This function generates boundary points for visualizing the true Pareto front
%   of various test problems. Different problems have different Pareto front
%   shapes, which are handled specifically:
%   - UF5: Discrete points with specified intervals
%   - UF6: Disconnected segments
%   - UF9: Two separate regions [0,0.25] and [0.75,1]
%   - Others: Uniform distribution in [0,1]

    switch name
        case {'UF5'}
            N = 10;  % Number of intervals
            d = 2;   % Number of points in each half interval
            
            % Create N+1 interval points
            x = linspace(0, 1, N+1);
            x_values = [];
            
            % Generate points for each interval
            for i = 1:N
                x_range = linspace(x(i), x(i+1), d+1);
                x_values = [x_values x_range(1:end-1) x_range(end)];
            end
            x = x_values;
            y = linspace(0, 1, Archive_member_no);
            
        case {'UF6'}
            % Generate disconnected segments
            x = linspace(0, 1, Archive_member_no);
            x1 = x(1);
            x2 = x(2);
            
            % First segment
            x(1:Archive_member_no/4-1) = 0;
            x(Archive_member_no/4) = x(Archive_member_no/4) + x2-x1;
            
            % Middle segment
            x(2*Archive_member_no/4+1:3*Archive_member_no/4-1) = 0.5;
            x(3*Archive_member_no/4) = x(Archive_member_no/4) + x2-x1;
            
            y = linspace(0, 1, Archive_member_no);
            
        case {'UF9'}
            Archive_member_no = 100;  % Fixed number of points
            
            % Generate points in two regions [0,0.25] and [0.75,1]
            x1a = linspace(0, 0.25, Archive_member_no/2);
            x1b = linspace(0.75, 1, Archive_member_no/2);
            x = [x1a x1b];
            y = linspace(0, 1, Archive_member_no);
            
        otherwise
            % Default case: uniform distribution
            x = linspace(0, 1, Archive_member_no);
            y = linspace(0, 1, Archive_member_no);
    end
end