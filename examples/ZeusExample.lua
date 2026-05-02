-- examples/ZeusExample.lua
-- 📋 Exemplo completo de como usar a arma Zeus no seu jogo

local Zeus = require(game.ServerScriptService.src.Weapons.Zeus)
local WeaponManager = require(game.ServerScriptService.src.Weapons.WeaponManager)

-- Setup inicial
local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoidRootPart = character:WaitForChild("HumanoidRootPart")

-- Criar gerenciador e equipar Zeus
local weaponManager = WeaponManager.new()
local zeus = Zeus.new(character, humanoidRootPart)
weaponManager:equipWeapon(zeus)

print("\n" .. string.rep("⚡", 15))
print("⚡ RAIO OLÍMPICO EQUIPADO!")
print(string.rep("⚡", 15))
print("\n🎮 CONTROLES:")
print("  M - Ataque M1 (combo de 3 golpes)")
print("  N - Ataque M2 (raio em linha reta)")
print("  Z - Julgamento Celestial (marca alvo)")
print("  X - Passo Tempestade (dash com imunidade)")
print("  C - Domínio da Tempestade (ULT)")
print("  U - Ver status da arma")
print(string.rep("⚡", 15) .. "\n")

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
        -- Z: Julgamento Celestial (aponta para o mouse)
        zeus:useSkillZ(mouse.Hit.Position)
    
    elseif key == Enum.KeyCode.X then
        -- X: Passo Tempestade (dash na direção do player)
        zeus:useSkillX()
    
    elseif key == Enum.KeyCode.C then
        -- C: Domínio da Tempestade (área no mouse)
        zeus:useSkillC(mouse.Hit.Position)
    
    elseif key == Enum.KeyCode.U then
        -- U: Ver status
        zeus:displayStatus()
    end
end)

-- ===== LOOP DE ATUALIZAÇÃO (HEARTBEAT) =====

local lastUpdate = tick()

game:GetService("RunService").Heartbeat:Connect(function()
    local currentTime = tick()
    local deltaTime = currentTime - lastUpdate
    lastUpdate = currentTime
    
    -- Atualizar todas as armas
    weaponManager:updateAll(deltaTime)
end)

-- ===== CLEANUP (quando o personagem morre) =====

character.Humanoid.Died:Connect(function()
    print("💀 Personagem morreu. Armas removidas.")
    weaponManager:destroyAll()
end)

-- ===== DEBUG =====

print("✅ Script de Zeus carregado com sucesso!")