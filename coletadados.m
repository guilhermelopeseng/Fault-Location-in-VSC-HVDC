clc
clear all

%Simula��o para coleta dos dados para os m�todos propostos
%Autor: Guilherme Lopes
%Universidade Federal do Piau�

%% 1 m�todo - Somente RNA - Faltas Polo Polo

%----------Vari�veis de entrada para RNA ------------%
base = [];
%----------Vari�veis de sa�da para RNA -------------%
distanciaFaltas = [];

%---------Vari�veis globais-------------------------%
cont = 1;
mat = '.mat';
caminho = './faltas_polo_polo/';
caminhoSave = './coleta_dados/primeiro_metodo_polo_polo.mat';

%----------Loop para coleta-------------------------%
for localizacao = 5:5:195
    for resistencia = 5:5:150
        % Obten��o do nome do arquivo da simula��o
        nameLoc = sprintf('L%.0f', localizacao);
        nameRes = sprintf('R%.3f', resistencia);
        nameCom = strcat(caminho,nameLoc, nameRes, mat);
        %Obten��o dos dados referente ao arquivo
        if(exist(nameCom,'file') == 2)
            
            load(nameCom);
            
            base(1,cont) = max(correnteretificadorpos.Data);
            
            base(2,cont) = min(correnteretificadorpos.Data);
            
            base(3,cont) = mean(correnteretificadorpos.Data(1:2700,1));
            base(4,cont) = mean(correnteretificadorpos.Data(2700:4725,1));
            base(5,cont) = mean(correnteretificadorpos.Data(4725:13500,1));
          
            base(6,cont) = var(correnteretificadorpos.Data);
            
            Ym = correnteretificadorpos.Data(1:2700,1);
            Yq = Ym.^2;
            Ym1 = correnteretificadorpos.Data(2700:4725,1);
            Yq1 = Ym1.^2;
            Ym2 = correnteretificadorpos.Data(4725:13500,1);
            Yq2 = Ym2.^2;
            base(7,cont) = sum(Yq(:));
            base(8,cont) = sum(Yq1(:));
            base(9,cont) = sum(Yq2(:));
            
            distanciaFaltas(:,cont) = localizacao/200;
            resistenciaFaltas(:,cont) = resistencia;
            
            cont=cont+1;
        end
    end
end
save(caminhoSave)

%% 1 m�todo - Somente RNA - Faltas Polo Terra

%----------Vari�veis de entrada para RNA ------------%
base = [];
%----------Vari�veis de sa�da para RNA -------------%
distanciaFaltas = [];

%---------Vari�veis globais-------------------------%
cont = 1;
mat = '.mat';
caminho = './faltas_polo_terra/';
caminhoSave = './coleta_dados/primeiro_metodo_polo_terra.mat';

%----------Loop para coleta-------------------------%
for localizacao = 5:5:195
    for resistencia = 5:5:150
        % Obten��o do nome do arquivo da simula��o
        nameLoc = sprintf('L%.0f', localizacao);
        nameRes = sprintf('R%.3f', resistencia);
        nameCom = strcat(caminho,nameLoc, nameRes, mat);
        %Obten��o dos dados referente ao arquivo
        if(exist(nameCom,'file') == 2)
            
            load(nameCom);
            
            base(1,cont) = max(correnteretificadorpos.Data);
            
            base(2,cont) = min(correnteretificadorpos.Data);
            
            base(3,cont) = mean(correnteretificadorpos.Data(1:2700,1));
            base(4,cont) = mean(correnteretificadorpos.Data(2700:4725,1));
            base(5,cont) = mean(correnteretificadorpos.Data(4725:13500,1));
          
            base(6,cont) = var(correnteretificadorpos.Data);
            
            Ym = correnteretificadorpos.Data(1:2700,1);
            Yq = Ym.^2;
            Ym1 = correnteretificadorpos.Data(2700:4725,1);
            Yq1 = Ym1.^2;
            Ym2 = correnteretificadorpos.Data(4725:13500,1);
            Yq2 = Ym2.^2;
            base(7,cont) = sum(Yq(:));
            base(8,cont) = sum(Yq1(:));
            base(9,cont) = sum(Yq2(:));
            
            distanciaFaltas(:,cont) = localizacao/200;
            resistenciaFaltas(:,cont) = resistencia;
            
            cont=cont+1;
        end
    end
end
save(caminhoSave)
%% 2 m�todo - RNA e Wavelet Transform - Faltas Polo Polo

%------------------Vari�veis para entrada da RNA ---------------------%
base = [];
%-----------------------Vari�veis de sa�da para RNA--------------%
distanciaFaltas = [];
%-----------------------Vari�veis globais ----------------------%
resistenciaFaltas = [];
mat = '.mat';
caminho = './faltas_polo_polo/';
caminhoSave = './coleta_dados/segundo_metodo_polo_polo.mat';
cont = 1;
%--------------------Loop para coleta dos dados------------------%
for localizacao = 5:5:195
    for resistencia = 5:5:150
        % Obten��o do nome do arquivo da simula��o
        nameLoc = sprintf('L%.0f', localizacao);
        nameRes = sprintf('R%.3f', resistencia);
        nameCom = strcat(caminho,nameLoc, nameRes, mat);
        %Obten��o dos dados referente ao arquivo
        if(exist(nameCom,'file') == 2)
            load(nameCom);
            c = wpdec(correnteretificadorpos.Data(2700:3067,1),4,'db1');
           %Obsten��o dos coeficientes da wavelet transform
           for k = 0:1:15
               base(k+1,cont) = max(wpcoef(c, [4 k]));
           end
            
            distanciaFaltas(:,cont) = localizacao/200;
            resistenciaFaltas(:,cont) = resistencia;
            
            cont=cont+1;
        end
    end
end

save(caminhoSave)

%% 2 m�todo - RNA e Wavelet Transform - Faltas Polo Terra

%------------------Vari�veis para entrada da RNA ---------------------%
base = [];
%-----------------------Vari�veis de sa�da para RNA--------------%
distanciaFaltas = [];
%-----------------------Vari�veis globais ----------------------%
resistenciaFaltas = [];
mat = '.mat';
caminho = './faltas_polo_terra/';
caminhoSave = './coleta_dados/segundo_metodo_polo_terra.mat';
cont = 1;
%--------------------Loop para coleta dos dados------------------%
for localizacao = 5:5:195
    for resistencia = 5:5:150
        % Obten��o do nome do arquivo da simula��o
        nameLoc = sprintf('L%.0f', localizacao);
        nameRes = sprintf('R%.3f', resistencia);
        nameCom = strcat(caminho,nameLoc, nameRes, mat);
        %Obten��o dos dados referente ao arquivo
        if(exist(nameCom,'file') == 2)
            load(nameCom);
            c = wpdec(correnteretificadorpos.Data(2700:3067,1),4,'db1');
           %Obsten��o dos coeficientes da wavelet transform
           for k = 0:1:15
               base(k+1,cont) = max(wpcoef(c, [4 k]));
           end
            
            distanciaFaltas(:,cont) = localizacao/200;
            resistenciaFaltas(:,cont) = resistencia;
            
            cont=cont+1;
        end
    end
end

save(caminhoSave)

%% 3 m�todo - RNA e Coeficientes Mel Cepstrais - Faltas Polo Polo
% Adicionar Path do MFCC
addpath(genpath('C:\Users\guilh\OneDrive\Documentos\IC 2021\Fault-Location-in-VSC-HVDC\rastamat'));

%----------------------------Vari�veis de Entrada da RNA -----------------%
mfccGeral = [];
%----------------------------Vari�vel de Sa�da da RNA --------------------%
distanciaFalta = [];
%----------------------------Vari�veis Globais ---------------------------%
fs = 135000; % frequ�ncia da simulu��o
numCep = 20; % n�mero de Cepstrais
inicio = 2700; % inicio da janela escolhida
fim = 3214; % fim da janela escolhida

resistenciaFaltas = [];
mat = '.mat';
caminho = './faltas_polo_polo/';
caminhoSave = './coleta_dados/terceiro_metodo_polo_polo.mat';
cont = 1;

for localizacao = 5:5:195
    for resistencia = 5:5:150
        % Obten��o do nome do arquivo da simula��o
        nameLoc = sprintf('L%.0f', localizacao);
        nameRes = sprintf('R%.3f', resistencia);
        nameCom = strcat(caminho,nameLoc, nameRes, mat);
        %Obten��o dos dados referente ao arquivo
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

%% 3 m�todo - RNA e Coeficientes Mel Cepstrais - Faltas Polo Terra
% Adicionar Path do MFCC
addpath(genpath('C:\Users\guilh\OneDrive\Documentos\IC 2021\Fault-Location-in-VSC-HVDC\rastamat'));

%----------------------------Vari�veis de Entrada da RNA -----------------%
mfccGeral = [];
%----------------------------Vari�vel de Sa�da da RNA --------------------%
distanciaFalta = [];
%----------------------------Vari�veis Globais ---------------------------%
fs = 135000; % frequ�ncia da simulu��o
numCep = 20; % n�mero de Cepstrais
inicio = 2700; % inicio da janela escolhida
fim = 3214; % fim da janela escolhida

resistenciaFaltas = [];
mat = '.mat';
caminho = './faltas_polo_terra/';
caminhoSave = './coleta_dados/terceiro_metodo_polo_terra.mat';
cont = 1;

for localizacao = 5:5:195
    for resistencia = 5:5:150
        % Obten��o do nome do arquivo da simula��o
        nameLoc = sprintf('L%.0f', localizacao);
        nameRes = sprintf('R%.3f', resistencia);
        nameCom = strcat(caminho,nameLoc, nameRes, mat);
        %Obten��o dos dados referente ao arquivo
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