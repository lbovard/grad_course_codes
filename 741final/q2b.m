clear all;
m=128;
dx=2*pi/m;
x=-pi+dx:dx:pi;
alp=pi/20;
ialp=20/pi;
u_int=exp(-ialp^2*x.^2);
dt=0.00049;
k=[0:m/2-1 0 -m/2+1:-1];
k2=k.^2;
k4=k.^4;
t=50;
%get roughly the number of timesteps required
t_steps=ceil(t/dt);
u=u_int;
display =1;
%update time
for j=1:t_steps

	%compute first RK4
	%compute derivatives
	utmp=u;
	uhat=fft(utmp);
	%derivative of (u^2/2)_x
	uu_x = real(ifft(1i*k.*fft(utmp.^2/2)));
	u_xx = real(ifft(-k2.*uhat));
	u_xxxx=real(ifft(k4.*uhat));
	%define f(u)
	f=-uu_x*alp-u_xx*alp^2-u_xxxx*alp^4;

	q_1=dt*f;
	
	%compute second RK4
	utmp=u+q_1/2;
	uhat=fft(utmp);
	uu_x = real(ifft(1i*k.*fft(utmp.^2/2)));
	u_xx = real(ifft(-k2.*uhat));
	u_xxxx=real(ifft(k4.*uhat));
	f=-uu_x*alp-u_xx*alp^2-u_xxxx*alp^4;
	
	q_2=dt*f;

	%compute third RK4
	utmp=u+q_2/2;
	uhat=fft(utmp);
	uu_x = real(ifft(1i*k.*fft(utmp.^2/2)));
	u_xx = real(ifft(-k2.*uhat));
	u_xxxx=real(ifft(k4.*uhat));
	f=-uu_x*alp-u_xx*alp^2-u_xxxx*alp^4;
	
	q_3=dt*f;

	%compute fourth RK4
	utmp=u+q_1;
	uhat=fft(utmp);
	uu_x = real(ifft(1i*k.*fft(utmp.^2/2)));
	u_xx = real(ifft(-k2.*uhat));
	u_xxxx=real(ifft(k4.*uhat));
	f=-uu_x*alp-u_xx*alp^2-u_xxxx*alp^4;
	
	q_4=dt*f;

	u=u+(q_1+2*q_2+2*q_3+q_4)/6;
	if(display==1)
	if(mod(j,1000)==0)
		plot(x,u)
		axis([-pi+dx pi -3 3])
		M(j)=getframe;
	end
	end
end



