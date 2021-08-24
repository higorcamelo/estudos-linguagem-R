
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

#Convertendo a variável de inadimplencia para fator
dados_clientes$Inadimplencia <- as.factor(dados_clientes$Inadimplencia)
prop.table(table(dados_clientes$Inadimplencia)) #Proporção de clientes nadimplentes e inadimplentes

#Set seed
set.seed(12345)

#Particionando os dados entre teste e treino
?createDataPartition
indice <- createDataPartition(dados_clientes$Inadimplencia, p = 0.75, list = FALSE) #Define 75% dos dados para o modelo 
dim(indice) #O indice "corta" parte dos dados, dividindo para treino e teste

dados_treino <- dados_clientes[indice,]
dim(dados_treino)

dados_teste <- dados_clientes[-indice,] #Com o simbolo de -, se seleciona tudo que não foi pegue anteriormente

#Inicindo primeiro modelo de aprendizado de maquina
?randomForest
modelo_v1 <- randomForest(Inadimplencia ~ ., data = dados_treino)#Lê-se "dado alvo ~ base de dados" . = todas 
modelo_v1

#Previsões do primeiro modelo
previsoes_v1 <- predict(modelo_v1, dados_teste)

#Matriz de confusao
?caret::confusionMatrix #Nome do pacote mais :: especifica em caso de funções presentes em varias bibliotecas
cm_v1 <- caret::confusionMatrix(previsoes_v1, dados_teste$Inadimplencia, positive = '1')
cm_v1 #Exibe dados acerca de precisão, taxa de acerto e etc...

#Verificar sobre recall, precision e F1
#Não foi possível balancear os dados, o pacote DMwR foi descontinuado

#Detectando as variaveis mais influentes no modelo
?importance
imp_var <- importance(modelo_v1)
VarImportancia <- data.frame(Variables = row.names(imp_var),
                             Importance = round(imp_var[ , 'MeanDecreaseGini'],2))
rankImportancia <- VarImportancia %>%
  mutate(Rank = paste0('#', dense_rank(desc(Importance)))) #Isso modifica a representação dos graficos

ggplot(rankImportancia, aes(x = reorder(Variables, Importance),
                            y = Importance, fill = Importance)) +
  geom_bar(stat = 'identity') + 
  geom_text(aes(x = Variables, y = 0.5, label = Rank),
                                          hjust = 0,
                                          vjust = 0.55,
                                          size = 4,
                                          colour = 'red') +
  labs(x = 'Variables') + coord_flip()

#Novo modelo de aprendizado, agora apenas com as variaveis úteis
modelo_v2 <- randomForest(Inadimplencia ~ PAY_0 + PAY_2 + PAY_3 + PAY_AMT1 + PAY_AMT2 + PAY_5 + BILL_AMT1,
                          data = dados_treino)
modelo_v2

previsoes_v2 <- predict(modelo_v2, dados_teste)

cm_v2 <- caret::confusionMatrix(previsoes_v2, dados_teste$Inadimplencia, positive = '1')
cm_v2 #Percebe-se uma levíssima, quase dispensável superioridade do primeiro modelo

#Salvando os modelos em disco
saveRDS(modelo_v1, file = 'Modelos/modelo_1.rds')
saveRDS(modelo_v2, file = 'Modelos/modelo_2.rds')

#ReadRDS para ler os arquivos, igual read.csv