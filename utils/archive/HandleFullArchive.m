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

function [Archive_X_Chopped, Archive_F_Chopped, Archive_mem_ranks_updated, Archive_member_no] = HandleFullArchive(Archive_X, Archive_F, Archive_member_no, Archive_mem_ranks, ArchiveMaxSize)
% HandleFullArchive - Handle archive when number of elements exceeds the limit
%
% Syntax:
%   [Archive_X_Chopped, Archive_F_Chopped, Archive_mem_ranks_updated, Archive_member_no] = 
%       HandleFullArchive(Archive_X, Archive_F, Archive_member_no, Archive_mem_ranks, ArchiveMaxSize)
%
% Inputs:
%   Archive_X         - Matrix of decision variables in archive
%   Archive_F         - Matrix of objective values in archive
%   Archive_member_no - Current number of elements in archive
%   Archive_mem_ranks - Ranking vector of elements in archive
%   ArchiveMaxSize    - Maximum allowed size of archive
%
% Outputs:
%   Archive_X_Chopped        - Matrix of decision variables after reduction
%   Archive_F_Chopped        - Matrix of objective values after reduction
%   Archive_mem_ranks_updated - Updated ranking vector
%   Archive_member_no        - New number of elements in archive

    % Loop until number of elements is within allowed limit
    for i = 1:size(Archive_F,1) - ArchiveMaxSize
        % Select element to remove using Roulette Wheel method
        index = RouletteWheelSelection(Archive_mem_ranks);
        
        % Remove selected element from archive
        Archive_X = [Archive_X(1:index-1,:); Archive_X(index+1:Archive_member_no,:)];
        Archive_F = [Archive_F(1:index-1,:); Archive_F(index+1:Archive_member_no,:)];
        Archive_mem_ranks = [Archive_mem_ranks(1:index-1) Archive_mem_ranks(index+1:Archive_member_no)];
        Archive_member_no = Archive_member_no - 1;
    end

    % Update results
    Archive_X_Chopped = Archive_X;
    Archive_F_Chopped = Archive_F;
    Archive_mem_ranks_updated = Archive_mem_ranks;
end
