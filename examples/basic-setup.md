# 🎯 Tutorial: Configuração Básica Passo-a-Passo

## 📋 O que você vai fazer

Este tutorial mostra como instalar o sistema de movimentação do ZERO em 5 minutos.

**Tempo estimado:** ⏱️ 5-10 minutos
**Dificuldade:** ⭐ Iniciante

---

## ✅ Pré-requisitos

- Roblox Studio instalado
- Um jogo Roblox novo ou existente aberto
- 5 minutos livres 😄

---

## 🚀 Passo 1: Preparar a Estrutura

### 1.1 Expandir StarterPlayer

1. No **Explorer** (esquerda), procure por `StarterPlayer`
2. Clique na **seta ▶** ao lado de `StarterPlayer` para expandir
3. Procure por `StarterPlayerScripts`

**Seu Explorer deve estar assim:**
```
▼ StarterPlayer
  ► StarterCharacterScripts
  ▼ StarterPlayerScripts
```

### 1.2 Criar LocalScript

1. Clique com **botão direito** em `StarterPlayerScripts`
2. Escolha **Insert Object**
3. Procure por **LocalScript**
4. Clique para criar

**Resultado:**
```
▼ StarterPlayer
  ▼ StarterPlayerScripts
    ✱ LocalScript  ← Novo
```

### 1.3 Renomear para "MovementClient"

1. Clique com **botão direito** no LocalScript
2. Escolha **Rename**
3. Escreva `MovementClient`
4. Pressione **Enter**

**Resultado:**
```
▼ StarterPlayer
  ▼ StarterPlayerScripts
    ✱ MovementClient
```

---

## 🛠️ Passo 2: Adicionar o Código

### 2.1 Abrir o Script

1. **Clique duas vezes** em `MovementClient`
2. O editor de código vai abrir
3. **Apague tudo** que está lá (geralmente `print("Hello world!")`)

### 2.2 Copiar o Código

1. Abra o arquivo `src/MovementClient.lua` (do repositório)
2. **Selecione tudo** (Ctrl+A)
3. **Copie** (Ctrl+C)
4. Volta ao Roblox Studio
5. **Cole** (Ctrl+V) no editor

**Seu script deve parecer assim:**
```lua
local UIS = game:GetService("UserInputService")
local Players = game:GetService("Players")
-- ... mais código ...
```

### 2.3 Salvar

1. Pressione **Ctrl+S** para salvar
2. Feche a aba do script (X no topo)

---

## 📦 Passo 3: Criar RemoteEvent

### 3.1 Expandir ReplicatedStorage

1. No Explorer, procure por `ReplicatedStorage`
2. Clique na **seta ▶** para expandir

### 3.2 Criar RemoteEvent

1. Clique com **botão direito** em `ReplicatedStorage`
2. Escolha **Insert Object**
3. Procure por **RemoteEvent**
4. Clique para criar

**Resultado:**
```
▼ ReplicatedStorage
  ✱ RemoteEvent  ← Novo
```

### 3.3 Renomear para "DashEvent"

1. Clique com **botão direito** em `RemoteEvent`
2. Escolha **Rename**
3. Escreva `DashEvent`
4. Pressione **Enter**

**Resultado:**
```
▼ ReplicatedStorage
  ✱ DashEvent
```

---

## 🎮 Passo 4: Testar o Jogo

### 4.1 Iniciar o Jogo

1. Clique em **▶ Play** (ou pressione F5) no topo do Roblox Studio
2. Seu personagem vai aparecer no jogo

### 4.2 Testar Sprint

1. Segure **Shift** (tecla Shift/Maiúscula)
2. Pressione **W** para andar para frente
3. Seu personagem deve correr **mais rápido**
4. Solte **Shift** para voltar ao normal

✅ **Sprint funcionando!**

### 4.3 Testar Dash

1. Pressione **Q + W** (Q e W juntos)
2. Seu personagem deve fazer um dash para frente
3. Espere ~0.7 segundos
4. Pressione **Q + W** novamente

✅ **Dash funcionando!**

### 4.4 Testar Outras Direções

- **Q + A** = Dash para esquerda ⬅️
- **Q + S** = Dash para trás ⬅️
- **Q + D** = Dash para direita ➡️
- **Q** (sozinho) = Dash para frente ⬆️

---

## 🎨 Passo 5: Ajustar (Opcional)

### 5.1 Velocidade

Se achar muito lento ou rápido:

1. Abra `MovementClient` (clique duplo)
2. Mude esta linha:

```lua
local NORMAL_SPEED = 16      -- Mude este número
local SPRINT_SPEED = 26      -- Ou este
```

**Exemplos:**
- Muito lento? Tente `20` e `35`
- Muito rápido? Tente `12` e `18`
- Padrão? Deixe como está `16` e `26`

3. Salve (Ctrl+S)
4. Stop no jogo (Shift+F5)
5. Play novamente (F5)

### 5.2 Força do Dash

Se o dash é muito fraco ou muito forte:

1. Abra `MovementClient`
2. Mude esta linha:

```lua
local DASH_POWER = 85  -- Mude este número
```

**Exemplos:**
- Muito fraco? Tente `120`
- Muito forte? Tente `50`
- Padrão? Deixe como está `85`

3. Repita o processo acima

### 5.3 Cooldown do Dash

Se quer fazer dashes mais rápido ou mais lento:

1. Abra `MovementClient`
2. Mude esta linha:

```lua
local DASH_COOLDOWN = 0.7  -- Mude este número
```

**Exemplos:**
- Mais rápido? Tente `0.5`
- Mais lento? Tente `1.0`
- Padrão? Deixe como está `0.7`

**⚠️ Aviso:** Números muito baixos (< 0.3) podem quebrar o jogo!

---

## ✨ Parabéns! 🎉

Você instalou com sucesso o sistema de movimentação!

### Próximos Passos

1. **Explorar as configurações** → Leia **[CONFIGURACAO.md](../docs/CONFIGURACAO.md)**
2. **Resolver problemas** → Consulte **[TROUBLESHOOTING.md](../docs/TROUBLESHOOTING.md)**
3. **Ver futuras features** → Confira **[ROADMAP.md](../docs/ROADMAP.md)**

---

## 🎓 Dicas Extras

### Dica 1: Teste com Presets

Tente os presets prontos de **[CONFIGURACAO.md](../docs/CONFIGURACAO.md)**:

- **ÁGIL** → Dashes rápidos e curtos
- **EQUILIBRADO** → Padrão (recomendado)
- **PESADO** → Dashes lentos mas poderosos
- **EXTREMO** → Speedrun (muito rápido!)

### Dica 2: Customize para seu Jogo

Diferentes jogos precisam de velocidades diferentes:

- **Exploração?** → Velocidade média (padrão)
- **PvP?** → Velocidade alta (ÁGIL)
- **Boss fights?** → Velocidade baixa (PESADO)
- **Speedrun?** → Velocidade extrema (EXTREMO)

### Dica 3: Aprenda o Código

Tenha curiosidade! Leia o script e tente entender:

- Como `UserInputService` detecta teclas?
- O que faz `BodyVelocity`?
- Como funciona o `WaitForChild`?

Compreender código te torna um desenvolvedor melhor! 💪

---

## 🆘 Algo deu errado?

Consulte **[TROUBLESHOOTING.md](../docs/TROUBLESHOOTING.md)** para soluções rápidas!

---

**Bom desenvolvimento! 🚀**
