%%% METHODS for Unrestricted Optimization - Performance Profile
% -------------------------------------------------------------------------

clear all

pkg load parallel
n_chuncks = 4; %4 core 

%limits
kmax= 100;
prec= 0.01;

% -------------------------------------------------------------------------
dados3
nprob= n_testes;%% total de problemas

% -------------------------------------------------------------------------
% Choice of Methods
% 1 = Cauchy
% 2 = Newton
% 3 = Gradiente Conjugado
% 4 = Quase-Newton BFGS
% 5 = Quase-Newton DFP

variant=[3 4];
nmet=length(variant);

% -------------------------------------------------------------------------
% Informacoes guardadas
it=zeros(nprob,nmet); % iteracoes

% -------------------------------------------------------------------------
disp('------------ BEGIN PP ---------------')
% -------------------------------------------------------------------------

tic 
for met= 1:nmet
    %print
    disp(['metodos: ',int2str(met),'/',int2str(nmet)]);
    fflush(stdout);
    
    %reset todas as funcoes para testar com outro metodo 
    for prob=1:nprob  
      testes(prob).reset()
    end
    
    k = 0;
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
    for prob=1:nprob
      it(prob,met)=k(prob);
    end
    
end

%print
disp('end');
fflush(stdout);
    

toc
%%% Salva informacoes em arquivo.mat
save guarda_dados_1.mat it nprob nmet kmax variant

clear all
