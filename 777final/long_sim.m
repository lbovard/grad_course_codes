clear all;

k=5000;
t_0=0;
t_1=30;
dt=0.01;
t=0:dt:30;
x=zeros(k,length(t));
tic
parfor j=1:k
        x(j,:)=har_sim(dt);
end
toc
tic 
parfor j=1:length(t)
	approx(j)=sum(x(:,j))/k
end
toc
exact=exp(-t/16).*(1/sqrt(223)*sin(sqrt(223)/16*t)+cos(sqrt(223)*t/16));

