% tic
% %load LSU20
% bsa('my_3Dgps_network',LSU20,100,20*3,1,0,1,100)
% [out,sol,v] = my_3Dgps_network(globalminimizer,LSU20);
% Coordinate= sol;
% A = toc;
% Initialize arrays to store results

all_sols = cell(1, 30);
all_A = zeros(1, 30);
all_Bestcost = cell(1, 30);
for iteration = 1:30
    tic;
    load LSU20

    % Call the function
    bsa('my_3Dgps_network',LSU20,100,20*3,1,0,1,100000);
    [out, sol, v] = my_3Dgps_network(globalminimizer,LSU20);
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

