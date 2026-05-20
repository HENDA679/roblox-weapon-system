# 🗺️ Roadmap — Sistema de Movimentação

## 📈 Versões Planejadas

```
1.0 ✅ [ATUAL]
├── Sprint básico
├── Dash 4 direções
├── Camera zoom
└── Cooldown

1.1 🔄 [PRÓXIMO]
├── Air Dash
├── Animações de movimento
├── Partículas básicas
└── Sons sincronizados

1.2 🚀
├── Wall Run
├── Slide no chão
├── Double Jump
└── Trails visuais

2.0 ✨
├── Sistema de Awakening
├── Movimentos únicos por personagem
├── Afterimages
└── Hit Pause
```

---

## 🎯 v1.0 — BASE (✅ COMPLETO)

### Features
- [x] Sprint com Shift
- [x] Dash em 4 direções (Q + WASD)
- [x] Camera zoom effect
- [x] Sistema de cooldown
- [x] BodyVelocity para física

### Arquivos
- `src/MovementClient.lua`
- `README.md`
- `docs/CONFIGURACAO.md`

---

## 🔄 v1.1 — POLIMENTO (3-4 semanas)

### ⚡ Air Dash
Permitir dash enquanto está no ar.

```lua
local function CanDash()
    local rayResult = workspace:FindPartOnRayWithIgnoreList(...)
    return rayResult == nil  -- True se no ar
end
```

**Desafio:** Limitar dashes no ar (máximo 1 por salto)

---

### 🎬 Animações de Movimento
Adicionar anims do Roblox ou custom:

```lua
local dashAnim = humanoid:LoadAnimation(dashAnimTrack)
dashAnim:Play()
```

**Anims sugeridas:**
- Sprint pose
- Dash wind-up
- Dash landing

---

### 🌪️ Partículas Básicas
Efeito de fumaça durante dash:

```lua
local particles = Instance.new("ParticleEmitter")
particles.Parent = root
particles:Emit(50)
```

**Tipos:**
- Fumaça branca/cinza
- Trilhas de velocidade
- Impacto no chão

---

### 🔊 Sons Sincronizados
Sons para cada ação:

```lua
local dashSound = Instance.new("Sound")
dashSound.SoundId = "rbxassetid://..."
dashSound:Play()
```

**Sons recomendados:**
- Whoosh de dash
- Impacto grave
- Passos rápidos (sprint)

---

## 🚀 v1.2 — EXPANSÃO (5-7 semanas)

### 🧗 Wall Run
Correr pelas paredes.

```lua
local function CheckWallRun()
    local raycast = workspace:FindPartOnRayWithIgnoreList(...)
    if raycast then
        return raycast.Name == "Wall"
    end
    return false
end
```

**Features:**
- Detectar parede
- Prender player na parede
- Animação de wall run
- Movimento horizontal na parede

---

### 🛝 Slide no Chão
Deslizar em alta velocidade.

```lua
local function Slide()
    humanoid:SetStateEnabled(Enum.HumanoidStateType.Running, false)
    -- Adicionar velocidade horizontal
    task.wait(1)
    humanoid:SetStateEnabled(Enum.HumanoidStateType.Running, true)
end
```

**Features:**
- Aumenta velocidade
- Diminui altura do player
- Partículas de chão
- Sons de atrito

---

### 🦘 Double Jump
Pular 2x no ar.

```lua
local jumpsUsed = 0

humanoid.StateChanged:Connect(function(oldState, newState)
    if newState == Enum.HumanoidStateType.Jumping then
        jumpsUsed = 0
    end
end)
```

---

### ✨ Trails Visuais
Rastros de movimento.

```lua
local trail = Instance.new("Trail")
trail.Attachment0 = attachment0
trail.Attachment1 = attachment1
trail.Parent = root
```

---

## ✨ v2.0 — SISTEMA COMPLETO (8-12 semanas)

### 🌟 Sistema de Awakening
Personagem muda quando desperta (tema Jujutsu).

```lua
local function Awaken()
    -- Trocar model visual
    -- Aumentar stats
    -- Novas habilidades
    -- Efeitos especiais
end
```

**Estados:**
- Normal (base)
- Awaken Tier 1 (buffado)
- Awaken Tier 2 (super buffado)
- Awaken Completo (extremo)

---

### 🎨 Movimentos Únicos por Personagem
Cada personagem tem movimentos diferentes.

**Exemplo - Velocista:**
- Sprint mais rápido
- Dash cooldown reduzido
- Air dash ativado

**Exemplo - Guerreiro:**
- Sprint mais lento
- Dash mais poderoso
- Wall run mais fácil

---

### 👻 Afterimages
Rastros fantasmagóricos durante movimento rápido.

```lua
local function CreateAfterimage()
    local clone = character:Clone()
    clone.Humanoid:Destroy()
    clone.Parent = workspace
    
    game:GetService("Debris"):AddItem(clone, 0.5)
end
```

---

### ⏸️ Hit Pause
Congelamento de frames em eventos importantes.

```lua
local function HitPause(duration)
    game:GetService("RunService"):Pause()
    task.wait(duration)
    game:GetService("RunService"):Resume()
end
```

---

### 🎥 Advanced Camera
Sistema de câmera mais sofisticado.

- Follow suave
- Tilt em dashes
- Zoom dinâmico
- Shake em impacts

---

## 📊 Timeline

```
Mês 1: v1.0 ✅
│
Mês 1-2: v1.1 🔄
│  ├─ Air Dash
│  ├─ Animações
│  ├─ Partículas
│  └─ Sons
│
Mês 2-3: v1.2 🚀
│  ├─ Wall Run
│  ├─ Slide
│  ├─ Double Jump
│  └─ Trails
│
Mês 3-4: v2.0 ✨
│  ├─ Awakening
│  ├─ Chars únicos
│  ├─ Afterimages
│  ├─ Hit Pause
│  └─ Câmera avançada
```

---

## 🤝 Como Contribuir

1. Fork o repositório
2. Implemente uma feature do roadmap
3. Faça testes completos
4. Envie um Pull Request
5. Aguarde review

---

## 💡 Ideias Futuras

- Sistema de combate integrado
- Customização de personagem
- Leaderboard de velocidade
- Modo tutorial
- Configurador de presets em-jogo

---

**Próximo:** Consulte [TROUBLESHOOTING.md](TROUBLESHOOTING.md) para resolver problemas!
