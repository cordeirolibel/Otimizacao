%>>>>>>>>        Otimizacao Irrestrita        <<<<<<<<<<%
%       Gustavo Cordeiro - UTFPR - maio de 2017         %
%-------------------------------------------------------%
%
%  Banco de Funcoes
%  More, Garbow e Hillstrom

%dimensao maxima
max_d = 20;
%dimensao minima
min_d = 2;
%numero de funcoes usadas (max 33)
n_testes = 33; 

nomes = [ 'badscb',	 
          'badscp', 
          'band',
          'bard',
          'bd',
          'beale',
          'biggs',	 
          'box1',
          'bv',
          'froth', 
          'gauss', 
          'gulf', 
          'helix',
          'ie',
          'jensam',
          'kowosb',
          'lin',
          'lin0', 
          'lin1',
          'meyer',
          'osb1',
          'osb2',
          'pen1',
          'pen2',
          'rosen',
          'rosex',
          'sing',
          'singx',
          'trid',
          'trig',
          'vardim', 
          'watson',
          'wood'];
          
ns = [2,
      2,
      floor(rand*(max_d-min_d+1)+min_d), %rand int [min_d,max_d]
      3,
      4,
      2,
      6,
      3,
      floor(rand*(max_d-min_d+1)+min_d),
      2,
      3,
      3,
      3,
      floor(rand*(max_d-min_d+1)+min_d),
      2,
      4,
      floor(rand*(max_d-min_d+1)+min_d),
      floor(rand*(max_d-min_d+1)+min_d),
      floor(rand*(max_d-min_d+1)+min_d),
      3,
      5,
      11,
      floor(rand*(max_d-min_d+1)+min_d),
      floor(rand*(max_d-min_d+1)+min_d),
      2,
      round((rand*(floor(max_d/2)*2-ceil(min_d/2)*2+1)+ceil(min_d/2)*2)/2)*2, %rand int [min_d,max_d] multiplo de 4,
      4,
      round((rand*(floor(max_d/4)*4-ceil(min_d/4)*4+1)+ceil(min_d/4)*4)/4)*4, %rand int [min_d,max_d] multiplo de 4
      floor(rand*(max_d-min_d+1)+min_d),
      floor(rand*(max_d-min_d+1)+min_d),
      floor(rand*(max_d-min_d+1)+min_d),
      20,
      4];

ms = [3,
      2,
      ns(3),
      15,
      20,
      3,
      13,
      10,
      ns(9),
      2,
      15,
      floor(rand*((max_d>100)*100+(max_d<=100)*100-ns(12)+1)+ns(12)),%rand int [n,max_d or 100]
      3,
      ns(14),
      ns(15),
      11,
      floor(rand*(max_d-ns(17)+1)+ns(17)),%rand int [n,max_d]
      floor(rand*(max_d-ns(18)+1)+ns(18)),
      floor(rand*(max_d-ns(19)+1)+ns(19)),
      16,
      33,
      65,
      ns(23)+1,
      2*ns(24),
      2,
      ns(26),
      4,
      ns(28),
      ns(29),
      ns(30),
      ns(31)+2,
      31,
      6];

%carregando funcoes
for i=1:1:n_testes
  funcTeste(i) = BancodeFuncoes(strtrim(nomes(i,:)),ns(i),ms(i));
  pontoX = rand(ns(i),1);
  testes(i) = FuncClass(funcTeste(i),pontoX);
end

clear nomes ns ms i pontoX max_d min_d