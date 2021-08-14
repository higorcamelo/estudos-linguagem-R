notas <- read.csv('Notas.csv', fileEncoding = 'Windows-1252')

#Resumo de tipos de dados e estatisticas
View(notas)
str(notas)
summary(notas$TurmaA)
summary(notas$TurmaB)

#Media de cada turma
mean(notas$TurmaA)
mean(notas$TurmaB)

#Qual turma teve maior discrepancia de notas?
sd(notas$TurmaA)
sd(notas$TurmaB)

#Coeficiente de variação
coeficiente_ta <- (sd(notas$TurmaA) / mean(notas$TurmaA)) * 100
coeficiente_tb <- (sd(notas$TurmaB) / mean(notas$TurmaB)) * 100

print(coeficiente_ta)
print(coeficiente_tb)

#Qual nota apareceu mais em cada turma?
calculaModa <- function(v){
  val_unico <- unique(v)
  val_unico[which.max(tabulate(match(v, val_unico)))]
}

calculaModa(notas$TurmaA)
calculaModa(notas$TurmaB)