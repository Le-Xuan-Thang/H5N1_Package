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
% RankingProcess - Tính toán xếp hạng cho các phần tử trong kho lưu trữ
%
% Cú pháp:
%   ranks = RankingProcess(Archive_F, ArchiveMaxSize, obj_no)
%
% Đầu vào:
%   Archive_F      - Ma trận các giá trị mục tiêu trong kho lưu trữ
%   ArchiveMaxSize - Kích thước tối đa cho phép của kho lưu trữ
%   obj_no        - Số lượng mục tiêu cần tối ưu
%
% Đầu ra:
%   ranks         - Vector xếp hạng của các phần tử

    global my_min;
    global my_max;

    % Cập nhật giá trị min và max toàn cục
    if size(Archive_F,1) == 1 && size(Archive_F,2) == 2
        % Trường hợp đặc biệt: chỉ có 1 phần tử và 2 mục tiêu
        my_min = Archive_F;
        my_max = Archive_F;
    elseif size(Archive_F,1) == 1 && size(Archive_F,2) == 3
        % Trường hợp đặc biệt: chỉ có 1 phần tử và 3 mục tiêu
        my_min = Archive_F;
        my_max = Archive_F;
    else
        % Trường hợp thông thường: nhiều phần tử
        my_min = min(Archive_F);
        my_max = max(Archive_F);
    end

    % Tính bán kính lân cận cho mỗi mục tiêu
    r = (my_max - my_min) / 20;
    
    % Khởi tạo vector xếp hạng
    ranks = zeros(1, size(Archive_F,1));

    % Tính xếp hạng cho từng phần tử
    for i = 1:size(Archive_F,1)
        ranks(i) = 0;
        for j = 1:size(Archive_F,1)
            % Đếm số mục tiêu nằm trong lân cận
            flag = 0;
            for k = 1:obj_no
                % Kiểm tra khoảng cách giữa hai phần tử trên mỗi mục tiêu
                if abs(Archive_F(j,k) - Archive_F(i,k)) < r(k)
                    flag = flag + 1;
                end
            end
            
            % Nếu tất cả mục tiêu đều nằm trong lân cận
            if flag == obj_no
                ranks(i) = ranks(i) + 1;
            end
        end
    end
end
