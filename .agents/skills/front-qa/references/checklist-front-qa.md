# Checklist Front QA

## Responsividade

- [ ] Sem scroll horizontal indesejado
- [ ] Textos legíveis sem zoom (≥ 16px body em mobile quando possível)
- [ ] Botões e links clicáveis ≥ 44×44px em touch
- [ ] Imagens responsivas (não estouram container)
- [ ] Tabelas: scroll horizontal ou layout alternativo em mobile
- [ ] Navbar/menu adaptado (hamburger, drawer, collapse)
- [ ] Formulários empilham corretamente em coluna estreita
- [ ] Modais cabem na viewport sem cortar ações

## UX

- [ ] Ação primária evidente (CTA destacado)
- [ ] Loading durante operações assíncronas
- [ ] Mensagens de erro claras e próximas ao campo/ação
- [ ] Confirmação antes de ações destrutivas
- [ ] Empty state quando lista vazia
- [ ] Breadcrumb ou contexto de navegação quando profundo
- [ ] Labels de formulário sempre visíveis (não só placeholder)
- [ ] Consistência de ícones, botões e modais no fluxo

## Acessibilidade (WCAG 2.1 AA — referência)

- [ ] Contraste texto normal ≥ 4.5:1
- [ ] Contraste texto grande ≥ 3:1
- [ ] Foco visível em `:focus` / `:focus-visible`
- [ ] Inputs com `<label>` associado ou `aria-label`
- [ ] Botões com texto ou `aria-label` descritivo
- [ ] Imagens informativas com `alt`; decorativas com `alt=""`
- [ ] Headings em ordem (não pular h1 → h3)
- [ ] Cor não é único indicador (ex.: erro também tem ícone/texto)
- [ ] Modais trapam foco e permitem fechar (Esc, botão)
- [ ] Links distinguíveis do texto corrido

## Validação visual

- [ ] Grid e espaçamentos consistentes com design system
- [ ] Tipografia (família, peso, tamanho) conforme spec
- [ ] Cores de marca e tokens CSS corretos
- [ ] Ícones alinhados ao texto baseline
- [ ] Estados hover/focus/disabled visíveis e distintos
- [ ] Sombras, bordas e radius consistentes
- [ ] Sem sobreposição acidental (z-index, overflow hidden)
- [ ] Comparação com referência (Figma/print) quando fornecida

## Breakpoints sugeridos

| Viewport | Largura | Foco |
|----------|---------|------|
| Mobile S | 320px | overflow, touch, legibilidade |
| Mobile L | 414px | layout em coluna |
| Tablet | 768px | transição sidebar/grid |
| Desktop | 1024px+ | layout completo |
| Wide | 1440px+ | max-width, espaço em branco |
