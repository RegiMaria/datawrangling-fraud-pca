# Detecção de Fraude em Cartão de Crédito - Data Wrangling & PCA

Projeto pessoal de preparação de dados (data wrangling) aplicado a um cenário de
detecção de fraude em transações de cartão de crédito. O dataset é **sintético**,
gerado programaticamente com a mesma estrutura de um problema real de fraude
(variáveis anonimizadas `V1`...`V28`, `Time`, `Amount` e `Class`).

## Contexto do projeto

Este exercício de preparação de dados faz parte da formação [MCIO + Leega](https://www.linkedin.com/company/mciobrasil/posts/)
para Engenharia de Dados. A formação inclui:

1. Fundamentos de dados
2. Preparação de dados
3. Engenharia e Arquitetura de dados
4. Visualização e storytelling de dados

Este projeto replica, com um dataset próprio e gerado de forma independente, o mesmo
fluxo técnico estudado no módulo de Data Wrangling & PCA: correlação entre variáveis,
padronização, redução de dimensionalidade e balanceamento de classes, aplicado a um
cenário de detecção de fraude em transações de cartão de crédito.

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
http://localhost:8888/lab/tree/notebooks/DataPrep.ipynb
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
│   └── transacoes_cartao.csv
├── notebooks/
│   └── DataPrep.ipynb
├── Dockerfile
├── docker-compose.yml
├── .dockerignore
├── .gitignore
├── requirements.txt
└── README.md
```

## Stack utilizada

- Python 3.11
- pandas, numpy
- scikit-learn (StandardScaler, PCA, train_test_split, normalize)
- matplotlib, seaborn
- Jupyter Lab (`tornado` fixado em `6.4.2` - veja "Desafios técnicos" abaixo)
- Docker / Docker Compose

## Desafios técnicos

Durante a containerização, o Jupyter Lab subia normalmente, mas toda a interface
ficava em branco: até arquivos simples como o favicon retornavam erro 500. O
*traceback8 revelou uma incompatibilidade entre o `jupyter_server` e uma versão
recente do `tornado` :

Mudança em como o `FileFindHandler` lida com links
simbólicos - `AttributeError: 'FileFindHandler' object has no attribute
'allowed_symlink_directory'`.

Como o `requirements.txt` não fixava a versão do `tornado`, o `pip` sempre
instalava a mais recente disponível - incluindo a versão com o bug. A correção
foi fixar `tornado==6.4.2`, uma versão anterior à mudança que quebrou a
compatibilidade, garantindo que o build seja sempre reprodutível até que o
`jupyter_server` seja atualizado para suportar a nova versão do `tornado`.

## Próximos passos

- Treinar um classificador (KNN, Regressão Logística ou Random Forest) sobre a base
  preparada e avaliar com métricas adequadas para classes desbalanceadas (precision,
  recall, F1, matriz de confusão).
- Adicionar testes automatizados para as etapas de preparação de dados.
- Publicar a imagem Docker em um registry (Docker Hub / GitHub Container Registry)
  para facilitar o compartilhamento.