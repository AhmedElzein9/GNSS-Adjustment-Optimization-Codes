% GEOMETRIC OPTIMIZATION PROBLEM ;
% 3D BASELINE ADJUSTMENT - EXPERIMENTAL HEURISTIC TECHNIQUE
% 100-points based 3D network has been adjusted using baselines.
% private use only
% sol : adjusted coordinates
% v : computed baselines
% dxdydz : observed baselines (see the code, line 25)
clear;
clc;
all_sols = cell(1, 30);
all_A = zeros(1, 30);
all_Bestcost = cell(1, 30);
for iteration = 1:30
    tic;
    load LSU20

algo_wde('my_3Dgps_network',LSU20,100,20*3,0,1,100000)
[out,sol,v] = my_3Dgps_network(globalminimizer,LSU20);
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
title('WDE Performance - 30 times', 'FontSize', 15);

grid on;
