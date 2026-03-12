# Algoritmo de Recomendação de Músicas com Neo4j

## 📋 Sobre
Sistema que utiliza grafos para recomendar músicas baseado em padrões de escuta.

## 🚀 Como usar

### Pré-requisitos
- Neo4j (4.4+)
- Biblioteca GDS instalada

### Instalação
1. Clone o repositório
2. Execute o schema: `cypher-shell -f data/schema.cypher`
3. Importe os dados: `cypher-shell -f data/dados_exemplo.cypher`

### Queries de recomendação
```cypher
// Cole aqui uma query exemplo
```
## 📊 Modelo de Dados
https://docs/diagrama.png

## 🛠️ Tecnologias

- Neo4j
- Graph Data Science Library
- Cypher


## Passo a Passo para Você Agora:

### 1. **No GitHub:**
```bash
# Crie uma pasta local
mkdir sistema-recomendacao-musical
cd sistema-recomendacao-musical

# Inicie o git
git init

# Crie os arquivos
mkdir data queries gds docs

# Adicione os códigos Cypher em arquivos .cypher
echo "// Seu código aqui" > data/schema.cypher

# Commit
git add .
git commit -m "Initial commit"

# Conecte ao GitHub
git remote add origin https://github.com/seu-usuario/sistema-recomendacao-musical.git
git push -u origin main

