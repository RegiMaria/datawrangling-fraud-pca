## Docker: conceitos básicos

Se você nunca usou Docker, aqui vai o essencial pra entender
este projeto antes de rodar os comandos abaixo.

**O que é Docker?**

Docker empacota um ambiente inteiro,  sistema operacional mínimo,
linguagem, bibliotecas e código, dentro de um pacote que roda de forma
idêntica em qualquer máquina. Isso resolve o clássico problema de
"na minha máquina funciona": sem Docker, quem for rodar este projeto
precisaria instalar Python na versão certa e cada biblioteca manualmente,
torcendo pra não haver conflito com outra coisa já instalada. 

Com Docker, o ambiente vem pronto, sempre igual.

**Os três conceitos mais importantes**

| Conceito | O que é |
|---|---|
| **Dockerfile** | A receita - um arquivo de texto com o passo a passo para montar o ambiente (`FROM`, `COPY`, `RUN`, `CMD`) |
| **Imagem** | O pacote pronto e congelado, gerado a partir do Dockerfile |
| **Container** | Uma instância rodando dessa imagem - o ambiente de fato ativo |

**O fluxo, passo a passo**

```
Dockerfile  --docker build-->  Imagem  --docker run     / compose up-->  Container
(a receita)                    (o pacote congelado)                  (rodando de verdade)
```

1. **Dockerfile** - a receita escrita neste repositório: qual sistema base usar (`python:3.11-slim`), quais bibliotecas instalar (`requirements.txt`), quais arquivos copiar (notebook e dados) e o que rodar ao final (`jupyter lab`). Sozinho, o Dockerfile não executa nada - é só texto.
2. **`docker build`** (ou `docker compose build`) - lê essa receita e gera a **imagem**: um pacote congelado, com tudo já instalado e configurado, pronto para ser ligado em qualquer máquina com Docker.
3. **`docker run`** (ou `docker compose up`) - pega essa imagem e liga um **container**: a instância viva, rodando de verdade, acessível em `http://localhost:8888`.

Resumindo com uma analogia: o Dockerfile é a receita de bolo; a imagem é o bolo assado e pronto;
o container é o bolo sendo servido e comido. Você escreve a receita uma vez, 
mas pode assar (build) e servir (run) quantas vezes quiser, em quantas cozinhas (máquinas) diferentes quiser
- o resultado será sempre o mesmo bolo.

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