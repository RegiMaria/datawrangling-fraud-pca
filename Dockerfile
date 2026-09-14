# Imagem base leve com Python 3.11
FROM python:3.11-slim

# Evita prompts interativos e bytecode desnecessário
ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1

# Diretório de trabalho dentro do container
WORKDIR /app

# Copia e instala as dependências primeiro (aproveita cache de camadas do Docker)
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copia o notebook e o dataset, preservando a mesma estrutura de pastas do projeto
COPY notebooks/ ./notebooks/
COPY data/ ./data/

# Porta padrão do Jupyter
EXPOSE 8888

# Sobe o Jupyter Lab acessível de fora do container, sem exigir token
# (adequado para uso local/portfólio; NÃO use --NotebookApp.token='' em produção)
CMD ["jupyter", "lab", \
     "--ip=0.0.0.0", \
     "--port=8888", \
     "--no-browser", \
     "--allow-root", \
     "--notebook-dir=/app", \
     "--NotebookApp.token=''", \
     "--NotebookApp.password=''"]