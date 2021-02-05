clear all 
clc

%Simulação para análise das médias pós falta
%Autor: Guilherme Lopes
%Universidade Federal do Piauí
mat = '.mat';
faltas_polo_polo = './faltas_polo_polo/';
faltas_polo_terra = './faltas_polo_terra/';
cont = 1;

%Calculo das médias pós falta Polo Polo
for localizacao = 5:5:195
    for resistencia = 5:5:150
        % Obtenção do nome do arquivo da simulação
        nameLoc = sprintf('L%.0f', localizacao);
        nameRes = sprintf('R%.3f', resistencia);
        nameCom = strcat(faltas_polo_polo,nameLoc, nameRes, mat);
        %Obtenção dos dados referente ao arquivo
        if(exist(nameCom,'file') == 2)
            load(nameCom);
            media_polo_polo_pos(cont) = mean(correnteretificadorpos.Data(4725:13500,1));
            media_polo_polo_neg(cont) = mean(correnteretificadorneg.Data(4725:13500,1));
        end
        % Obtenção do nome do arquivo da simulação
        nameCom = strcat(faltas_polo_terra,nameLoc, nameRes, mat);
        %Obtenção dos dados referente ao arquivo
        if(exist(nameCom,'file') == 2)
            load(nameCom);
            media_polo_terra_pos(cont) = mean(correnteretificadorpos.Data(4725:13500,1));
            media_polo_terra_neg(cont) = mean(correnteretificadorneg.Data(4725:13500,1));
        end
        cont=cont+1;        
    end
end

diferenca_polo_polo = abs(media_polo_polo_pos + media_polo_polo_neg);
diferenca_polo_terra = abs(media_polo_terra_pos + media_polo_terra_neg);