function x = har_sim(dt)
t_0=0;
t_1=30;
t=0:dt:t_1;

x=zeros(1,length(t));
v=x;
%initialise
x(1)=1;
xi=di_sim(dt);

for j=2:length(t)
        x(j) = x(j-1)+dt*v(j-1);
        v(j) = v(j-1)+dt*(-1*(1+xi(j-1)))*x(j-1);
end
