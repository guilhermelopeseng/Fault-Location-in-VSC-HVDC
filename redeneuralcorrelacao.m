clc
clear all

%Simula��o de treinamento da RNA para o segundo m�todo
%Autor: Guilherme Lopes
%Universidade Federal do Piau�
load('./coleta_dados/correlacao_metodo');

% -------------------- Vari�veis Globais---------------------------------
Matriz = [];
entrada_treinamento = [];
entrada_teste = [];
previsao = [];
erro = [];

% -------------------Separa��o dos dados entre treinamento e teste -------
[treinamento, validacao, teste] = divideint(base,0.8,0,0.2);

%--------------------Organiza��o dos dados de entrada para treinamento----
for i = 1:1:entradas
    entrada_treinamento(i,:) = treinamento(i,:); %retirando loc. e res. da matriz
end

%--------------------Organiza��o dos dados de entrada para teste----------
for i = 1:1:entradas
    entrada_teste(i,:) = teste(i,:); %retirando loc. e res. da matriz
end

%--------------------Organiza��o dos dados de saida para treinamento-------
saida_treinamento(1,:) = treinamento(entradas+1,:);
saida_teste(1,:) = teste(entradas+1,:);

%------------------Outras configura��o de para compara��o de resultados----
resistencia_treinamento(1,:) = treinamento(entradas+2,:);
resistencia_teste(1,:) = teste(entradas+2,:);

%---------------Elabora��o da Matriz de m�n e m�x para RNA ---------------

for i = 1:1:entradas
    Matriz(i,1) = min(entrada_treinamento(i,:));
    Matriz(i,2) = max(entrada_treinamento(i,:));
end

%---------------Treinamento da RNA----------------------------------------
rede = newff( Matriz, [21 3 1], {'tansig' 'tansig' 'purelin'});
rede.trainParam.showWindow = true; 
rede.trainParam.mu = 0.01;
rede.trainParam.mu_dec = 0.1;
rede.trainParam.mu_inc = 9;
rede.trainParam.epochs = 200;%n�mero de �pocas desejadas
rede.trainParam.goal = 1e-20;%erro final desejado
rede.trainParam.show = 20;
NET = train(rede, entrada_treinamento, saida_treinamento);

%----------------------Teste da RNA---------------------------------------
for cont = 1:1:length(entrada_teste)
    previsao(1,cont) = sim(NET, entrada_teste(:,cont));
end

saida_teste = saida_teste*200;
previsao = previsao*200;

%----------------------Calculo dos erros do teste--------------------------
for cont = 1:1:length(saida_teste)
    erro(1,cont) = sqrt(immse(saida_teste(1,cont), previsao(1,cont)));
end

erro_max = max(erro)
erro_min = min(erro)
erro_medio = sqrt(perform(NET, saida_teste, previsao))
desvio_padrao = std(erro)

save('./resultados_redes_neurais/terceiro_metodo_polo_polo.mat');

%%
clc
clear all

%Simula��o de treinamento da RNA para o segundo m�todo
%Autor: Guilherme Lopes
%Universidade Federal do Piau�
load('./coleta_dados/correlacao_metodo');

% -------------------- Vari�veis Globais---------------------------------
Matriz = [];
entrada_treinamento = [];
entrada_teste = [];
previsao = [];
erro = [];

% -------------------Separa��o dos dados entre treinamento e teste -------
dataA = base';  % obt�m-se a matriz base
p = .8;      % propor��o do treinamento 
N = size(dataA,1);  % total do n�mero de linhas 
tf = false(N,1);    % cria��o do index logico do vetor
tf(1:round(p*N)) = true;     
tf = tf(randperm(N));   % Escolha aleatoriamente os valores
treinamento = dataA(tf,:)'; %Associa o vetor para o treinamento 
teste = dataA(~tf,:)'; %O restante associa para o vetor teste

%--------------------Organiza��o dos dados de entrada para treinamento----
for i = 1:1:entradas
    entrada_treinamento(i,:) = treinamento(i,:); %retirando loc. e res. da matriz
end

%--------------------Organiza��o dos dados de entrada para teste----------
for i = 1:1:entradas
    entrada_teste(i,:) = teste(i,:); %retirando loc. e res. da matriz
end

%--------------------Organiza��o dos dados de saida para treinamento-------
saida_treinamento(1,:) = treinamento(entradas+1,:);
saida_teste(1,:) = teste(entradas+1,:);

%------------------Outras configura��o de para compara��o de resultados----
resistencia_treinamento(1,:) = treinamento(entradas+2,:);
resistencia_teste(1,:) = teste(entradas+2,:);

%---------------Elabora��o da Matriz de m�n e m�x para RNA ---------------

for i = 1:1:entradas
    Matriz(i,1) = min(entrada_treinamento(i,:));
    Matriz(i,2) = max(entrada_treinamento(i,:));
end

%---------------Treinamento da RNA----------------------------------------
rede = newff( Matriz, [21 3 1], {'tansig' 'tansig' 'purelin'});
rede.trainParam.showWindow = true; 
rede.trainParam.mu = 0.01;
rede.trainParam.mu_dec = 0.1;
rede.trainParam.mu_inc = 9;
rede.trainParam.epochs = 200;%n�mero de �pocas desejadas
rede.trainParam.goal = 1e-20;%erro final desejado
rede.trainParam.show = 20;
NET = train(rede, entrada_treinamento, saida_treinamento);

%----------------------Teste da RNA---------------------------------------
for cont = 1:1:length(entrada_teste)
    previsao(1,cont) = sim(NET, entrada_teste(:,cont));
end

saida_teste = saida_teste*200;
previsao = previsao*200;

%----------------------Calculo dos erros do teste--------------------------
for cont = 1:1:length(saida_teste)
    erro(1,cont) = sqrt(immse(saida_teste(1,cont), previsao(1,cont)));
end

erro_max = max(erro)
erro_min = min(erro)
erro_medio = sqrt(perform(NET, saida_teste, previsao))
desvio_padrao = std(erro)

save('./resultados_redes_neurais/terceiro_metodo_polo_terra.mat');

