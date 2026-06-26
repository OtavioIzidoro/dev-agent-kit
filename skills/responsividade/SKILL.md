---
name: responsividade
description: Audita e corrige responsividade mobile-first em PWA e navegador — celular, tablet e desktop. Botões, imagens, gráficos, textos, safe area, viewport dinâmico e modos standalone/browser sem quebrar layout. Use quando telas falharem no celular, PWA ou browser, ou pedido de responsividade impecável em todos os tipos de acesso.
disable-model-invocation: true
---

# Responsividade — PWA, navegador e todos os dispositivos

Corrija responsividade para que **todo o projeto** funcione impecavelmente em **qualquer forma de acesso** e **qualquer tipo de dispositivo**, sem regressão no desktop.

## Quando usar

- Telas inutilizáveis ou difíceis de usar no celular, tablet ou desktop
- Problemas **só no PWA** (instalado) ou **só no navegador** (aba normal)
- Botões, imagens, gráficos ou textos quebrando layout
- Scroll horizontal, conteúdo cortado ou inacessível (notch, barra do browser, teclado virtual)
- Pedido explícito de responsividade 100%, mobile-first ou PWA
- Dashboard, TreeMap, tabelas ou modais problemáticos no mobile

## Escopo de acesso (obrigatório)

A responsividade deve funcionar em **todos** estes modos — não basta testar só desktop ou só DevTools:

| Modo | O que validar |
|------|----------------|
| **Navegador mobile** | Safari iOS, Chrome Android — barra de endereço, zoom, teclado |
| **PWA standalone** | App instalado na home — sem barra de URL, com safe area |
| **Navegador tablet** | Portrait e landscape — touch e, se houver, mouse |
| **Navegador desktop** | Chrome, Firefox, Safari, Edge — mouse, hover, janela redimensionável |
| **Janela estreita no desktop** | Sidebar + conteúdo; split view; não assumir largura mínima de monitor |

Se o projeto **é PWA** (manifest, service worker ou meta `apple-mobile-web-app-capable`), valide **browser + standalone**. Se **não é PWA**, garanta que nada quebre caso vire PWA no futuro (viewport, safe area, `dvh`).

## Tipos de dispositivo

| Dispositivo | Larguras típicas | Atenção extra |
|-------------|------------------|---------------|
| Celular pequeno | 320–360px | Limite inferior; tudo acessível |
| Celular padrão | 375–430px | Toque, teclado, barra do browser |
| Celular landscape | 568–932px altura reduzida | Header/footer fixos não podem comer conteúdo |
| Tablet | 768–1024px | 2 colunas; filtros; tabelas |
| Laptop | 1024–1440px | Layout híbrido; modais não oversized |
| Desktop grande | 1440–1920px+ | Sem regressão; max-width quando o projeto usa |
| Dobrável / ultrawide | variável | Conteúdo não preso a largura fixa central |

**Orientação:** toda tela crítica deve ser testada em **portrait e landscape** no mobile e tablet.

## Diferença de papéis

| Skill | Papel |
|-------|-------|
| `/responsividade` | **Auditar e corrigir código** — aplica fixes no projeto |
| `/front-qa` | **Analisar evidência visual** — reporta achados; não corrige por padrão |

Use `/front-qa` para validar **depois** das correções (screenshots ou browser MCP).

## Pré-requisitos

```
/guardiao-padroes   →   /responsividade
```

Antes de alterar código:

1. Identifique stack, biblioteca de UI, biblioteca de gráficos e padrão de estilos
2. Detecte se o projeto é **PWA** (`manifest.json`, `vite-plugin-pwa`, `@vite-pwa/*`, Workbox, `display: standalone`)
3. Leia `index.html` / layout root — viewport meta, theme-color, safe area
4. Leia 2–4 telas/componentes similares já responsivos no projeto
5. Siga `/continuidade-projeto`: menor diff, sem refatorar fora do escopo

## Definição de pronto

### Dispositivos pequenos (320px–430px portrait)

**Nenhum** item abaixo pode falhar:

| Elemento | Critério |
|----------|----------|
| **Botões/ações** | Visíveis, clicáveis (≥44×44px quando possível), sem sair da viewport, sem sobreposição que impeça toque |
| **Imagens** | Contidas no container (`max-width: 100%`), proporção preservada, sem empurrar layout crítico |
| **Gráficos** | Legíveis ou com fallback; tooltip no toque; legenda não quebra layout; sem corte horizontal |
| **Textos** | Quebram linha; URLs/emails longos não estouram; títulos legíveis sem overflow |
| **Tabelas** | Scroll horizontal controlado **ou** versão em cards/lista |
| **Modais/drawers** | Cabem na viewport; scroll interno; ações acessíveis |
| **Formulários** | Campos 100% largura; `font-size` ≥16px nos inputs (evita zoom iOS); selects abrem corretamente |
| **Layout global** | **Zero** scroll horizontal no `body`/container principal; nenhum conteúdo inacessível |

### PWA e navegador (todos os dispositivos)

| Cenário | Critério |
|---------|----------|
| **Navegador mobile** | Conteúdo não fica atrás da barra de endereço; scroll e fixed estáveis ao rolar |
| **PWA standalone** | Header/footer/bottom nav respeitam notch e home indicator (`safe-area-inset-*`) |
| **Teclado virtual** | Inputs focados permanecem visíveis; botão submit não fica irrecuperável |
| **Landscape mobile** | Conteúdo principal acessível sem depender só de scroll vertical infinito |
| **Tablet** | Layout organizado; filtros e ações usáveis com toque |
| **Desktop browser** | Sem regressão visual; hover não é único caminho para ação essencial |
| **Redimensionar janela** | Layout flui entre breakpoints; sem “buracos” ou overflow súbito |

Desktop **não pode regredir** visualmente.

## PWA e viewport (auditar primeiro)

### Checklist no HTML / layout root

- [ ] `<meta name="viewport" content="width=device-width, initial-scale=1, viewport-fit=cover">` quando houver notch/safe area
- [ ] `theme-color` coerente (barra do Android / UI do browser)
- [ ] Manifest com `display: standalone` ou `standalone`/`fullscreen` — saber qual o projeto usa
- [ ] Ícones e splash não são escopo de layout, mas manifest indica app instalável

### Viewport dinâmico — browser vs PWA

| Unidade | Uso |
|---------|-----|
| `100dvh` | Altura **dinâmica** — preferir para layout full-height no mobile (barra do browser aparece/some) |
| `100svh` | Altura **pequena** — útil para modais que devem caber com barra visível |
| `100lvh` | Altura **grande** — backgrounds; cuidado com overflow |
| `100vh` | Evitar em mobile — causa corte com barra de endereço e teclado |

**Regra:** full-height layout (`min-h-screen`, `h-screen`, drawers, modais) → migrar para `dvh`/`svh` conforme comportamento desejado, no padrão do projeto.

### Safe area (PWA e iPhone no browser)

```css
/* Padding global quando o projeto usa header/footer fixos */
padding-top: env(safe-area-inset-top);
padding-right: env(safe-area-inset-right);
padding-bottom: env(safe-area-inset-bottom);
padding-left: env(safe-area-inset-left);

/* Bottom nav / FAB / barra de ações fixa */
bottom: calc(16px + env(safe-area-inset-bottom));
```

- Elementos `position: fixed` no topo/base **devem** considerar safe area no PWA
- Botões no canto inferior não podem ficar sob o home indicator (iOS)
- Em `@media (display-mode: standalone)` aplicar ajustes extras **se** o browser normal já estiver ok sem eles

### Detectar modo de exibição (quando o projeto já usa JS/CSS condicional)

```css
@media (display-mode: standalone) { /* PWA instalado */ }
@media (display-mode: browser)    { /* Aba normal */ }
```

```js
const isStandalone =
  window.matchMedia('(display-mode: standalone)').matches ||
  window.navigator.standalone === true; // iOS legacy
```

Use **só** se o projeto já tem padrão similar — não inventar camada nova.

### Teclado virtual (mobile browser e PWA)

- Evitar `position: fixed` no footer de formulário sem testar com teclado aberto
- Preferir scroll natural do container; considerar `visualViewport` resize **se o projeto já usa**
- Inputs no final da página devem permanecer editáveis (scroll into view)

### Touch vs mouse

- Toque: alvos ≥44px, sem depender de hover, `touch-action` adequado em carrosséis
- Mouse: hover pode enriquecer, mas ação essencial visível sem hover
- Tablet com mouse/teclado: foco e clique devem funcionar

## Fluxo de trabalho

### Fase 1 — Auditoria

Mapeie o projeto e localize problemas **antes** de corrigir.

**Detectar stack:**

- Framework: React, Next.js, Vue, Angular, etc.
- UI: MUI, Tailwind, Bootstrap, Ant Design, Chakra, Styled Components, CSS Modules
- Gráficos: Recharts, Chart.js, ECharts, Highcharts, ApexCharts, Nivo, D3, Plotly
- PWA: Workbox, vite-plugin-pwa, next-pwa, manifest, service worker

**Buscar anti-padrões** (grep no escopo afetado):

```
width:\s*100vw
min-width:\s*\d{3,}px
width:\s*\d{3,}px
white-space:\s*nowrap
overflow:\s*hidden
height:\s*100vh
min-height:\s*100vh
h-screen(?!\S)
100vh
position:\s*fixed
flex-wrap:\s*nowrap
w-\[\d{3,}px\]
min-w-\[\d{3,}px\]
viewport-fit(?!=cover)
user-scalable=no
maximum-scale=1
```

**Priorizar telas com:**

- Gráficos, dashboards, TreeMap
- Textos longos, imagens, cards
- Filtros, tabelas, modais, menus laterais
- Botões, formulários, selects/autocompletes
- Header/footer/bottom nav fixos
- Tooltips e legendas de gráficos

**Registrar por tela:** modo (browser/PWA), dispositivo, orientação, viewport, elemento afetado, causa provável, severidade.

### Fase 2 — Correção (menor diff possível)

Aplique fixes **diretamente no código**. Não apenas sugira.

#### Regras invioláveis

- Não alterar regra de negócio, endpoints, payloads ou contratos de API
- Não remover funcionalidades
- Não refatorar sem necessidade
- Preservar layout desktop existente
- Corrigir só o que impacta responsividade, usabilidade mobile, PWA, browser e toque

#### 1. Containers e layout base

```css
/* Padrão seguro para filhos de flex/grid */
width: 100%;
max-width: 100%;
min-width: 0;
box-sizing: border-box;
```

- Evitar `width: 100vw` (scrollbar causa overflow horizontal)
- Full-height: `min-height: 100dvh` (mobile browser + PWA), não `100vh` rígido
- Evitar `overflow: hidden` em containers principais quando bloqueia acesso ao conteúdo
- Safe area em headers, footers e bottom nav fixos (ver seção PWA)
- `overscroll-behavior-x: none` no root **só** se o projeto já usa — evita bounce horizontal

#### 2. Grid e flex

- Grid rígido → responsivo: 1 coluna mobile, 2 tablet, N desktop
- `repeat(auto-fit, minmax(min(100%, 280px), 1fr))` quando couber no padrão do projeto
- Flex com risco de estouro → `flex-wrap: wrap` + `min-width: 0` nos filhos
- Grupos de botões: empilhar (`flex-direction: column` ou `width: 100%`) quando não couberem

#### 3. Botões e áreas clicáveis

- Mínimo **44×44px** de área tocável (padding conta)
- Botões lado a lado → empilhar ou reduzir gap no mobile
- Evitar `position: absolute/fixed` que coloque ação fora da tela — somar safe area no PWA
- Nada depende **apenas** de `:hover` — estados visíveis no toque
- Icon buttons: garantir hit area, não só ícone 16px
- FAB e ações flutuantes: canto inferior com `env(safe-area-inset-bottom)`

#### 4. Textos

```css
overflow-wrap: anywhere; /* ou break-word conforme padrão do projeto */
word-break: break-word;  /* URLs e strings longas */
```

- Remover `white-space: nowrap` quando quebrar layout
- Títulos: `clamp()` ou media query para reduzir no mobile
- Truncar com ellipsis **só** quando o design do projeto já usa; senão, quebrar linha
- Labels de gráfico/eixo: reduzir fonte, rotacionar ou ocultar no mobile via prop da lib

#### 5. Imagens e mídia

```css
max-width: 100%;
height: auto;
object-fit: contain; /* ou cover conforme layout */
```

- SVG/ícones grandes: limitar `max-width`/`max-height`
- Background-image: `background-size: cover/contain` responsivo
- `aspect-ratio` quando o projeto já usa, para evitar layout shift
- `<picture>` / `srcset` **só** se o projeto já usa — não introduzir padrão novo

#### 6. Gráficos (todas as bibliotecas)

Todo gráfico em **container responsivo** — redimensiona em browser, PWA e orientação:

```tsx
// Recharts — recalcular em resize/orientationchange
<ResponsiveContainer width="100%" height={isMobile ? 220 : 360}>
  ...
</ResponsiveContainer>
```

Checklist por gráfico:

- [ ] Container com `width: 100%`, `min-width: 0`, altura adaptada ao mobile
- [ ] Listener de resize/orientation se a lib não reagir sozinha
- [ ] Margens/padding internos menores no mobile
- [ ] Labels/eixos legíveis ou simplificados
- [ ] Legenda abaixo ou oculta se quebrar layout
- [ ] Tooltip funciona no **toque** (não só hover)
- [ ] ResizeObserver ou `ResponsiveContainer` / equivalente da lib

**Por biblioteca:**

| Lib | Ação mobile / PWA |
|-----|-------------------|
| Recharts | `ResponsiveContainer`, reduzir `margin`, `tick={{ fontSize: 10 }}` |
| Chart.js | `maintainAspectRatio: false` + container com altura fixa responsiva |
| ECharts | `grid`, `legend`, `dataZoom`; chamar `resize()` no orientationchange |
| ApexCharts | `chart.toolbar.show: false`, legend `position: 'bottom'` |
| Nivo | `ResponsiveWrapper` ou dimensões via hook de breakpoint |

#### 7. TreeMap

- Container responsivo com altura menor no mobile
- Labels grandes → ocultar ou tooltip no toque
- Se ilegível no celular: **fallback em lista/cards** com os mesmos dados (desktop mantém TreeMap)
- Nunca deixar blocos cortados sem alternativa de leitura

#### 8. Tabelas

- Muitas colunas → wrapper com `overflow-x: auto` e `-webkit-overflow-scrolling: touch`
- Mobile: transformar linhas em cards **se o projeto já tiver padrão**; senão scroll controlado
- Tabela não pode estourar o `body`

#### 9. Modais e drawers

```css
max-width: min(100vw - 24px, /* valor desktop */);
max-height: calc(100dvh - 24px - env(safe-area-inset-top) - env(safe-area-inset-bottom));
overflow-y: auto;
```

- Mobile browser: modal cabe com barra de endereço visível (`svh` ou padding extra se necessário)
- PWA: respeitar safe area no topo e base
- Mobile: `fullScreen` (MUI Dialog) ou modal quase fullscreen se for padrão do projeto
- Botões de ação sempre visíveis (footer fixo **dentro** do modal, não fora da viewport)
- Drawer: `width: min(320px, 90vw)` + scroll interno

#### 10. Formulários

- Inputs `width: 100%` no mobile
- Campos lado a lado → 1 coluna
- `font-size: 16px` mínimo em inputs (iOS — browser e PWA)
- Select/autocomplete/date picker abrem sem cortar (portal no body se o projeto usa)
- Botões submit/cancelar empilham se necessário
- Testar com teclado virtual aberto (browser mobile)

### Fase 3 — Validação obrigatória

Teste **cada tela corrigida** em viewports **e modos de acesso**:

| Viewport | Dispositivo | Modos a testar |
|----------|-------------|----------------|
| 320×568 | Celular pequeno | Browser + PWA se aplicável; portrait |
| 375×667 | iPhone clássico | Browser Safari; portrait + landscape |
| 390×844 | iPhone moderno | Browser + PWA standalone; safe area |
| 430×932 | iPhone Plus/Pro Max | Browser + PWA |
| 768×1024 | Tablet | Portrait + landscape; browser |
| 1024×768 | Tablet landscape | Filtros, tabelas, gráficos |
| 1366×768 | Laptop | Browser desktop |
| 1920×1080 | Desktop | Sem regressão |

**Matriz mínima (não pular):**

| # | Cenário |
|---|---------|
| 1 | Mobile browser — portrait |
| 2 | Mobile browser — landscape |
| 3 | PWA standalone — portrait *(se projeto for PWA)* |
| 4 | PWA standalone — landscape *(se projeto for PWA)* |
| 5 | Tablet — portrait e landscape |
| 6 | Desktop browser — largura completa |
| 7 | Desktop browser — janela estreita (~1024px) |
| 8 | Formulário mobile — teclado virtual aberto |
| 9 | Orientação — rotacionar após carregar (gráficos e fixed) |

**Checklist por cenário:**

- [ ] Sem scroll horizontal global
- [ ] Todos os botões tocáveis/clicáveis
- [ ] Gráficos visíveis ou com fallback após resize/orientação
- [ ] Imagens contidas
- [ ] Textos sem overflow
- [ ] Modais cabem na viewport (browser **e** PWA)
- [ ] Formulários usáveis com teclado
- [ ] Header/footer/bottom nav não cobrem conteúdo crítico
- [ ] Safe area respeitada no PWA / notch

**Como validar:**

1. **Dispositivo real** ou emulador — ideal para PWA, safe area e teclado
2. Browser MCP: resize + snapshot + screenshot por viewport e modo
3. Chrome DevTools: device toolbar + “Add to home screen” / Application → Manifest
4. `/front-qa` com prints por viewport **e** indicando browser vs PWA

**Build (obrigatório):**

```bash
npm run lint   # ou yarn/pnpm, conforme projeto
npm run build
npm run test   # se existir
```

Se falhar por problema **pré-existente** fora do escopo, documente — não corrija fora da responsividade.

## Adaptação por stack (só se o projeto usar)

### Material UI

- `useMediaQuery(theme.breakpoints.down('sm'))` se já for padrão
- `Dialog fullScreen={isMobile}`
- `TableContainer` com scroll horizontal
- `Stack direction={{ xs: 'column', sm: 'row' }}`
- Não usar `sx` se o projeto não usa `sx`

### Tailwind

- `w-full max-w-full min-w-0 overflow-x-auto`
- `min-h-dvh` / `h-dvh` em vez de `min-h-screen` quando full-height no mobile
- `pb-[env(safe-area-inset-bottom)]` em bottom nav fixa
- `grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3`
- `flex flex-wrap gap-2`
- Evitar `w-[1200px]`, `min-w-[800px]` sem breakpoint

### Styled Components / CSS Modules

- Media queries no **mesmo padrão** de breakpoints do projeto
- `@media (display-mode: standalone)` para ajustes PWA quando necessário
- Não criar arquivo/tema paralelo

### Vite PWA / Workbox / next-pwa

- Correções de layout **não dependem** do service worker — foco em CSS/HTML/componentes
- Se offline shell tem layout diferente, tratar como tela crítica na auditoria

## Entrega final

```markdown
# Correção de Responsividade — PWA e Navegador

## Telas ajustadas
- [lista]

## Modos e dispositivos validados
- [ ] Browser mobile (Safari/Chrome) — portrait / landscape
- [ ] PWA standalone — portrait / landscape *(ou N/A)*
- [ ] Tablet — portrait / landscape
- [ ] Desktop browser — full / janela estreita

## Problemas encontrados
- [modo → dispositivo → viewport → causa → sintoma]

## Correções aplicadas
- [objetivo e técnica, por tela/componente]

## Arquivos alterados
- [paths]

## Validação realizada
- Viewports: 320, 375, 390, 430, 768, 1024, 1366, 1920
- Modos: browser, PWA *(se aplicável)*, teclado virtual, orientação
- Build: [comando] — exit [0|N]
- QA visual: [front-qa / device / DevTools]

## Pontos pendentes
- [só decisão de produto/design ou mudança maior fora do escopo]
```

## O que NÃO fazer

- Redesign completo
- Trocar biblioteca de UI ou gráficos
- Sugerir correções sem aplicar no código
- Testar só desktop ou só um breakpoint mobile
- Validar PWA **apenas** no DevTools sem simular standalone/display-mode
- Ignorar 320px ou landscape porque “é edge case”
- Usar `user-scalable=no` ou bloquear zoom acessível
- Corrigir desktop e quebrar mobile/PWA (ou vice-versa)
