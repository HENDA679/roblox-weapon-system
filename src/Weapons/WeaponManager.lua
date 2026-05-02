-- src/Weapons/WeaponManager.lua
-- 🎯 Gerenciador de múltiplas armas

local WeaponManager = {}

function WeaponManager.new()
    return {
        weapons = {}
    }
end

function WeaponManager:equipWeapon(weapon)
    table.insert(self.weapons, weapon)
    print("✅ Arma equipada: " .. weapon.name)
end

function WeaponManager:updateAll(deltaTime)
    for _, weapon in ipairs(self.weapons) do
        if weapon.update then
            weapon:update(deltaTime)
        end
    end
end

function WeaponManager:destroyAll()
    print("🔥 Todas as armas removidas.")
    self.weapons = {}
end

return WeaponManager