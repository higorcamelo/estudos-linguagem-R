vendas <- read.csv("Vendas.csv", fileEncoding = "windows-1252")

#Variancia
var(vendas$Valor)

#Desvio padrao
sd(vendas$Valor)

#Resumos
head(vendas)
tail(vendas)
View(vendas)

#Tendencia central
summary(vendas[c("Valor","Custo")]) #c() cria vetores de palavras, no caso, Valor e Custo

#Variaveis numericas
quantile(vendas$Valor)
quantile(vendas$Valor, probs = c(0.01, 0.99)) #Divide o percentil em apenas 1% e 99%
quantile(vendas$Valor, seq(from = 0, to = 1, by = 0.20)) #Calcula quartis de 0 a 100% indo de 20 em 20
IQR(vendas$Valor) #Diferença entre quartil 3 e 1
range(vendas$Valor) #Exibe os valores máximos e minimos
diff(range(vendas$Valor)) #diff calcula a diferença entre os valores de range()
