
# Instala os pacotes
install.packages("dplyr")
install.packages("data.table")
install.packages("ggplot2")

# Carrega os pacotes e dados
library(dplyr)
library(data.table)
library(ggplot2)

dados_iris <- iris
View(dados_iris)


#Sumarizar os dados com as médias de cada coluna de um dataset.
library(dplyr)
medias_iris <- summarize(group_by(dados_iris, Species),
                         media_sepal_length = mean(Sepal.Length), 
                         media_sepal_width = mean(Sepal.Width),
                         media_petal_length = mean(Petal.Length), 
                         media_petal_width = mean(Petal.Width))

View(medias_iris)


#Extrair o valor inteiro de uma das colunas decimais.
library(data.table)
dados_iris_id <- data.table(dados_iris)
View(dados_iris_id)
dados_iris_id$Sepal.Length <- as.integer(dados_iris_id$Sepal.Length)
View(dados_iris_id)


#Para executar no Power Query/Power BI
library(data.table)
dados_iris_id <- data.table(dados_iris)
dados_iris_id$Sepal.Length <- as.integer(dados_iris_id$Sepal.Length)


#Construir um gráfico mostrando a relação de duas variáveis numéricas para as 3 categorias de uma variável categórica.
library(ggplot2)
ggplot(data = dados_iris, aes(x = Petal.Width, y = Petal.Length)) +
  geom_point(aes(color = Species), size = 3) +
  ggtitle("Largura e Comprimento das Pétalas") +
  labs(x = "Largura da Pétala", 
       y = "Comprimento da Pétala") +
  theme_bw() +
  theme(title = element_text(size = 15, color = "turquoise4"))

colors() #Cores disponíveis no R

