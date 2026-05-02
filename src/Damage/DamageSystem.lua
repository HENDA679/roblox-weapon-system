-- src/Damage/DamageSystem.lua
-- 💥 Sistema completo de dano com detecção de HitBox

local DamageSystem = {}

-- Configuração de dano por habilidade
local DAMAGE_CONFIG = {
    M1 = { damage = 15, hitboxSize = 10, knockback = 50 },
    M2 = { damage = 25, hitboxSize = 15, knockback = 80 },
    Z = { damage = 50, hitboxSize = 20, knockback = 100 },
    X = { damage = 10, hitboxSize = 8, knockback = 30 },
    C = { damage = 35, hitboxSize = 50, knockback = 60, isArea = true }
}

-- Tabela para rastrear quem já levou dano
local damageRegistry = {}

function DamageSystem:getDamageConfig(skillName)
    return DAMAGE_CONFIG[skillName]
end

function DamageSystem:applyDamage(skillName, sourcePlayer, targetPlayer, damagePosition)
    local config = self:getDamageConfig(skillName)
    if not config then
        print("⚠️ Skill " .. skillName .. " não configurada!")
        return false
    end
    
    if not targetPlayer or not targetPlayer:FindFirstChild("Humanoid") then
        print("⚠️ Alvo inválido!")
        return false
    end
    
    local humanoid = targetPlayer:FindFirstChild("Humanoid")
    
    -- Aplicar dano
    humanoid:TakeDamage(config.damage)
    print("💥 " .. skillName .. " causou " .. config.damage .. " de dano em " .. targetPlayer.Name)
    
    -- Aplicar knockback
    self:applyKnockback(targetPlayer, sourcePlayer, config.knockback)
    
    return true
end

function DamageSystem:applyKnockback(targetPlayer, sourcePlayer, knockbackPower)
    local targetRoot = targetPlayer:FindFirstChild("HumanoidRootPart")
    local sourceRoot = sourcePlayer:FindFirstChild("HumanoidRootPart")
    
    if not targetRoot or not sourceRoot then return end
    
    -- Direção do knockback (afasta do atacante)
    local direction = (targetRoot.Position - sourceRoot.Position).Unit
    
    -- Aplicar velocidade
    targetRoot.AssemblyLinearVelocity = direction * knockbackPower
    
    print("💨 Knockback aplicado! Força: " .. knockbackPower)
end

function DamageSystem:createHitbox(position, size, sourcePlayer, skillName, duration)
    duration = duration or 1
    
    -- Criar parte invisível para o hitbox
    local hitbox = Instance.new("Part")
    hitbox.Shape = Enum.PartType.Ball
    hitbox.Size = Vector3.new(size, size, size)
    hitbox.Color = Color3.fromRGB(255, 0, 0)
    hitbox.Material = Enum.Material.Neon
    hitbox.CanCollide = false
    hitbox.Transparency = 0.5
    hitbox.CFrame = CFrame.new(position)
    hitbox.Parent = workspace
    
    local touchedPlayers = {}
    
    hitbox.Touched:Connect(function(hit)
        local humanoid = hit.Parent:FindFirstChild("Humanoid")
        if humanoid and hit.Parent ~= sourcePlayer and not touchedPlayers[hit.Parent] then
            touchedPlayers[hit.Parent] = true
            self:applyDamage(skillName, sourcePlayer, hit.Parent, position)
        end
    end)
    
    -- Remover hitbox após duração
    task.wait(duration)
    hitbox:Destroy()
    
    print("✅ Hitbox de " .. skillName .. " removido")
end

function DamageSystem:createAreaDamage(centerPosition, areaSize, sourcePlayer, skillName, duration, damageInterval)
    damageInterval = damageInterval or 0.5
    
    -- Criar parte para a área de dano
    local area = Instance.new("Part")
    area.Shape = Enum.PartType.Ball
    area.Size = Vector3.new(areaSize, areaSize, areaSize)
    area.Color = Color3.fromRGB(255, 100, 0)
    area.Material = Enum.Material.Neon
    area.CanCollide = false
    area.Transparency = 0.7
    area.CFrame = CFrame.new(centerPosition)
    area.Parent = workspace
    
    local playersInArea = {}
    local lastDamageTime = {}
    
    area.Touched:Connect(function(hit)
        local humanoid = hit.Parent:FindFirstChild("Humanoid")
        if humanoid and hit.Parent ~= sourcePlayer then
            playersInArea[hit.Parent] = true
        end
    end)
    
    area.TouchEnded:Connect(function(hit)
        if playersInArea[hit.Parent] then
            playersInArea[hit.Parent] = false
        end
    end)
    
    -- Loop de dano contínuo
    local elapsedTime = 0
    while elapsedTime < duration and area.Parent do
        task.wait(damageInterval)
        elapsedTime = elapsedTime + damageInterval
        
        for player, inArea in pairs(playersInArea) do
            if inArea and player:FindFirstChild("Humanoid") then
                if not lastDamageTime[player] or (tick() - lastDamageTime[player]) >= damageInterval then
                    self:applyDamage(skillName, sourcePlayer, player, centerPosition)
                    lastDamageTime[player] = tick()
                end
            end
        end
    end
    
    -- Remover área
    if area.Parent then
        area:Destroy()
    end
    
    print("✅ Área de dano de " .. skillName .. " removida")
end

return DamageSystem