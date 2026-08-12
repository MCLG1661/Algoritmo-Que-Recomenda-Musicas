# 🎵  Algoritmo de Recomendação de Músicas com Neo4j

*Sistema de recomendação de músicas utilizando Graph Data Science*

![Neo4j](https://img.shields.io/badge/Neo4j-Graph%20Database-4581C3?logo=neo4j&logoColor=white)
![Cypher](https://img.shields.io/badge/Cypher-Query%20Language-018BFF)
![Graph Data Science](https://img.shields.io/badge/Neo4j-Graph%20Data%20Science-008CC1)
![Recommendation System](https://img.shields.io/badge/ML-Recommendation%20System-8A2BE2)
![PageRank](https://img.shields.io/badge/Algorithm-PageRank-orange)
![Louvain](https://img.shields.io/badge/Algorithm-Louvain-green)
![Jaccard](https://img.shields.io/badge/Similarity-Jaccard-blue)
![DIO](https://img.shields.io/badge/DIO-Neo4j%20Bootcamp-5A0FC8)
![Status](https://img.shields.io/badge/Status-Concluído-brightgreen)

Sistema de recomendação de músicas desenvolvido com **Neo4j, Cypher e Graph Data Science (GDS)**.

O projeto utiliza relacionamentos entre usuários, músicas, artistas, gêneros e padrões 
de escuta para explorar diferentes estratégias de recomendação baseadas em grafos.

Além de consultas Cypher, o projeto aplica algoritmos como **PageRank, Louvain, 
Jaccard Similarity e Shortest Paths**, culminando em uma abordagem híbrida de recomendação.

---

## 🎯 Objetivo

Explorar como bancos de dados orientados a grafos e algoritmos de Graph Data Science 
podem ser utilizados para construir sistemas de recomendação musical.

O projeto trabalha conceitos como:

- Graph Databases
- Neo4j
- Cypher
- Graph Data Science
- Recommendation Systems
- Similaridade entre usuários
- Detecção de comunidades
- Centralidade
- Caminhos em grafos
- Recomendação híbrida

---

## 🧠 Por que Grafos para Recomendação?

Sistemas de recomendação trabalham fundamentalmente com **relações**.

Em um contexto musical :

```text
Usuário
   ↓
OUVIU
   ↓
Música
   ↓
PERTENCE_A
   ↓
Gênero

Ao mesmo tempo:

Usuário A
   ↓
OUVIU
   ↓
Música X
   ↑
OUVIU
   ↑
Usuário B

```

Essas conexões permitem identificar padrões de comportamento, similaridade entre 
usuários e conteúdos relacionados.

---

## 🏗️ Arquitetura Conceitual

```text
Usuários
   ↓
Histórico de Escuta
   ↓
Grafo Neo4j
   ↓
┌─────────────────────────────┐
│ Graph Data Science          │
│                             │
│ • Jaccard Similarity        │
│ • Louvain                   │
│ • PageRank                  │
│ • Shortest Paths            │
└──────────────┬──────────────┘
               ↓
        Análise do Grafo
               ↓
     Geração de Candidatos
               ↓
      Recomendação Híbrida
               ↓
            Músicas

```

---

## 🕸️ Visualização do Grafo

<p align="center">
  <img src="./Algoritmo  de Recomendação de Música.png"
       alt="Grafo do Sistema de Recomendação Musical"
       width="850">
</p>

O grafo representa as conexões utilizadas para explorar padrões de consumo musical 
e gerar recomendações.

---

## 🔬 Algoritmos Utilizados

👥 Jaccard Similarity

A similaridade de Jaccard é utilizada para explorar o grau de similaridade entre 
usuários a partir de elementos compartilhados.

No contexto do projeto, essa abordagem permite investigar usuários com padrões 
de consumo musical semelhantes.

Arquivo :

`Similaridade entre Usuários (Jaccard Similarity).cypher`

🧩 Louvain Community Detection

O algoritmo **Louvain** permite identificar comunidades dentro de um grafo.

Em sistemas de recomendação, comunidades podem revelar grupos de usuários ou 
entidades com padrões de relacionamento semelhantes.

Arquivo :

`Detecção de Comunidades (Louvain).cypher`

⭐ PageRank

O **PageRank** explora a importância relativa dos nós considerando sua estrutura 
de conexões.

No contexto musical, métricas de centralidade podem ajudar a analisar a relevância 
estrutural de determinados elementos dentro do grafo.

Arquivo:

`Algoritmos GDS - PageRank.cypher`

🛣️ Shortest Paths

A análise de caminhos permite explorar conexões indiretas existentes no grafo.

Essas conexões podem revelar relações que não seriam imediatamente evidentes em 
uma análise baseada apenas em relações diretas.

Arquivo :

`Caminhos Mais Curtos (Recomendação por Conexões Indiretas).cypher`

---

# 🎯 Sistema de Recomendação

O projeto explora diferentes sinais provenientes do grafo para construir recomendações.

Uma estratégia conceitual pode ser representada por :

```text
Preferências do Usuário
        +
Similaridade entre Usuários
        +
Comunidades
        +
Centralidade
        +
Conexões Indiretas
        ↓
Combinação dos Sinais
        ↓
Ranking
        ↓
Recomendação
```

O repositório inclui uma implementação específica destinada à exploração dessa 
abordagem:

`Sistema de Recomendação Completo (Híbrido).cypher`

---

## 🔄 Pipeline

```text
Dados
  ↓
Schema do Grafo
  ↓
Nós + Relacionamentos
  ↓
Neo4j
  ↓
Consultas Cypher
  ↓
Graph Data Science
  ↓
┌───────────────────────────┐
│ Similaridade              │
│ Comunidades               │
│ Centralidade              │
│ Caminhos                  │
└─────────────┬─────────────┘
              ↓
       Recommendation
              ↓
           Ranking
              ↓
           Músicas
```
---

## 🛠️ Tecnologias


**Neo4j** - Banco de dados orientado a grafos

**Cypher** - Modelagem e consultas

**Neo4j GDS** - Algoritmos de Graph Data Science

**PageRank** - Análise de centralidade

**Louvain** - Detecção de comunidades 

**Jaccard Similarity** - Similaridade

**Shortest Paths** - Análise de conexões indiretas

**Git** - Versionamento

**GitHub** - Repositório e documentação

---

## 📂 Estrutura do Projeto

```text
Algoritmo-Que-Recomenda-Musicas/
│
├── Schema e Dados de Exemplo.cypher
├── Queries Básicas Para Recomendação.cypher
├── Similaridade entre Usuários (Jaccard Similarity).cypher
├── Detecção de Comunidades (Louvain).cypher
├── Algoritmos GDS - PageRank.cypher
├── Caminhos Mais Curtos (Recomendação por Conexões Indiretas).cypher
├── Sistema de Recomendação Completo (Híbrido).cypher
├── Algoritmo de Recomendação de Músicas.json
├── Algoritmo de Recomendação de Música.png
└── README.md
```
---

## ▶️ Como Executar

### Pré-requisitos

- Neo4j
- Neo4j Graph Data Science Library
- Ambiente capaz de executar consultas Cypher

1. Clone o projeto

git clone https://github.com/MCLG1661/Algoritmo-Que-Recomenda-Musicas.git

2. Crie o grafo

Execute:

`Schema e Dados de Exemplo.cypher`

3. Explore as consultas básicas

Execute:

`Queries Básicas Para Recomendação.cypher`

4. Explore os algoritmos

Execute individualmente os arquivos correspondentes a:

- Jaccard Similarity
- Louvain
- PageRank
- Shortest Paths

5. Explore a abordagem híbrida

Execute:

`Sistema de Recomendação Completo (Híbrido).cypher`

---

## 💡 Competências Demonstradas

- Neo4j
- Cypher
- Graph Databases
- Graph Data Science
- Recommendation Systems
- Similarity Analysis
- Community Detection
- Centrality Algorithms
- Path Finding
- Data Modeling
- Sistemas de recomendação baseados em grafos
- Análise de relacionamentos
- NoSQL
- Git e GitHub

---

## 🚀 Possíveis Evoluções

O projeto pode evoluir incorporando:

- Dataset musical de maior escala
- Dados reais de interação
- Embeddings
- Node Similarity
- K-Nearest Neighbors
- Collaborative Filtering
- Content-Based Filtering
- Machine Learning
- Graph Embeddings
- FastAPI
- Interface web
- Avaliação das recomendações
- Precision@K
- Recall@K
- NDCG
- Personalização em tempo real

Uma evolução particularmente interessante seria comparar o sistema baseado em 
grafos com métodos tradicionais de Collaborative Filtering.

---

## 🎓 Contexto Acadêmico

Projeto desenvolvido como desafio final da disciplina **Primeiros Passos com Cypher 
e Neo4j**, integrante do **Bootcamp Neo4j — Análise de Dados com Grafos**, da DIO.

**Professor:** Matheus Ferreira  
**Período:** Primeiro semestre de 2026  
**Entrega:** 12/03/2026

---

## 🤝 Como Contribuir

Contribuições são bem-vindas, especialmente nas áreas de:

- Graph Data Science
- Recommendation Systems
- Cypher
- Algoritmos de similaridade
- Graph Machine Learning
- Avaliação de recomendações

1. Faça um Fork do projeto
2. Crie uma branch para sua funcionalidade
3. Implemente e teste as alterações
4. Faça o commit
5. Envie sua branch
6. Abra um Pull Request descrevendo a melhoria

---

## 👨‍💻 Autor

**Marcus Guedes**

Marketing | Data Science | Inteligência Artificial | Gestão de Projetos

GitHub: MCLG1661  
LinkedIn: Marcus Guedes

---

🎵 **Transformando conexões entre usuários e músicas em recomendações.** 


