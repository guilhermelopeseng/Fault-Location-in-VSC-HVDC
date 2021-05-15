% Exportar dados em formato csv
clc
clear all

resistenciasEscolhidas = [1, 5:5:50, 60:10:100, 150:50:300];
mat = '.mat';
caminho_polo_polo = './faltas_polo_polo/';
caminho_polo_terra = './faltas_polo_terra/';
cont = 1;
headers = {};

for localizacao = 5:5:195
    nameLoc = sprintf('L%.0f', localizacao);
    for k = 1:1:length(resistenciasEscolhidas)
        resistencia = resistenciasEscolhidas(k);
        nameRes = sprintf('R%.3f', resistencia);
        nameCom = strcat(caminho_polo_polo,nameLoc, nameRes, mat);
        if(exist(nameCom,'file') == 2)
            load(nameCom);
            fault_pole_to_pole(:,cont) = correnteretificadorpos.Data;
            distance_pole_to_pole(:,cont) = localizacao;
        end
        nameCom = strcat(caminho_polo_terra,nameLoc, nameRes, mat);
        if(exist(nameCom,'file') == 2)
            load(nameCom);
            fault_pole_to_ground(:,cont) = correnteretificadorpos.Data;
            distance_pole_to_ground(:,cont) = localizacao;
        end
        cont = cont + 1;
    end
end
csvwrite('fault_pole_to_pole.csv',fault_pole_to_pole)
csvwrite('fault_pole_to_ground.csv',fault_pole_to_ground)

csvwrite('distance_pole_to_pole.csv',distance_pole_to_pole)
csvwrite('distance_pole_to_ground.csv',distance_pole_to_ground)