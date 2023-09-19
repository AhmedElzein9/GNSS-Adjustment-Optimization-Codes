%{
% GEOMETRIC OPTIMIZATION PROBLEM ;
% 3D BASELINE ADJUSTMENT - EXPERIMENTAL HEURISTIC TECHNIQUE
% 100-points based 3D network has been adjusted using baselines.
% private use only
% sol : adjusted coordinates
% v : computed baselines
% dxdydz : observed baselines (see the code, line 25)


load gps_3Dnet_data LSU
algo_wde('my_3Dgps_network',LSU,5,100*3,0,1,3e6)
[out,sol,v] = my_3Dgps_network(globalminimizer,LSU)






%}

function [out,sol,v] = my_3Dgps_network(X,LSU20)
n=size(X,1);
out=size(n,1);
data=LSU20.data;
dxdydz=LSU20.dxdydz;
j=LSU20.connection;
N=size(data,1);
for i=1:n
   sol=reshape(X(i,:),N,3);
   dxdydz0=sol(j(:,1),:)-sol(j(:,2),:);    
   v=abs(dxdydz0-dxdydz);
   v=v-mean(v); % save centeroid of geometry
   err=sum(sum ( v .* v) ) ;
   out(i)=err ;  
end







