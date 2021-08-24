#Aqui serão testados os modelos previamente criados
#Mas desta vez em um novo contexto, com novos dados

modelo_final <- readRDS('Modelos/modelo_2.rds')

#Novos dados de 3 novos clientes
PAY_0 <- c(0,0,0)
PAY_2 <- c(0,0,0)
PAY_3 <- c(1,0,0)

PAY_AMT1 <- c(1100, 1000, 1200)
PAY_AMT2 <- c(1500, 1300, 1150)
PAY_5 <- c(0,0,0)
BILL_AMT1 <- c(350,420,280)

#Concatena em uma tabela
novos_clientes <- data.frame(PAY_0, PAY_2, PAY_3, PAY_AMT1, PAY_AMT2, PAY_5, BILL_AMT1)
View(novos_clientes)

#Faz-se a previsão(Incorreta, visto que os tipos das variaveis não batem com o modelo de aprendizado)
previsao_novos_clientes <- predict(modelo_final, novos_clientes)

#Convertendo os dados
novos_clientes$PAY_0 <- factor(novos_clientes$PAY_0, levels = levels(dados_treino$PAY_0))
novos_clientes$PAY_2 <- factor(novos_clientes$PAY_2, levels = levels(dados_treino$PAY_2))
novos_clientes$PAY_3 <- factor(novos_clientes$PAY_3, levels = levels(dados_treino$PAY_3))
novos_clientes$PAY_5 <- factor(novos_clientes$PAY_5, levels = levels(dados_treino$PAY_5))

str(novos_clientes)
#Previsão correta
previsao_novos_clientes <- predict(modelo_final, novos_clientes)
utils::View(previsao_novos_clientes)

#Assim, conclui-se que, de 3 clientes, não haverá inadimplencias
#Deve-se considerar o baixo número de amostras, em maiores quantidades de dados, o resultado não deve aparentar tão estranho

#Para exibição de modelos de previsão em formato de tabela, deve-se usar utils::View()