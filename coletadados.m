clc
clear all

%Simulação para coleta dos dados para os métodos propostos
%Autor: Guilherme Lopes
%Universidade Federal do Piauí

%%  Melhores valores para os filtros do MFCC

% Adicionar Path do MFCC
addpath(genpath('C:\Users\guilh\OneDrive\Documentos\IC 2021\Fault-Location-in-VSC-HVDC\rastamat'));

%----------------------------Variáveis de Entrada da RNA -----------------%
base = [];
%----------------------------Variável de Saída da RNA --------------------%
distanciaFalta = [];
%----------------------------Variáveis Globais ---------------------------%
fs = 135000; % frequência da simulução
numCep = 20; % número de Cepstrais
inicio = 2700; % inicio da janela escolhida
fim = 3214; % fim da janela escolhida

resistenciaFaltas = [];
resistenciaEscolhidas = [5 10 30 50 100 150];
mat = '.mat';
caminho = './faltas_polo_polo/';
caminhoSave = './coleta_dados/terceiro_metodo_polo_polo.mat';
cont = 1;

for localizacao = 10:10:190
    for resistencia = 50:5:150
        nameLoc = sprintf('L%.0f', localizacao);
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
        end
    end
end
save(caminhoSave)

%% 3 método - RNA e Coeficientes Mel Cepstrais - Faltas Polo Terra
% Adicionar Path do MFCC
addpath(genpath('C:\Users\guilh\OneDrive\Documentos\IC 2021\Fault-Location-in-VSC-HVDC\rastamat'));

%----------------------------Variáveis de Entrada da RNA -----------------%
base = [];
%----------------------------Variável de Saída da RNA --------------------%
distanciaFalta = [];
%----------------------------Variáveis Globais ---------------------------%
fs = 135000; % frequência da simulução
numCep = 20; % número de Cepstrais
inicio = 2700; % inicio da janela escolhida
fim = 3214; % fim da janela escolhida

resistenciaFaltas = [];
mat = '.mat';
caminho = './faltas_polo_terra/';
caminhoSave = './coleta_dados/terceiro_metodo_polo_terra.mat';
cont = 1;

for localizacao = 5:5:195
    for resistencia = 55:5:100
        % Obtenção do nome do arquivo da simulação
        nameLoc = sprintf('L%.0f', localizacao);
        nameRes = sprintf('R%.3f', resistencia);
        nameCom = strcat(caminho,nameLoc, nameRes, mat);
        %Obtenção dos dados referente ao arquivo
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

%% 3 método - RNA e Coeficientes Mel Cepstrais - Faltas Polo Terra Polo Polo
% Adicionar Path do MFCC
addpath(genpath('C:\Users\guilh\OneDrive\Documentos\IC 2021\Fault-Location-in-VSC-HVDC\rastamat'));

%----------------------------Variáveis de Entrada da RNA -----------------%
base = [];
%----------------------------Variável de Saída da RNA --------------------%
distanciaFalta = [];
%----------------------------Variáveis Globais ---------------------------%
fs = 135000; % frequência da simulução
numCep = 20; % número de Cepstrais
inicio = 2700; % inicio da janela escolhida
fim = 3214; % fim da janela escolhida

resistenciaFaltas = [];
mat = '.mat';
caminho_polo_terra = './faltas_polo_terra/';
caminho_polo_polo = './faltas_polo_polo/';
caminhoSave = './coleta_dados/terceiro_metodo.mat';
cont = 1;

for localizacao = 5:5:195
    for resistencia = 55:5:100
        % Obtenção do nome do arquivo da simulação
        nameLoc = sprintf('L%.0f', localizacao);
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