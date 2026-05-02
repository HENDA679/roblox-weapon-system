# 💥 Sistema de Dano + 🔊 Sistema de Áudio

## 📋 O que foi adicionado?

### ✅ DamageSystem.lua
- 💥 Detecção de HitBox
- 🎯 Dano aplicado quando HitBox colide com inimigos
- 💨 Knockback automático
- 📍 Área de dano contínua (para ULT)

### ✅ AudioSystem.lua
- 🔊 Sons para todas as habilidades
- 📊 Volume configurável
- ⚙️ Sistema assíncrono (não bloqueia)

### ✅ ZeusWithDamage.lua
- ⚡ Versão completa do Zeus com TUDO integrado
- 💥 Dano em cada ataque
- 🔊 Som em cada ataque
- 🎮 Controles iguais ao antigo

---

## 💥 Dano por Habilidade

| Habilidade | Dano | HitBox | Knockback | Som |
|-----------|------|--------|-----------|------|
| **M1** | 15 | 10 | 50 | SWOOSH |
| **M2** | 25 | 15 | 80 | LIGHTNING_STRIKE |
| **Z** | 50 | 20 | 100 | THUNDER + CHARGE |
| **X** | 10 | 8 | 30 | DASH |
| **C (ULT)** | 35/tick | 50 | 60 | STORM |

---

## 🔊 Sons Disponíveis

```
• LIGHTNING_STRIKE (Volume: 0.7)  - ⚡ Raio
• THUNDER (Volume: 0.8)           - 🌩️ Trovão
• SWOOSH (Volume: 0.5)            - 💨 Movimento
• IMPACT (Volume: 0.8)            - 💥 Impacto
• CHARGE (Volume: 0.6)            - 🔋 Carregamento
• DASH (Volume: 0.6)              - ↔️ Dash
• STORM (Volume: 0.9)             - 🌪️ Tempestade
```

---

## 🎮 Controles

| Tecla | Ação |
|-------|------|
| **M** | M1 (combo com dano) |
| **N** | M2 (raio com dano) |
| **Z** | Julgamento Celestial (dano alto) |
| **X** | Passo Tempestade (dano + knockback) |
| **C** | Domínio da Tempestade (dano contínuo) |
| **U** | Ver status |
| **D** | Ver informações de DANO 💥 |
| **A** | Ver sons disponíveis 🔊 |
| **O** | Criar DUMMY de teste 🧪 |

---

## 🧪 Teste Rápido

### 1. Criar Dummy
Pressione **'O'** para criar um inimigo de teste

### 2. Atacar
Use M, N, Z, X, C para atacar o dummy

### 3. Ver Dano
Pressione **'D'** para ver quanto dano cada skill faz

### 4. Ver Dano em Tempo Real
O console mostra quando o dummy leva dano:
```
💥 M1 causou 15 de dano em Dummy
💨 Knockback aplicado! Força: 50
💀 Dummy foi derrotado!
```

---

## 🔧 Como Usar no Seu Jogo

### 1. Copiar Arquivos
```
ServerScriptService/
└── src/
    ├── Weapons/ZeusWithDamage.lua
    ├── Damage/DamageSystem.lua
    ├── Audio/AudioSystem.lua
    ├── Effects/LightningEffect.lua
    └── Weapons/WeaponBase.lua
```

### 2. Criar LocalScript
Copie o conteúdo de `examples/ZeusWithDamageExample.lua` para um LocalScript em `StarterPlayer`

### 3. Testar
Jogue e veja tudo funcionando! ⚡

---

## 🎯 Como Customizar Dano

Edite `DamageSystem.lua` na tabela `DAMAGE_CONFIG`:

```lua
local DAMAGE_CONFIG = {
    M1 = { damage = 15, hitboxSize = 10, knockback = 50 },
    M2 = { damage = 25, hitboxSize = 15, knockback = 80 },
    -- ... etc
}
```

---

## 🔊 Como Customizar Sons

Edite `AudioSystem.lua`:

```lua
local VOLUME_CONFIG = {
    LIGHTNING_STRIKE = 0.7,
    THUNDER = 0.8,
    -- ... etc
}
```

---

## 📊 Arquitetura

```
ZeusWithDamage.lua
    ↓
    ├─ WeaponBase.lua (energia, cooldown)
    ├─ DamageSystem.lua (hitbox, knockback)
    ├─ AudioSystem.lua (sons)
    └─ LightningEffect.lua (efeitos visuais)
```

---

## ✨ Próximos Passos

- [ ] Telas de dano flutuante (números)
- [ ] Sistema de crítico
- [ ] Mais armas (Fogo, Gelo)
- [ ] Particle effects melhorados
- [ ] Animações customizadas

---

**Feito com 💥 para a comunidade Roblox!**
