function [vor_1,vor_2] = vortex_interaction

clear all; 

global vis dt correction

Re=1000;
vis = 1/Re;
dt=10^-4;
t_max=2.25;
t=dt:dt:t_max;
N=length(t);
display = 0;
%correction, 0 none, 1 self-advec, 2 other advec, 3 both
correction=2;
sampling=1;

psi_1=zeros(1,N);
psi_2=psi_1;
det_psi_1=psi_1;
det_psi_2=psi_2;

%initial positions
psi_1(1) = -0.5+0.0*1i;
psi_2(1) =  0.5+0.0*1i;

det_psi_1(1)=psi_1(1);
det_psi_2(1)=psi_2(1);


for j=2:N
        time_elapsed=j*dt;
        %update determistic position
        det_psi_1(j) = det_update_1(det_psi_1(j-1),det_psi_2(j-1));
        det_psi_2(j) = det_update_2(det_psi_1(j-1),det_psi_2(j-1));
        
        %update stochastic position
        psi_1(j) = update_1(psi_1(j-1),psi_2(j-1),det_psi_1(j-1),det_psi_2(j-1),time_elapsed);
        psi_2(j) = update_2(psi_1(j-1),psi_2(j-1),det_psi_1(j-1),det_psi_2(j-1),time_elapsed);             
end

%do sampling
if(sampling==1)
    sample_times=2500*(1:1:9);
    vor_1 = psi_1(sample_times);
    vor_2 = psi_2(sample_times);
end

if(display==1)
        clf
        plot(real(psi_1),imag(psi_1))
        hold on
        plot(real(psi_2),imag(psi_2),'red') 
end
if(display==2)
        clf
        plot(real(det_psi_1),imag(det_psi_1))
        hold on
        plot(real(det_psi_2),imag(det_psi_2))
end

end 

%update positions
function new_pos_1 = update_1(pos_1,pos_2,det_1,det_2,time)
        global dt vis correction
        nu=sqrt(8*pi*vis);
        if(correction==0)
            new_pos_1 = pos_1 + interaction(pos_1,pos_2)*dt + nu*sqrt(dt)*randn;
        elseif(correction==1)
            new_pos_1 = pos_1 +1i*dt*gauss_vort(det_1,time,pos_1)+ interaction(pos_1,pos_2)*dt + nu*sqrt(dt)*randn;
        elseif(correction==2)
            new_pos_1 = pos_1 +1i*dt*gauss_vort(det_2,time,pos_2)+ interaction(pos_1,pos_2)*dt + nu*sqrt(dt)*randn;
        elseif(correction==3)
            new_pos_1 = pos_1 +1i*dt*gauss_vort(det_2,time,pos_2)+1i*dt*gauss_vort(det_1,time,pos_1)+ interaction(pos_1,pos_2)*dt + nu*sqrt(dt)*randn;
        end
end

function new_pos_2 = update_2(pos_1,pos_2,det_1,det_2,time)
        global dt vis correction
        nu=sqrt(8*pi*vis);
        if(correction==0)
            new_pos_2 = pos_2 -  interaction(pos_1,pos_2)*dt + nu*sqrt(dt)*randn;
        elseif(correction==1)
            new_pos_2 = pos_2+gauss_vort(det_2,time,pos_2)*1i*dt -  interaction(pos_1,pos_2)*dt + nu*sqrt(dt)*randn;
        elseif(correction==2)
            new_pos_2 = pos_2+gauss_vort(det_1,time,pos_1)*1i*dt -  interaction(pos_1,pos_2)*dt + nu*sqrt(dt)*randn;
        elseif(correction==3)
            new_pos_2 = pos_2+1i*dt*gauss_vort(det_2,time,pos_2)+1i*dt*gauss_vort(det_1,time,pos_1) -  interaction(pos_1,pos_2)*dt + nu*sqrt(dt)*randn;
        end
end

%interaction term
function interact = interaction(pos_1,pos_2)
            interact = 2*1i*(pos_1-pos_2)/abs(pos_1-pos_2)^2;
end

function det_pos_1 = det_update_1(pos_1,pos_2)
        global dt
        det_pos_1 = pos_1 + dt*interaction(pos_1,pos_2);
end

function det_pos_2 = det_update_2(pos_1,pos_2)
        global dt
        det_pos_2 = pos_2 - dt*interaction(pos_1,pos_2);
end

%adds the determistic gaussian vortex effect at that point
function gaussian_vort = gauss_vort(position,time,stoch_pos)
        x=real(position);
        y=imag(position);
        x_s=real(stoch_pos);
        y_s=imag(stoch_pos);
        if(time<=1.07)
            gaussian_vort=exp(-(x-x_s)^2-(y-y_s)^2);
        else
            gaussian_vort=2*exp(-x_s^2-y_s^2);
        end
end
