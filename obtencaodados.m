clear all
clc

%Simula��o para obten��o dos dados dos sistemas modelo
%Autor: Guilherme Lopes
%Universidade Federal do Piau�

%% Novas faltas Polo Polo para an�lise da menor resistencia de falta
tempfault = [1.5, 1.515]; %Tempo da falta
dados = 13500; %tamanho da janela de amostras

caminho = './faltas_polo_terra/';
mat = '.mat';

for L = 5:5:195
    Res = 1;
    tam = sprintf('L%.0f',L);
    res = sprintf('R%.3f', Res);
    nome = strcat(caminho,tam,res,mat); %Concatena o nome
    temp = sim('sistema_polo_terra'); %Roda a simula��o e retorna o temp dela
    save(nome); %Salva os dados
end
%% Novas faltas Polo Terra para an�lise da menor resistencia de falta
Resistencias = [2 2.5 3 3.5 4 4.5];
tempfault = [1.5, 1.515]; %Tempo da falta
dados = 13500; %tamanho da janela de amostras

caminho = './faltas_polo_terra/';
mat = '.mat';

for k = 1:1:length(Resistencias)
    % Para Dist�ncia no km 10
    L = 10;
    Res = Resistencias(k);
    tam = sprintf('L%.0f',L);
    res = sprintf('R%.3f', Res);
    nome = strcat(caminho,tam,res,mat); %Concatena o nome
    temp = sim('sistema_polo_terra'); %Roda a simula��o e retorna o temp dela
    save(nome); %Salva os dados
    % Para Dist�ncia no km 190
    L = 190;
    Res = Resistencias(k);
    tam = sprintf('L%.0f',L);
    res = sprintf('R%.3f', Res);
    nome = strcat(caminho,tam,res,mat); %Concatena o nome
    temp = sim('sistema_polo_terra'); %Roda a simula��o e retorna o temp dela
    save(nome); %Salva os dados
end
%% Faltas Polo Polo de 50 em 50 de 100 at� 300 ohms 
tempfault = [1.5, 1.515]; %Tempo da falta
dados = 13500; %tamanho da janela de amostras

caminho = './faltas_polo_polo/';
mat = '.mat';

for L = 5:10:195
    tam = sprintf('L%.0f',L);
    for Res = 200:50:300
        res = sprintf('R%.3f', Res);
        nome = strcat(caminho,tam,res,mat); %Concatena o nome
        temp = sim('sistema_polo_polo'); %Roda a simula��o e retorna o temp dela
        save(nome); %Salva os dados
    end
end
%% Faltas Polo Terra de 50 em 50 de 100 at� 300 ohms 
tempfault = [1.5, 1.515]; %Tempo da falta
dados = 13500; %tamanho da janela de amostras

caminho = './faltas_polo_terra/';
mat = '.mat';

for L = 5:10:195
    tam = sprintf('L%.0f',L);
    for Res = 200:50:300
        res = sprintf('R%.3f', Res);
        nome = strcat(caminho,tam,res,mat); %Concatena o nome
        temp = sim('sistema_polo_terra'); %Roda a simula��o e retorna o temp dela
        save(nome); %Salva os dados
    end
end