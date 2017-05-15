%>>>>>>>>       Banco de Funcoes Class        <<<<<<<<<<%
%       Gustavo Cordeiro - UTFPR - maio de 2017         %
%-------------------------------------------------------%
% 

classdef BancodeFuncoes<handle
    properties (SetAccess = private)    
    end
    properties (SetAccess = public)
        n
        m
        nome
    end
    methods(SetAccess = public)
      function obj = BancodeFuncoes(nome,n,m)
        obj.nome = nome;
        obj.n = n;
        obj.m = m;
      end
      function out = func(obj, x, ordem)
        addpath('@BancodeFuncoes');
        %ordem nao informada
        if(nargin==2)
          ordem = 0;
        end
        if(ordem==0) %f(x) = fvec'*fvec
          [fvec,J] = feval(obj.nome,obj.n,obj.m,x,1);
          out = fvec'*fvec;
        elseif (ordem==1)% \/f(x)= 2*J'*fvec;
          [fvec,J] = feval(obj.nome,obj.n,obj.m,x,3);
          out = (2*J')*fvec;
        %elseif (ordem==2)
        %  out = ;
        else
          out = 0;
        end
      end
    end
end
    