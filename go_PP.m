%%% METHODS for Unrestricted Optimization - Performance Profile
% -------------------------------------------------------------------------

clear all

pkg load parallel
n_chuncks = 4; %4 core 

%limits
kmax= 200;
prec=0.01;

% -------------------------------------------------------------------------
% Dimension
vetorn=[ 5 10 15 20]; 
nn=length(vetorn);
% lambda min
lambdamin=[1 2 3 4 5];  %%% 
nlmin=length(lambdamin);
% lambda max
lambdamax=[10 11 12 13 14];  %%% 
nlmax=length(lambdamax);

nprob=nn*nlmin*nlmax; %% total de problemas

% -------------------------------------------------------------------------
% Choice of Methods
% 1 = Cauchy
% 2 = Newton
% 3 = Gradiente Conjugado
% 4 = Quase-Newton BFGS
% 5 = Quase-Newton DFP

variant=[2 4];
nmet=length(variant);

% -------------------------------------------------------------------------
% Informacoes guardadas
it=zeros(nprob,nmet); % iteracoes

% -------------------------------------------------------------------------
disp('-------------- BEGIN PP ---------------')
% -------------------------------------------------------------------------

%criando funcoes
probs=0;
tic
for in=1:nn   % varia n
    n=vetorn(in);
   
    for ilmin=1:nlmin % varia lambdamin
        lmin=lambdamin(ilmin);
        for ilmax=1:nlmax % varia lambdamax
            lmax=lambdamax(ilmax);
            %dados
            probs=probs+1;

            %criando funcao quadratica
            funcTestes(probs) = QuadFunc;
            funcTestes(probs).create(n,lmin,lmax);
            pontoX = rand(n,1); 
            testes(probs) = FuncClass(funcTestes(probs),pontoX);
                        
        end
    end
end


for met= 1:nmet
    k = 0;
    
    %print
    disp(['metodos: ',int2str(met),'/',int2str(nmet)]);
    fflush(stdout);
    
    switch variant(met)
           case 1   
              k = pararrayfun(n_chuncks,@(u) solve(u,kmax,prec,'gradiente','armijo'),testes(1:nprob),"ChunksPerProc", 1,"VerboseLevel", 0);               
           case 2
              k = pararrayfun(n_chuncks,@(u) solve(u,kmax,prec,'newton','armijo'),testes(1:nprob),"ChunksPerProc", 1,"VerboseLevel", 0);
           case 3
              k = pararrayfun(n_chuncks,@(u) solve(u,kmax,prec,'gradiente conjugado','armijo'),testes(1:nprob),"ChunksPerProc", 1,"VerboseLevel", 0);
           case 4
              k = pararrayfun(n_chuncks,@(u) solve(u,kmax,prec,'quase-newton','armijo'),testes(1:nprob),"ChunksPerProc", 1,"VerboseLevel", 0);
           case 5
              k = pararrayfun(n_chuncks,@(u) solve(u,kmax,prec,'quase-newton DFP','armijo'),testes(1:nprob),"ChunksPerProc", 1,"VerboseLevel", 0);
    end
   
    % Guarda para performance profile
    for prob = 1:probs
      it(prob,met)=k(prob);
    end
    
end

%print
disp([int2str(prob),'\',int2str(nprob));
fflush(stdout);

toc
%%% Salva informacoes em arquivo.mat
save guarda_dados_1.mat it nprob nmet kmax variant

clear all
