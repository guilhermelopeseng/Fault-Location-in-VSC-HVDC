clear all
clc

%Simulação para obtenção dos dados dos sistemas modelo
%Autor: Guilherme Lopes
%Universidade Federal do Piauí

%% Referente a faltas Polo Polo

L = 5;% Variável para indicar o tamanho da rede
Res = 5.000; %Variável para indicar a resistência da falta
tempfault = [1.5, 1.515]; %Tempo da falta
dados = 13500; %tamanho da janela de amostras

caminho = './faltas_polo_polo/';

for Res = 5:5:150
    for L = 5:5:195
        tam = sprintf('L%.0f',L);
        res = sprintf('R%.3f', Res);
        mat = '.mat';
        
        nome = strcat(caminho,tam,res,mat); %Concatena o nome
        temp = sim('sistema_polo_polo'); %Roda a simulação e retorna o temp dela
        save(nome); %Salva os dados
    end
end

%% Referente a faltas Polo Terra

L = 5;% Variável para indicar o tamanho da rede
Res = 5.000; %Variável para indicar a resistência da falta
tempfault = [1.5, 1.515]; %Tempo da falta
dados = 13500; %tamanho da janela de amostras

caminho = './faltas_polo_terra/';

for Res = 5:5:150
    for L = 5:5:195
        tam = sprintf('L%.0f',L);
        res = sprintf('R%.3f', Res);
        mat = '.mat';
        
        nome = strcat(caminho,tam,res,mat); %Concatena o nome
        temp = sim('sistema_polo_terra'); %Roda a simulação e retorna o temp dela
        save(nome); %Salva os dados
    end
end

%% Referente a faltas Polo Polo para faltas com resistencia de 0.1 e 200

L = 5;% Variável para indicar o tamanho da rede
Res = 5.000; %Variável para indicar a resistência da falta
tempfault = [1.5, 1.515]; %Tempo da falta
dados = 13500; %tamanho da janela de amostras

caminho = './faltas_polo_polo/';
mat = '.mat';

for L = 10:10:190
    % Para faltas de reistencia 0.1 Ohms
    tam = sprintf('L%.0f',L);
    Res = 0.1;
    res = sprintf('R%.3f', Res);
    nome = strcat(caminho,tam,res,mat); %Concatena o nome
    temp = sim('sistema_polo_polo'); %Roda a simulação e retorna o temp dela
    save(nome); %Salva os dados
    % Para faltas de resistencia 200 Ohms
    Res = 200;
    res = sprintf('R%.3f', Res);
    nome = strcat(caminho,tam,res,mat); %Concatena o nome
    temp = sim('sistema_polo_polo'); %Roda a simulação e retorna o temp dela
    save(nome); %Salva os dados
end

%% Referente a faltas Polo Terra para faltas com resistencia de 0.1 e 200

L = 5;% Variável para indicar o tamanho da rede
Res = 5.000; %Variável para indicar a resistência da falta
tempfault = [1.5, 1.515]; %Tempo da falta
dados = 13500; %tamanho da janela de amostras

caminho = './faltas_polo_terra/';
mat = '.mat';

for L = 10:10:190
    % Para faltas de reistencia 0.1 Ohms
    tam = sprintf('L%.0f',L);
    Res = 0.1;
    res = sprintf('R%.3f', Res);
    nome = strcat(caminho,tam,res,mat); %Concatena o nome
    temp = sim('sistema_polo_terra'); %Roda a simulação e retorna o temp dela
    save(nome); %Salva os dados
    % Para faltas de resistencia 200 Ohms
    Res = 200;
    res = sprintf('R%.3f', Res);
    nome = strcat(caminho,tam,res,mat); %Concatena o nome
    temp = sim('sistema_polo_terra'); %Roda a simulação e retorna o temp dela
    save(nome); %Salva os dados
end
