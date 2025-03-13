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
% UpdateArchive - Cập nhật kho lưu trữ các giải pháp không bị trội
%
% Cú pháp:
%   [Archive_X_updated, Archive_F_updated, Archive_member_no] = UpdateArchive(Archive_X, Archive_F, Particles_X, Particles_F, Archive_member_no)
%
% Đầu vào:
%   Archive_X       - Ma trận các biến quyết định trong kho lưu trữ hiện tại
%   Archive_F       - Ma trận các giá trị mục tiêu trong kho lưu trữ hiện tại
%   Particles_X     - Ma trận các biến quyết định của các phần tử mới
%   Particles_F     - Ma trận các giá trị mục tiêu của các phần tử mới
%   Archive_member_no - Số lượng phần tử hiện tại trong kho lưu trữ
%
% Đầu ra:
%   Archive_X_updated  - Ma trận các biến quyết định đã cập nhật
%   Archive_F_updated  - Ma trận các giá trị mục tiêu đã cập nhật
%   Archive_member_no  - Số lượng phần tử mới trong kho lưu trữ

    % Kết hợp kho lưu trữ hiện tại với các phần tử mới
    Archive_X_temp = [Archive_X; Particles_X];
    Archive_F_temp = [Archive_F; Particles_F];

    % Vector đánh dấu các phần tử bị trội
    o = zeros(1, size(Archive_F_temp, 1));

    % Kiểm tra quan hệ trội giữa các phần tử
    for i = 1:size(Archive_F_temp, 1)
        o(i) = 0;
        for j = 1:i-1
            % Kiểm tra nếu hai phần tử khác nhau
            if any(Archive_F_temp(i,:) ~= Archive_F_temp(j,:))
                % Kiểm tra quan hệ trội
                if dominates(Archive_F_temp(i,:), Archive_F_temp(j,:))
                    o(j) = 1;  % j bị trội bởi i
                elseif dominates(Archive_F_temp(j,:), Archive_F_temp(i,:))
                    o(i) = 1;  % i bị trội bởi j
                    break;
                end
            else
                % Nếu hai phần tử giống nhau, đánh dấu cả hai
                o(j) = 1;
                o(i) = 1;
            end
        end
    end

    % Cập nhật kho lưu trữ với các phần tử không bị trội
    Archive_member_no = 0;
    index = 0;
    
    % Lọc ra các phần tử không bị trội
    for i = 1:size(Archive_X_temp, 1)
        if o(i) == 0  % Phần tử không bị trội
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
