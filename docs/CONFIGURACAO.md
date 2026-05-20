# ⚙️ Guia Completo de Configuração

## 📊 Parâmetros Principais

Todos esses valores estão no início do script `src/MovementClient.lua`:

### 1️⃣ NORMAL_SPEED
```lua
local NORMAL_SPEED = 16
```
- **O que faz:** Velocidade padrão de movimento
- **Padrão:** `16` (velocidade padrão Roblox)
- **Recomendação:** `14-20`
  - `14` = Mais lento, mais controle
  - `16` = Padrão
  - `20` = Mais rápido, mais agressivo

---

### 2️⃣ SPRINT_SPEED
```lua
local SPRINT_SPEED = 26
```
- **O que faz:** Velocidade ao pressionar Shift
- **Padrão:** `26` (63% mais rápido que normal)
- **Recomendação:** `22-35`
  - `22` = Sprint leve
  - `26` = Balanceado
  - `35` = Super rápido

**Fórmula:** `SPRINT_SPEED / NORMAL_SPEED` = multiplicador
- Exemplo: `26 / 16 = 1.625x` (62.5% mais rápido)

---

### 3️⃣ DASH_POWER
```lua
local DASH_POWER = 85
```
- **O que faz:** Força/distância do dash
- **Padrão:** `85` (distância média)
- **Recomendação:** `60-120`
  - `60` = Dash curto (500 studs em ~0.15s)
  - `85` = Equilibrado
  - `120` = Dash longo (exploração fácil)

**Cálculo aproximado:** `DASH_POWER * DASH_TIME` = distância em studs
- Exemplo: `85 * 0.15 = 12.75 studs`

---

### 4️⃣ DASH_TIME
```lua
local DASH_TIME = 0.15
```
- **O que faz:** Duração do impulso de dash
- **Padrão:** `0.15` segundos
- **Recomendação:** `0.1-0.3`
  - `0.1` = Dash muito rápido e curto
  - `0.15` = Padrão (snappy)
  - `0.3` = Dash longo (mais fluido)

---

### 5️⃣ DASH_COOLDOWN
```lua
local DASH_COOLDOWN = 0.7
```
- **O que faz:** Tempo entre dashes (em segundos)
- **Padrão:** `0.7` segundos
- **Recomendação:** `0.5-1.5`
  - `0.5` = Muito rápido (pode quebrar jogo)
  - `0.7` = Balanceado
  - `1.0` = Mais controlado
  - `1.5` = Bem estratégico

---

## 🎯 PRESETS PRONTOS

### 🏃 Preset: ÁGIL (Dashes rápidos)
```lua
local NORMAL_SPEED = 14
local SPRINT_SPEED = 28
local DASH_POWER = 100
local DASH_TIME = 0.12
local DASH_COOLDOWN = 0.5
```
**Uso:** Combate rápido, parkour

### 🛡️ Preset: EQUILIBRADO (Padrão)
```lua
local NORMAL_SPEED = 16
local SPRINT_SPEED = 26
local DASH_POWER = 85
local DASH_TIME = 0.15
local DASH_COOLDOWN = 0.7
```
**Uso:** Exploração + Combate

### 💪 Preset: PESADO (Dashes poderosos)
```lua
local NORMAL_SPEED = 18
local SPRINT_SPEED = 24
local DASH_POWER = 120
local DASH_TIME = 0.25
local DASH_COOLDOWN = 1.2
```
**Uso:** Boss fights, defesa

### 🌪️ Preset: EXTREMO (Speedrun)
```lua
local NORMAL_SPEED = 20
local SPRINT_SPEED = 40
local DASH_POWER = 150
local DASH_TIME = 0.2
local DASH_COOLDOWN = 0.3
```
**Uso:** Speedrun, exploração extrema

---

## 📐 Tabela de Comparação

| Preset | Speed | Sprint | Dash Power | Cooldown | Sensação |
|--------|-------|--------|------------|----------|----------|
| Ágil | 14 | 28 | 100 | 0.5s | Rápido, Arcade |
| Equilibrado | 16 | 26 | 85 | 0.7s | Balanceado |
| Pesado | 18 | 24 | 120 | 1.2s | Poderoso, Tático |
| Extremo | 20 | 40 | 150 | 0.3s | Insano, Speedrun |

---

## 🎮 Testando Valores

### Passo-a-passo:

1. Abra o script em Roblox Studio
2. Mude **um valor por vez**
3. Pressione **F6** para rodar o jogo
4. Teste o movimento
5. Anote qual valor gostou
6. Repita até achar o equilíbrio perfeito

### Dicas de Debug:

```lua
-- No console, veja as velocidades atuais:
print("Speed:", humanoid.WalkSpeed)
print("Dash Cooldown:", dashCooldown)
```

---

## 🔧 Ajustes Avançados

### Efeito de Câmera

No script, mude o zoom durante dash:

```lua
TweenService:Create(cam, TweenInfo.new(0.1), {
    FieldOfView = 80  -- Mude este valor (padrão = 70)
}):Play()
```

- `75` = Zoom leve
- `80` = Zoom médio (padrão)
- `85` = Zoom extremo

### Duração do Efeito de Câmera

```lua
TweenService:Create(cam, TweenInfo.new(0.1), {  -- Mude de 0.1 para outro valor
    FieldOfView = 80
}):Play()
```

- `0.05` = Muito rápido
- `0.1` = Rápido (padrão)
- `0.2` = Lento

---

## ❓ Qual Preset Escolher?

- **Exploração casual?** → EQUILIBRADO ou ÁGIL
- **PvP/Combate?** → ÁGIL ou EXTREMO
- **Boss fights?** → PESADO
- **Speedrun?** → EXTREMO
- **Primeiro teste?** → EQUILIBRADO

---

## 💾 Salvar Múltiplos Presets

Crie uma função para trocar presets:

```lua
local function SetPreset(name)
    if name == "AGIL" then
        NORMAL_SPEED = 14
        SPRINT_SPEED = 28
        DASH_POWER = 100
        DASH_TIME = 0.12
        DASH_COOLDOWN = 0.5
    elseif name == "PESADO" then
        NORMAL_SPEED = 18
        SPRINT_SPEED = 24
        DASH_POWER = 120
        DASH_TIME = 0.25
        DASH_COOLDOWN = 1.2
    end
    print("Preset mudado para: " .. name)
end

-- Use: SetPreset("AGIL")
```

---

**Próximo:** Veja [ROADMAP.md](ROADMAP.md) para features futuras!
