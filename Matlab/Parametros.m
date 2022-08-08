Jl=0.252; %%+-.1260
Jlmin=0.252-.126;
Jlmax=0.256+.126;
bl=0; %%+-.0630
blmax=0+.063;
blmin=0-.063;
Tl=0; %%+-1.57
Tlmin=0-1.57;
Tlmax=0+1.57;

Jm=3.1e-6; 
bm=1.5e-5;

nqnom=21; %%velocidad nominal de salida rpm q punto=2.2 rad/s
Tqnom=7.26; %%regimen continuo o rms
Tqmax=29.42; %%Corta duracion aceleracion
lambdam=.01546; %%verificar unidades
Pp=3;
Lq=5.8e-3;
Ld=6.6e-3;
Lls=0.8e-3;
Rs40=1.02;
Rs115=1.32;
Rs=1.02;

Rts=55;
Cts=1.091;

r=314.3008;
Jeq=Jm+(Jl/r^2);
beq=bm+(bl/r^2);
Jeqmi=Jm+(Jlmin/r^2);
beqmi=bm+(blmin/r^2);
Jeqma=Jm+(Jlmax/r^2);
beqma=bm+(blmax/r^2);

ke_thetha=6400;
ke_omega=3200^2;


ke_thetha2=6400+3200
ke_omega2=3200^2+(6400*3200)
ke_int=3200^3


Ka=(3/2)*Pp*lambdam;
Kb=Pp*lambdam;

R0p=4;
Rdp=33;
Rqp=29;

wpos=800;
n=2.5;

ba=Jeq*n*wpos;
ksa=Jeq*n*wpos^2;
ksia=Jeq*wpos^3;

G1=tf([Ka],[Jeq*Lq,Rs40*Jeq+beq*Lq,Rs40*beq+(3/2)*9*lambdam^2,0]);
G2=tf([Ka],[Jeqmi*Lq,Rs40*Jeqmi+beqmi*Lq,Rs40*beqmi+(3/2)*9*lambdam^2,0]);
G3=tf([Ka],[Jeqma*Lq,Rs40*Jeqma+beqma*Lq,Rs40*beqma+(3/2)*9*lambdam^2,0]);
H1=tf([Lq,Rs40],[Jeq*Lq,Rs40*Jeq+beq*Lq,Rs40*beq+(3/2)*9*lambdam^2,0]);

p1=pole(G1);
p2=pole(G2);
p3=pole(G3);
z1=zero(H1);
figure(1);
pzplot(H1,'r',G2,'g',G3,'k');
legend("Polos y cero valores nominales","Polos valores minimos","Polos valores maximos");
grid on;

G4=tf([Ka],[Jeq*Lq,Rs115*Jeq+beq*Lq,Rs115*beq+(3/2)*9*lambdam^2,0]);
G5=tf([Ka],[Jeqmi*Lq,Rs115*Jeqmi+beqmi*Lq,Rs115*beqmi+(3/2)*9*lambdam^2,0]);
G6=tf([Ka],[Jeqma*Lq,Rs115*Jeqma+beqma*Lq,Rs115*beqma+(3/2)*9*lambdam^2,0]);
H2=tf([Lq,Rs115],[Jeq*Lq,Rs115*Jeq+beq*Lq,Rs115*beq+(3/2)*9*lambdam^2,0]);
p4=pole(G4);
p5=pole(G5);
p6=pole(G6);
z2=zero(H2);

figure(2);
pzplot(H2,'r',G5,'g',G6,'k');
legend("Polos y cero valores nominales","Polos valores minimos","Polos valores maximos");
grid on;

wn=sqrt((Rs40*beq+3/2*Pp^2*lambdam^2)/(Jeq*Lq));
tzita=(Rs40/Lq+beq/Jeq)/(2*wn);

%scope_omega_m=stepinfo(out.omega(1000:2999),'SettlingTimeThreshold',0.01)
%scope_iqs=stepinfo(out.iqs(3000:5000),'SettlingTimeThreshold',0.01)

G7=tf([1],[Jeq,ba,ksa,ksia]);
G8=tf([1],[Jeqma,ba,ksa,ksia]);
p7=pole(G7);
p8=pole(G8);
figure(3);
pzplot(G1,'r',G7,'b',G8,'k');
legend("Sistema original R40","PID (Jeq nominal)","PID (Jeq maximo)");

grid on;

wn1=sqrt((Rs40*beqma+3/2*Pp^2*lambdam^2)/(Jeqma*Lq))
tzita1=(Rs40/Lq+beqma/Jeqma)/(2*wn1)

wn2=sqrt((Rs40*beqmi+3/2*Pp^2*lambdam^2)/(Jeqmi*Lq))
tzita2=(Rs40/Lq+beqmi/Jeqmi)/(2*wn2)

wn11=sqrt((Rs115*beqma+3/2*Pp^2*lambdam^2)/(Jeqma*Lq))
tzita1=(Rs115/Lq+beqma/Jeqma)/(2*wn11)

wn22=sqrt((Rs115*beqmi+3/2*Pp^2*lambdam^2)/(Jeqmi*Lq))
tzita2=(Rs115/Lq+beqmi/Jeqmi)/(2*wn22)

