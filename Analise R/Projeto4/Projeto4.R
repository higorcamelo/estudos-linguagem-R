dados <- read.table("Usuarios.csv",
                    dec = '.',   #Aqui, é definido o separador das casas decimais, "." 
                    sep = ',',   #Aqui, o separador de colunas, ","
                    h = T,       #E aqui, considera a primeira linha com cabeçalho(header)
                    fileEncoding = 'windows-1252')

#Exibição de dados
View(dados)
names(dados) #Nome das colunas e linhas
str(dados)
summary(dados$grau_instrucao)#Como obviamente não se pode fazer calculos, exibe-se apenas a contagem

#Tabela de frequencias
frequencia <- table(dados$grau_instrucao)
View(frequencia)

#Tabela de frequencia relativa
frequencia_relativa <- prop.table(frequencia) * 100 #Multiplicação por 100 para deixar os valores mais agradaveis
View(frequencia_relativa)

#Adicionando linhas de total
frequencia <- c(frequencia, sum(frequencia)) #Relembrando, função c() cria vetores de palavras
names(frequencia)[4] <- 'Total'
View(frequencia)

#Adicionandos linhas de total de frequencia relativa
frequencia_relativa <- c(frequencia_relativa, sum(frequencia_relativa))
View(frequencia_relativa)

#Nessas duas últimas funções, há algo errado que não gera as tabelas no formato padrão de tabelas

#Cria uma tabela final
tabela_final <- cbind(frequencia, frequencia_relativa = round(frequencia_relativa, digits = 2))
View(tabela_final)
