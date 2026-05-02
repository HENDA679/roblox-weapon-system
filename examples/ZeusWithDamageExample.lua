-- examples/ZeusWithDamageExample.lua
-- 📋 EXEMPLO COMPLETO COM DANO + ÁUDIO
-- ⚙️ Certifique-se de que 'src/' está em ServerScriptService

local Zeus = require(game.ServerScriptService.src.Weapons.ZeusWithDamage)
local WeaponManager = require(game.ServerScriptService.src.Weapons.WeaponManager)
local AudioSystem = require(game.ServerScriptService.src.Audio.AudioSystem)

-- Setup inicial
local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoidRootPart = character:WaitForChild("HumanoidRootPart")

-- Criar gerenciador e equipar Zeus
local weaponManager = WeaponManager.new()
local zeus = Zeus.new(character, humanoidRootPart, player)
weaponManager:equipWeapon(zeus)

print("\n" .. string.rep("⚡", 20))
print("⚡ RAIO OLÍMPICO - VERSÃO COM DANO + ÁUDIO")
print(string.rep("⚡", 20))
print("\n🎮 CONTROLES:")
print("  M - M1 (combo com dano)")
print("  N - M2 (raio com dano)")
print("  Z - Julgamento Celestial (dano alto)")
print("  X - Passo Tempestade (dano + knockback)")
print("  C - Domínio da Tempestade (dano contínuo)")
print("  U - Ver status")
print("  D - Ver informações de DANO")
print("  A - Ver sons disponíveis")
print("  O - Criar DUMMY de teste")
print(string.rep("⚡", 20) .. "\n")

-- ===== FUNÇÃO PARA CRIAR DUMMY =====

local function createDummy(position)
    -- Criar humanoid
    local dummy = Instance.new("Model")
    dummy.Name = "Dummy"
    
    local humanoidRootPart = Instance.new("Part")
    humanoidRootPart.Name = "HumanoidRootPart"
    humanoidRootPart.Shape = Enum.PartType.Cylinder
    humanoidRootPart.Size = Vector3.new(2, 5, 2)
    humanoidRootPart.Color = Color3.fromRGB(255, 0, 0)
    humanoidRootPart.CFrame = CFrame.new(position)
    humanoidRootPart.CanCollide = true
    humanoidRootPart.Parent = dummy
    
    -- Criar humanoid
    local humanoid = Instance.new("Humanoid")
    humanoid.Parent = dummy
    humanoid.MaxHealth = 100
    humanoid.Health = 100
    
    dummy.Parent = workspace
    
    print("🧪 Dummy criado em: " .. tostring(position))
    print("❤️ HP do Dummy: " .. humanoid.Health)
    
    -- Monitorar dano
    humanoid.HealthChanged:Connect(function(health)
        print("💥 Dano recebido! HP atual: " .. math.floor(health))
        if health <= 0 then
            print("💀 Dummy foi derrotado!")
            dummy:Destroy()
        end
    end)
end

-- ===== SISTEMA DE INPUT =====

local UserInputService = game:GetService("UserInputService")
local mouse = player:GetMouse()

UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    
    local key = input.KeyCode
    
    if key == Enum.KeyCode.M then
        zeus:useM1()
    
    elseif key == Enum.KeyCode.N then
        zeus:useM2()
    
    elseif key == Enum.KeyCode.Z then
        zeus:useSkillZ(mouse.Hit.Position)
    
    elseif key == Enum.KeyCode.X then
        zeus:useSkillX()
    
    elseif key == Enum.KeyCode.C then
        zeus:useSkillC(mouse.Hit.Position)
    
    elseif key == Enum.KeyCode.U then
        zeus:displayStatus()
    
    elseif key == Enum.KeyCode.D then
        zeus:displayDamageInfo()
    
    elseif key == Enum.KeyCode.A then
        AudioSystem:printAvailableSounds()
    
    elseif key == Enum.KeyCode.O then
        local dummyPosition = humanoidRootPart.Position + humanoidRootPart.CFrame.LookVector * 20
        createDummy(dummyPosition)
    end
end)

-- ===== LOOP DE ATUALIZAÇÃO =====

local lastUpdate = tick()

game:GetService("RunService").Heartbeat:Connect(function()
    local currentTime = tick()
    local deltaTime = currentTime - lastUpdate
    lastUpdate = currentTime
    
    weaponManager:updateAll(deltaTime)
end)

-- ===== CLEANUP =====

character.Humanoid.Died:Connect(function()
    print("💀 Personagem morreu. Armas removidas.")
    weaponManager:destroyAll()
end)

print("\n✅ Zeus com Dano + Áudio carregado com sucesso!\n")