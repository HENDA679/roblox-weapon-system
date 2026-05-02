-- src/Weapons/Zeus.lua
-- ⚡ RAIO OLÍMPICO - Arma completa de Zeus

local WeaponBase = require(script.Parent.WeaponBase)
local LightningEffect = require(script.Parent.Parent.Effects.LightningEffect)

local Zeus = setmetatable({}, {__index = WeaponBase})
Zeus.__index = Zeus

function Zeus.new(character, humanoidRootPart)
    local self = WeaponBase.new(character, humanoidRootPart)
    setmetatable(self, Zeus)
    
    self.name = "⚡ Raio Olímpico"
    self.m1Combo = 0
    self.m1LastHit = 0
    
    return self
end

-- M1: Combo de 3 golpes
function Zeus:useM1()
    local now = tick()
    
    -- Reset combo se passou muito tempo
    if now - self.m1LastHit > 1 then
        self.m1Combo = 0
    end
    
    self.m1Combo = self.m1Combo + 1
    self.m1LastHit = now
    
    print("⚡ M1 Golpe " .. self.m1Combo .. " de 3")
    
    if self.m1Combo == 3 then
        print("🌟 Stun aplicado!")
        self.m1Combo = 0
    end
    
    return true
end

-- M2: Raio em linha reta (cooldown 2s)
function Zeus:useM2()
    if self.cooldowns["M2"] and self.cooldowns["M2"] > 0 then
        print("⏱️ M2 em cooldown: " .. math.floor(self.cooldowns["M2"]) .. "s")
        return false
    end
    
    print("⚡ M2 - Raio disparado!")
    
    -- Criar efeito visual
    LightningEffect:createBeam(
        self.humanoidRootPart.Position,
        self.humanoidRootPart.Position + self.humanoidRootPart.CFrame.LookVector * 100
    )
    
    self:setCooldown("M2", 2)
    return true
end

-- Z: Julgamento Celestial (25 energia, 8s cooldown)
function Zeus:useSkillZ(targetPosition)
    if not self:canUseSkill("Z", 25) then return false end
    
    self:consumeEnergy(25)
    self:setCooldown("Z", 8)
    
    print("⚡ Z - Julgamento Celestial marcado!")
    print("🎯 Alvo marcado em: " .. tostring(targetPosition))
    
    -- Criar marca visual
    LightningEffect:createMarkEffect(targetPosition)
    
    -- Delay de 1 segundo antes do raio cair
    task.wait(1)
    LightningEffect:createImpact(targetPosition)
    print("💥 Raio caiu!")
    
    return true
end

-- X: Passo Tempestade (15 energia, 4s cooldown)
function Zeus:useSkillX()
    if not self:canUseSkill("X", 15) then return false end
    
    self:consumeEnergy(15)
    self:setCooldown("X", 4)
    
    print("⚡ X - Passo Tempestade! Dash rápido!")
    print("✨ Imunidade por 0.3s")
    
    -- Animar dash
    local dashDirection = self.humanoidRootPart.CFrame.LookVector
    
    for i = 1, 10 do
        self.humanoidRootPart.CFrame = self.humanoidRootPart.CFrame + dashDirection * 5
        task.wait(0.05)
    end
    
    return true
end

-- C: Domínio da Tempestade (50 energia, 28s cooldown)
function Zeus:useSkillC(centerPosition)
    if not self:canUseSkill("C", 50) then return false end
    
    self:consumeEnergy(50)
    self:setCooldown("C", 28)
    
    print("⚡ C - DOMÍNIO DA TEMPESTADE ATIVADO!")
    print("💢 Área grande ativa por 6s")
    
    -- Criar área de tempestade
    LightningEffect:createStormArea(centerPosition, 6)
    
    return true
end

-- Ver status da arma
function Zeus:displayStatus()
    print("\n" .. string.rep("=", 30))
    print("⚡ " .. self.name)
    print(string.rep("=", 30))
    print("⚡ Energia: " .. math.floor(self.energy) .. "/" .. self.maxEnergy)
    print("\n🕐 COOLDOWNS:")
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