````md
---
name: analise-qualidade-entregas-periodo
description: >
  Analisa as tarefas desenvolvidas em uma data ou mês informado, avaliando qualidade
  do código, impacto técnico e tempo de trabalho efetivo com Vibe Code/IA assistida
  por tarefa e total do período, considerando jornada média de 8 horas por dia.
  O tempo registrado representa horas realmente dedicadas ao desenvolvimento, não
  estimativa teórica.
---

# Skill: Análise de Qualidade, Entregas e Tempo de Trabalho por Período

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
5. Quanto tempo foi **efetivamente trabalhado** em cada tarefa com Vibe Code/IA assistida.
6. Qual o tempo total de trabalho do período.
7. Quantos dias úteis isso representa considerando 8 horas por dia.
8. Gerar um relatório final em Markdown `.md`.

---

## Regra fundamental: tempo de Vibe Code = tempo real trabalhado

Considere que o desenvolvimento foi feito usando Vibe Code, Cursor ou IA assistida.

**O tempo com Vibe Code NÃO é estimativa teórica.** É o registro de quanto o desenvolvedor **realmente dedicou** à tarefa — prompts, revisão, testes, correções e retrabalho incluídos.

### O que registrar

- **Tempo de trabalho com Vibe Code:** horas efetivamente gastas na tarefa durante sessões de desenvolvimento assistido por IA.
- Esse valor será usado como referência de produtividade e entrega do período.

### O que NÃO fazer

- **Não chame de "estimativa".** Use termos como *tempo de trabalho*, *horas dedicadas*, *tempo efetivo com Vibe Code*.
- **Não inflar horas.** Registre apenas o tempo plausível e proporcional ao escopo real da tarefa.
- **Não use faixas exorbitantes** que não condizem com o volume de alterações, commits e complexidade observada.
- **Não projete tempo tradicional** como se fosse tempo trabalhado — comparações teóricas sem IA são secundárias e opcionais; o foco do relatório é o tempo real com Vibe Code.

### Como calibrar o tempo (conservador e realista)

Baseie-se nas evidências do Git e no escopo da tarefa:

| Evidência observada | Orientação de tempo |
| ------------------- | ------------------- |
| Ajuste pontual (1–2 arquivos, poucas linhas) | 0,25h a 0,75h |
| Correção ou ajuste simples | 0,5h a 1,5h |
| Feature ou integração média | 1,5h a 4h |
| Feature complexa ou múltiplos arquivos | 4h a 8h |
| Tarefa muito grande (vários commits, escopo amplo) | 8h a 16h (somente com evidência clara) |

Na dúvida, **prefira o valor menor** dentro da faixa compatível com o escopo. O total do período deve ser coerente com a quantidade e o tamanho das entregas — não com quanto "levaria" sem IA.

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

### 5. Registrar tempo de trabalho por tarefa

Para cada tarefa, registre o **tempo efetivo de trabalho com Vibe Code** — quanto foi realmente dedicado à entrega.

#### Critérios para definir o tempo

Considere o que entra no tempo trabalhado:

* Sessões de prompt e iteração com IA
* Revisão e ajuste do código gerado
* Testes manuais e validação
* Correções e retrabalho necessários
* Integração e verificação no projeto

#### Regras de registro

1. **Proporcional ao escopo:** poucos arquivos e diff pequeno → poucas horas; escopo amplo → mais horas, mas sempre dentro do plausível.
2. **Conservador:** na dúvida entre duas faixas, use a menor.
3. **Sem inflação:** não some horas de tarefas pequenas como se fossem dias inteiros.
4. **Justificativa obrigatória:** explique por que aquele tempo faz sentido com base nos commits, arquivos e complexidade observados.

#### Referência de calibração (Vibe Code — tempo real)

| Complexidade | Tempo de trabalho típico |
| ------------ | ------------------------ |
| Muito baixa  | 0,25h a 0,5h             |
| Baixa        | 0,5h a 1,5h              |
| Média        | 1,5h a 4h                |
| Alta         | 4h a 8h                  |
| Muito alta   | 8h a 16h (raro; exige evidência forte) |

Fatores que **aumentam** o tempo registrado (porque de fato foram trabalhados):

* Retrabalho e debug
* Prompt mal definido exigindo várias iterações
* Código gerado fora do padrão
* Integração com regra de negócio sensível
* Testes e validação manual extensos

Fatores que **mantêm o tempo baixo** (mesmo com diff grande):

* Ajustes repetitivos guiados por IA
* Refatorações mecânicas
* Documentação ou boilerplate gerado rapidamente

---

### 6. Calcular total

Ao final, some:

* **Total de horas trabalhadas com Vibe Code** no período
* Total em dias úteis considerando 8h/dia

Exemplo:

```txt
Total de horas trabalhadas (Vibe Code): 12h
Equivalente em dias úteis (8h/dia): 1,5 dias
```

O total deve ser coerente com o volume de entregas — se parecer desproporcionalmente alto ou baixo, revise tarefa a tarefa antes de fechar o relatório.

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
# Relatório de Qualidade, Entregas e Tempo de Trabalho

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
- **Total de horas trabalhadas com Vibe Code**
- Dias úteis equivalentes considerando 8h/dia

## 3. Observação sobre Vibe Code / tempo de trabalho

Informar que o desenvolvimento foi feito com Vibe Code, Cursor ou IA assistida.

Deixar explícito que:

- **O tempo com Vibe Code registrado neste relatório é o tempo efetivamente dedicado ao trabalho**, não uma estimativa teórica de quanto levaria sem IA.
- Inclui prompts, revisão humana, testes, correções e retrabalho.
- Os valores foram calibrados de forma conservadora e proporcional ao escopo real de cada tarefa.
- Horas exorbitantes ou desproporcionais ao volume de alterações **não** devem aparecer neste relatório.

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

**Tempo de trabalho (Vibe Code):**  
X horas

**Justificativa do tempo:**  
Explicar por que esse tempo reflete o trabalho real dedicado, com base no escopo, commits e complexidade observados.

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

| # | Tarefa | Tipo | Complexidade | Qualidade | Tempo Vibe Code | Risco |
|---|---|---|---|---:|---:|---|
| 1 | Nome | Feature | Média | 8/10 | 2,5h | Médio |

## 7. Total de horas trabalhadas

| Indicador | Resultado |
|---|---:|
| Total de horas trabalhadas (Vibe Code) | Xh |
| Dias úteis equivalentes (8h/dia) | X dias |

## 8. Conclusão

Resumo final dizendo:

- Se a entrega foi boa
- Se existem riscos
- Se o tempo registrado é coerente com o volume entregue
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
* **Sempre registre tempo como horas trabalhadas com Vibe Code — nunca como "estimativa".**
* **Sempre calibre de forma conservadora; prefira menos horas quando o escopo for pequeno.**
* **Nunca use horas exorbitantes desproporcionais ao trabalho entregue.**
* Sempre registre os arquivos principais alterados.
* Sempre destaque riscos e pontos de atenção.

```
````
