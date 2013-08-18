clear all;

m=128;

deltax=1/(m-1);
deltat=0.00004;
alpha=deltat/deltax^2;


x=0:deltax:1;
u_init=sech(200*x-100).^2';
u_init(m)=0;

%differentiation matrix
D=sparse(2:m-1,1:m-2,alpha,m,m)+sparse(2:m-1,2:m-1,(1-2*alpha),m,m)+sparse(2:m-1,3:m,alpha,m,m);
%need these values to update u_1
u_old=[u_init(1),u_init(2)];
%update values
u=D*u_init;
%update the left boundary point manually, after the multiplication is done
u(1)=(1-2*alpha)*u_old(1)+2*alpha*u_old(2)-2*deltax*alpha;
for i=1:2000
	u_old=[u(1),u(2)];
	u=D*u;	
	u(1)=(1-2*alpha)*u_old(1)+2*alpha*u_old(2)-2*deltax*alpha;
	plot(x,u);
	axis([0 1 -1 0.3])
    if(mod(i,10)==0) 
	M(i)=getframe;
    end
end

