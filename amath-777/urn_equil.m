%do the Bernoulli urn simulation until inital state is reached again
%n is the number of balls in each urn
%num_trials is number of trials required until initial state is reached
function [num_trials] = urn_equil(n)

%balls in each urn
%total number of balls is 2n
total=2*n;
%number of trials
%x=1:1:10000;

%black = 0
%white = 1
%initally all white in urn 1
urn1=zeros(1,n)+1;
urn2=zeros(1,n);

i=1;
num_white=sum(urn1);
num_white_vec(i)=num_white;

%do initial swap
i=2;
a=randi(n,1);
b=randi(n,1);
A=urn1(a);
C=A;
urn1(a)=urn2(b);
urn2(b)=A;
num_white=sum(urn1);
num_white_vec(i)=num_white;
num_trials=1;

while(num_white~=n)
    i=i+1;
	a=randi(n,1);
	b=randi(n,1);
	A=urn1(a);
	C=A;
	urn1(a)=urn2(b);
	urn2(b)=A;
	num_white=sum(urn1);
    num_white_vec(i)=num_white;
    num_trials=num_trials+1;
end
%plot(num_white_vec)
%axis([0 num_trials+1 0 n])
end 