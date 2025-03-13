%==========================================================================
%% Get problems
%  INPUT of function
%  ProblemName : Name of Group problem
%  NoProb : Number of problem in the group of problems
%  OUTPUT of function
%  VarMin : lower boundary
%  VarMax : upper boundary
%  nVar : number of variables or dimension
%  nObj : denotes number of output/object
%  CostFunction: Call function of group problem
%% Summary what we have
% ZDT have 3 problem 1,2,3
%% Contact Infor
%  Developed in MATLAB R2022a
%
%  Developer : Le Xuan Thang
%
%  eMail: lexuanthang.official@gmail.com
%         lexuanthang.official@outlook.comj
%         website: https://lexuanthang.vn
% Main paper: Le, T.X., Bui, T.T. and Tran, H.N. (2025), "The H5N1 algorithm: a viral-inspired optimization for solving real-world engineering problems", Engineering Computations 
% DOI:https://doi.org/10.1108/EC-05-2024-0472
%==========================================================================

%% Function
function [VarMin,VarMax,nVar,nObj,CostFunction] = Get_problem(name,dim)

% Get Group Name of Problem only
xrange = xboundary(name,dim);
VarMin = xrange(:,1)';
VarMax = xrange(:,2)';
nVar = dim;
CostFunction = str2func('ZDT');
% Extract group of Problem Name
switch name
    case {'ZDT5'}
        nObj = 3;

    otherwise
        nObj = 2;
end
end