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
% HandleFullArchive - Xử lý kho lưu trữ khi số lượng phần tử vượt quá giới hạn
%
% Cú pháp:
%   [Archive_X_Chopped, Archive_F_Chopped, Archive_mem_ranks_updated, Archive_member_no] = 
%       HandleFullArchive(Archive_X, Archive_F, Archive_member_no, Archive_mem_ranks, ArchiveMaxSize)
%
% Đầu vào:
%   Archive_X         - Ma trận các biến quyết định trong kho lưu trữ
%   Archive_F         - Ma trận các giá trị mục tiêu trong kho lưu trữ
%   Archive_member_no - Số lượng phần tử hiện tại trong kho lưu trữ
%   Archive_mem_ranks - Vector xếp hạng các phần tử trong kho lưu trữ
%   ArchiveMaxSize    - Kích thước tối đa cho phép của kho lưu trữ
%
% Đầu ra:
%   Archive_X_Chopped        - Ma trận các biến quyết định sau khi cắt giảm
%   Archive_F_Chopped        - Ma trận các giá trị mục tiêu sau khi cắt giảm
%   Archive_mem_ranks_updated - Vector xếp hạng đã cập nhật
%   Archive_member_no        - Số lượng phần tử mới trong kho lưu trữ

    % Lặp cho đến khi số lượng phần tử nằm trong giới hạn cho phép
    for i = 1:size(Archive_F,1) - ArchiveMaxSize
        % Chọn phần tử để loại bỏ bằng phương pháp Roulette Wheel
        index = RouletteWheelSelection(Archive_mem_ranks);
        
        % Loại bỏ phần tử được chọn khỏi kho lưu trữ
        Archive_X = [Archive_X(1:index-1,:); Archive_X(index+1:Archive_member_no,:)];
        Archive_F = [Archive_F(1:index-1,:); Archive_F(index+1:Archive_member_no,:)];
        Archive_mem_ranks = [Archive_mem_ranks(1:index-1) Archive_mem_ranks(index+1:Archive_member_no)];
        Archive_member_no = Archive_member_no - 1;
    end

    % Cập nhật kết quả
    Archive_X_Chopped = Archive_X;
    Archive_F_Chopped = Archive_F;
    Archive_mem_ranks_updated = Archive_mem_ranks;
end
