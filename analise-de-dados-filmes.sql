-- Lembrando das tabelas do banco de dados ---

SELECT * FROM alugueis;
SELECT * FROM atores;
SELECT * FROM atuacoes;
SELECT * FROM clientes;
SELECT * FROM filmes;

# ===== PARTE 1: ===== #
# ===== CRIANDO AGRUPAMENTOS ===== #

-- CASE 1. Você deverá começar fazendo uma análise para descobrir o preço médio de aluguel dos filmes.

SELECT AVG(preco_aluguel) AS preco_medio_de_aluguel
FROM filmes;

-- CASE 2. Agora que você sabe o preço médio para se alugar filmes na hashtagmovie, você deverá ir além da sua análise e 
-- descobrir qual é o preço médio para cada gênero de filme.

SELECT 
	genero,
	ROUND(AVG(preco_aluguel),2) AS preco_medio_de_aluguel,
    COUNT(*) AS qtd_filmes
FROM filmes
GROUP BY genero;

# ===== PARTE 2: ===== #
# ===== FILTROS EM AGRUPAMENTOS ===== #

-- Você deve alterar a consulta do CASE 2 e considerar o seguinte cenário:

-- CASE 3: Fazer a mesma análise, mas considerando apenas os filmes com ANO_LANCAMENTO igual a 2011.

SELECT 
	genero,
	ROUND(AVG(preco_aluguel),2) AS preco_medio_de_aluguel,
	COUNT(*) AS qtd_filmes
FROM filmes
WHERE ano_lancamento = 2011
GROUP BY genero;

# ===== PARTE 3: ===== #
# ===== SUBQUERIES: UTILIZANDO UM SELECT DENTRO DE OUTRO SELECT ===== #

-- CASE 4: Você precisará fazer uma análise de desempenho dos alugueis. Para isso,
-- uma análise comum é identificar quais aluguéis tiveram notas acima da média. Você
-- seria capaz de fazer isso?

SELECT * 
FROM alugueis
WHERE nota >= (SELECT AVG(nota) FROM alugueis);

-- CASE 5. Crie uma view para guardar o resultado do SELECT.

CREATE VIEW resultados AS
SELECT 
	titulo,
	COUNT(*) AS num_alugueis,
	AVG(nota) AS media_nota,
	SUM(preco_aluguel) AS receita_total
FROM alugueis
LEFT JOIN filmes
ON alugueis.id_filme = filmes.id_filme
GROUP BY titulo
ORDER BY num_alugueis DESC;

SELECT * FROM resultados;