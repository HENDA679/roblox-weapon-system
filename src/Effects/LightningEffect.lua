-- src/Effects/LightningEffect.lua
-- ✨ Efeitos visuais para Lightning (Beam + Partículas)

local LightningEffect = {}

-- Criar Beam (linha de luz elétrica)
function LightningEffect:createBeam(fromPosition, toPosition)
    -- Criar attachments
    local attachment0 = Instance.new("Attachment")
    attachment0.Parent = workspace
    attachment0.WorldPosition = fromPosition
    
    local attachment1 = Instance.new("Attachment")
    attachment1.Parent = workspace
    attachment1.WorldPosition = toPosition
    
    -- Criar beam
    local beam = Instance.new("Beam")
    beam.Attachment0 = attachment0
    beam.Attachment1 = attachment1
    beam.Color = ColorSequence.new(Color3.fromRGB(100, 200, 255))
    beam.Thickness = 0.5
    beam.Transparency = NumberSequence.new(0.3)
    beam.Parent = workspace
    
    print("✨ Beam criado!")
    
    -- Remover após 0.5s
    task.wait(0.5)
    beam:Destroy()
    attachment0:Destroy()
    attachment1:Destroy()
end

-- Criar marca visual (antes do impacto)
function LightningEffect:createMarkEffect(position)
    local part = Instance.new("Part")
    part.Shape = Enum.PartType.Ball
    part.Size = Vector3.new(1, 1, 1)
    part.Color = Color3.fromRGB(100, 200, 255)
    part.Material = Enum.Material.Neon
    part.CanCollide = false
    part.CFrame = CFrame.new(position)
    part.Parent = workspace
    
    print("🎯 Marca visual criada!")
    
    -- Pulsação visual
    for i = 1, 10 do
        part.Size = part.Size + Vector3.new(0.1, 0.1, 0.1)
        part.Transparency = 0.2 + (i / 10) * 0.8
        task.wait(0.05)
    end
    
    part:Destroy()
end

-- Criar impacto com partículas (explosão elétrica)
function LightningEffect:createImpact(position)
    local part = Instance.new("Part")
    part.Shape = Enum.PartType.Ball
    part.Size = Vector3.new(3, 3, 3)
    part.Color = Color3.fromRGB(100, 200, 255)
    part.Material = Enum.Material.Neon
    part.CanCollide = false
    part.CFrame = CFrame.new(position)
    part.Parent = workspace
    
    -- Particle Emitter (partículas de raio)
    local emitter = Instance.new("ParticleEmitter")
    emitter.Parent = part
    emitter.Enabled = true
    emitter.Rate = 100
    emitter.Lifetime = NumberRange.new(0.5, 1)
    emitter.Speed = NumberRange.new(30, 50)
    emitter.Color = ColorSequence.new(Color3.fromRGB(100, 200, 255))
    emitter.Transparency = NumberSequence.new({
        NumberSequenceKeypoint.new(0, 0),
        NumberSequenceKeypoint.new(1, 1)
    })
    emitter.Acceleration = Vector3.new(0, -10, 0)
    
    print("💥 Impacto criado com partículas!")
    
    -- Desabilitar emitter após 0.2s
    task.wait(0.2)
    emitter.Enabled = false
    
    -- Remover parte após 2s
    task.wait(2)
    part:Destroy()
end

-- Criar área de tempestade (6 segundos)
function LightningEffect:createStormArea(centerPosition, duration)
    -- Parte visual da área
    local area = Instance.new("Part")
    area.Shape = Enum.PartType.Ball
    area.Size = Vector3.new(50, 50, 50)
    area.Color = Color3.fromRGB(100, 200, 255)
    area.Material = Enum.Material.Neon
    area.Transparency = 0.7
    area.CanCollide = false
    area.CFrame = CFrame.new(centerPosition)
    area.Parent = workspace
    
    print("✨ Área de tempestade criada!")
    print("⚡ Raios caindo a cada 0.3s...")
    
    -- Raios aleatórios durante 6 segundos
    local elapsedTime = 0
    local raioInterval = 0.3 -- A cada 0.3s cai um raio
    
    while elapsedTime < duration and area.Parent do
        task.wait(raioInterval)
        elapsedTime = elapsedTime + raioInterval
        
        -- Raio aleatório dentro da área
        local randomOffset = Vector3.new(
            math.random(-25, 25),
            math.random(-25, 25),
            math.random(-25, 25)
        )
        
        local raioPosition = centerPosition + randomOffset
        
        -- Criar impacto visual
        self:createImpact(raioPosition)
    end
    
    -- Remover área
    if area.Parent then
        area:Destroy()
    end
    
    print("⚡ Tempestade acabou!")
end

return LightningEffect