clear all;

N=10000;
x=zeros(9,N);
y=zeros(9,N);
k=10;

for j=1:k
        temp=int2str(j);
        temp_x=strcat('x_positions_',temp);
       	temp_y=strcat('y_positions_',temp);
        x(:,(j-1)*1000+1:1000*j)=dlmread(temp_x);
        y(:,(j-1)*1000+1:1000*j)=dlmread(temp_y);
end
X(:,1:N)=real(x);
X(:,N+1:2*N)=real(y);
Y(:,1:N)=imag(x);
Y(:,N+1:2*N)=imag(y);

for j=1:9
        temp=int2str(j);
        temp_x=strcat('x_coords_',temp);
        temp_y=strcat('y_coords_',temp);
        dlmwrite(temp_x,X(j,:));
        dlmwrite(temp_y,Y(j,:));
end
quit;
