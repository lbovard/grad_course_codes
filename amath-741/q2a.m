clear all;

m=128;

deltax=1/(m-1);
deltat=0.00003;
alpha=deltat/deltax^2;


x=0:deltax:1;
u_init=sech(200*x-100).^2';
u_init(1)=0;
u_init(m)=0;

%differentiation matrix
D=sparse(2:m-1,1:m-2,alpha,m,m)+sparse(2:m-1,2:m-1,(1-2*alpha),m,m)+sparse(2:m-1,3:m,alpha,m,m);
u=D*u_init;

for i=1:50
	u=D*u;	
	plot(x,u);
	axis([0 1 0 0.3])
	M(i)=getframe;
end
	
