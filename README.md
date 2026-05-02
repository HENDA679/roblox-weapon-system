# ⚡ Roblox Weapon System - Zeus

Sistema de armas profissional para Roblox com a arma **Raio Olímpico (Zeus)**.

## 🎯 Características

✅ **Sistema de energia** (100 max, +10/s regeneração)
✅ **4 tipos de ataque** (M1, M2, Z, X, C)
✅ **Efeitos visuais profissionais** (Beam + ParticleEmitter)
✅ **Sistema de cooldown automático**
✅ **Framework extensível** para criar mais armas
✅ **Código bem estruturado e documentado**

## 🚀 Como usar

### 1. Preparar o Roblox
Clone ou baixe este repositório:
```
git clone https://github.com/HENDA679/roblox-weapon-system.git
```

### 2. Copiar para seu jogo
Copie a pasta `src/` para:
```
ServerScriptService/src/
```

### 3. Criar LocalScript
Crie um `LocalScript` no `StarterPlayer` e copie o conteúdo de `examples/ZeusExample.lua`

### 4. Testar
Jogue no Roblox Studio e use os controles!

## 🎮 Controles

| Tecla | Ação | Energia | Cooldown |
|-------|------|---------|----------|
| **M** | M1 - Combo de 3 golpes | - | - |
| **N** | M2 - Raio em linha reta | - | 2s |
| **Z** | Julgamento Celestial | 25 | 8s |
| **X** | Passo Tempestade | 15 | 4s |
| **C** | Domínio da Tempestade (ULT) | 50 | 28s |
| **U** | Ver status | - | - |

## ⚡ Habilidades Detalhadas

### M1 - Combo (Gratuito)
- **3 golpes** sequenciais
- **3º golpe** aplica pequeno stun
- **Alcance:** Médio
- **Dano:** Alto (teste)

### M2 - Raio (Gratuito)
- **Lança raio** em linha reta
- **Cooldown:** 2s
- **Efeito:** Beam elétrico

### Z - Julgamento Celestial
- **Dano:** Alto
- **Energia:** 25
- **Cooldown:** 8s
- **Mecânica:** 
  - Marca o alvo com efeito visual
  - 1 segundo depois → raio cai
  - Pode ser esquivado
  - Área pequena de impacto

### X - Passo Tempestade
- **Dano:** Baixo
- **Energia:** 15
- **Cooldown:** 4s
- **Mecânica:**
  - Dash rápido na direção do player
  - Atravessa inimigos (não atravessa paredes)
  - Imunidade curta: 0.3s

### C - Domínio da Tempestade (ULT)
- **Dano:** Contínuo (alto se ficar dentro)
- **Energia:** 50
- **Cooldown:** 28s
- **Mecânica:**
  - Área grande se ativa por 6s
  - Raios caem aleatoriamente a cada 0.3s
  - Inimigos podem sair da área
  - Efeito visual impressionante com partículas

## 🔋 Sistema de Energia

```
Energia máxima: 100
Regeneração: +10 por segundo

Consumo:
  Z = 25 energia
  X = 15 energia
  C = 50 energia
```

⚠️ **Importante:** Sem energia = sem habilidade (força estratégia e gerenciamento)

## 📁 Estrutura do Projeto

```
roblox-weapon-system/
├── src/
│   ├── Weapons/
│   │   ├── WeaponBase.lua       ← Classe base (toda arma herda daqui)
│   │   ├── Zeus.lua             ← Implementação da arma Zeus
│   │   └── WeaponManager.lua    ← Gerenciador de múltiplas armas
│   ├── Effects/
│   │   └── LightningEffect.lua  ← Efeitos visuais (Beam + Partículas)
│   └── Energy/
│       └── (para futuro)
├── examples/
│   └── ZeusExample.lua          ← Exemplo completo de uso
└── README.md                    ← Este arquivo
```

## 🔧 Como Estender

### Criar Nova Arma

1. Crie um novo arquivo em `src/Weapons/`
2. Use `WeaponBase` como classe pai
3. Implemente as funções desejadas

```lua
local MyWeapon = setmetatable({}, {__index = WeaponBase})
MyWeapon.__index = MyWeapon

function MyWeapon.new(character, humanoidRootPart)
    local self = WeaponBase.new(character, humanoidRootPart)
    setmetatable(self, MyWeapon)
    self.name = "⚔️ Minha Arma"
    return self
end
```

## 📊 Debugg

O sistema imprime mensagens automáticas:
- ✅ Ações bem-sucedidas
- ⚠️ Alertas de energia insuficiente
- ⏱️ Cooldowns restantes
- 💥 Efeitos visuais

Abra **Output** no Roblox Studio para ver!

## 🎨 Efeitos Visuais

### Beam (Raio)
- Linha de luz brilhante azul
- Conecta dois pontos
- Duração: 0.5s

### ParticleEmitter (Partículas)
- Explosão de partículas azuis
- 100 partículas/segundo
- Queda com gravidade
- Efeito realista

### Marca Visual
- Esfera pulsante no alvo
- Anuncia o impacto de Julgamento Celestial
- Duração: 0.5s

### Área de Tempestade
- Esfera grande semitransparente
- Raios caindo aleatoriamente
- Duração: 6 segundos

## 🐛 Troubleshooting

**Problema:** Nada acontece quando pressiono as teclas
- **Solução:** Verifique se o `LocalScript` está em `StarterPlayer`

**Problema:** Erro "WeaponBase not found"
- **Solução:** Certifique-se de que a pasta `src/` está em `ServerScriptService`

**Problema:** Efeitos não aparecem
- **Solução:** Verifique se `LightningEffect.lua` está em `src/Effects/`

## 📚 Conceitos Aprendidos

- ✅ OOP (Object-Oriented Programming) em Lua
- ✅ Sistema de herança com metatables
- ✅ Gerenciamento de energia e cooldown
- ✅ Efeitos visuais (Beam + Partículas)
- ✅ Async/await com `task.wait()`
- ✅ Input handling com `UserInputService`
- ✅ Heartbeat para atualização contínua

## 📝 Próximos Passos

- [ ] Sistema de dano (HitBox detection)
- [ ] Animações customizadas
- [ ] Sons e efeitos de áudio
- [ ] Skill trees / upgrades
- [ ] Multiplayer sincronização
- [ ] Mais armas (Fogo, Gelo, Vento)
- [ ] Sistema de combo visual
- [ ] Leaderboard de dano

## 👨‍💻 Autor

**HENDA679** - Sistema completo de armas para Roblox

## 📄 Licença

MIT - Use livremente!

---

**Feito com ⚡ para a comunidade Roblox!**

🌟 Se gostou, deixe uma ⭐ no repositório!
