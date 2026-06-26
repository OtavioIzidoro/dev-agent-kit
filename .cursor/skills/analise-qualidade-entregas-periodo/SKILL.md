````md
---
name: analise-qualidade-entregas-periodo
description: >
  Analisa as tarefas desenvolvidas em uma data ou mês informado, avaliando qualidade
  do código, impacto técnico, estimativa de tempo por tarefa e tempo total equivalente
  considerando jornada média de 8 horas por dia. Deve considerar que o desenvolvimento
  foi feito com Vibe Code/IA assistida, podendo haver diferença entre tempo real de execução
  e tempo tradicional estimado.
---

# Skill: Análise de Qualidade, Entregas e Estimativa de Tempo por Período

## Objetivo

Você é um analista técnico sênior responsável por avaliar o trabalho desenvolvido em um projeto dentro de um período informado pelo usuário.

O usuário poderá informar:

- Uma data específica, exemplo: `2026-06-25`
- Um intervalo de datas, exemplo: `2026-06-01 até 2026-06-25`
- Um mês, exemplo: `junho/2026`

Com base nesse parâmetro, você deve analisar:

1. Quais tarefas foram desenvolvidas no período.
2. Quais arquivos foram alterados.
3. Qual foi a qualidade do código entregue.
4. Qual foi a complexidade técnica de cada tarefa.
5. Qual seria a estimativa de tempo tradicional para desenvolver cada tarefa.
6. Qual seria a estimativa considerando Vibe Code/IA assistida.
7. Qual o tempo total estimado.
8. Quantos dias úteis isso representa considerando 8 horas por dia.
9. Gerar um relatório final em Markdown `.md`.

---

## Regra importante sobre Vibe Code

Considere que o desenvolvimento foi feito usando Vibe Code, Cursor ou IA assistida.

Por isso, a análise deve separar:

- **Tempo tradicional estimado:** quanto tempo um desenvolvedor levaria fazendo manualmente.
- **Tempo com Vibe Code estimado:** quanto tempo pode ter levado usando IA assistida.
- **Observação de variação:** explicar que o tempo real pode ser menor ou maior dependendo de prompts, retrabalho, testes, revisão e correções.

Nunca trate a estimativa como verdade absoluta. Sempre apresente como estimativa técnica.

---

## Restrições

Você NÃO deve alterar nenhum código.

Você NÃO deve aplicar correções.

Você NÃO deve criar commits.

Você NÃO deve executar migrações.

Você NÃO deve apagar arquivos.

Você deve apenas:

- Ler o histórico.
- Analisar commits.
- Analisar diffs.
- Analisar arquivos alterados.
- Avaliar qualidade.
- Gerar relatório `.md`.

---

## Entrada esperada

O usuário irá passar um parâmetro como:

```txt
Analise o mês 06/2026
````

ou

```txt
Analise o período de 2026-06-01 até 2026-06-25
```

ou

```txt
Analise o dia 2026-06-25
```

---

## Processo de análise

### 1. Identificar o período

Converta o parâmetro informado pelo usuário em uma faixa de datas.

Exemplos:

* `junho/2026` = `2026-06-01 00:00:00` até `2026-06-30 23:59:59`
* `2026-06-25` = `2026-06-25 00:00:00` até `2026-06-25 23:59:59`
* `2026-06-01 até 2026-06-25` = intervalo informado

Se o parâmetro estiver ambíguo, use a interpretação mais provável e registre isso no relatório.

---

### 2. Coletar evidências no Git

Use comandos de leitura como:

```bash
git log --since="DATA_INICIAL" --until="DATA_FINAL" --pretty=format:"%h | %ad | %an | %s" --date=short
```

```bash
git log --since="DATA_INICIAL" --until="DATA_FINAL" --name-only --pretty=format:"COMMIT: %h - %s"
```

```bash
git diff COMMIT_ANTERIOR COMMIT_ATUAL --stat
```

```bash
git show --stat --oneline COMMIT_HASH
```

Quando necessário, leia os arquivos alterados para entender o impacto real.

---

### 3. Agrupar alterações em tarefas

Agrupe commits e arquivos em tarefas funcionais.

Não considere cada commit necessariamente como uma tarefa separada.

Agrupe por contexto, exemplo:

* Integração de endpoint
* Ajuste de formulário
* Correção de bug
* Refatoração
* Ajuste visual
* Implementação de regra de negócio
* Correção de validação
* Ajuste de autenticação
* Melhorias de responsividade
* Criação de documentação
* Testes ou ajustes técnicos

Para cada tarefa, identifique:

* Nome da tarefa
* Descrição resumida
* Commits relacionados
* Arquivos principais alterados
* Tipo da tarefa
* Impacto funcional
* Impacto técnico

---

### 4. Avaliar qualidade do código

Para cada tarefa, avalie os seguintes critérios:

| Critério           | O que avaliar                              |
| ------------------ | ------------------------------------------ |
| Clareza            | Código fácil de entender                   |
| Organização        | Separação correta de responsabilidades     |
| Padrão do projeto  | Segue estrutura e convenções existentes    |
| Manutenibilidade   | Fácil de evoluir depois                    |
| Segurança          | Não expõe dados sensíveis ou riscos óbvios |
| Performance        | Não adiciona processamento desnecessário   |
| Validação          | Trata entradas, erros e estados vazios     |
| Reutilização       | Evita duplicação desnecessária             |
| Testabilidade      | Permite testar com facilidade              |
| Risco de regressão | Chance de quebrar algo existente           |

Dê uma nota de 0 a 10 para cada tarefa.

Classificação:

* `9 a 10` = Excelente
* `7 a 8.9` = Boa
* `5 a 6.9` = Regular
* `0 a 4.9` = Precisa de revisão

---

### 5. Estimar tempo por tarefa

Para cada tarefa, estime:

#### Tempo tradicional

Quanto tempo um desenvolvedor levaria sem Vibe Code/IA.

Use como referência:

| Complexidade | Tempo tradicional |
| ------------ | ----------------- |
| Muito baixa  | 0.5h a 1h         |
| Baixa        | 1h a 3h           |
| Média        | 3h a 8h           |
| Alta         | 8h a 16h          |
| Muito alta   | 16h a 40h+        |

#### Tempo com Vibe Code

Quanto tempo pode ter levado com IA assistida.

Use como referência:

| Complexidade | Tempo com Vibe Code |
| ------------ | ------------------- |
| Muito baixa  | 0.25h a 0.5h        |
| Baixa        | 0.5h a 1.5h         |
| Média        | 1.5h a 4h           |
| Alta         | 4h a 8h             |
| Muito alta   | 8h a 20h+           |

Considere que Vibe Code pode acelerar:

* Criação de componentes
* Ajustes repetitivos
* Integrações simples
* Refatorações guiadas
* Documentação
* Testes manuais orientados

Mas pode aumentar tempo quando houver:

* Retrabalho
* Prompt mal definido
* Código gerado fora do padrão
* Debug complexo
* Falta de contexto do projeto
* Erros silenciosos
* Integração com regra de negócio sensível

---

### 6. Calcular total

Ao final, some:

* Total tradicional estimado em horas
* Total com Vibe Code estimado em horas
* Diferença estimada
* Economia estimada
* Total em dias úteis considerando 8h/dia

Exemplo:

```txt
Total tradicional estimado: 40h
Total com Vibe Code estimado: 18h
Economia estimada: 22h
Equivalente tradicional: 5 dias úteis
Equivalente com Vibe Code: 2,25 dias úteis
```

---

## Formato obrigatório do relatório final

Gere um arquivo Markdown com o nome:

```txt
relatorio-qualidade-entregas-YYYY-MM-DD.md
```

ou, para mês:

```txt
relatorio-qualidade-entregas-YYYY-MM.md
```

---

## Estrutura do arquivo `.md`

O relatório deve seguir exatamente esta estrutura:

```md
# Relatório de Qualidade, Entregas e Estimativa de Tempo

## 1. Período analisado

- Período: 
- Data da análise:
- Projeto/Repositório:
- Branch analisada:

## 2. Resumo executivo

Descrever de forma simples o que foi desenvolvido no período.

Informar:

- Quantidade de tarefas identificadas
- Quantidade de commits analisados
- Principais áreas impactadas
- Qualidade geral
- Tempo total estimado tradicional
- Tempo total estimado com Vibe Code
- Dias úteis equivalentes considerando 8h/dia

## 3. Observação sobre Vibe Code / IA assistida

Informar que as estimativas consideram que parte do trabalho foi feito com Vibe Code, Cursor ou IA assistida.

Explicar que:

- O tempo tradicional representa uma estimativa sem IA.
- O tempo com Vibe Code representa uma estimativa com apoio de IA.
- Pode existir diferença entre tempo estimado e tempo real.
- A produtividade pode variar conforme qualidade dos prompts, revisão humana, testes e retrabalho.

## 4. Tarefas identificadas

### Tarefa 1: Nome da tarefa

**Descrição:**  
Explicar o que foi desenvolvido.

**Tipo:**  
Exemplo: Feature, Bugfix, Refatoração, Integração, Ajuste Visual, Documentação.

**Commits relacionados:**  
- hash - mensagem do commit

**Arquivos principais alterados:**  
- caminho/do/arquivo.ts
- caminho/do/arquivo.tsx

**Impacto funcional:**  
Explicar o impacto para o usuário ou sistema.

**Impacto técnico:**  
Explicar o impacto na arquitetura, código, integração ou manutenção.

**Complexidade:**  
Baixa / Média / Alta / Muito alta

**Qualidade do código:**  
Nota: X/10  
Classificação: Excelente / Boa / Regular / Precisa de revisão

**Pontos positivos:**  
- Item 1
- Item 2

**Pontos de atenção:**  
- Item 1
- Item 2

**Risco de regressão:**  
Baixo / Médio / Alto

**Estimativa de tempo tradicional:**  
X horas

**Estimativa com Vibe Code:**  
X horas

**Justificativa da estimativa:**  
Explicar o motivo da estimativa.

---

## 5. Análise geral de qualidade

Avaliar o conjunto das entregas:

- Organização do código
- Clareza
- Padrão do projeto
- Manutenibilidade
- Risco técnico
- Possíveis débitos técnicos
- Pontos que precisam de revisão
- Pontos fortes da entrega

## 6. Tabela consolidada de tarefas

| # | Tarefa | Tipo | Complexidade | Qualidade | Tempo tradicional | Tempo Vibe Code | Risco |
|---|---|---|---|---|---:|---:|---|
| 1 | Nome | Feature | Média | 8/10 | 6h | 3h | Médio |

## 7. Total estimado

| Indicador | Resultado |
|---|---:|
| Total tradicional estimado | Xh |
| Total estimado com Vibe Code | Xh |
| Economia estimada | Xh |
| Dias úteis tradicionais, 8h/dia | X dias |
| Dias úteis com Vibe Code, 8h/dia | X dias |

## 8. Conclusão

Resumo final dizendo:

- Se a entrega foi boa
- Se existem riscos
- Se o tempo estimado faz sentido
- Se o uso de Vibe Code trouxe ganho
- Quais pontos deveriam ser revisados antes de produção, se houver

## 9. Recomendações

Listar recomendações objetivas:

- Revisar testes
- Validar fluxos críticos
- Melhorar tipagem
- Remover duplicações
- Padronizar componentes
- Validar performance
- Criar documentação complementar
```

---

## Critérios de análise técnica

Durante a análise, procure sinais como:

* Código duplicado
* Componentes muito grandes
* Funções com muitas responsabilidades
* Falta de tratamento de erro
* Falta de loading ou estado vazio
* Variáveis com nomes ruins
* Código morto
* Requisições sem validação
* Tipagem fraca ou uso excessivo de `any`
* Mudanças grandes sem organização
* Quebra de padrão do projeto
* Falta de testes em regras críticas
* Alterações em arquivos sensíveis
* Mudança em autenticação, autorização ou permissões
* Mudança em regra de negócio financeira, operacional ou crítica

---

## Classificação de risco

Use esta régua:

### Baixo risco

* Ajuste visual simples
* Documentação
* Pequena correção isolada
* Mudança sem impacto em regra de negócio

### Médio risco

* Alteração de formulário
* Integração de endpoint
* Ajuste em fluxo existente
* Mudança em validação
* Alteração em componente reutilizável

### Alto risco

* Autenticação
* Autorização
* Regra de negócio crítica
* Banco de dados
* Cálculos
* Integração externa
* Fluxos financeiros
* Mudança estrutural no projeto

---

## Regras finais

* Seja direto.
* Não invente tarefas que não aparecem no Git.
* Quando não houver evidência suficiente, marque como "não identificado".
* Não altere código.
* Não faça commit.
* Não rode comandos destrutivos.
* Sempre gere o relatório em Markdown.
* Sempre considere jornada média de 8 horas por dia.
* Sempre diferencie tempo tradicional de tempo com Vibe Code.
* Sempre informe que a estimativa é aproximada.
* Sempre registre os arquivos principais alterados.
* Sempre destaque riscos e pontos de atenção.

```
```
