clc
clear all

%Simulação de treinamento da RNA para o segundo método
%Autor: Guilherme Lopes
%Universidade Federal do Piauí

%% Treinamento da Rede Neural para faltas Polo Polo
clc
clear all
load('./coleta_dados/segundo_metodo_polo_polo');

% -------------------- Variáveis Globais---------------------------------
Matriz = [];
entrada_treinamento = [];
entrada_teste = [];
quant_entradas = 32;
previsao = [];
erro = [];

% ------------------- Normalização da matriz de entrada ------------------
for i = 17:1:quant_entradas
    for j = 1:1:length(base)
        base(i,j) = (base(i,j) - min(base(i,:)))/( max(base(i,:))- min(base(i,:)) );
    end
end

base(quant_entradas+1,:) = distanciaFaltas;
base(quant_entradas+2,:) = resistenciaFaltas;
% -------------------Separação dos dados entre treinamento e teste -------
[treinamento, validacao, teste] = divideint(base,0.8,0,0.2);

%--------------------Organização dos dados de entrada para treinamento----
for i = 1:1:quant_entradas
    entrada_treinamento(i,:) = treinamento(i,:); %retirando loc. e res. da matriz
end

%--------------------Organização dos dados de entrada para teste----------
for i = 1:1:quant_entradas
    entrada_teste(i,:) = teste(i,:); %retirando loc. e res. da matriz
end

%--------------------Organização dos dados de saida para treinamento-------
saida_treinamento(1,:) = treinamento(quant_entradas+1,:);
saida_teste(1,:) = teste(quant_entradas+1,:);

%------------------Outras configuração de para comparação de resultados----
resistencia_treinamento(1,:) = treinamento(quant_entradas+2,:);
resistencia_teste(1,:) = teste(quant_entradas+2,:);

%---------------Elaboração da Matriz de mín e máx para RNA ---------------

for i = 1:1:quant_entradas
    Matriz(i,1) = min(entrada_treinamento(i,:));
    Matriz(i,2) = max(entrada_treinamento(i,:));
end

%---------------Treinamento da RNA----------------------------------------
rede = newff( Matriz, [21 3 1], {'tansig' 'tansig' 'purelin'});
rede.trainParam.showWindow = true; 
rede.trainParam.mu = 0.001;
rede.trainParam.mu_dec = 0.1;
rede.trainParam.mu_inc = 9;
rede.trainParam.epochs = 50;%número de épocas desejadas
rede.trainParam.goal = 1e-12;%erro final desejado
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

save('./resultados_redes_neurais/segundo_metodo_polo_polo.mat');

%% Treinamento da Rede Neural para faltas Polo Terra
clc
clear all
load('./coleta_dados/segundo_metodo_polo_terra');

% -------------------- Variáveis Globais---------------------------------
Matriz = [];
entrada_treinamento = [];
entrada_teste = [];
quant_entradas = 32;
previsao = [];
erro = [];

% ------------------- Normalização da matriz de entrada ------------------
for i = 17:1:quant_entradas
    for j = 1:1:length(base)
        base(i,j) = (base(i,j) - min(base(i,:)))/( max(base(i,:))- min(base(i,:)) );
    end
end
base(quant_entradas+1,:) = distanciaFaltas;
base(quant_entradas+2,:) = resistenciaFaltas;
% -------------------Separação dos dados entre treinamento e teste -------
[treinamento, validacao, teste] = divideint(base,0.8,0,0.2);

%--------------------Organização dos dados de entrada para treinamento----
for i = 1:1:quant_entradas
    entrada_treinamento(i,:) = treinamento(i,:); %retirando loc. e res. da matriz
end

%--------------------Organização dos dados de entrada para teste----------
for i = 1:1:quant_entradas
    entrada_teste(i,:) = teste(i,:); %retirando loc. e res. da matriz
end

%--------------------Organização dos dados de saida para treinamento-------
saida_treinamento(1,:) = treinamento(quant_entradas+1,:);
saida_teste(1,:) = teste(quant_entradas+1,:);

%------------------Outras configuração de para comparação de resultados----
resistencia_treinamento(1,:) = treinamento(quant_entradas+2,:);
resistencia_teste(1,:) = teste(quant_entradas+2,:);

%---------------Elaboração da Matriz de mín e máx para RNA ---------------

for i = 1:1:quant_entradas
    Matriz(i,1) = min(entrada_treinamento(i,:));
    Matriz(i,2) = max(entrada_treinamento(i,:));
end

%---------------Treinamento da RNA----------------------------------------
rede = newff( Matriz, [21 3 1], {'tansig' 'tansig' 'purelin'});
rede.trainParam.showWindow = true; 
rede.trainParam.mu = 0.001;
rede.trainParam.mu_dec = 0.1;
rede.trainParam.mu_inc = 9;
rede.trainParam.epochs = 30;%número de épocas desejadas
rede.trainParam.goal = 1e-12;%erro final desejado
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

save('./resultados_redes_neurais/segundo_metodo_polo_terra.mat');

%% Treinamento da Rede Neural para faltas Polo Terra e Polo Polo sem classificador
clc
clear all
load('./coleta_dados/segundo_metodo');

% -------------------- Variáveis Globais---------------------------------
Matriz = [];
entrada_treinamento = [];
entrada_teste = [];
quant_entradas = 16;
previsao = [];
erro = [];

% ------------------- Normalização da matriz de entrada ------------------
for i = 1:1:quant_entradas
    for j = 1:1:length(base)
        base(i,j) = (base(i,j) - min(base(i,:)))/( max(base(i,:))- min(base(i,:)) );
    end
end
base(quant_entradas+1,:) = distanciaFaltas;
base(quant_entradas+2,:) = resistenciaFaltas;
% -------------------Separação dos dados entre treinamento e teste -------
[treinamento, validacao, teste] = divideint(base,0.8,0,0.2);

%--------------------Organização dos dados de entrada para treinamento----
for i = 1:1:quant_entradas
    entrada_treinamento(i,:) = treinamento(i,:); %retirando loc. e res. da matriz
end

%--------------------Organização dos dados de entrada para teste----------
for i = 1:1:quant_entradas
    entrada_teste(i,:) = teste(i,:); %retirando loc. e res. da matriz
end

%--------------------Organização dos dados de saida para treinamento-------
saida_treinamento(1,:) = treinamento(quant_entradas+1,:);
saida_teste(1,:) = teste(quant_entradas+1,:);

%------------------Outras configuração de para comparação de resultados----
resistencia_treinamento(1,:) = treinamento(quant_entradas+2,:);
resistencia_teste(1,:) = teste(quant_entradas+2,:);

%---------------Elaboração da Matriz de mín e máx para RNA ---------------

for i = 1:1:quant_entradas
    Matriz(i,1) = min(entrada_treinamento(i,:));
    Matriz(i,2) = max(entrada_treinamento(i,:));
end

%---------------Treinamento da RNA----------------------------------------
rede = newff( Matriz, [12 3 1], {'tansig' 'tansig' 'purelin'});
rede.trainParam.showWindow = true; 
rede.trainParam.mu = 0.001;
rede.trainParam.mu_dec = 0.1;
rede.trainParam.mu_inc = 9;
rede.trainParam.epochs = 40;%número de épocas desejadas
rede.trainParam.goal = 1e-12;%erro final desejado
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

save('./resultados_redes_neurais/segundo_metodo.mat');