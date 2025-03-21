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
% Please note that these codes have been taken from:
% http://playmedusa.com/blog/roulette-wheel-selection-algorithm-in-matlab-2/
%
%   Reference:
%   S. Mirjalili, A.H. Gandomi, S.Z. Mirjalili, S. Saremi, H. Faris, S.M. Mirjalili,
%   Salp Swarm Algorithm: A bio-inspired optimizer for engineering design problems
%   Advances in Engineering Software
%   DOI: http://dx.doi.org/10.1016/j.advengsoft.2017.07.002
%____________________________________________________________________________________


% ---------------------------------------------------------
% Roulette Wheel Selection Algorithm. A set of weights
% represents the probability of selection of each
% individual in a group of choices. It returns the index
% of the chosen individual.
% Usage example:
% fortune_wheel ([1 5 3 15 8 1])
%    most probable result is 4 (weights 15)
% ---------------------------------------------------------

function choice = RouletteWheelSelection(weights)
% RouletteWheelSelection - Select an index based on probability weights
%
% Syntax:
%   choice = RouletteWheelSelection(weights)
%
% Inputs:
%   weights - Vector of weights representing selection probabilities
%
% Outputs:
%   choice  - Selected index based on the probability distribution
%
% Description:
%   This function implements the Roulette Wheel Selection algorithm, where each
%   weight represents the probability of selecting the corresponding index.
%   The probability of selection is proportional to the weight value.
%   Example:
%     choice = RouletteWheelSelection([1 5 3 15 8 1])
%     % Most probable result is 4 (weight 15)

    % Calculate cumulative sum of weights
    accumulation = cumsum(weights);
    
    % Generate random point
    p = rand() * accumulation(end);
    
    % Find the selected index
    chosen_index = -1;
    for index = 1 : length(accumulation)
        if (accumulation(index) > p)
            chosen_index = index;
            break;
        end
    end
    choice = chosen_index;
end
