clear all;

matlabpool open 
%number of simulations
%each simulation takes about a second
%1000 takes about 17 minutes
N=1000;

x_pos=zeros(9,N);
y=x_pos;
tic
parfor i=1:N
        %do simulation
        [x,y]=vortex_interaction;
        x_pos(:,i)=x;
        y_pos(:,i)=y;	
end
toc

dlmwrite('x_positions',x_pos)
dlmwrite('y_positions',y_pos)
quit
