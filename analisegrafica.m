clear all 
clc

%Simulação para análise gráfica das faltas
%Autor: Guilherme Lopes
%Universidade Federal do Piauí

faltas_polo_polo = './faltas_polo_polo/';
faltas_polo_terra = './faltas_polo_terra/';
falta = 'L30R5.000.mat'; 

nome_polo_polo = strcat(faltas_polo_polo,falta);
nome_polo_terra = strcat(faltas_polo_terra,falta);

load(nome_polo_polo)
plot(correnteretificadorpos.Data);
hold on
media_polo_polo = mean(correnteretificadorpos.Data(4725:13500,1));

load(nome_polo_terra)
plot(correnteretificadorpos.Data)
media_polo_terra = mean(correnteretificadorpos.Data(4725:13500,1));

legend('Falta Polo Polo', 'Falta Polo Terra')

%% 
clear all 
clc

%Simulação para análise gráfica das faltas
%Autor: Guilherme Lopes
%Universidade Federal do Piauí

faltas_polo_polo = './faltas_polo_polo/';
faltas_polo_terra = './faltas_polo_terra/';
falta = 'L30R5.000.mat'; 

nome_polo_polo = strcat(faltas_polo_polo,falta);
nome_polo_terra = strcat(faltas_polo_terra,falta);

load(nome_polo_polo)
plot(correnteretificadorpos.Data);
hold on
plot(correnteretificadorneg.Data);
hold on
media_polo_polo = mean(correnteretificadorpos.Data(4725:13500,1));

load(nome_polo_terra)
plot(correnteretificadorpos.Data);
hold on
plot(correnteretificadorneg.Data);
media_polo_terra = mean(correnteretificadorpos.Data(4725:13500,1));

legend('Falta Polo Polo Pos', 'Falta Polo Polo Neg','Falta Polo Terra Pos', 'Falta Polo Terra Neg')
%% Verificar comportamento destoante da corrente faltas polo terra
clc
clear all
caminho = './faltas_polo_terra/';
mat = '.mat';
for localizacao = 20:5:180
    for resistencia = 5:5:10
        % Obtenção do nome do arquivo da simulação
        nameLoc = sprintf('L%.0f', localizacao);
        nameRes = sprintf('R%.3f', resistencia);
        nameCom = strcat(caminho,nameLoc, nameRes, mat);
        if(exist(nameCom,'file') == 2)
            load(nameCom);
            plot(correnteretificadorpos);
            hold on
        end
    end
end
hold off
%% Verificando comportamento destoante
clc
clear all
load('./faltas_polo_terra/L10R0.100.mat')
plot(correnteretificadorpos.Data);
hold on
load('./faltas_polo_terra/L5R5.000.mat')
plot(correnteretificadorpos.Data);
hold on
load('./faltas_polo_terra/L195R5.000.mat')
plot(correnteretificadorpos.Data);
hold on
load('./faltas_polo_terra/L195R10.000.mat')
plot(correnteretificadorpos.Data);
hold on
load('./faltas_polo_terra/L10R5.000.mat')
plot(correnteretificadorpos.Data);
load('./faltas_polo_terra/L5R10.000.mat')
plot(correnteretificadorpos.Data);
hold on
load('./faltas_polo_terra/L10R10.000.mat')
plot(correnteretificadorpos.Data);
hold on
load('./faltas_polo_terra/L5R15.000.mat')
plot(correnteretificadorpos.Data);
hold on
legend('L10R0.100.mat','L5R5.000.mat','L195R5.000.mat','L195R10.000.mat','L10R5.000.mat','L5R10.000.mat','L10R10.000.mat','L5R15.000.mat')
%% Verificando comportamento destoante
clc
clear all
load('./faltas_polo_polo/L10R0.100.mat')
plot(correnteretificadorpos.Data);
hold on
load('./faltas_polo_polo/L10R0.500.mat')
plot(correnteretificadorpos.Data);
hold on
load('./faltas_polo_polo/L10R1.000.mat')
plot(correnteretificadorpos.Data);
hold on
load('./faltas_polo_polo/L10R1.500.mat')
plot(correnteretificadorpos.Data);
hold on
load('./faltas_polo_polo/L10R2.000.mat')
plot(correnteretificadorpos.Data);
hold on
legend('L10R0.100.mat','L10R0.500.mat','L10R1.000.mat','L10R1.500.mat','L10R2.000.mat')

%% Verificar a menor resistencia de falta a ser utilizada Polo Polo
faltas = [0.1 0.5 1 1.5 2 2.5 3 3.5 4 4.5 5];
mat = '.mat';
caminho = './faltas_polo_polo/';
cont = 1;
%--------------------Loop para verificação dos dados------------------%
for k = 1:1:length(faltas)
    % Para faltas no km 10
    localizacao = 190;
    nameLoc = sprintf('L%.0f', localizacao);
    resistencia = faltas(k);
    nameRes = sprintf('R%.3f', resistencia);
    nameCom = strcat(caminho,nameLoc, nameRes, mat);
    if(exist(nameCom,'file') == 2)
        load(nameCom);
        plot(correnteretificadorpos.Data);
        hold on
    end
end
legend('Res = 0.1','Res = 0.5', 'Res = 1', 'Res = 1.5', 'Res = 2', 'Res = 2.5', 'Res = 3', 'Res = 3.5', 'Res = 4', 'Res = 4.5', 'Res = 5');
%% Verificar a menor resistencia de falta a ser utilizada Polo Terra
faltas = [0.1 0.5 1 1.5 2 2.5 3 3.5 4 4.5 5];
mat = '.mat';
caminho = './faltas_polo_terra/';
cont = 1;
%--------------------Loop para verificação dos dados------------------%

for resistenciaValores = 1:1:length(faltas)
    % Para faltas no km 10
    localizacao = 190;
    nameLoc = sprintf('L%.0f', localizacao);
    resistencia = faltas(resistenciaValores);
    nameRes = sprintf('R%.3f', resistencia);
    nameCom = strcat(caminho,nameLoc, nameRes, mat);
    if(exist(nameCom,'file') == 2)
        load(nameCom);
        plot(correnteretificadorpos.Data);
        hold on
    end
end
legend('Res = 0.1','Res = 0.5', 'Res = 1', 'Res = 1.5', 'Res = 2', 'Res = 2.5', 'Res = 3', 'Res = 3.5', 'Res = 4', 'Res = 4.5', 'Res = 5');