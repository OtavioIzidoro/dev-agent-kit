# Checklist — Front-end Implementador

## Antes de codar

- [ ] `/guardiao-padroes` executado ou exemplos similares lidos
- [ ] Caminho de destino definido
- [ ] Componentes UI reutilizáveis listados
- [ ] Hooks/services existentes verificados
- [ ] Contrato API claro (se integração)

## Tela / Page

- [ ] Rota registrada (se aplicável)
- [ ] Layout alinhado a páginas irmãs
- [ ] Loading, empty, error tratados
- [ ] Responsivo (mobile + desktop)

## Componente

- [ ] Props tipadas
- [ ] Export no padrão do projeto (default vs named)
- [ ] Sem lógica de fetch pesada — delegar a hook/service

## Formulário

- [ ] Mesma lib do projeto
- [ ] Labels visíveis
- [ ] Validação + mensagens de erro
- [ ] Submit com loading/disabled
- [ ] Cancel/reset se padrão existir

## Integração API

- [ ] Service ou hook no padrão do projeto
- [ ] Tipos request/response corretos
- [ ] Erro de rede tratado
- [ ] Cache/refetch (React Query etc.) se projeto usa

## UI composta

### Tabela
- [ ] Colunas, sort, paginação conforme listagens existentes
- [ ] Empty state
- [ ] Ações por linha (editar, excluir) no padrão

### Filtro
- [ ] Controlled state
- [ ] Debounce se busca por texto
- [ ] Limpar filtros se padrão existir

### Modal
- [ ] Abrir/fechar
- [ ] Foco e overlay
- [ ] Confirmação em ações destrutivas

### Select / Checkbox
- [ ] Componente base do design system
- [ ] Label associado (a11y)

## Escopo

- [ ] Só arquivos necessários alterados
- [ ] Nenhuma refatoração colateral
- [ ] Nenhuma dependência nova sem motivo

## Entrega

- [ ] Lista de arquivos criados/alterados informada
- [ ] Lacunas/fora de escopo documentadas
