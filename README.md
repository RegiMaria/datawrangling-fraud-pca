# Detecção de Fraude em Cartão de Crédito - Data Wrangling & PCA

Projeto pessoal de preparação de dados (data wrangling) aplicado a um cenário de
detecção de fraude em transações de cartão de crédito. O dataset é **sintético**,
gerado programaticamente com a mesma estrutura de um problema real de fraude
(variáveis anonimizadas `V1`...`V28`, `Time`, `Amount` e `Class`).

**Contexto do projeto**

Este exericício de preparação de dados faz parte da formação MCIO + Leega
para Engenharia de dados.

A formação inclui:
1. Fundamentos de dados
2. Preparação de dados
3. Engenharia e Arquitetura de dados
4. Visualização e storytelling de dados

Este projeto replica, com um dataset próprio e gerado de forma independente, o mesmo
fluxo técnico de preparação de dados aplicado a um cenário de detecção de fraude em
transações de cartão de crédito - inspirado no que estudei no módulo de Data Wrangling &
PCA da minha formação em Dados (Leega + MCIO+).


## O que este projeto faz

1. Gera uma base sintética de transações, fortemente desbalanceada (~0,35% de fraude).
2. Analisa a correlação entre as variáveis.
3. Padroniza `Amount` e `Time` com `StandardScaler`.
4. Reduz a dimensionalidade para 2 componentes principais com `PCA`.
5. Balanceia as classes (undersampling).
6. Separa a base em treino (80%) e teste (20%), com normalização.

## Como rodar com Docker

### Opção 1 - Docker Compose (recomendado)

```bash
docker compose up --build
```

Depois, acesse no navegador:

```
http://localhost:8888/lab/tree/DataPrep.ipynb
```

Para parar:

```bash
docker compose down
```

### Opção 2 - Docker puro

```bash
# Build da imagem
docker build -t fraude-datawrangling .

# Executar o container
docker run -p 8888:8888 fraude-datawrangling
```

Depois, acesse:

```
http://localhost:8888/lab
```

## Estrutura do projeto

```
.
├── data/
|     ├── transacoes_cartao.csv
├── notebooks/
|      ├── DataPrep.ipynb
├── Dockerfile
├── docker-compose.yml
├── .dockerignore
├── requirements.txt
├── README.md
```

## Stack utilizada

- Python 3.11
- pandas, numpy
- scikit-learn (StandardScaler, PCA, train_test_split, normalize)
- matplotlib, seaborn
- Jupyter Lab
- Docker / Docker Compose

## Próximos passos

- Treinar um classificador (KNN, Regressão Logística ou Random Forest) sobre a base
  preparada e avaliar com métricas adequadas para classes desbalanceadas (precision,
  recall, F1, matriz de confusão).
- Adicionar testes automatizados para as etapas de preparação de dados.
- Publicar a imagem Docker em um registry (Docker Hub / GitHub Container Registry)
  para facilitar o compartilhamento.
