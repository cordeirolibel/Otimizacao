%>>>>>>>>        Otimizacao Irrestrita        <<<<<<<<<<%
%     Gustavo Cordeiro - UTFPR - janeiro de 2017        %
%-------------------------------------------------------%

pkg load parallel

%load functions
dados2;

%limits
kmax = 100;
prec = 0.01;

%divisao dos problemas
MIN = 10;
MAX = n_testes;
N_PASSOS = 5;
PASSO = floor((MAX-MIN)/N_PASSOS);
MED = 1; %calcula MED vezes e tira a media dos tempos

%parametros para os graficos
ns = MIN:PASSO:MAX;
t_serial = [];
t_parallel = [];

[MIN,MAX]

for n = ns
  n
  
  tempo = [];
  %serial
  for i = 1:MED
    tic
    for i = 1:n
      solve(testes(i),100,0.01,'newton','armijo');
    end
    tempo = [tempo,toc];
  end
  t_serial = [t_serial,mean(tempo)];
  
  tempo = [];
  %paralelo
  for i = 1:MED
    tic
    pararrayfun(4,@(u) solve(u,100,0.01,'newton','armijo'),testes(1:n),"ChunksPerProc", 1,"VerboseLevel", 0);
    tempo = [tempo,toc];
  end
  t_parallel = [t_parallel,mean(tempo)];

end

%=====plot
clf;
plot(ns,t_serial,'color','r','linewidth',2.0)
hold on;
plot(ns,t_parallel,'color','b','linewidth',2.0)

%legendas
leg = legend('Serial',
             'Paralelo','location','southeast');
set (leg, 'fontsize', 14);

xlabel('Numero de problemas','FontSize',16);
ylabel('Tempo(s)','FontSize',16);

%print ('img/paralelo','-djpg');
hold off;

%clear t_serial t_parallel ns funcTeste testes