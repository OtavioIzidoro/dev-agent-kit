Você é um especialista sênior em responsividade mobile para aplicações web com comportamento de aplicativo.

Preciso corrigir a responsividade do projeto porque existem telas que não consigo mexer corretamente no celular.

Objetivo:
Auditar e corrigir todas as telas problemáticas para que funcionem bem em mobile, tablet e desktop, sem quebrar o layout atual do desktop.

Priorize telas que possuem:
- Gráficos;
- Dashboards;
- TreeMap;
- Textos longos;
- Imagens;
- Cards;
- Filtros;
- Tabelas;
- Modais;
- Menus laterais;
- Botões e ações clicáveis;
- Formulários;
- Selects/autocompletes;
- Tooltips e legendas de gráficos.

Regras obrigatórias:
- Não alterar regras de negócio.
- Não alterar endpoints.
- Não alterar payloads.
- Não alterar contratos de API.
- Não remover funcionalidades.
- Não refatorar sem necessidade.
- Aplicar o menor diff possível.
- Respeitar o padrão visual e técnico do projeto.
- Preservar o layout desktop existente.
- Corrigir apenas o que impacta responsividade, usabilidade mobile e acessibilidade de toque.
- Garantir que todos os botões e ações sejam clicáveis no celular.
- Garantir que nenhum conteúdo fique cortado ou inacessível.
- Evitar scroll horizontal global.
- Evitar width fixo, min-width excessivo e height rígido em telas mobile.
- Evitar overflow hidden em containers principais quando impedir acesso ao conteúdo.

Faça primeiro uma auditoria no projeto e identifique:
- Framework utilizado;
- Biblioteca de UI;
- Biblioteca de gráficos;
- Padrão de estilos;
- Arquivos globais de CSS/tema;
- Telas com layout quebrando;
- Componentes reutilizáveis que precisam de ajuste;
- Containers que causam overflow;
- Gráficos ou TreeMaps que não se adaptam ao mobile.

Procure especificamente por problemas como:
- width: 100vw causando overflow;
- min-width fixo;
- max-width ausente;
- height: 100vh em mobile;
- overflow: hidden indevido;
- position fixed/absolute quebrando layout;
- grid sem responsividade;
- flex sem flex-wrap;
- cards com largura fixa;
- gráficos sem container responsivo;
- TreeMap cortado ou ilegível;
- imagens estourando o container;
- textos sem quebra de linha;
- tabelas sem scroll controlado;
- modais maiores que a tela;
- drawer/menu sem scroll;
- filtros inacessíveis;
- botões fora da tela;
- inputs/selects cortados;
- header/footer cobrindo conteúdo;
- layout que depende apenas de hover.

Breakpoints obrigatórios para validar:
- 320px x 568px
- 375px x 667px
- 390px x 844px
- 430px x 932px
- 768px x 1024px
- 1366px x 768px
- 1920px x 1080px

Correções esperadas:

1. Containers principais:
- Usar width: 100%;
- Usar max-width: 100%;
- Usar min-width: 0;
- Usar box-sizing: border-box;
- Evitar overflow-x global.
- Usar min-height: 100dvh no lugar de height: 100vh quando necessário.

2. Grids:
- Transformar grids rígidos em grids responsivos.
- Desktop pode ter várias colunas.
- Tablet pode ter 2 colunas.
- Mobile deve quebrar para 1 coluna quando necessário.
- Usar repeat(auto-fit, minmax(...)) quando fizer sentido.

3. Flex:
- Garantir flex-wrap quando houver risco de estouro.
- Garantir min-width: 0 nos filhos.
- Garantir que conteúdo longo quebre corretamente.

4. Cards:
- Cards devem ocupar 100% no mobile.
- Cards não podem ter largura fixa.
- Espaçamentos devem reduzir no mobile.
- Cards de dashboard devem empilhar corretamente.

5. Gráficos:
- Todo gráfico deve estar dentro de container responsivo.
- Usar ResponsiveContainer quando a biblioteca permitir.
- Ajustar altura do gráfico para mobile.
- Reduzir margens internas no mobile.
- Reduzir labels/eixos quando necessário.
- Garantir tooltip funcional no toque.
- Garantir que legenda não quebre o layout.
- Em mobile, legenda pode ir para baixo ou ser ocultada se prejudicar uso.

6. TreeMap:
- TreeMap deve ter container responsivo.
- Ajustar altura para mobile.
- Evitar labels grandes dentro dos blocos no celular.
- Tooltip deve funcionar no toque.
- Se o TreeMap ficar ilegível no mobile, criar fallback em lista/cards mantendo os mesmos dados.
- Desktop deve manter TreeMap completo.
- Mobile pode exibir TreeMap simplificado ou lista alternativa.

7. Textos:
- Textos longos devem quebrar linha.
- Usar overflow-wrap: anywhere ou word-break quando necessário.
- Reduzir tamanho de títulos no mobile com clamp ou media query.
- Evitar white-space: nowrap quando quebrar layout.

8. Imagens:
- Toda imagem deve respeitar max-width: 100%;
- Usar height: auto;
- Usar object-fit adequado;
- Evitar imagem empurrando conteúdo crítico para fora da tela.

9. Tabelas:
- Se houver muitas colunas, envolver em container com overflow-x: auto.
- No mobile, se necessário, transformar linhas em cards.
- Não deixar tabela estourar o body.

10. Modais:
- Modal deve caber na tela do celular.
- Usar max-width: calc(100vw - 24px);
- Usar max-height: calc(100dvh - 24px);
- Usar overflow-y: auto;
- Em mobile, considerar modal full screen se o projeto usar Material UI ou padrão semelhante.
- Botões de ação do modal devem continuar acessíveis.

11. Menus e drawers:
- Menu lateral deve ser usável no mobile.
- Drawer deve ter largura máxima adequada, como min(320px, 90vw).
- Drawer deve ter scroll interno.
- Header não pode cobrir o conteúdo.

12. Formulários:
- Inputs devem ocupar 100% no mobile.
- Campos lado a lado devem quebrar para uma coluna.
- Select/autocomplete deve abrir corretamente no celular.
- Botões devem empilhar se não couberem.
- Inputs devem ter font-size mínimo de 16px para evitar zoom automático no iOS.

13. Touch/app:
- Botões e áreas clicáveis devem ter pelo menos 44px de altura/largura quando possível.
- Nada deve depender apenas de hover.
- Menus, filtros, cards, tooltips e ações devem funcionar com toque.

Se o projeto usar React, Next.js, Vite, Material UI, Tailwind, Styled Components ou CSS Modules, siga o padrão já existente no projeto.

Se usar Material UI:
- Usar useMediaQuery e theme.breakpoints quando já existir padrão.
- Dialog pode usar fullScreen no mobile.
- TableContainer deve ter scroll horizontal controlado.
- Não usar sx se o projeto não usa sx.

Se usar Tailwind:
- Preferir classes como w-full, max-w-full, min-w-0, overflow-x-auto.
- Usar grid-cols-1 md:grid-cols-2 lg:grid-cols-3 quando fizer sentido.
- Evitar w-[1200px] ou min-w fixo sem necessidade.

Se usar Styled Components:
- Manter styled-components.
- Criar media queries no mesmo padrão do projeto.

Se usar CSS Modules:
- Manter CSS Modules.
- Criar classes responsivas no mesmo arquivo/padrão.

Validação obrigatória:
Depois das alterações, valide visualmente e tecnicamente:
- Mobile 320px não pode ter conteúdo inacessível.
- Mobile 375px não pode ter scroll horizontal global.
- Mobile 390px deve permitir tocar em todos os botões.
- Mobile 430px deve exibir gráficos corretamente.
- Tablet deve manter layout organizado.
- Desktop não pode ter regressão visual.
- Gráficos devem estar responsivos.
- TreeMap deve funcionar ou ter fallback mobile.
- Modais devem caber na viewport.
- Tabelas devem ter scroll controlado ou versão em cards.
- Textos longos não podem estourar.
- Imagens não podem estourar containers.
- Formulários devem ser usáveis no celular.

Execute os comandos disponíveis no projeto:
- npm run lint / yarn lint / pnpm lint
- npm run build / yarn build / pnpm build
- npm run test / yarn test / pnpm test, se existir

Se algum comando falhar por problema já existente e não relacionado à responsividade, documente sem corrigir fora do escopo.

Ao finalizar, entregue um resumo com:

# Correção de Responsividade Mobile

## Telas ajustadas
Liste as telas ajustadas.

## Problemas encontrados
Liste os principais problemas encontrados.

## Correções aplicadas
Liste as correções aplicadas de forma objetiva.

## Arquivos alterados
Liste os arquivos alterados.

## Validação realizada
Informe os breakpoints testados.

## Pontos pendentes
Liste apenas se houver algo que dependa de decisão visual, regra de produto ou alteração maior.

Importante:
Aplique as correções diretamente no código.
Não apenas sugira.
Não faça redesign completo.
Não mude regra de negócio.
Não quebre desktop.
Faça o menor conjunto de alterações necessário para a aplicação funcionar bem como app no celular.