clear all 
clc

%Simula��o para an�lise das m�dias p�s falta
%Autor: Guilherme Lopes
%Universidade Federal do Piau�
mat = '.mat';
faltas_polo_polo = './faltas_polo_polo/';
faltas_polo_terra = './faltas_polo_terra/';
cont = 1;
resistenciasEscolhidas = [1, 5:5:50, 60:10:100, 150:50:300];

Ib = (20/23)*1e+03;

%Calculo das m�dias p�s falta Polo Polo
for localizacao = 5:5:195
    nameLoc = sprintf('L%.0f', localizacao);
    for k = 1:1:length(resistenciasEscolhidas)
        resistencia = resistenciasEscolhidas(k);
        nameRes = sprintf('R%.3f', resistencia);
        nameCom = strcat(faltas_polo_polo,nameLoc, nameRes, mat);
        %Obten��o dos dados referente ao arquivo
        if(exist(nameCom,'file') == 2)
            load(nameCom);
            media_polo_polo_pos(cont) = mean(correnteretificadorpos.Data/Ib);
            media_polo_polo_neg(cont) = mean(correnteretificadorneg.Data/Ib);
        else
            fprintf(nameCom)
        end
        % Obten��o do nome do arquivo da simula��o
        nameCom = strcat(faltas_polo_terra,nameLoc, nameRes, mat);
        %Obten��o dos dados referente ao arquivo
        if(exist(nameCom,'file') == 2)
            load(nameCom);
            media_polo_terra_pos(cont) = mean(correnteretificadorpos.Data/Ib);
            media_polo_terra_neg(cont) = mean(correnteretificadorneg.Data/Ib);
        else
            fprintf(nameCom)
        end
        cont=cont+1;        
    end
end

diferenca_polo_polo = abs(media_polo_polo_pos + media_polo_polo_neg);
diferenca_polo_terra = abs(media_polo_terra_pos + media_polo_terra_neg);

max(diferenca_polo_polo)
min(diferenca_polo_terra)
% Menor que 0.15 falta polo polo maior � falta polo terra