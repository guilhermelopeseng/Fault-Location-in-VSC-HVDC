clear all 
clc

%Coleta dos melhores valores segunda a correlação
%Autor: Guilherme Lopes
%Universidade Federal do Piauí
addpath(genpath('C:\Users\guilh\OneDrive\Documentos\IC 2021\Fault-Location-in-VSC-HVDC\rastamat'));
caminho = './faltas_polo_terra/';
caminhoSave = './coleta_dados/correlacao_metodo.mat';
mat = '.mat';
cont = 1;
resistenciaValores = [5 10 30 50 100 150 200]; 
energia = [3 5 6 7 9 10 11 12 13 14];
maximo = [7 11 13 14];
mfcc = [4 13 14];
entradas = length(energia) + length(maximo) + length(mfcc);
%------------ Loop para coleta dos valores de energia da twp -----------
for localizacao = 10:10:190
    nameLoc = sprintf('L%.0f', localizacao);
    for resistencia = 5:5:150
        nameRes = sprintf('R%.3f', resistencia);
        nameCom = strcat(caminho,nameLoc, nameRes, mat);
        if(exist(nameCom,'file') == 2)
            load(nameCom);
            c = wpdec(correnteretificadorpos.Data(2700:3067,1),4,'db1');
            %Obstenção dos coeficientes da wavelet transform
            inicial_valores = wpcoef(c, [0 0]);
            quadrado_inicial_valores = inicial_valores.^2;
            total_inical_valores = sum(quadrado_inicial_valores(:));
            
            for k = 1:1:length(energia)
                valor = energia(k);
                quarta_camada = wpcoef(c, [4 valor]);
                quadrado_quarta_camada = quarta_camada.^2;
                total_quarta_camada = sum(quadrado_quarta_camada(:));
                base(k,cont) = total_quarta_camada/total_inical_valores;
            end
            for k = 1:1:length(maximo)
                valor = maximo(k);
                base(length(energia)+k,cont) = max(wpcoef(c, [4 valor]));
            end
            
            distanciaFaltas(1,cont) = localizacao/200;
            resistenciaFaltas(1,cont) = resistencia;
            cont=cont+1;
        end
    end
end

fs = 135000; % frequência da simulução
numCep = 20; % número de Cepstrais
inicio = 2700; % inicio da janela escolhida
fim = 3214; % fim da janela escolhida
cont = 1;
%---------------- Loop para os valores do MFCC -------------------------
for localizacao = 10:10:190
    for resistencia = 5:5:150
        nameLoc = sprintf('L%.0f', localizacao);
        nameRes = sprintf('R%.3f', resistencia);
        nameCom = strcat(caminho,nameLoc, nameRes, mat);
        if(exist(nameCom,'file') == 2)
            load(nameCom);
            sinal = correnteretificadorpos.Data(inicio:fim,1);
            time = (correnteretificadorpos.Time(fim)-correnteretificadorpos.Time(inicio));
            [mm,aspc] = melfcc(sinal, fs, 'maxfreq', fs/2, 'numcep', numCep, 'dcttype', 1, 'wintime', time, 'hoptime', time/2, 'preemph', 0);
            for k = 1:1:length(mfcc)
                valor = mfcc(k);
                base(length(energia)+length(maximo)+k,cont) = mm(valor);
            end
            cont=cont+1;
        end
    end
end

for i = length(energia)+1:1:entradas
    for j = 1:1:length(base)
        base(i,j) = (base(i,j) - min(base(i,:)))/( max(base(i,:))- min(base(i,:)) );
    end
end
base(entradas+1,:) = distanciaFaltas;
base(entradas+2,:) = resistenciaFaltas;
[R,P] = corrcoef(base');
save(caminhoSave);

