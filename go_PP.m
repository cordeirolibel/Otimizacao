%%% METHODS for Unrestricted Optimization - Performance Profile
% -------------------------------------------------------------------------

clear all

%limits
kmax= 20;
prec=0.001;

% -------------------------------------------------------------------------
% Dimension
vetorn=[ 5 10 15 20]; 
nn=length(vetorn);
% lambda min
lambdamin=[1 2 3 4 5 ];  %%% 
nlmin=length(lambdamin);
% lambda max
lambdamax=[10 11 12 13 14];  %%% 
nlmax=length(lambdamax);

nprob=nn*nlmin*nlmax; %% total de problemas

% -------------------------------------------------------------------------
% Choice of Methods
% 1 = Cauchy
% 2 = Newton

variant=[1 2];
nmet=length(variant);

% -------------------------------------------------------------------------
% Informacoes guardadas
it=zeros(nprob,nmet); % iteracoes

% -------------------------------------------------------------------------
disp('------------------------------ BEGIN PP ------------------------------')
% -------------------------------------------------------------------------
prob=0;
for in=1:nn   % varia n
    n=vetorn(in);
   
    for ilmin=1:nlmin % varia lambdamin
        lmin=lambdamin(ilmin);
        for ilmax=1:nlmax % varia lambdamax
            lmax=lambdamax(ilmax);
           
            %dados
            prob=prob+1;
            
            %criando funcao quadratica
            funcTeste = QuadFunc;
            funcTeste.create(n,lmin,lmax);
            pontoX = rand(n,1); 
            
            for i= 1:nmet
                k = 0;
                func = FuncClass(funcTeste,pontoX);
                switch variant(i)
                       case 1 
                        k = func.solve('gradiente','armijo',kmax,prec);                        
                       case 2 
                       for k=1:kmax
                         k = func.solve('newton','armijo',kmax,prec);
                       end
                end
               
                % Guarda para performance profile
                it(prob,i)=k;
                
            end
            %print
            disp([int2str(prob),'\',int2str(nprob),' - ','n:',int2str(n),' lmin:',int2str(lmin),' lmax:',int2str(lmax)]);
        end
    end
end

%%% Salva informacoes em arquivo.mat
save guarda_dados_1.mat it nprob nmet kmax

clear all
