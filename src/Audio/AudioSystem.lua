-- src/Audio/AudioSystem.lua
-- 🔊 Sistema de áudio para efeitos sonoros

local AudioSystem = {}

-- IDs de som do Roblox (som padrão)
local SOUND_IDS = {
    LIGHTNING_STRIKE = "rbxassetid://12221967",  -- Som agudo
    THUNDER = "rbxassetid://12221967",            -- Som de trovão
    SWOOSH = "rbxassetid://12221944",             -- Som de movimento
    IMPACT = "rbxassetid://12221967",             -- Som de impacto
    CHARGE = "rbxassetid://12221967",             -- Som de carregamento
    DASH = "rbxassetid://12221944",               -- Som de dash
    STORM = "rbxassetid://12221967"               -- Som de tempestade
}

-- Configuração de volume
local VOLUME_CONFIG = {
    LIGHTNING_STRIKE = 0.7,
    THUNDER = 0.8,
    SWOOSH = 0.5,
    IMPACT = 0.8,
    CHARGE = 0.6,
    DASH = 0.6,
    STORM = 0.9
}

function AudioSystem:playSoundAtPosition(soundName, position, volume)
    volume = volume or (VOLUME_CONFIG[soundName] or 0.5)
    
    -- Criar parte para o som
    local soundPart = Instance.new("Part")
    soundPart.CanCollide = false
    soundPart.Transparency = 1
    soundPart.CFrame = CFrame.new(position)
    soundPart.Parent = workspace
    
    -- Criar som
    local sound = Instance.new("Sound")
    sound.SoundId = SOUND_IDS[soundName] or SOUND_IDS.IMPACT
    sound.Volume = volume
    sound.Parent = soundPart
    
    -- Reproduzir
    sound:Play()
    print("🔊 Som: " .. soundName .. " tocando!")
    
    -- Remover após terminar
    game:GetService("Debris"):AddItem(soundPart, sound.TimeLength + 1)
end

function AudioSystem:playSoundForPlayer(soundName, player, volume)
    if player:FindFirstChild("HumanoidRootPart") then
        local position = player:FindFirstChild("HumanoidRootPart").Position
        self:playSoundAtPosition(soundName, position, volume)
    end
end

function AudioSystem:getSoundList()
    local list = {}
    for soundName, _ in pairs(SOUND_IDS) do
        table.insert(list, soundName)
    end
    return list
end

function AudioSystem:printAvailableSounds()
    print("\n" .. string.rep("🔊", 15))
    print("SONS DISPONÍVEIS:")
    print(string.rep("🔊", 15))
    for soundName, soundId in pairs(SOUND_IDS) do
        print("  • " .. soundName .. " (Volume: " .. VOLUME_CONFIG[soundName] .. ")")
    end
    print(string.rep("🔊", 15) .. "\n")
end

return AudioSystem