%
% Copyright (c) 2015, Yarpiz (www.yarpiz.com)
% All rights reserved. Please read the "license.txt" for license terms.
%
% Project Code: YPEA102
% Project Title: Implementation of Particle Swarm Optimization in MATLAB
% Publisher: Yarpiz (www.yarpiz.com)
% 
% Developer: S. Mostapha Kalami Heris (Member of Yarpiz Team)
% 
% Contact Info: sm.kalami@gmail.com, info@yarpiz.com
%
all_sols = cell(1, 30);
all_A = zeros(1, 30);
all_Bestcost = cell(1, 30);
for iteration = 1:30
    tic;
    load LSU20

pso;
[out,sol,v] = my_3Dgps_network(GlobalBest.Position,LSU20);
A = toc;

    % Store results for this iteration
    all_sols{iteration} = sol;
    all_A(iteration) = A;
    all_Bestcost{iteration} = BestCost;
    BestCost = cell2mat(all_Bestcost);
    ALLCOOR = cell2mat(all_sols);
end

figure('Position', [100, 100, 800, 650]);
%plot(BestCost,'LineWidth',2);
semilogy(BestCost,'LineWidth',2);
xlabel('Iteration', 'FontSize', 15);
ylabel('Best Cost', 'FontSize', 15);
title('PSO Preformance - 30 times', 'FontSize', 15);

grid on;


   