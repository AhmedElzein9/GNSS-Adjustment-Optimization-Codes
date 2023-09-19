%{

Weighted Differential Evolution Algorithm  (WDE)

Platform: Matlab 2018a   


Cite this algorithm as;
-----------------------------
P Civicioglu,  E Besdok, MA Gunen, UH Atasever, (2018),  Weighted Differential Evolution Algorithm for Numerical Function Optimization ;  A Comparative Study with Cuckoo Search, Arti?cial Bee Colony, Adaptive Differential Evolution, and Backtracking Search Optimization Algorithms, Neural Comput & Applic (2018). https://doi.org/10.1007/s00521-018-3822-5

see for pdf
-----------------------------
https://link.springer.com/article/10.1007/s00521-018-3822-5#citeas




Copyright Notice
Copyright (c) 2018, P Civicioglu,  E Besdok, MA Gunen, UH Atasever

All rights reserved.

Redistribution and use in source and binary forms, with or without 
modification, are permitted provided that the following conditions are 
met:

    * Redistributions of source code must retain the above copyright 
      notice, this list of conditions and the following disclaimer.
    * Redistributions in binary form must reproduce the copyright 
      notice, this list of conditions and the following disclaimer in 
      the documentation and/or other materials provided with the distribution
      
THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" 
AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE 
IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE 
ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE 
LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR 
CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF 
SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS 
INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN 
CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) 
ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE 
POSSIBILITY OF SUCH DAMAGE.



%}





function algo_wde(fnc,LSU20,N,D,low,up,MaxEpk)

%INITIALIZATION
if numel(low)==1, low = low * ones(1,D); up = up * ones(1,D); end % this line must be adapted to your problem
P = GenP(2*N,D,low,up); % see Eq.1 in [1]
fitP = feval(fnc,P,LSU20);
B = zeros(MaxEpk,1);
% ------------------------------------------------------------------------------------------

for epk=1:MaxEpk
    
    j = randperm(2*N);
    k = j(1:N);
    l = j(N+1 : 2*N);
    trialP = P(k,:);
    fitTrialP = fitP(k);    
        
    temp = trialP ;  % memory
    for index = 1:N
        w = rand(N,1).^3;
        w = w ./ sum(w);
        temp(index,:) = sum( w .* P(l,:) );
    end
    
    while 1, m = randperm(N); if sum( 1:N == m ) == 0, break; end, end   %  bijective - morphism
            
    E = temp - trialP(m,:) ;
    
    %  recombination
    M = GenM(N,D);
    
    if rand<rand, F = randn(1,D).^3 ; else, F = randn(N,1).^3 ; end
    
    Trial = trialP + F .* M .* E;  % re-scaling and shift
    
    % Trial = BoundaryControl(Trial,low,up) ; % see Algorithm-3 in [1]
    
    fitT = feval(fnc,Trial,LSU20) ;
    ind = fitT < fitTrialP ;
    
    trialP(ind,:)  = Trial(ind,:) ;
    fitTrialP(ind) = fitT(ind) ;
    
    fitP(k)=fitTrialP;
    P(k,:)=trialP;
    
    % keep the solutions
    [bestsol,ind] = min(fitP);
    best = P(ind,:);
    B(epk)=bestsol;
    assignin('base','globalminimum',bestsol)
    assignin('base','globalminimizer',best)
    assignin('base','BestCost',B)
    % display the results
    fprintf('WDE | %5.0f ---> %9.16f \n',epk,bestsol) ;
    
       
end %epk

return


function M = GenM(N,D)
M = zeros(N,D);
for i=1:N
    if rand<rand, k = rand^3;  else, k=1-rand^3; end
    V = randperm(D);
    j = V( 1:ceil(k*D) );
    M(i,j) =  1;
end


function pop = GenP(N,D,low,up)
pop = ones(N,D);
for i = 1:N
    for j = 1:D
        pop(i,j) = rand * ( up(j) - low(j) ) + low(j);
    end
end
return


function pop = BoundaryControl(pop,low,up)
[popsize,dim] = size(pop);
for i = 1:popsize
    for j = 1:dim
        F = rand.^3 ;
        if pop(i,j) < low(j), pop(i,j) = low(j) +  F .* ( up(j)-low(j) );  end
        if pop(i,j) > up(j),  pop(i,j) = up(j)  +  F .* ( low(j)-up(j));   end
    end
end
return
















