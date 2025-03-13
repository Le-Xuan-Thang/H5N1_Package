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

function [Archive_X_updated, Archive_F_updated, Archive_member_no] = UpdateArchive(Archive_X, Archive_F, Particles_X, Particles_F, Archive_member_no)
% UpdateArchive - Update archive of non-dominated solutions
%
% Syntax:
%   [Archive_X_updated, Archive_F_updated, Archive_member_no] = UpdateArchive(Archive_X, Archive_F, Particles_X, Particles_F, Archive_member_no)
%
% Inputs:
%   Archive_X       - Matrix of decision variables in current archive
%   Archive_F       - Matrix of objective values in current archive
%   Particles_X     - Matrix of decision variables of new particles
%   Particles_F     - Matrix of objective values of new particles
%   Archive_member_no - Current number of elements in archive
%
% Outputs:
%   Archive_X_updated  - Updated matrix of decision variables
%   Archive_F_updated  - Updated matrix of objective values
%   Archive_member_no  - New number of elements in archive

    % Combine current archive with new particles
    Archive_X_temp = [Archive_X; Particles_X];
    Archive_F_temp = [Archive_F; Particles_F];

    % Vector to mark dominated elements
    o = zeros(1, size(Archive_F_temp, 1));

    % Check dominance relationships between elements
    for i = 1:size(Archive_F_temp, 1)
        o(i) = 0;
        for j = 1:i-1
            % Check if two elements are different
            if any(Archive_F_temp(i,:) ~= Archive_F_temp(j,:))
                % Check dominance relationship
                if dominates(Archive_F_temp(i,:), Archive_F_temp(j,:))
                    o(j) = 1;  % j is dominated by i
                elseif dominates(Archive_F_temp(j,:), Archive_F_temp(i,:))
                    o(i) = 1;  % i is dominated by j
                    break;
                end
            else
                % If elements are identical, mark both
                o(j) = 1;
                o(i) = 1;
            end
        end
    end

    % Update archive with non-dominated elements
    Archive_member_no = 0;
    index = 0;
    
    % Filter out non-dominated elements
    for i = 1:size(Archive_X_temp, 1)
        if o(i) == 0  % Non-dominated element
            Archive_member_no = Archive_member_no + 1;
            Archive_X_updated(Archive_member_no,:) = Archive_X_temp(i,:);
            Archive_F_updated(Archive_member_no,:) = Archive_F_temp(i,:);
        else
            index = index + 1;
            %         dominated_X(index,:)=Archive_X_temp(i,:);
            %         dominated_F(index,:)=Archive_F_temp(i,:);
        end
    end
end
