function xi = di_sim(dt)
t_0=0;
t_1=30;
t=t_0:dt:t_1;

%randoml choose what the initial condition is
if(rand<0.5)
        p_p=0.5+0.5*exp(-2*t);
        p_m=0.5-0.5*exp(-2*t);
else
        p_p=0.5-0.5*exp(-2*t);
        p_m=0.5+0.5*exp(-2*t);
end

%generate a string of random numbers
x=rand(1,length(t));
%calculate the probability of it being at plus or minus at each step
for j=1:length(t)
        if(x(j)<=p_p(j))
                xi(j)=1;
        else
                xi(j)=-1;
        end
end
