# Fault Location in VSC HVDC
Este repositório consiste nos arquivos utlizados para localização de faltas em linhas de transmissão de alta tensão em corrente contínua.

## Simulação!

 * Foi utilizado o sistema VSC-HVDC disponibilizado pelo Simulink, onde as faltas que vieram com o modelo foram retiradas. O sistema utilizado pode ser encontrados nos arquivos:
    * sistema_polo_polo.slx
    * sistema_polo_terra.slx
 * Algumas configurações do sistema:
    * Linha: 200km
    * Resistência por unidade de comprimento: 1.39 x 10e-02 Ohms/km
    * Indutância por unidade de comprimento: 1.59 x 10-04 H/km
    * Capacitância por unidade de comprimento: 2.31 x 10e-07 F/km
    * Número de seções pi: 4
 - Demais configurações podem ser encontradas no help no matlab!

## Métodos utilizados!

### Método 1: Utilização de uma Rede Neural Artificial.

- Este método consite em obter os dados a partir das simulações de faltas em sistemas HVDC e aplicar entradas em uma RNA, sendo a saída a distância na linha de transmissão onde ocorreu a falta.

Foram aplicadas as seguinte entradas:
* Valor máximo
* Valor mínimo
* Variância
* Média pré falta
* Média na falta
* Média pós falta
* Energia pré falta
* Energia na falta
* Energia pós falta

De modo que esses valores foram calculados no sinal de corrente no polo positivo do retificador. 


### Método 2: Utilização de uma Rede Neural Artificial com processamento por Transformada Wavelet Packet.

- Este método consiste em processar os dados obtidos das simulações de faltas em sistemas HVDC com a Transformada Wavelet Packet e inserir os valores máximos dos coeficientes em uma RNA, sendo a saída a distância da linha de transmissão onde ocorreu a falta. 

Algumas configuração da Wavelet:
* Familia: db2
* Nível: 4º nivel
* Janela escolhida é composto por 368 dados. 


### Método 3: Utilização de uma Rede Neural Artificial com processamento por meio dos Coeficientes de Frequência Mel Cepstrais.

- Este método consiste em processar os dados obtidos das simulações de faltas em sistemas HVDC com os Coeficiêntes de frequência de Mel Cepstrais (MFCC) e inserir os Cepstrais em uma RNA, sendo a saída a distância da linha de transmissão onde ocorreu a falta.

Algumas configurações do MFCC:
* Número de Cepstrais: 20
* Unica janela com 515 amostras. 

