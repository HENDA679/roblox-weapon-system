# 🆘 Guia de Resolução de Problemas

## ❌ Problema: "Dash não funciona"

### Causas Comuns

#### 1. RemoteEvent não existe
```
Erro: "Unable to find RemoteEvent"
```

**Solução:**
1. Vá para `ReplicatedStorage`
2. Clique com botão direito → Insert Object
3. Escolha "RemoteEvent"
4. Nomeie como "DashEvent"

---

#### 2. Script não está em LocalScript
```
Erro: "Service not available"
```

**Solução:**
- O script DEVE estar em: `StarterPlayer → StarterPlayerScripts → MovementClient`
- Verifique se é um **LocalScript** (não Script normal)

---

#### 3. Variáveis não carregadas
```
Erro: "humanoid is nil"
```

**Solução:**
Adicione este código no início para debug:
```lua
print("Player:", player)
print("Character:", character)
print("Humanoid:", humanoid)
print("Root:", root)
```

Se qualquer um for `nil`, adicione `WaitForChild` com timeout:
```lua
local root = character:WaitForChild("HumanoidRootPart", 5)
if not root then
    print("ERRO: HumanoidRootPart não encontrado!")
    return
end
```

---

## 🐛 Problema: "Personagem muito lento/rápido"

### Solução Rápida

Mude estas linhas (em segundos):

```lua
local NORMAL_SPEED = 16      -- ← Mude aqui
local SPRINT_SPEED = 26      -- ← Ou aqui
```

**Teste valores:**
- Muito lento? → Aumente ambos (ex: 20, 35)
- Muito rápido? → Diminua ambos (ex: 12, 18)

Consulte **[CONFIGURACAO.md](CONFIGURACAO.md)** para presets prontos.

---

## 🔄 Problema: "Dash não tem cooldown"

### Sintoma
Você consegue fazer 10 dashes seguidos sem esperar.

### Causa
A variável `dashCooldown` não está resetando.

### Solução

Verifique se tem esta linha:

```lua
task.wait(DASH_COOLDOWN)  -- ← Esta linha é CRÍTICA
dashCooldown = false
```

Se faltar, adicione dentro da função `Dash()`:

```lua
local function Dash(direction)
    if dashCooldown then return end
    dashCooldown = true
    
    -- ... código do dash ...
    
    task.wait(DASH_COOLDOWN)  -- ← Adicione isto
    dashCooldown = false      -- ← E isto
end
```

---

## 👻 Problema: "Personagem desaparece"

### Causa
BodyVelocity elevando o player infinitamente.

### Solução

Mude a linha:
```lua
bv.MaxForce = Vector3.new(100000, 0, 100000)  -- Sem Y (vertical)
```

Isso mantém a gravidade funcionando.

---

## 🎬 Problema: "Camera não volta ao normal"

### Sintoma
Depois do dash, a câmera fica com zoom errado.

### Causa
O Tween está sendo interrompido.

### Solução

Adicione um ID único para cada Tween:

```lua
local cameraZoomIn = TweenService:Create(cam, TweenInfo.new(0.1), {
    FieldOfView = 80
})

local cameraZoomOut = TweenService:Create(cam, TweenInfo.new(0.1), {
    FieldOfView = original
})

cameraZoomIn:Play()
task.wait(0.1)
cameraZoomOut:Play()
```

---

## 💥 Problema: "Personagem voa para o infinito"

### Causa
BodyVelocity Y está muito alto.

### Solução

Mude para:
```lua
bv.MaxForce = Vector3.new(100000, 0, 100000)  -- 0 no Y
```

Ou reduza DASH_POWER:
```lua
local DASH_POWER = 50  -- Mais baixo
```

---

## 🔊 Problema: "Sem som no dash"

### Causa
Sons ainda não foram implementados (v1.0).

### Solução
Consulte **[ROADMAP.md](ROADMAP.md)** para v1.1 com sistema de sons.

---

## ⏱️ Problema: "Dash muito lento/rápido"

### Ajuste a Duração

```lua
local DASH_TIME = 0.15  -- Mude este valor
```

**Guia:**
- `0.05` = Muito rápido, curto
- `0.15` = Padrão (recomendado)
- `0.3` = Lento, fluido

### Ajuste o Poder

```lua
local DASH_POWER = 85  -- Mude este valor
```

**Guia:**
- `50` = Muito fraco
- `85` = Padrão
- `150` = Muito forte

---

## 🎮 Problema: "Controles não respondem"

### Verificar Inputs

Adicione print para debug:

```lua
UIS.InputBegan:Connect(function(input, gpe)
    if input.KeyCode == Enum.KeyCode.Q then
        print("Q pressionado!")  -- ← Debug
    end
end)
```

**Se nada aparecer:**
- Verifique se o jogo está em foco
- Tente apertar Q na janela do Roblox
- Reinicie o jogo

**Se "Q pressionado!" aparece mas nada acontece:**
- Verifique se `dashCooldown = true`
- Veja se há erros na aba Output (F9)

---

## 🔍 Problema: "Erro na aba Output"

### Como Ler Erros

**Exemplo de erro:**
```
10:52:45.123 - Humanoid is not a valid member of Part
```

**Significa:**
- Você tentou acessar `.Humanoid` em algo que não é um personagem
- Verifique a linha indicada (10:52:45)

### Usar Output para Debug

1. Abra F9 durante o jogo
2. Procure por erros em vermelho
3. Clique na linha para ver mais detalhes
4. Leia o número da linha (à esquerda)
5. Correija o problema

---

## 🔧 Debug Avançado

### Imprimir Estado do Sistema

Adicione isto no início do script:

```lua
local function DebugInfo()
    while true do
        print("----- DEBUG INFO -----")
        print("Speed:", humanoid.WalkSpeed)
        print("Dash Cooldown:", dashCooldown)
        print("Sprinting:", sprinting)
        print("Position:", root.Position)
        task.wait(2)
    end
end

-- Descomentar para ativar:
-- task.spawn(DebugInfo)
```

### Raytesting (Para Wall Run)

```lua
local function IsOnGround()
    local rayOrigin = root.Position
    local rayDirection = Vector3.new(0, -5, 0)
    
    local rayResult = workspace:FindPartOnRayWithIgnoreList(
        Ray.new(rayOrigin, rayDirection),
        {character}
    )
    
    return rayResult ~= nil
end

print("No chão?", IsOnGround())
```

---

## 📞 Ainda Com Problemas?

### Checklist Final

- [ ] Script está em `StarterPlayer → StarterPlayerScripts`?
- [ ] Script é um **LocalScript**?
- [ ] RemoteEvent existe em `ReplicatedStorage`?
- [ ] Não há erros na aba Output (F9)?
- [ ] Humanoid, Character e Root estão carregados?
- [ ] Você testou em Play mode?

### Se Nada Funcionar

1. **Crie um novo LocalScript do zero**
2. **Copie o código de `src/MovementClient.lua` linha por linha**
3. **Teste após cada seção** (Sprint primeiro, depois Dash)
4. **Identifique qual parte quebra**

---

## 🎓 Recursos Adicionais

- **[Documentação Roblox](https://create.roblox.com/docs)** — Referência oficial
- **[DevForum](https://devforum.roblox.com/)** — Comunidade de desenvolvedores
- **[Wiki Roblox](https://roblox.fandom.com/)** — Base de conhecimento comunitária

---

**Próximo:** Veja [basic-setup.md](../examples/basic-setup.md) para um tutorial passo-a-passo!
