clc
clear all

%Simulação para coleta dos dados para os métodos propostos
%Autor: Guilherme Lopes
%Universidade Federal do Piauí

%% Coleta das entradas utilizando todos os filtros para RMA, faltas polo polo
% Adicionar Path do MFCC
addpath(genpath('C:\Users\guilh\OneDrive\Documentos\IC 2021\Fault-Location-in-VSC-HVDC\rastamat'));

%----------------------------Variáveis de Entrada da RNA -----------------%
base = [];
%----------------------------Variável de Saída da RNA --------------------%
distanciaFaltas = [];
%----------------------------Variáveis Globais ---------------------------%
fs = 135000; % frequência da simulução
inicio = 2700; % inicio da janela escolhida
fim = 3214; % fim da janela escolhida

resistenciasEscolhidas = [1, 5:5:50, 60:10:100, 150:50:300];

mat = '.mat';
caminho = './faltas_polo_polo/';
caminhoSave = './coleta_dados/novo_metodo_mfcc.mat';
cont = 1;
criterio = 100;
numCep = 24;
for localizacao = 5:5:195
    nameLoc = sprintf('L%.0f', localizacao);
    for k = 1:1:length(resistenciasEscolhidas)
        resistencia = resistenciasEscolhidas(k);
        nameRes = sprintf('R%.3f', resistencia);
        nameCom = strcat(caminho,nameLoc, nameRes, mat);
        if(exist(nameCom,'file') == 2)
            load(nameCom);
            sinal = correnteretificadorpos.Data(inicio:fim,1);
            time = (correnteretificadorpos.Time(fim)-correnteretificadorpos.Time(inicio));
            [mm,aspc] = melfcc(sinal, fs, 'maxfreq', fs/2, 'numcep', numCep, 'dcttype', 1, 'wintime', time, 'hoptime', time/2, 'preemph', 0);
            base(:,cont) = mm;
            distanciaFaltas(:,cont) = localizacao/200;
            resistenciaFaltas(:,cont) = resistencia;
            cont=cont+1;
        else
            fprintf(nameCom)                
        end
    end
end
save(caminhoSave)
%% Coleta das entradas utilizando todos os filtros para RMA, faltas polo terra
% Adicionar Path do MFCC
addpath(genpath('C:\Users\guilh\OneDrive\Documentos\IC 2021\Fault-Location-in-VSC-HVDC\rastamat'));

%----------------------------Variáveis de Entrada da RNA -----------------%
base = [];
%----------------------------Variável de Saída da RNA --------------------%
distanciaFaltas = [];
%----------------------------Variáveis Globais ---------------------------%
fs = 135000; % frequência da simulução
inicio = 2700; % inicio da janela escolhida
fim = 3214; % fim da janela escolhida

resistenciasEscolhidas = [1, 5:5:50, 60:10:100, 150:50:300];

mat = '.mat';
caminho = './faltas_polo_terra/';
caminhoSave = './coleta_dados/novo_metodo_mfcc_polo_terra.mat';
cont = 1;
numCep = 24;
for localizacao = 5:5:195
    nameLoc = sprintf('L%.0f', localizacao);
    for k = 1:1:length(resistenciasEscolhidas)
        resistencia = resistenciasEscolhidas(k);
        nameRes = sprintf('R%.3f', resistencia);
        nameCom = strcat(caminho,nameLoc, nameRes, mat);
        if(exist(nameCom,'file') == 2)
            load(nameCom);
            sinal = correnteretificadorpos.Data(inicio:fim,1);
            time = (correnteretificadorpos.Time(fim)-correnteretificadorpos.Time(inicio));
            [mm,aspc] = melfcc(sinal, fs, 'maxfreq', fs/2, 'numcep', numCep, 'dcttype', 1, 'wintime', time, 'hoptime', time/2, 'preemph', 0);
            base(:,cont) = mm;
            distanciaFaltas(:,cont) = localizacao/200;
            resistenciaFaltas(:,cont) = resistencia;
            cont=cont+1;
        else
            fprintf(nameCom)                
        end
    end
end
save(caminhoSave)

%%  Utilizando todos os filtros como entrada para RNA, faltas polo polo
warning('off','all')
% Adicionar Path do MFCC
addpath(genpath('C:\Users\guilh\OneDrive\Documentos\IC 2021\Fault-Location-in-VSC-HVDC\rastamat'));

%----------------------------Variáveis de Entrada da RNA -----------------%
base = [];
%----------------------------Variável de Saída da RNA --------------------%
distanciaFaltas = [];
%----------------------------Variáveis Globais ---------------------------%
fs = 135000; % frequência da simulução
inicio = 2700; % inicio da janela escolhida
fim = 3214; % fim da janela escolhida

resistenciasEscolhidas = [1, 5:5:50, 60:10:100, 150:50:300];

mat = '.mat';
caminho = './faltas_polo_polo/';
caminhoSave = './resultados_redes_neurais/novo_metodo.mat';
cont = 1;
criterio = 100;

for numCep = 15:1:30
    for localizacao = 5:5:195
        nameLoc = sprintf('L%.0f', localizacao);
        for k = 1:1:length(resistenciasEscolhidas)
            resistencia = resistenciasEscolhidas(k);
            nameRes = sprintf('R%.3f', resistencia);
            nameCom = strcat(caminho,nameLoc, nameRes, mat);
            if(exist(nameCom,'file') == 2)
                load(nameCom);
                sinal = correnteretificadorpos.Data(inicio:fim,1);
                time = (correnteretificadorpos.Time(fim)-correnteretificadorpos.Time(inicio));
                [mm,aspc] = melfcc(sinal, fs, 'maxfreq', fs/2, 'numcep', numCep, 'dcttype', 1, 'wintime', time, 'hoptime', time/2, 'preemph', 0);
                base(:,cont) = mm;
                distanciaFaltas(:,cont) = localizacao/200;
                resistenciaFaltas(:,cont) = resistencia;
                cont=cont+1;
            else
                fprintf(nameCom)                
            end
        end
    end
    cont = 1;
    % -------------------- Variáveis Globais---------------------------------
    Matriz = [];
    entrada_treinamento = [];
    entrada_teste = [];
    previsao = [];
    erro = [];

    % ------------------- Normalização da matriz de entrada ------------------
    for i = 1:1:numCep
        for j = 1:1:length(base)
            base(i,j) = (base(i,j) - min(base(i,:)))/( max(base(i,:))- min(base(i,:)) );
        end
    end
    base(numCep+1,:) = distanciaFaltas;
    base(numCep+2,:) = resistenciaFaltas;
    % -------------------Separação dos dados entre treinamento e teste -------
    dataA = base';  % obtêm-se a matriz base
    p = .8;      % proporção do treinamento 
    N = size(dataA,1);  % total do número de linhas 
    tf = false(N,1);    % criação do index logico do vetor
    tf(1:round(p*N)) = true;     
    tf = tf(randperm(N));   % Escolha aleatoriamente os valores
    treinamento = dataA(tf,:)'; %Associa o vetor para o treinamento 
    teste = dataA(~tf,:)'; %O restante associa para o vetor teste

    %--------------------Organização dos dados de entrada para treinamento----
    for i = 1:1:numCep
        entrada_treinamento(i,:) = treinamento(i,:); %retirando loc. e res. da matriz
    end

    %--------------------Organização dos dados de entrada para teste----------
    for i = 1:1:numCep
        entrada_teste(i,:) = teste(i,:); %retirando loc. e res. da matriz
    end

    %--------------------Organização dos dados de saida para treinamento-------
    saida_treinamento(1,:) = treinamento(numCep+1,:);
    saida_teste(1,:) = teste(numCep+1,:);

    %------------------Outras configuração de para comparação de resultados----
    resistencia_treinamento(1,:) = treinamento(numCep+2,:);
    resistencia_teste(1,:) = teste(numCep+2,:);

    %---------------Elaboração da Matriz de mín e máx para RNA ---------------
    for i = 1:1:numCep
        Matriz(i,1) = min(entrada_treinamento(i,:));
        Matriz(i,2) = max(entrada_treinamento(i,:));
    end
    %---------------Treinamento da RNA----------------------------------------
    for x = 12:1:25
        for y = 1:1:5
            for range = 1:1:5
                rede = newff( Matriz, [x y 1], {'tansig' 'tansig' 'purelin'});
                rede.trainParam.showWindow = true; 
                rede.trainParam.mu = 0.01;
                rede.trainParam.mu_dec = 0.1;
                rede.trainParam.mu_inc = 9;
                rede.trainParam.epochs = 60;%número de épocas desejadas
                rede.trainParam.goal = 1e-20;%erro final desejado
                rede.trainParam.show = 20;
                rede.trainParam.showWindow = false;
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
                erro_max = max(erro);
                erro_min = min(erro);
                erro_medio = sqrt(immse(saida_teste, previsao));
                desvio_padrao = std(erro);
                
                saida_teste = saida_teste/200;
                
                if (erro_medio <= criterio)
                    criterio = erro_medio;
                    save(caminhoSave)
                    fprintf('SALVO! Erro médio de %s\n', erro_medio)
                    fprintf('Ceptrais: %d, Quantidade de neurônios %d %d\n',numCep, x, y)
                end
            end
        end
    end
    cont = 1;
    clear base entrada_treinamento entrada_teste saida_treinamento saida_teste NET rede Matriz previsao erro mm aspc distanciaFaltas resistenciaFaltas
end
%%  Utilizando as melhores correlações como entrada para RNA, faltas polo polo
warning('off','all')
% Adicionar Path do MFCC
addpath(genpath('C:\Users\guilh\OneDrive\Documentos\IC 2021\Fault-Location-in-VSC-HVDC\rastamat'));

%----------------------------Variáveis de Entrada da RNA -----------------%
baseGeral = [];
%----------------------------Variável de Saída da RNA --------------------%
distanciaFaltas = [];
%----------------------------Variáveis Globais ---------------------------%
fs = 135000; % frequência da simulução
inicio = 2700; % inicio da janela escolhida
fim = 3214; % fim da janela escolhida

resistenciasEscolhidas = [1, 5:5:50, 60:10:100, 150:50:300];

mat = '.mat';
csv = '.csv';
caminho = './faltas_polo_polo/';
caminhoSave = './resultados_redes_neurais/novo_metodo2.mat';
caminhoMatriz = './matrizes_correlacoes/';
cont = 1;
criterio = 1.117066;
entradas = 24;

for numCep = 32:1:40 %melhor config 24 erro médio 1.117066
    for localizacao = 5:5:195
        nameLoc = sprintf('L%.0f', localizacao);
        for k = 1:1:length(resistenciasEscolhidas)
            resistencia = resistenciasEscolhidas(k);
            nameRes = sprintf('R%.3f', resistencia);
            nameCom = strcat(caminho,nameLoc, nameRes, mat);
            if(exist(nameCom,'file') == 2)
                load(nameCom);
                sinal = correnteretificadorpos.Data(inicio:fim,1);
                time = (correnteretificadorpos.Time(fim)-correnteretificadorpos.Time(inicio));
                [mm,aspc] = melfcc(sinal, fs, 'maxfreq', fs/2, 'numcep', numCep, 'dcttype', 1, 'wintime', time, 'hoptime', time/2, 'preemph', 0);
                baseGeral(:,cont) = mm;
                distanciaFaltas(:,cont) = localizacao/200;
                resistenciaFaltas(:,cont) = resistencia;
                cont=cont+1;
            else
                fprintf(nameCom)                
            end
        end
    end
    cont = 1;
    % -------------------- Variáveis Globais---------------------------------
    Matriz = [];
    entrada_treinamento = [];
    entrada_teste = [];
    previsao = [];
    erro = [];

    % ------------------- Normalização da matriz de entrada ------------------
    for i = 1:1:numCep
        for j = 1:1:length(baseGeral)
            baseGeral(i,j) = (baseGeral(i,j) - min(baseGeral(i,:)))/( max(baseGeral(i,:))- min(baseGeral(i,:)) );
        end
    end
    baseGeral(numCep+1,:) = distanciaFaltas;
    baseGeral(numCep+2,:) = resistenciaFaltas;
    % ---------------- Correlação dos coeficientes com a distância---------
    [R,P] = corrcoef(baseGeral');
    correlacoes = abs(R(:,numCep+1)');
    correlacoes_crescente = sort(correlacoes);
    i = 1;
    for k = length(correlacoes):-1:length(correlacoes)-entradas
        posicoes(i) = find(correlacoes == correlacoes_crescente(k));
        i = i + 1;
    end
    
    for k = 2:1:entradas+1
        base(k-1,:) = baseGeral(posicoes(k),:);
    end
    base(entradas+1,:) = distanciaFaltas;
    base(entradas+2,:) = resistenciaFaltas;
    
    nameCep = sprintf('Ceptrais%.0f', numCep);
    nameMatriz = strcat(caminhoMatriz,nameCep,csv);
    csvwrite(nameMatriz,R);
    % -------------------Separação dos dados entre treinamento e teste -------
    dataA = base';  % obtêm-se a matriz base
    p = .8;      % proporção do treinamento 
    N = size(dataA,1);  % total do número de linhas 
    tf = false(N,1);    % criação do index logico do vetor
    tf(1:round(p*N)) = true;     
    tf = tf(randperm(N));   % Escolha aleatoriamente os valores
    treinamento = dataA(tf,:)'; %Associa o vetor para o treinamento 
    teste = dataA(~tf,:)'; %O restante associa para o vetor teste

    %--------------------Organização dos dados de entrada para treinamento----
    for i = 1:1:entradas
        entrada_treinamento(i,:) = treinamento(i,:); %retirando loc. e res. da matriz
    end

    %--------------------Organização dos dados de entrada para teste----------
    for i = 1:1:entradas
        entrada_teste(i,:) = teste(i,:); %retirando loc. e res. da matriz
    end

    %--------------------Organização dos dados de saida para treinamento-------
    saida_treinamento(1,:) = treinamento(entradas+1,:);
    saida_teste(1,:) = teste(entradas+1,:);

    %------------------Outras configuração de para comparação de resultados----
    resistencia_treinamento(1,:) = treinamento(entradas+2,:);
    resistencia_teste(1,:) = teste(entradas+2,:);

    %---------------Elaboração da Matriz de mín e máx para RNA ---------------
    for i = 1:1:entradas
        Matriz(i,1) = min(entrada_treinamento(i,:));
        Matriz(i,2) = max(entrada_treinamento(i,:));
    end
    %---------------Treinamento da RNA----------------------------------------
    for x = 12:1:30
        for y = 1:1:10
            for range = 1:1:5
                rede = newff( Matriz, [x y 1], {'tansig' 'tansig' 'purelin'});
                rede.trainParam.showWindow = true; 
                rede.trainParam.mu = 0.01;
                rede.trainParam.mu_dec = 0.1;
                rede.trainParam.mu_inc = 9;
                rede.trainParam.epochs = 60;%número de épocas desejadas
                rede.trainParam.goal = 1e-20;%erro final desejado
                rede.trainParam.show = 20;
                rede.trainParam.showWindow = false;
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
                erro_max = max(erro);
                erro_min = min(erro);
                erro_medio = sqrt(immse(saida_teste, previsao));
                desvio_padrao = std(erro);
                
                saida_teste = saida_teste/200;
                
                if (erro_medio <= criterio)
                    criterio = erro_medio;
                    save(caminhoSave)
                    csvwrite('./matrizes_correlacoes/matrizCorrelacao.csv',R);
                    fprintf('SALVO! Erro médio de %s\n', erro_medio)
                    fprintf('Ceptrais: %d, Quantidade de neurônios %d %d\n',numCep, x, y)
                end
            end
        end
    end
    cont = 1;
    clear base baseGeral entrada_treinamento entrada_teste saida_treinamento saida_teste NET rede Matriz previsao erro mm aspc distanciaFaltas resistenciaFaltas
end
%% 3 método - RNA e Coeficientes Mel Cepstrais - Faltas Polo Terra Polo Polo
% Adicionar Path do MFCC
addpath(genpath('C:\Users\guilh\OneDrive\Documentos\IC 2021\Fault-Location-in-VSC-HVDC\rastamat'));

%----------------------------Variáveis de Entrada da RNA -----------------%
base = [];
%----------------------------Variável de Saída da RNA --------------------%
distanciaFalta = [];
%----------------------------Variáveis Globais ---------------------------%
fs = 135000; % frequência da simulução
numCep = 24; % número de Cepstrais
inicio = 2700; % inicio da janela escolhida
fim = 3214; % fim da janela escolhida

resistenciasEscolhidas = [1, 5:5:50, 60:10:100, 150:50:300];
mat = '.mat';
caminho_polo_terra = './faltas_polo_terra/';
caminho_polo_polo = './faltas_polo_polo/';
caminhoSave = './coleta_dados/novo_metodo_mfcc_total.mat';
cont = 1;

for localizacao = 5:5:195
    % Obtenção do nome do arquivo da simulação
    nameLoc = sprintf('L%.0f', localizacao);
    for k = 1:1:length(resistenciasEscolhidas)
        resistencia = resistenciasEscolhidas(k);
        nameRes = sprintf('R%.3f', resistencia);
        nameCom = strcat(caminho_polo_terra,nameLoc, nameRes, mat);
        %Obtenção dos dados referente ao arquivo polo_terra
        if(exist(nameCom,'file') == 2)
            load(nameCom);
            
            sinal = correnteretificadorpos.Data(inicio:fim,1);
            time = (correnteretificadorpos.Time(fim)-correnteretificadorpos.Time(inicio));
            [mm,aspc] = melfcc(sinal, fs, 'maxfreq', fs/2, 'numcep', numCep, 'dcttype', 1, 'wintime', time, 'hoptime', time/2, 'preemph', 0);
            
            base(:,cont) = mm;
            
            distanciaFaltas(:,cont) = localizacao/200;
            resistenciaFaltas(:,cont) = resistencia;
            
            cont=cont+1;
        end
        % Obtenção do nome do arquivo da simulação
        nameLoc = sprintf('L%.0f', localizacao);
        nameRes = sprintf('R%.3f', resistencia);
        nameCom = strcat(caminho_polo_polo,nameLoc, nameRes, mat);
        %Obtenção dos dados referente ao arquivo polo_polo
        if(exist(nameCom,'file') == 2)
            load(nameCom);
            
            sinal = correnteretificadorpos.Data(inicio:fim,1);
            time = (correnteretificadorpos.Time(fim)-correnteretificadorpos.Time(inicio));
            [mm,aspc] = melfcc(sinal, fs, 'maxfreq', fs/2, 'numcep', numCep, 'dcttype', 1, 'wintime', time, 'hoptime', time/2, 'preemph', 0);
            
            base(:,cont) = mm;
            
            distanciaFaltas(:,cont) = localizacao/200;
            resistenciaFaltas(:,cont) = resistencia;
            
            cont=cont+1;
        end
    end
end
save(caminhoSave)