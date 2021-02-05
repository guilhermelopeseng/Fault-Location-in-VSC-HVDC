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




