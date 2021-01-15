clc
clear all

%Simulação para coleta dos dados para os métodos propostos
%Autor: Guilherme Lopes
%Universidade Federal do Piauí

%% 1 método - Somente RNA - Faltas Polo Polo

%----------Variáveis de entrada para RNA ------------%
valormaximo = [];
valorminimo = [];
mediaprefalta = [];
mediafalta = [];
mediaposfalta = [];
variancia = [];
energiaprefalta = [];
energiafalta = [];
energiaposfalta = [];
%----------Variáveis de saída para RNA -------------%
distanciaFaltas = [];

%---------Variáveis globais-------------------------%
cont = 1;
mat = '.mat';
caminho = './faltas_polo_polo/';
caminhoSave = './coleta_dados/primeiro_metodo_polo_polo.mat';

%----------Loop para coleta-------------------------%
for localizacao = 5:5:195
    for resistencia = 5:5:150
        % Obtenção do nome do arquivo da simulação
        nameLoc = sprintf('L%.0f', localizacao);
        nameRes = sprintf('R%.3f', resistencia);
        nameCom = strcat(caminho,nameLoc, nameRes, mat);
        %Obtenção dos dados referente ao arquivo
        if(exist(nameCom,'file') == 2)
            
            load(nameCom);
            
            valormaximo(cont,:) = max(correnteretificadorpos.Data);%pega somente o valor maximo 
            
            valorminimo(cont,:) = min(correnteretificadorpos.Data);
            
            mediaprefalta(cont,:) = mean(correnteretificadorpos.Data(1:2700,1));
            mediafalta(cont,:) = mean(correnteretificadorpos.Data(2700:4725,1));
            mediaposfalta(cont,:) = mean(correnteretificadorpos.Data(4725:13500,1));
            
            variancia(cont,:) = var(correnteretificadorpos.Data);
            
            Ym = correnteretificadorpos.Data(1:2700,1);
            Yq = Ym.^2;
            Ym1 = correnteretificadorpos.Data(2700:4725,1);
            Yq1 = Ym1.^2;
            Ym2 = correnteretificadorpos.Data(4725:13500,1);
            Yq2 = Ym2.^2;
            energiaprefalta(cont,:) = sum(Yq(:));
            energiafalta(cont,:) = sum(Yq1(:));
            energiaposfalta(cont,:) = sum(Yq2(:));
            
            distanciaFaltas(cont,:) = localizacao/200;
            resistenciaFaltas(cont,:) = resistencia;
            
            cont=cont+1;
        end
    end
end
save(caminhoSave)

%% 1 método - Somente RNA - Faltas Polo Terra

%----------Variáveis de entrada para RNA ------------%
valormaximo = [];
valorminimo = [];
mediaprefalta = [];
mediafalta = [];
mediaposfalta = [];
variancia = [];
energiaprefalta = [];
energiafalta = [];
energiaposfalta = [];
%----------Variáveis de saída para RNA -------------%
distanciaFaltas = [];

%---------Variáveis globais-------------------------%
cont = 1;
mat = '.mat';
caminho = './faltas_polo_terra/';
caminhoSave = './coleta_dados/primeiro_metodo_polo_terra.mat';

%----------Loop para coleta-------------------------%
for localizacao = 5:5:195
    for resistencia = 5:5:150
        % Obtenção do nome do arquivo da simulação
        nameLoc = sprintf('L%.0f', localizacao);
        nameRes = sprintf('R%.3f', resistencia);
        nameCom = strcat(caminho,nameLoc, nameRes, mat);
        %Obtenção dos dados referente ao arquivo
        if(exist(nameCom,'file') == 2)
            
            load(nameCom);
            
            valormaximo(cont,:) = max(correnteretificadorpos.Data);%pega somente o valor maximo 
            
            valorminimo(cont,:) = min(correnteretificadorpos.Data);
            
            mediaprefalta(cont,:) = mean(correnteretificadorpos.Data(1:2700,1));
            mediafalta(cont,:) = mean(correnteretificadorpos.Data(2700:4725,1));
            mediaposfalta(cont,:) = mean(correnteretificadorpos.Data(4725:13500,1));
            
            variancia(cont,:) = var(correnteretificadorpos.Data);
            
            Ym = correnteretificadorpos.Data(1:2700,1);
            Yq = Ym.^2;
            Ym1 = correnteretificadorpos.Data(2700:4725,1);
            Yq1 = Ym1.^2;
            Ym2 = correnteretificadorpos.Data(4725:13500,1);
            Yq2 = Ym2.^2;
            energiaprefalta(cont,:) = sum(Yq(:));
            energiafalta(cont,:) = sum(Yq1(:));
            energiaposfalta(cont,:) = sum(Yq2(:));
            
            distanciaFaltas(cont,:) = localizacao/200;
            resistenciaFaltas(cont,:) = resistencia;
            
            cont=cont+1;
        end
    end
end
save(caminhoSave)

%% 2 método - RNA e Wavelet Transform - Faltas Polo Polo

%------------------Variáveis para entrada da RNA ---------------------%
valormaximo41 = [];
valormaximo42 = [];
valormaximo43 = [];
valormaximo44 = [];
valormaximo45 = [];
valormaximo46 = [];
valormaximo47 = [];
valormaximo48 = [];
valormaximo49 = [];
valormaximo410 = [];
valormaximo411 = [];
valormaximo412 = [];
valormaximo413 = [];
valormaximo414 = [];
%-----------------------Variáveis de saída para RNA--------------%
distanciaFaltas = [];
%-----------------------Variáveis globais ----------------------%
resistenciaFaltas = [];
mat = '.mat';
caminho = './faltas_polo_polo/';
caminhoSave = './coleta_dados/segundo_metodo_polo_polo.mat';
cont = 1;
%--------------------Loop para coleta dos dados------------------%
for localizacao = 5:5:195
    for resistencia = 5:5:150
        % Obtenção do nome do arquivo da simulação
        nameLoc = sprintf('L%.0f', localizacao);
        nameRes = sprintf('R%.3f', resistencia);
        nameCom = strcat(caminho,nameLoc, nameRes, mat);
        %Obtenção dos dados referente ao arquivo
        if(exist(nameCom,'file') == 2)
            load(nameCom);
            c = wpdec(correnteretificadorpos.Data(2700:3067,1),4,'db1');
           %Obstenção dos coeficientes da wavelet transform 
            cfs41 = wpcoef(c,[4 1]);
            valormaximo41(cont,:) = max(cfs41);
           
            cfs42 = wpcoef(c,[4 2]);
            valormaximo42(cont,:) = max(cfs42);
           
            cfs43 = wpcoef(c,[4 3]);
            valormaximo43(cont,:) = max(cfs43);
           
            cfs44 = wpcoef(c,[4 4]);
            valormaximo44(cont,:) = max(cfs44);
           
            cfs45 = wpcoef(c,[4 5]);
            valormaximo45(cont,:) = max(cfs45);
           
            cfs46 = wpcoef(c,[4 6]);
            valormaximo46(cont,:) = max(cfs46);
          
            cfs47 = wpcoef(c,[4 7]);
            valormaximo47(cont,:) = max(cfs47);
           
            cfs48 = wpcoef(c,[4 8]);
            valormaximo48(cont,:) = max(cfs48);
           
            cfs49 = wpcoef(c,[4 9]);
            valormaximo49(cont,:) = max(cfs49);
           
            cfs410 = wpcoef(c,[4 10]);
            valormaximo410(cont,:) = max(cfs410);
            
            cfs411 = wpcoef(c,[4 11]);
            valormaximo411(cont,:) = max(cfs411);
           
            cfs412 = wpcoef(c,[4 12]);
            valormaximo412(cont,:) = max(cfs412);
           
            cfs413 = wpcoef(c,[4 13]);
            valormaximo413(cont,:) = max(cfs413);
            
            cfs414 = wpcoef(c,[4 14]);
            valormaximo414(cont,:) = max(cfs414);
            
            distanciaFaltas(cont,:) = localizacao/200;
            resistenciaFaltas(cont,:) = resistencia;
            
            cont=cont+1;
        end
    end
end

save(caminhoSave)

%% 2 método - RNA e Wavelet Transform - Faltas Polo Terra

%------------------Variáveis para entrada da RNA ---------------------%
valormaximo41 = [];
valormaximo42 = [];
valormaximo43 = [];
valormaximo44 = [];
valormaximo45 = [];
valormaximo46 = [];
valormaximo47 = [];
valormaximo48 = [];
valormaximo49 = [];
valormaximo410 = [];
valormaximo411 = [];
valormaximo412 = [];
valormaximo413 = [];
valormaximo414 = [];
%-----------------------Variáveis de saída para RNA--------------%
distanciaFaltas = [];
%-----------------------Variáveis globais ----------------------%
resistenciaFaltas = [];
mat = '.mat';
caminho = './faltas_polo_terra/';
caminhoSave = './coleta_dados/segundo_metodo_polo_terra.mat';
cont = 1;
%--------------------Loop para coleta dos dados------------------%
for localizacao = 5:5:195
    for resistencia = 5:5:150
        % Obtenção do nome do arquivo da simulação
        nameLoc = sprintf('L%.0f', localizacao);
        nameRes = sprintf('R%.3f', resistencia);
        nameCom = strcat(caminho,nameLoc, nameRes, mat);
        %Obtenção dos dados referente ao arquivo
        if(exist(nameCom,'file') == 2)
            load(nameCom);
            c = wpdec(correnteretificadorpos.Data(2700:3067,1),4,'db1');
           %Obstenção dos coeficientes da wavelet transform 
            cfs41 = wpcoef(c,[4 1]);
            valormaximo41(cont,:) = max(cfs41);
           
            cfs42 = wpcoef(c,[4 2]);
            valormaximo42(cont,:) = max(cfs42);
           
            cfs43 = wpcoef(c,[4 3]);
            valormaximo43(cont,:) = max(cfs43);
           
            cfs44 = wpcoef(c,[4 4]);
            valormaximo44(cont,:) = max(cfs44);
           
            cfs45 = wpcoef(c,[4 5]);
            valormaximo45(cont,:) = max(cfs45);
           
            cfs46 = wpcoef(c,[4 6]);
            valormaximo46(cont,:) = max(cfs46);
          
            cfs47 = wpcoef(c,[4 7]);
            valormaximo47(cont,:) = max(cfs47);
           
            cfs48 = wpcoef(c,[4 8]);
            valormaximo48(cont,:) = max(cfs48);
           
            cfs49 = wpcoef(c,[4 9]);
            valormaximo49(cont,:) = max(cfs49);
           
            cfs410 = wpcoef(c,[4 10]);
            valormaximo410(cont,:) = max(cfs410);
            
            cfs411 = wpcoef(c,[4 11]);
            valormaximo411(cont,:) = max(cfs411);
           
            cfs412 = wpcoef(c,[4 12]);
            valormaximo412(cont,:) = max(cfs412);
           
            cfs413 = wpcoef(c,[4 13]);
            valormaximo413(cont,:) = max(cfs413);
            
            cfs414 = wpcoef(c,[4 14]);
            valormaximo414(cont,:) = max(cfs414);
            
            distanciaFaltas(cont,:) = localizacao/200;
            resistenciaFaltas(cont,:) = resistencia;
            
            cont=cont+1;
        end
    end
end

save(caminhoSave)

%% 3 método - RNA e Coeficientes Mel Cepstrais - Faltas Polo Polo
% Adicionar Path do MFCC
addpath(genpath('C:\Users\guilh\OneDrive\Documentos\IC 2021\Fault-Location-in-VSC-HVDC\rastamat'));

%----------------------------Variáveis de Entrada da RNA -----------------%
mfccGeral = [];
%----------------------------Variável de Saída da RNA --------------------%
distanciaFalta = [];
%----------------------------Variáveis Globais ---------------------------%
fs = 135000; % frequência da simulução
numCep = 20; % número de Cepstrais
inicio = 2700; % inicio da janela escolhida
fim = 3214; % fim da janela escolhida

resistenciaFaltas = [];
mat = '.mat';
caminho = './faltas_polo_polo/';
caminhoSave = './coleta_dados/terceiro_metodo_polo_polo.mat';
cont = 1;

for localizacao = 5:5:195
    for resistencia = 5:5:150
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
            
            mfccGeral(cont,:) = mm;
            
            distanciaFaltas(cont,:) = localizacao/200;
            resistenciaFaltas(cont,:) = resistencia;
            
            cont=cont+1;
        end
    end
end
save(caminhoSave)

%% 3 método - RNA e Coeficientes Mel Cepstrais - Faltas Polo Terra
% Adicionar Path do MFCC
addpath(genpath('C:\Users\guilh\OneDrive\Documentos\IC 2021\Fault-Location-in-VSC-HVDC\rastamat'));

%----------------------------Variáveis de Entrada da RNA -----------------%
mfccGeral = [];
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
    for resistencia = 5:5:150
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
            
            mfccGeral(cont,:) = mm;
            
            distanciaFaltas(cont,:) = localizacao/200;
            resistenciaFaltas(cont,:) = resistencia;
            
            cont=cont+1;
        end
    end
end
save(caminhoSave)