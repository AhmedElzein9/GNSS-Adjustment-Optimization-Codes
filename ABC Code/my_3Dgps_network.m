%{
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







