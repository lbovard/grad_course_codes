clear all;

m=10;

deltax=1/(m-1);
deltat=0.00004;
alpha=deltat/deltax^2;


x=0:deltax:1;
u_init=sech(200*x-100).^2';
u_init(m)=0;

%differentiation matrix for n time
D_n=sparse(2:m-1,1:m-2,alpha,m,m)+sparse(2:m-1,2:m-1,(1-2*alpha),m,m)+sparse(2:m-1,3:m,alpha,m,m);
D_n(1,1)=1;
D_n(m,m)=1;
%differentiation matrix for n+1 time
D_n_1 =sparse(2:m-1,1:m-2,-alpha,m,m)+sparse(2:m-1,2:m-1,(1+2*alpha),m,m)+sparse(2:m-1,3:m,-alpha,m,m);
D_n_1(1,1)=1;
D_n_1(m,m)=1;

%compute the proper updating matrix
D=inv(D_n_1)*D_n;
%need these values to update u_1
u_old=[u_init(1),u_init(2)];
%update values
u=D*u_init;
%update the left boundary point manually, after the multiplication is done
u(1)=(1-2*alpha)*u_old(1)+2*alpha*u_old(2)-2*deltax*alpha;
for i=1:10
	u_old=[u(1),u(2)];
	u=D*u;	
	u(1)=(1-2*alpha)*u_old(1)+2*alpha*u_old(2)-2*deltax*alpha;
end

	plot(x,u);
	axis([0 1 -1 0.3])
