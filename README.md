# 🎮 Sistema de Movimentação — Roblox Battlegrounds

> Um sistema de movimento fluido e responsivo inspirado em Roblox Battlegrounds com sprint, dash multidirecional e efeitos de câmera.

## ✨ Features

- ⚡ **Sprint** — Aumenta velocidade com Shift
- 🔄 **Dash em 4 direções** — Q + WASD para controlar direção
- 📷 **Camera Zoom Effect** — Feedback visual durante dash
- ⏱️ **Sistema de Cooldown** — Evita spam de dash
- 🎯 **Movimento fluido** — BodyVelocity para física natural

## 📋 Requisitos

- Roblox Studio
- Conhecimento básico de Lua
- Paciência para configurar 😄

## 🚀 Instalação Rápida

### 1. Estrutura no Roblox

Crie esta hierarquia no seu jogo:

```
StarterPlayer
 └── StarterPlayerScripts
      └── MovementClient (LocalScript)

ReplicatedStorage
 └── RemoteEvent
      └── DashEvent
```

### 2. Copie o Script

1. Abra `src/MovementClient.lua`
2. Copie todo o conteúdo
3. Cole no **MovementClient** LocalScript do seu jogo

### 3. Teste

- **Shift** — Sprint
- **Q + W/A/S/D** — Dash em 4 direções

## 🎮 Controles

| Tecla | Ação |
|-------|------|
| **Shift (segurado)** | Sprint |
| **Q + W** | Dash para frente |
| **Q + S** | Dash para trás |
| **Q + A** | Dash para esquerda |
| **Q + D** | Dash para direita |
| **Q** (sem direção) | Dash para frente (padrão) |

## ⚙️ Configurações

Todos os valores podem ser ajustados no início do script:

```lua
local NORMAL_SPEED = 16        -- Velocidade normal
local SPRINT_SPEED = 26        -- Velocidade de sprint
local DASH_POWER = 85          -- Força do dash
local DASH_TIME = 0.15         -- Duração do dash (segundos)
local DASH_COOLDOWN = 0.7      -- Tempo entre dashes
```

Veja `docs/CONFIGURACAO.md` para mais detalhes e presets!

## 📚 Documentação

- 📖 **[CONFIGURACAO.md](docs/CONFIGURACAO.md)** — Guia completo de configurações
- 🗺️ **[ROADMAP.md](docs/ROADMAP.md)** — Plano de desenvolvimento
- 🆘 **[TROUBLESHOOTING.md](docs/TROUBLESHOOTING.md)** — Resolução de problemas
- 🎯 **[basic-setup.md](examples/basic-setup.md)** — Tutorial para iniciantes

## 🎨 Próximos Passos

### v1.1 (Próximo)
- [ ] Air Dash
- [ ] Animações de movimento
- [ ] Sons sincronizados

### v1.2
- [ ] Wall Run
- [ ] Slide no chão
- [ ] Efeitos de partículas

### v2.0
- [ ] Sistema de Awakening
- [ ] Movimentos únicos por personagem
- [ ] Trails e afterimages

Ver roadmap completo em **[ROADMAP.md](docs/ROADMAP.md)**

## 💡 Dicas Profissionais

Para deixar o movimento **absolutamente insano**, adicione:

1. 🎬 **Camera Shake** — Tremores durante dash
2. 🌪️ **Partículas** — Efeito de fumaça/energia
3. 🔊 **Sons** — Dash elétrico + impacto
4. ⏸️ **Hit Pause** — Congelamento de frames rápido
5. 🖼️ **Animações** — Transições suaves

> "Um bom movimento Battlegrounds não é sobre números. É sobre **sensação**."

## 🐛 Problemas?

Consulte **[TROUBLESHOOTING.md](docs/TROUBLESHOOTING.md)** para soluções rápidas.

## 📄 Licença

MIT License — Use livremente em seus projetos!

---

**Desenvolvido com ❤️ para a comunidade Roblox**

⭐ Se achou útil, não esquece de dar uma estrela! ⭐
