<p align="center"> <img width="600" height="300" alt="Image" src="https://github.com/user-attachments/assets/c913687b-f3a6-4381-bb31-a1bcf7eb9548"  /> </p>


# Detecção de Fraude em Cartão de Crédito - Data Wrangling & PCA

Projeto pessoal de preparação de dados (data wrangling) aplicado a um cenário de
detecção de fraude em transações de cartão de crédito. O dataset é **sintético**,
gerado programaticamente com a mesma estrutura de um problema real de fraude
(variáveis anonimizadas `V1`...`V28`, `Time`, `Amount` e `Class`).

## Contexto do projeto

Este exercício de preparação de dados faz parte da formação [MCIO + Leega](https://www.linkedin.com/company/mciobrasil/posts/)
para Engenharia de Dados realizada entre 06 de julho de 2026 a 06 de novembro de 2026. A formação inclui:

1. Fundamentos de dados (12 horas)
2. Preparação de dados (20 horas)
3. Engenharia e Arquitetura de dados (20 horas)
4. Visualização e storytelling de dados (20 horas)

Este projeto replica, com um dataset próprio e gerado de forma independente, o mesmo
fluxo técnico estudado no módulo de Data Wrangling & PCA: correlação entre variáveis,
padronização, redução de dimensionalidade e balanceamento de classes, aplicado a um
cenário de detecção de fraude em transações de cartão de crédito.

<div align="center">
  <a href="https://github.com/RegiMaria/awesome-readme/blob/main/badges-templates.md">
    <img width="260" height="62" alt="Trilha em andamento" src="https://github.com/user-attachments/assets/c941873d-c43b-4958-937d-d493bb54c53d" />
  </a>
</div>

## Certificados

| 01 - Fundamentos de dados | 02 - Preparação de dados | 03 - Engenharia e Arquitetura de dados |
|:---:|:---:|:---:|
| <img src="https://github.com/user-attachments/assets/bb205a10-f5ad-40c8-bf23-c25679b6f348" width="400"/> | <img src="https://github.com/user-attachments/assets/1dea7381-fbc8-46f5-9a6c-1a2168252c18" width="400"/> | <img src="https://github.com/user-attachments/assets/0f39db7b-e989-4bca-b3c8-97ff8a95d845" width="400"/> |

## O que este projeto faz

1. Gera uma base sintética de transações, fortemente desbalanceada (~0,35% de fraude).
2. Analisa a correlação entre as variáveis.
3. Padroniza `Amount` e `Time` com `StandardScaler`.
4. Reduz a dimensionalidade para 2 componentes principais com `PCA`.
5. Balanceia as classes (undersampling).
6. Separa a base em treino (80%) e teste (20%), com normalização.

Problema de negócio

Este projeto simula um cenário real de consultoria de dados: um cliente do setor financeiro
já possui um modelo de machine learning treinado para detectar fraude em transações de cartão
de crédito, mas a base de dados bruta ainda não está em condições de alimentar esse modelo.

O que o cliente pediu:

- Entender se existe correlação entre as variáveis do dataset (matriz de correlação).
- Normalizar/padronizar as variáveis numéricas.
- Aplicar PCA para reduzir o dataset a 2 componentes principais, usados para treinar o modelo que o cliente já possui.
- Separar a base em treino (80%) e teste (20%) para o algoritmo.

Este repositório resolve esse problema de ponta a ponta, da análise exploratória até a base pronta para treino,
usando um dataset próprio, sintético e gerado de forma independente para fins de portfólio
(não é o dataset usado em sala de aula), com a mesma estrutura de um problema real de fraude
(variáveis anonimizadas V1...V28, Time, Amount e Class).

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

---
  <div align="center">

Se gostou, deixa uma ⭐

<img width="200" alt="Image" src="https://github.com/user-attachments/assets/aca57b06-3ea1-49e4-96fb-b2a00b8f8918" />

</div>

<div align="center">
Feito com 💙 por RegiMaria
</div>
