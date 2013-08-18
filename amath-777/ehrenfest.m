%simulation of Ehrenfest urn model

%run each simluation at n=5,6,7,8,9,10 a defined number of timesa

clear all;

n=5:1:10;
trials=1000;
i=1;
for j=n
    num=0;
    for k=1:trials 
        num=urn_equil(j)+num;
    end
    avg_trials(i)=num/trials;
    i=i+1;
end
    
    
