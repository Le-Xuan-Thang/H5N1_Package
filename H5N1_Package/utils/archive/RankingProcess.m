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

function ranks = RankingProcess(Archive_F, ArchiveMaxSize, obj_no)
% RankingProcess - Calculate rankings for elements in the archive
%
% Syntax:
%   ranks = RankingProcess(Archive_F, ArchiveMaxSize, obj_no)
%
% Inputs:
%   Archive_F      - Matrix of objective values in the archive
%   ArchiveMaxSize - Maximum allowed size of the archive
%   obj_no        - Number of objectives to optimize
%
% Outputs:
%   ranks         - Ranking vector of elements

    global my_min;
    global my_max;

    % Update global min and max values
    if size(Archive_F,1) == 1 && size(Archive_F,2) == 2
        % Special case: only 1 element and 2 objectives
        my_min = Archive_F;
        my_max = Archive_F;
    elseif size(Archive_F,1) == 1 && size(Archive_F,2) == 3
        % Special case: only 1 element and 3 objectives
        my_min = Archive_F;
        my_max = Archive_F;
    else
        % Normal case: multiple elements
        my_min = min(Archive_F);
        my_max = max(Archive_F);
    end

    % Calculate neighborhood radius for each objective
    r = (my_max - my_min) / 20;
    
    % Initialize ranking vector
    ranks = zeros(1, size(Archive_F,1));

    % Calculate ranking for each element
    for i = 1:size(Archive_F,1)
        ranks(i) = 0;
        for j = 1:size(Archive_F,1)
            % Count objectives within neighborhood
            flag = 0;
            for k = 1:obj_no
                % Check distance between two elements on each objective
                if abs(Archive_F(j,k) - Archive_F(i,k)) < r(k)
                    flag = flag + 1;
                end
            end
            
            % If all objectives are within neighborhood
            if flag == obj_no
                ranks(i) = ranks(i) + 1;
            end
        end
    end
end
