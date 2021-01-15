# Fault Location in VSC HVDC
Este repositório consiste nos arquivos utlizados para localização de faltas em linhas de transmissão de alta tensão em corrente contínua.

##Métodos utilizados!

###Método 1: Utilização de uma Rede Neural Artificial.

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

Obs.: Este repositório está em processo de atualização!
