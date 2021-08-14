vetor_dados <- c(5, 1, 6, 12, 10, 25) #Cria-se um conjunto de valores de exemplo
name(vetor_dados) = c('A', 'B', 'C', 'D', 'E', 'F')
vetor_dados

#Barplot
?barplot
barplot(vetor_dados)
barplot(vetor_dados, col = c(1,2,3,4,5))

#Salvando o barplot na pasta
png('barplot.png', width = 480, height = 480)
barplot(vetor_dados,
        col = rgb(1,0,0,0.5),
        xlab = 'Categorias',
        ylab = 'Valores',      #xlab() e ylab() definem as legendas dos dados
        main = 'Barplot em R', #Dá um titulo ao grafico 
        ylim = c(0,30)) #Impõe limite a uma dimensão
dev.off()

#ggplot2
library(ggplot2)
View(mtcars) #Uma tabela que vem de base no R

#Segundo barplot
ggplot(mtcars, aes(x = as.factor(cyl))) + geom_bar()

#Mais dados de exemplo
dados = data.frame(group = c('A','B','C','D'), value = c(33,62,57,64))

#Terceiro barplot
ggplot(dados, aes(x = group, y = value, fill = group)) + geom_bar(width = 0.85, stat = 'identity')

#Pie chart (gráfico de pizza)
?pie
partes <- c(4,8,16,10,12)
estados <- c('Sergipe', 'Maranhão', 'Ceará', 'Bahia', 'Paraiba')
pie(partes, labels = estados, main = "Estados por quantidade de arranha-ceus")

#Pacote plotlix permite gráficos mais "bonitos"
install.packages('plotrix')
library('plotrix')

#Pie chart 3D
partes <- c(4,8,16,10,12)
estados <- c('Sergipe', 'Maranhão', 'Ceará', 'Bahia', 'Paraiba')
pie3D(partes, labels = estados, main = "Estados por quantidade de arranha-ceus") #Não é muito bonito, mas existe

#Gráfico de linhas
carros <- c(1,4,3,6,12)
caminhoes <- c(2,5,1,9,10)

?plot
plot(carros, type = 'o', col = 'darkblue', ylim = c(0,12))

?lines
lines(caminhoes, type = 'o', col = 'red', ylim = c(0,12))

title(main = 'Produção de veículos em Março (em centenas)', col.main = 'red', font.main = 1)

#Boxplot
View(mpg)

?boxplot
ggplot(mpg, aes(x = reorder(class,hwy), y = hwy, fill = class)) + 
  geom_boxplot() +
  xlab('class') +
  theme(legend.position = 'none' )

#Scatter plot (gráfico de dispersão)
?data.frame
data = data.frame(cond = rep(c('Condição 1', 'Condição 2'), each = 10), #Cria repetição de Condição 1 e 2 a cada 10 unidades
                  my_x = 1:100 + rnorm(100, sd = 9), my_y = 1:100 + rnorm(100, sd=16)) #Gera valores aleatorios 

View(data)
ggplot(data, aes(x = my_x, y = my_y)) + geom_point(shape = 1)

#Scatter plot com uma linha de regressão
ggplot(data, aes(x = my_x, y = my_y)) + geom_point(shape = 1) +
  geom_smooth(method = lm, color = 'red', se = FALSE) #Para por margem de erro, 'se = TRUE'

#Treemap
install.packages('treemap')
library(treemap)

grupo = c(rep('grupo-1', 4), rep('grupo-2', 2), rep('grupo-3', 3)) #Treemaps não aceitam palavras com underline nem letra maiuscula
subgrupo = paste('subgrupo', c(1,2,3,4,1,2,1,2,3), sep = '-')
valor = c(25,4,12,16,22,8,5,19,15)
dados = data.frame(grupo, subgrupo, valor)
View(dados)

?treemap
treemap(dados,
        index = c('grupo', 'subgrupo'),
        vSize = 'valor',
        type = 'index',
        fontsize.labels = c(12,8),
        fontcolor.labels = c('white', 'orange'),
        fontface.labels = c(2,1),
        bg.labels = 220,
        align.labels = list(c('center', 'center'), c('right', 'bottom')),
        overlap.labels = 0.5,
        inflate.labels = F)
 
#Histograma
dados_histo <- mtcars$mpg
?hist
histo <- hist(dados_histo,
          breaks = 10,
          col = 'orange',
          xlab = 'Milhas por galão',
          main = 'Histograma com curva de distribuição',)

#Personalizando o histograma
xfit <- seq(min(dados_histo), max(dados_histo), length = 40)
yfit <- dnorm(xfit, mean = mean(dados_histo), sd = sd(dados_histo))
yfit <- yfit * diff(histo$mids[1:2]) * length(dados_histo)
lines(xfit, yfit, col = 'blue', lwd = 2) #É criada uma linha que segue a média dos valores

#Histograma usando ggplot
tabela_histo = data.frame(dados_histo)
View(tabela_histo)
ggplot(tabela_histo, aes(x = dados_histo)) + 
  geom_histogram(binwidth = 1.2, color = 'white', fill = rgb(0.2,0.7,0.1,0.4))

#Versão do histograma com indicação de cor próxima a média
ggplot(tabela_histo, aes(x = dados_histo)) + 
  geom_histogram(binwidth = 1.2, aes(fill = ..count..))

