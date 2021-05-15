% Verificação dos erros para determinadas resistências polo polo
clc
clear all
load('./resultados_redes_neurais/terceiro_metodo.mat');

for cont = 1:1:length(entrada_treinamento)
    previsao_treinamento(1,cont) = sim(NET, entrada_treinamento(:,cont));
end
previsao_treinamento = previsao_treinamento * 200;
previsao_teste = previsao;
previsao = [previsao_teste previsao_treinamento];
resistencia = [resistencia_teste resistencia_treinamento];
saida_treinamento = saida_treinamento*200;
saida = [saida_teste saida_treinamento];

p=1;
for cont = 1:1:length(saida)
    if saida(1,cont) == 195
        erroGeral(1,p) = sqrt(immse(saida(1,cont),previsao(1,cont)));
        p = p + 1;
    end
end

maximoGeral = max(erroGeral)
minimoGeral = min(erroGeral)
mediaGeral = mean(erroGeral)
desvioGeral = std(erroGeral)