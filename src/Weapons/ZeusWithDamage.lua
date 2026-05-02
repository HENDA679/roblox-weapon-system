-- src/Weapons/ZeusWithDamage.lua
-- ⚡ RAIO OLÍMPICO COM DANO + ÁUDIO COMPLETO

local WeaponBase = require(script.Parent.WeaponBase)
local LightningEffect = require(script.Parent.Parent.Effects.LightningEffect)
local DamageSystem = require(script.Parent.Parent.Damage.DamageSystem)
local AudioSystem = require(script.Parent.Parent.Audio.AudioSystem)

local Zeus = setmetatable({}, {__index = WeaponBase})
Zeus.__index = Zeus

function Zeus.new(character, humanoidRootPart, player)
    local self = WeaponBase.new(character, humanoidRootPart)
    setmetatable(self, Zeus)
    
    self.name = "⚡ Raio Olímpico (Com Dano)"
    self.player = player
    self.m1Combo = 0
    self.m1LastHit = 0
    self.damageSystem = DamageSystem
    self.audioSystem = AudioSystem
    
    return self
end

-- M1: Combo de 3 golpes COM DANO
function Zeus:useM1()
    local now = tick()
    
    -- Reset combo se passou muito tempo
    if now - self.m1LastHit > 1 then
        self.m1Combo = 0
    end
    
    self.m1Combo = self.m1Combo + 1
    self.m1LastHit = now
    
    print("⚡ M1 Golpe " .. self.m1Combo .. " de 3")
    
    -- Criar hitbox de dano
    local hitboxPosition = self.humanoidRootPart.Position + self.humanoidRootPart.CFrame.LookVector * 10
    self.damageSystem:createHitbox(hitboxPosition, 10, self.character, "M1", 0.5)
    
    -- Som
    self.audioSystem:playSoundForPlayer("SWOOSH", self.character)
    
    if self.m1Combo == 3 then
        print("🌟 Stun aplicado!")
        self.audioSystem:playSoundForPlayer("IMPACT", self.character)
        self.m1Combo = 0
    end
    
    return true
end

-- M2: Raio em linha reta COM DANO
function Zeus:useM2()
    if self.cooldowns["M2"] and self.cooldowns["M2"] > 0 then
        print("⏱️ M2 em cooldown: " .. math.floor(self.cooldowns["M2"]) .. "s")
        return false
    end
    
    print("⚡ M2 - Raio disparado!")
    
    -- Criar efeito visual
    local beamEnd = self.humanoidRootPart.Position + self.humanoidRootPart.CFrame.LookVector * 100
    LightningEffect:createBeam(self.humanoidRootPart.Position, beamEnd)
    
    -- Som
    self.audioSystem:playSoundForPlayer("LIGHTNING_STRIKE", self.character)
    
    -- Criar hitbox
    self.damageSystem:createHitbox(beamEnd, 15, self.character, "M2", 0.3)
    
    self:setCooldown("M2", 2)
    return true
end

-- Z: Julgamento Celestial COM DANO
function Zeus:useSkillZ(targetPosition)
    if not self:canUseSkill("Z", 25) then return false end
    
    self:consumeEnergy(25)
    self:setCooldown("Z", 8)
    
    print("⚡ Z - Julgamento Celestial marcado!")
    print("🎯 Alvo marcado em: " .. tostring(targetPosition))
    
    -- Som de carregamento
    self.audioSystem:playSoundAtPosition("CHARGE", targetPosition)
    
    -- Criar marca visual
    LightningEffect:createMarkEffect(targetPosition)
    
    -- Delay de 1 segundo antes do raio cair
    task.wait(1)
    
    -- Som de impacto
    self.audioSystem:playSoundAtPosition("THUNDER", targetPosition)
    
    -- Criar impacto visual
    LightningEffect:createImpact(targetPosition)
    
    -- Criar hitbox de dano
    self.damageSystem:createHitbox(targetPosition, 20, self.character, "Z", 0.5)
    
    print("💥 Raio caiu!")
    
    return true
end

-- X: Passo Tempestade COM DANO
function Zeus:useSkillX()
    if not self:canUseSkill("X", 15) then return false end
    
    self:consumeEnergy(15)
    self:setCooldown("X", 4)
    
    print("⚡ X - Passo Tempestade! Dash rápido!")
    print("✨ Imunidade por 0.3s")
    
    -- Som de dash
    self.audioSystem:playSoundForPlayer("DASH", self.character)
    
    -- Animar dash
    local dashDirection = self.humanoidRootPart.CFrame.LookVector
    
    for i = 1, 10 do
        self.humanoidRootPart.CFrame = self.humanoidRootPart.CFrame + dashDirection * 5
        
        -- Criar hitbox durante o dash
        if i % 2 == 0 then
            self.damageSystem:createHitbox(
                self.humanoidRootPart.Position,
                8,
                self.character,
                "X",
                0.1
            )
        end
        
        task.wait(0.05)
    end
    
    return true
end

-- C: Domínio da Tempestade COM DANO CONTÍNUO
function Zeus:useSkillC(centerPosition)
    if not self:canUseSkill("C", 50) then return false end
    
    self:consumeEnergy(50)
    self:setCooldown("C", 28)
    
    print("⚡ C - DOMÍNIO DA TEMPESTADE ATIVADO!")
    print("💢 Área grande ativa por 6s")
    
    -- Som da tempestade
    self.audioSystem:playSoundAtPosition("STORM", centerPosition)
    
    -- Criar área de tempestade com dano contínuo
    LightningEffect:createStormArea(centerPosition, 6)
    
    -- Criar área de dano contínuo
    self.damageSystem:createAreaDamage(
        centerPosition,
        50,
        self.character,
        "C",
        6,
        0.5
    )
    
    return true
end

-- Ver informações de dano
function Zeus:displayDamageInfo()
    print("\n" .. string.rep("💥", 15))
    print("INFORMAÇÕES DE DANO:")
    print(string.rep("💥", 15))
    local configs = {
        M1 = self.damageSystem:getDamageConfig("M1"),
        M2 = self.damageSystem:getDamageConfig("M2"),
        Z = self.damageSystem:getDamageConfig("Z"),
        X = self.damageSystem:getDamageConfig("X"),
        C = self.damageSystem:getDamageConfig("C")
    }
    
    for skill, config in pairs(configs) do
        print("\n" .. skill .. ":")
        print("  💥 Dano: " .. config.damage)
        print("  📦 HitBox: " .. config.hitboxSize)
        print("  💨 Knockback: " .. config.knockback)
    end
    print(string.rep("💥", 15) .. "\n")
end

-- Ver status da arma
function Zeus:displayStatus()
    print("\n" .. string.rep("=", 30))
    print("⚡ " .. self.name)
    print(string.rep("=", 30))
    print("⚡ Energia: " .. math.floor(self.energy) .. "/" .. self.maxEnergy)
    print("\n⏱️ COOLDOWNS:")
    print("  Z (8s): " .. math.floor(self.cooldowns["Z"] or 0) .. "s")
    print("  X (4s): " .. math.floor(self.cooldowns["X"] or 0) .. "s")
    print("  C (28s): " .. math.floor(self.cooldowns["C"] or 0) .. "s")
    print("  M2 (2s): " .. math.floor(self.cooldowns["M2"] or 0) .. "s")
    print(string.rep("=", 30) .. "\n")
end

-- Atualizar arma (chamado a cada frame)
function Zeus:update(deltaTime)
    self:regenerateEnergy(deltaTime)
    self:updateCooldowns(deltaTime)
end

return Zeus