-- src/Weapons/WeaponBase.lua
-- 📋 Classe base para TODAS as armas

local WeaponBase = {}
WeaponBase.__index = WeaponBase

function WeaponBase.new(character, humanoidRootPart)
    local self = setmetatable({}, WeaponBase)
    
    self.character = character
    self.humanoidRootPart = humanoidRootPart
    self.energy = 100
    self.maxEnergy = 100
    self.energyRegenRate = 10
    self.cooldowns = {}
    
    return self
end

-- Regenerar energia automaticamente
function WeaponBase:regenerateEnergy(deltaTime)
    if self.energy < self.maxEnergy then
        self.energy = math.min(self.energy + self.energyRegenRate * deltaTime, self.maxEnergy)
    end
end

-- Verificar se pode usar skill (energia + cooldown)
function WeaponBase:canUseSkill(skillName, energyCost)
    if self.energy < energyCost then
        print("⚠️ Energia insuficiente! Precisa: " .. energyCost .. " | Tem: " .. math.floor(self.energy))
        return false
    end
    if self.cooldowns[skillName] and self.cooldowns[skillName] > 0 then
        print("⏱️ Skill em cooldown: " .. math.floor(self.cooldowns[skillName]) .. "s")
        return false
    end
    return true
end

-- Consumir energia
function WeaponBase:consumeEnergy(amount)
    self.energy = math.max(self.energy - amount, 0)
    print("⚡ Energia: " .. math.floor(self.energy) .. "/" .. self.maxEnergy)
end

-- Definir cooldown de skill
function WeaponBase:setCooldown(skillName, duration)
    self.cooldowns[skillName] = duration
end

-- Atualizar cooldowns (chamado a cada frame)
function WeaponBase:updateCooldowns(deltaTime)
    for skillName, cooldownTime in pairs(self.cooldowns) do
        if cooldownTime > 0 then
            self.cooldowns[skillName] = cooldownTime - deltaTime
        end
    end
end

return WeaponBase