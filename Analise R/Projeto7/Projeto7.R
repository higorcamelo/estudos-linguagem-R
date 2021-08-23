#Carregando os pacotes
library(Amelia)
library(caret)
library(ggplot2)
library(dplyr)
library(reshape)
library(randomForest)
library(e1071)

dados_clientes <- read.csv('dataset.csv')
#Genero: masculino = 1, feminino = 2
#Escolaridade: PG = 1, ES = 2, EM = 3, outros = 4
#Estado civil: casado = 1, solteiro = 2, outros = 3
#Adimplencia: em dia = -1, devendo = x > 1 (meses)

View(dados_clientes)

#Remoção da coluna de ID
dados_clientes$ID <- NULL
dim(dados_clientes)
View(dados_clientes)

#Renomeação de colunas
colnames(dados_clientes)
colnames(dados_clientes)[24] <- "Inadimplencia"
colnames(dados_clientes)[2] <- "Genero"
colnames(dados_clientes)[3] <- "Escolaridade"
colnames(dados_clientes)[4] <- "Estado_civil"
colnames(dados_clientes)[5] <- "Idade"

View(dados_clientes)

#Checagem de valores nulos
sapply(dados_clientes, function(x) sum(is.na(x))) #Percorre a tabela e detecta valores nulos
missmap(dados_clientes, main = "Valores nulos observados") #Visualmente não muito agradável, mas funcional
dados_clientes <- na.omit(dados_clientes)

#Substituindo valores de genero
?cut
dados_clientes$Genero <- cut(dados_clientes$Genero, c(0,1,2), labels = c('Masculino', 'Feminino'))

#Substituindo valores de escolaridade
dados_clientes$Escolaridade <- cut(dados_clientes$Escolaridade, c(0,1,2,3,4),
                                   labels = c('Pos graduação', 'Ensino superior', 'Ensino medio', 'Outros'))

#Substituindo valores de estado civil
dados_clientes$Estado_civil <- cut(dados_clientes$Estado_civil, c(-1,0,1,2,3),
                                   labels = c('Desconhecido', 'Casado', 'Solteiro', 'Outros'))

#Convertendo valores de idade para categorias
dados_clientes$Idade <- cut(dados_clientes$Idade, c(0,30,50,100), labels = c('Jovem', 'Adulto', 'Idoso'))

#Convertendo valores de adimplencia em fatores
dados_clientes$PAY_0 <- as.factor(dados_clientes$PAY_0)
dados_clientes$PAY_1 <- as.factor(dados_clientes$PAY_1)
dados_clientes$PAY_2 <- as.factor(dados_clientes$PAY_2)
dados_clientes$PAY_3 <- as.factor(dados_clientes$PAY_3)
dados_clientes$PAY_4 <- as.factor(dados_clientes$PAY_4)
dados_clientes$PAY_5 <- as.factor(dados_clientes$PAY_5)
dados_clientes$PAY_6 <- as.factor(dados_clientes$PAY_6)

#Remove-se valores nulos vindos da substituição de escolaridade
dados_clientes <- na.omit(dados_clientes)
