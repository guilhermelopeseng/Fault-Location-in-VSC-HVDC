clear all
clc

%Simula��o para obten��o dos dados dos sistemas modelo
%Autor: Guilherme Lopes
%Universidade Federal do Piau�

%% Referente a faltas Polo Polo

L = 5;% Vari�vel para indicar o tamanho da rede
Res = 5.000; %Vari�vel para indicar a resist�ncia da falta
tempfault = [1.5, 1.515]; %Tempo da falta
dados = 13500; %tamanho da janela de amostras

caminho = './faltas_polo_polo/';

for Res = 5:5:150
    for L = 5:5:195
        tam = sprintf('L%.0f',L);
        res = sprintf('R%.3f', Res);
        mat = '.mat';
        
        nome = strcat(caminho,tam,res,mat); %Concatena o nome
        temp = sim('sistema_polo_polo'); %Roda a simula��o e retorna o temp dela
        save(nome); %Salva os dados
    end
end

%% Referente a faltas Polo Terra

L = 5;% Vari�vel para indicar o tamanho da rede
Res = 5.000; %Vari�vel para indicar a resist�ncia da falta
tempfault = [1.5, 1.515]; %Tempo da falta
dados = 13500; %tamanho da janela de amostras

caminho = './faltas_polo_terra/';

for Res = 5:5:150
    for L = 5:5:195
        tam = sprintf('L%.0f',L);
        res = sprintf('R%.3f', Res);
        mat = '.mat';
        
        nome = strcat(caminho,tam,res,mat); %Concatena o nome
        temp = sim('sistema_polo_terra'); %Roda a simula��o e retorna o temp dela
        save(nome); %Salva os dados
    end
end