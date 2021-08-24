function pointload_cantilever
E=20e10;
v=0.3;
L=0.1;
b=0.05;
d=0.05;
D=E*(d^3)/(12*(1-v^2));
I=b*(d^3)/12;
S=7800;
N=40;
dx=L/N;
a=0.25;
dt=((a*S*d*(dx^4))/D)^(0.5);
w=zeros(N,6000);
P=zeros(N+1,6000);
P(40,1:3000)=+500000000000;
F=90000000;
x=zeros(N+1);
for j=1:6000
    w(1,j)=0;
end
for i=1:N+1
x(i)=dx*(i-1);
w(i,1)=0;%(-F*(x(i)^2)*(3*L-x(i)))/(6*E*I);
end
for j=2:6000
for i=2:N+1
if  j==2
if i==2
w(i,j)=w(i,1)-(a/2)*(w(4,1)-4*w(3,1)+7*w(2,1)-4*w(1,1))-(P(i,j)*((dt)^2)/(2*S*d));
elseif i==N
w(i,j)=w(N,1)-(a/2)*(w(N-2,1)-4*w(N-1,1)+5*w(N,1)-2*w(N+1,1))-(P(i,j)*((dt)^2)/(2*S*d));
elseif i==N+1
    w(i,j)=w(N+1,1)-(a/2)*(2*w(N-1,1)-4*w(N,1)+2*w(N+1,1))-(P(i,j)*((dt)^2)/(2*S*d));
else
w(i,j)=w(i,1)-(a/2)*(w(i+2,1)-4*w(i+1,1)+6*w(i,1)-4*w(i-1,1)+w(i-2,1))-(P(i,j)*((dt)^2)/(2*S*d));
end
else
if i==2
w(i,j)=(2*w(2,j-1)-w(2,j-2))-a*(w(4,j-1)-4*w(3,j-1)+7*w(2,j-1)-4*w(1,j-1))-(P(i,j)*((dt)^2)/(S*d));
elseif i==N
w(i,j)=(2*w(N,j-1)-w(N,j-2))-a*(-2*w(N+1,j-1)+5*w(N,j-1)-4*w(N-1,j-1)+w(N-2,j-1))-(P(i,j)*((dt)^2)/(S*d));
elseif i==N+1
    w(i,j)=(2*w(N+1,j-1)-w(N+1,j-2))-a*(2*w(N-1,j-1)-4*w(N,j-1)+2*w(N+1,j-1))-(P(i,j)*((dt)^2)/(S*d));
else
w(i,j)=(2*w(i,j-1)-w(i,j-2))-a*(w(i+2,j-1)-4*w(i+1,j-1)+6*w(i,j-1)-4*w(i-1,j-1)+w(i-2,j-1))-(P(i,j)*((dt)^2)/(S*d));
end
end
end
end
for j=1:10:6000
plot(x,w(:,j),'LineWidth',2)
% title(['t= ',num2str(t),' sec'])
 title(['t= ',num2str(j),' sec'])
 xlabel('Position (m)')
 ylabel('Displacement (m)')
 axis([0,2*L,-1.5,1.5])
 grid on
 getframe;
 pause(0.001)
end
disp(w);
