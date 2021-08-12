setwd("D:/Users/Higor/Documents/Anomalias de Codigo/Analise R/Projeto1")
getwd()

vendas <- read.csv("Vendas.csv", fileEncoding = "windows-1252")

View(vendas)
str(vendas)

#Resumo
summary(vendas$Valor)
summary(vendas$Custo)

#Media
?mean
mean(vendas$Valor)
mean(vendas$Valor)

#Media ponderada
?weighted.mean
weighted.mean(vendas$Valor, w = vendas$Custo)

#Mediana
median(vendas$Valor)
median(vendas$Custo)

#Moda
moda <- function(v){
  valor_unico <- unique(v) #Unique conta o numero de repeticoes
  valor_unico[which.max(tabulate(match(v, valor_unico)))]
}

resultado <- moda(vendas$Custo)
print(resultado)

#Criação de graficos
install.packages("ggplot2")
library(ggplot2)

ggplot(vendas) + stat_summary(aes(x = Estado, y = Valor),
                             fun = mean,
                             geom = "bar",
                             fill = "orange",
                             col = "grey50") +
  labs(title = "Média de valor por estado")
