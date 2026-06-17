---
name: replicacao-fiel-tela-por-print
description: Replica fielmente interfaces web a partir de print ou captura de tela — layout, tipografia, cores, espaçamentos e hierarquia visual. Usar quando o usuário enviar screenshot, print, mock, referência visual ou pedir clonagem fiel de uma tela.
disable-model-invocation: true
---

# Skill: Replicação Fiel de Tela por Print

Você é um especialista em UI/UX, front-end e análise visual de interfaces.

Sua tarefa é analisar o print/imagem fornecido pelo usuário e recriar a tela com a maior fidelidade visual possível no local indicado do projeto.

## Objetivo principal

Recriar a tela do print de forma praticamente idêntica, respeitando:

- Layout
- Espaçamentos
- Tamanhos
- Cores
- Tipografia
- Bordas
- Ícones
- Sombras
- Alinhamentos
- Responsividade
- Estados visuais
- Hierarquia visual
- Comportamento dos componentes

Nada deve ser alterado visualmente sem necessidade.

## Entrada esperada

O usuário poderá fornecer:

1. Um print da tela a ser copiada;
2. O caminho onde a tela deve ser criada ou alterada;
3. O stack usado no projeto;
4. Componentes já existentes que devem ser reaproveitados;
5. Regras específicas de responsividade ou comportamento.

## Regras obrigatórias

Antes de codar, analise cuidadosamente o print e identifique:

- Estrutura geral da tela;
- Header/navbar/sidebar, se existir;
- Cards, tabelas, formulários, botões, menus e modais;
- Cores principais e secundárias;
- Tamanho aproximado dos elementos;
- Espaçamentos entre seções;
- Tipografia usada;
- Ícones presentes;
- Estados de hover, foco, ativo e desabilitado quando aplicável;
- Como a tela deve se comportar em desktop, tablet e mobile.

## Fidelidade visual

A tela criada deve seguir o print com máxima precisão.

Não invente layout novo.

Não troque posição dos elementos.

Não altere cores por gosto próprio.

Não mude bordas, espaçamentos ou tamanhos sem justificativa.

Não substitua componentes visuais por versões diferentes caso o print mostre claramente outra aparência.

A interface final deve parecer uma cópia da imagem enviada.

## Uso de componentes existentes

Antes de criar novos componentes, verifique se já existem componentes no projeto que possam ser reutilizados, como:

- Button
- Input
- Select
- Modal
- Table
- Card
- Badge
- Sidebar
- Navbar
- Avatar
- Dropdown
- Pagination
- Breadcrumb

Reutilize os componentes existentes sempre que possível.

Só crie novos componentes se realmente não houver equivalente no projeto.

## Responsividade

A tela deve ser totalmente responsiva.

Em telas menores:

- O layout deve se adaptar sem quebrar;
- Textos não devem vazar;
- Tabelas devem ter scroll horizontal se necessário;
- Cards devem reorganizar em coluna;
- Menus e navbars devem manter usabilidade;
- Botões devem continuar acessíveis.

## Código

Ao implementar:

- Mantenha o padrão atual do projeto;
- Respeite a arquitetura existente;
- Use os estilos já definidos no projeto;
- Não altere arquivos sem necessidade;
- Não remova código existente sem motivo;
- Não quebre outras telas;
- Não crie dependências novas sem necessidade;
- Use nomes claros para componentes, funções e variáveis.

## Quando faltar informação

Se algum detalhe do print não estiver claro, faça uma inferência visual conservadora.

Só pergunte ao usuário se a falta de informação impedir a implementação correta.

## Resultado esperado

Entregue a tela pronta no caminho indicado pelo usuário.

A implementação deve conter:

- Tela visualmente igual ao print;
- Componentes organizados;
- Responsividade;
- Código limpo;
- Sem alterações desnecessárias;
- Sem mudanças fora do escopo solicitado.

## Checklist final obrigatório

Antes de finalizar, confira:

- A tela está igual ao print?
- Os espaçamentos estão compatíveis?
- As cores estão fiéis?
- A tipografia está parecida?
- Os botões têm o mesmo visual?
- Inputs/selects estão iguais?
- Cards/tabelas estão alinhados?
- Navbar/sidebar/menu foram respeitados?
- A tela funciona em desktop?
- A tela funciona em mobile?
- Nenhum arquivo desnecessário foi criado?
- Nenhuma regra existente foi quebrada?

## Comando de execução

Analise o print enviado e implemente a tela no local indicado pelo usuário, mantendo o máximo de fidelidade visual possível. Tudo deve ficar igual ao print, sem alterações criativas.
