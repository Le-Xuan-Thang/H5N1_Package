
%_________________________________________________________________________________
%  ZDT test problems
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
function [f,ps] = ZDT(x,Problem_Name)

switch Problem_Name
    case 'ZDT1' % ZDT1
        [f,ps] = ZDT1(x);

    case 'ZDT2' % ZDT2
        [f,ps] = ZDT2(x);
    case 'ZDT3'
        [f,ps]= ZDT3(x);

    otherwise
        error('No problem in here')

end


%% ZDT1
    function [f,ps] = ZDT1(x)
        nVar = numel(x);
        g = 1+9*sum(x(2:end))/(nVar-1);
        % F1
        F1 = x(1);
        % F2
        F2 = g*(1-sqrt(F1/g));

        f = [F1
            F2];
        ps = x;
    end


    function [f,ps] = ZDT2(x)
        nVar = numel(x);
        g = 1+9*sum(x(2:end))/(nVar-1);
        % F1
        F1 = x(1);
        % F2
        F2 = g*(1-power(F1/g,2));
        f = [F1
            F2];
        ps = x;
    end
    function [f,ps] = ZDT3(x)
        nVar = numel(x);
        % ZDT3
        g = 1+9*sum(x(2:end))/(nVar-1);
        % F1
        F1 = x(1);
        % F2
        F2 = g*(1-sqrt(F1/g)-F1/g*sin(10*pi()*F1));
        f = [F1
            F2];
        ps = x;
    end

end