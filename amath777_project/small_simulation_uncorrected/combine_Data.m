clear all;

X=dlmread('x_positions');
Y=dlmread('y_positions');
N=2*length(X);

for i=1:9
	temp=int2str(i);
	temp_x=strcat('x_coords_',temp);
	temp_y=strcat('y_coords_',temp);
	x(1:N/2)=real(X(i,:));
	x(N/2+1:N)=real(Y(i,:));
	y(1:N/2)=imag(X(i,:));
	y(N/2+1:N)=imag(Y(i,:));
	dlmwrite(temp_x,x);
	dlmwrite(temp_y,y);	
end
quit
