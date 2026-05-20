--[[
  Sistema de Movimentação — Roblox Battlegrounds
  Versão: 1.0
  Autor: Community
  Descrição: Sistema fluido de sprint e dash com efeitos de câmera
]]

local UIS = game:GetService("UserInputService")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")

-- ⚙️ CONFIGURAÇÕES
local NORMAL_SPEED = 16
local SPRINT_SPEED = 26
local DASH_POWER = 85
local DASH_TIME = 0.15
local DASH_COOLDOWN = 0.7

-- 📍 REFERÊNCIAS
local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")
local root = character:WaitForChild("HumanoidRootPart")

-- 🔄 ESTADO
local dashCooldown = false
local sprinting = false

-- ========================================
-- 🏃 SPRINT
-- ========================================

UIS.InputBegan:Connect(function(input, gpe)
	if gpe then return end

	if input.KeyCode == Enum.KeyCode.LeftShift then
		sprinting = true
		humanoid.WalkSpeed = SPRINT_SPEED
	end
end)

UIS.InputEnded:Connect(function(input)
	if input.KeyCode == Enum.KeyCode.LeftShift then
		sprinting = false
		humanoid.WalkSpeed = NORMAL_SPEED
	end
end)

-- ========================================
-- ⚡ DASH
-- ========================================

local function Dash(direction)
	if dashCooldown then return end
	dashCooldown = true

	-- Criar BodyVelocity para impulso
	local bv = Instance.new("BodyVelocity")
	bv.MaxForce = Vector3.new(100000, 0, 100000)
	bv.Parent = root

	-- Definir direção do dash
	if direction == "Front" then
		bv.Velocity = root.CFrame.LookVector * DASH_POWER
	elseif direction == "Back" then
		bv.Velocity = -root.CFrame.LookVector * DASH_POWER
	elseif direction == "Left" then
		bv.Velocity = -root.CFrame.RightVector * DASH_POWER
	elseif direction == "Right" then
		bv.Velocity = root.CFrame.RightVector * DASH_POWER
	end

	-- 📷 EFEITO DE CÂMERA
	local cam = workspace.CurrentCamera
	local original = cam.FieldOfView

	-- Zoom in
	TweenService:Create(cam, TweenInfo.new(0.1), {
		FieldOfView = 80
	}):Play()

	task.wait(0.1)

	-- Zoom out
	TweenService:Create(cam, TweenInfo.new(0.1), {
		FieldOfView = original
	}):Play()

	-- Remover BodyVelocity após duração
	game.Debris:AddItem(bv, DASH_TIME)

	-- Cooldown
	task.wait(DASH_COOLDOWN)
	dashCooldown = false
end

-- ========================================
-- 🎮 INPUT - DASH COM DIREÇÕES
-- ========================================

UIS.InputBegan:Connect(function(input, gpe)
	if gpe then return end

	if input.KeyCode == Enum.KeyCode.Q then
		-- Verificar qual direção está sendo pressionada
		if UIS:IsKeyDown(Enum.KeyCode.W) then
			Dash("Front")

		elseif UIS:IsKeyDown(Enum.KeyCode.S) then
			Dash("Back")

		elseif UIS:IsKeyDown(Enum.KeyCode.A) then
			Dash("Left")

		elseif UIS:IsKeyDown(Enum.KeyCode.D) then
			Dash("Right")
		else
			-- Sem direção = dash para frente
			Dash("Front")
		end
	end
end)

-- ========================================
-- 🎯 FIM DO SCRIPT
-- ========================================
