clear all 
clc

%Simula��o para an�lise das m�dias p�s falta
%Autor: Guilherme Lopes
%Universidade Federal do Piau�
mat = '.mat';
faltas_polo_polo = './faltas_polo_polo/';
faltas_polo_terra = './faltas_polo_terra/';
cont = 1;

Ib = (20/23)*1e+03;

%Calculo das m�dias p�s falta Polo Polo
for localizacao = 5:5:195
    for resistencia = 5:5:150
        % Obten��o do nome do arquivo da simula��o
        nameLoc = sprintf('L%.0f', localizacao);
        nameRes = sprintf('R%.3f', resistencia);
        nameCom = strcat(faltas_polo_polo,nameLoc, nameRes, mat);
        %Obten��o dos dados referente ao arquivo
        if(exist(nameCom,'file') == 2)
            load(nameCom);
            media_polo_polo_pos(cont) = mean(correnteretificadorpos.Data(4725:13500,1)/Ib);
            media_polo_polo_neg(cont) = mean(correnteretificadorneg.Data(4725:13500,1)/Ib);
        end
        % Obten��o do nome do arquivo da simula��o
        nameCom = strcat(faltas_polo_terra,nameLoc, nameRes, mat);
        %Obten��o dos dados referente ao arquivo
        if(exist(nameCom,'file') == 2)
            load(nameCom);
            media_polo_terra_pos(cont) = mean(correnteretificadorpos.Data(4725:13500,1)/Ib);
            media_polo_terra_neg(cont) = mean(correnteretificadorneg.Data(4725:13500,1)/Ib);
        end
        cont=cont+1;        
    end
end

diferenca_polo_polo = abs(media_polo_polo_pos + media_polo_polo_neg);
diferenca_polo_terra = abs(media_polo_terra_pos + media_polo_terra_neg);

max(diferenca_polo_polo)
min(diferenca_polo_terra)
% Menor que 0.15 falta polo polo maior que 0.1 falta polo terra