-- 🍫 KinderzHub ULTIMATE - Version Complète Totale
-- ⭐ Tous les features des meilleurs hubs réunis!

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local HttpService = game:GetService("HttpService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

pcall(function() playerGui:FindFirstChild("KinderzHub"):Destroy() end)

-- ═══════════════════════════════════════════════════════════════════
-- 📋 CONFIGURATION ULTIME
-- ═══════════════════════════════════════════════════════════════════

local CONFIG = {
    COLORS = {
        PRIMARY = Color3.fromRGB(255, 125, 45),
        DARK_BG = Color3.fromRGB(19, 17, 24),
        SIDEBAR = Color3.fromRGB(24, 22, 30),
        BUTTON_OFF = Color3.fromRGB(210, 105, 50),
        BUTTON_ON = Color3.fromRGB(255, 180, 75),
        CARD_BG = Color3.fromRGB(32, 29, 38),
        HOVER = Color3.fromRGB(45, 42, 52),
        TEXT_PRIMARY = Color3.new(1, 1, 1),
        TEXT_SECONDARY = Color3.fromRGB(150, 150, 150),
        SUCCESS = Color3.fromRGB(0, 255, 100),
        ERROR = Color3.fromRGB(255, 50, 50),
    },
    TOGGLE_FEATURES = {
        FARMING = {
            "🔴 Auto Farm Exp",
            "💰 Auto Farm Money",
            "🍎 Auto Fruit Harvest",
            "🌾 Auto Plant Seeds",
            "📊 Auto Crop Sell",
            "⭐ Auto Level Up",
            "🏴 Auto Quest",
            "🪙 Auto Coin Collect",
            "💎 Auto Diamond Farm",
        },
        COMBAT = {
            "⚔️ Kill Aura",
            "🎯 Aim Bot",
            "⚡ Auto Skills",
            "🛡️ Auto Dodge",
            "🗡️ Auto Sword Attack",
            "🔫 Auto Gun Fire",
            "💥 Auto Ultimate",
            "🔄 Auto Buff",
            "👹 Target Closest",
        },
        COLLECTION = {
            "🪙 Auto Coin Pickup",
            "💎 Auto Diamond Pickup",
            "🎁 Auto Chest Open",
            "🍎 Auto Fruit Pickup",
            "📦 Auto Item Pickup",
            "⚔️ Auto Weapon Pickup",
            "🏆 Auto Quest Reward",
            "✨ Auto Shimmer",
        },
        TELEPORT = {
            "🏠 Teleport Spawn",
            "👑 Teleport Boss",
            "🏰 Teleport Dungeon",
            "🏪 Teleport Shop",
            "🪨 Teleport Ore",
            "🌳 Teleport Trees",
            "🌊 Teleport Sea",
            "⚡ Teleport Arena",
        },
        WORLD = {
            "👀 ESP Players",
            "👾 ESP Mobs",
            "💎 ESP Items",
            "🏆 ESP Boss",
            "📍 Show Distance",
            "🎯 Mob Tracker",
            "👁️ Player Tracker",
            "🗺️ Map Teleport",
        },
        TOOLS = {
            "🚀 Speed Hack",
            "⬆️ Jump Hack",
            "👻 Noclip",
            "🛡️ God Mode",
            "🪜 Infinite Stamina",
            "⏩ Walk Speed Control",
            "🔄 Anti Stun",
            "💪 Force Push",
        },
        AUTOMATION = {
            "🔄 Auto Sell All",
            "🎯 Auto Quest Turn",
            "💰 Auto Spend Money",
            "🏋️ Auto Train",
            "🎁 Auto Claim Reward",
            "⚙️ Auto Update",
            "🌐 Webhook Logger",
            "📊 Stats Tracker",
        },
        MISC = {
            "🔐 Anti AFK",
            "💾 Save Config",
            "📂 Load Config",
            "🎮 FPS Boost",
            "🎨 Custom Colors",
            "🔊 Sound Toggle",
            "⚙️ Settings",
            "ℹ️ About Hub",
        }
    }
}

-- ═══════════════════════════════════════════════════════════════════
-- 🎮 STATE & LOGGER
-- ═══════════════════════════════════════════════════════════════════

local UIState = {
    Features = {},
    ActiveCategory = "FARMING",
    IsOpen = true,
    CategoryButtons = {},
    ToggleButtons = {},
    RunningCoroutines = {},
    Settings = {
        Speed = 50,
        JumpPower = 100,
        FPSTarget = 60,
        AutoSellDelay = 5,
    }
}

local Logger = {}
function Logger:Print(prefix, message)
    local timestamp = os.date("%H:%M:%S")
    print("[" .. timestamp .. "] " .. prefix .. " " .. message)
end

Logger:Print("🍫", "KinderzHub ULTIMATE - Chargement...")

-- ═══════════════════════════════════════════════════════════════════
-- 🛠️ FONCTIONS UTILITAIRES
-- ═══════════════════════════════════════════════════════════════════

local function CreateElement(className, properties)
    local element = Instance.new(className)
    for prop, value in pairs(properties) do
        pcall(function() element[prop] = value end)
    end
    return element
end

local function TweenElement(element, targetProperties, duration)
    duration = duration or 0.3
    local tweenInfo = TweenInfo.new(duration, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut)
    local tween = TweenService:Create(element, tweenInfo, targetProperties)
    tween:Play()
    return tween
end

local function GetCharacter()
    return player.Character or player.CharacterAdded:Wait()
end

local function GetHumanoidRootPart()
    local char = GetCharacter()
    return char:WaitForChild("HumanoidRootPart")
end

local function GetHumanoid()
    local char = GetCharacter()
    return char:WaitForChild("Humanoid")
end

-- ✅ Fonction de téléportation sécurisée
local function TeleportTo(position)
    if position then
        local hrp = GetHumanoidRootPart()
        hrp.CFrame = CFrame.new(position + Vector3.new(0, 3, 0))
        return true
    end
    return false
end

-- ✅ Trouver objet par nom
local function FindObjectByName(name, maxDistance)
    maxDistance = maxDistance or 500
    local workspace = game:GetService("Workspace")
    local nearest = nil
    local nearestDist = maxDistance
    
    for _, obj in ipairs(workspace:GetDescendants()) do
        if obj.Name:find(name) or (obj:FindFirstChild("Name") and obj.Name:GetAttribute and obj.Name:GetAttribute("PlaceName") == name) then
            if obj:IsA("BasePart") or obj:FindFirstChild("HumanoidRootPart") then
                local pos = obj:IsA("BasePart") and obj.Position or obj:FindFirstChild("HumanoidRootPart").Position
                local dist = (pos - GetHumanoidRootPart().Position).Magnitude
                if dist < nearestDist then
                    nearest = obj
                    nearestDist = dist
                end
            end
        end
    end
    
    return nearest, nearestDist
end

-- ✅ Trouver le mob le plus proche
local function FindNearestMob(maxDistance)
    maxDistance = maxDistance or 150
    local workspace = game:GetService("Workspace")
    local nearestMob = nil
    local nearestDistance = maxDistance
    
    for _, mob in ipairs(workspace:GetDescendants()) do
        if mob:IsA("Model") and mob:FindFirstChild("Humanoid") then
            if not Players:FindFirstChild(mob.Name) then
                if mob:FindFirstChild("HumanoidRootPart") then
                    local distance = (mob.HumanoidRootPart.Position - GetHumanoidRootPart().Position).Magnitude
                    if distance < nearestDistance and mob.Humanoid.Health > 0 then
                        nearestMob = mob
                        nearestDistance = distance
                    end
                end
            end
        end
    end
    
    return nearestMob, nearestDistance
end

-- ✅ Trouver tous les items autour
local function FindAllNearbyItems(maxDistance, itemType)
    maxDistance = maxDistance or 200
    local workspace = game:GetService("Workspace")
    local items = {}
    
    for _, item in ipairs(workspace:GetDescendants()) do
        if item:IsA("BasePart") and (not itemType or item.Name:find(itemType)) then
            local distance = (item.Position - GetHumanoidRootPart().Position).Magnitude
            if distance < maxDistance then
                table.insert(items, {obj = item, distance = distance})
            end
        end
    end
    
    table.sort(items, function(a, b) return a.distance < b.distance end)
    return items
end

-- ═══════════════════════════════════════════════════════════════════
-- 🌾 FARMING FEATURES
-- ═══════════════════════════════════════════════════════════════════

local function AutoFarmExp(enabled)
    if enabled then
        UIState.RunningCoroutines["AutoFarmExp"] = task.spawn(function()
            Logger:Print("🔴", "Auto Farm Exp activé!")
            
            while UIState.Features["FARMING_Auto Farm Exp"] do
                local mob = FindNearestMob(200)
                if mob and mob.Humanoid.Health > 0 then
                    local hrp = GetHumanoidRootPart()
                    hrp.CFrame = mob:FindFirstChild("HumanoidRootPart").CFrame + Vector3.new(0, 3, 10)
                    
                    local char = GetCharacter()
                    local tool = char:FindFirstChildOfClass("Tool")
                    if tool then
                        tool:Activate()
                    end
                end
                task.wait(0.3)
            end
            Logger:Print("❌", "Auto Farm Exp désactivé")
        end)
    else
        if UIState.RunningCoroutines["AutoFarmExp"] then
            task.cancel(UIState.RunningCoroutines["AutoFarmExp"])
        end
    end
end

local function AutoFarmMoney(enabled)
    if enabled then
        UIState.RunningCoroutines["AutoFarmMoney"] = task.spawn(function()
            Logger:Print("💰", "Auto Farm Money activé!")
            
            while UIState.Features["FARMING_Auto Farm Money"] do
                local mob = FindNearestMob(200)
                if mob and mob.Humanoid.Health > 0 then
                    local hrp = GetHumanoidRootPart()
                    hrp.CFrame = mob:FindFirstChild("HumanoidRootPart").CFrame + Vector3.new(0, 3, 10)
                    
                    local char = GetCharacter()
                    local tool = char:FindFirstChildOfClass("Tool")
                    if tool then
                        for i = 1, 3 do
                            tool:Activate()
                            task.wait(0.2)
                        end
                    end
                else
                    -- Chercher les pièces/money qui traînent
                    local coins = FindAllNearbyItems(300, "Coin")
                    for _, coinData in ipairs(coins) do
                        GetHumanoidRootPart().CFrame = coinData.obj.CFrame
                        task.wait(0.1)
                    end
                end
                task.wait(0.5)
            end
            Logger:Print("❌", "Auto Farm Money désactivé")
        end)
    else
        if UIState.RunningCoroutines["AutoFarmMoney"] then
            task.cancel(UIState.RunningCoroutines["AutoFarmMoney"])
        end
    end
end

local function AutoFruitHarvest(enabled)
    if enabled then
        UIState.RunningCoroutines["AutoFruitHarvest"] = task.spawn(function()
            Logger:Print("🍎", "Auto Fruit Harvest activé!")
            
            while UIState.Features["FARMING_Auto Fruit Harvest"] do
                local fruits = FindAllNearbyItems(300, "Fruit")
                if #fruits > 0 then
                    for _, fruitData in ipairs(fruits) do
                        if UIState.Features["FARMING_Auto Fruit Harvest"] then
                            GetHumanoidRootPart().CFrame = fruitData.obj.CFrame + Vector3.new(0, 2, 0)
                            task.wait(0.2)
                        end
                    end
                end
                task.wait(1)
            end
            Logger:Print("❌", "Auto Fruit Harvest désactivé")
        end)
    else
        if UIState.RunningCoroutines["AutoFruitHarvest"] then
            task.cancel(UIState.RunningCoroutines["AutoFruitHarvest"])
        end
    end
end

local function AutoLevelUp(enabled)
    if enabled then
        UIState.RunningCoroutines["AutoLevelUp"] = task.spawn(function()
            Logger:Print("⭐", "Auto Level Up activé!")
            
            while UIState.Features["FARMING_Auto Level Up"] do
                local mobs = {}
                for _, mob in ipairs(game.Workspace:GetDescendants()) do
                    if mob:IsA("Model") and mob:FindFirstChild("Humanoid") and mob:FindFirstChild("HumanoidRootPart") then
                        if not Players:FindFirstChild(mob.Name) then
                            table.insert(mobs, mob)
                        end
                    end
                end
                
                if #mobs > 0 then
                    local mob = mobs[math.random(1, #mobs)]
                    local hrp = GetHumanoidRootPart()
                    local targetPos = mob:FindFirstChild("HumanoidRootPart").Position
                    hrp.CFrame = CFrame.new(targetPos) * CFrame.new(0, 3, 15)
                    
                    local char = GetCharacter()
                    local tool = char:FindFirstChildOfClass("Tool")
                    if tool and mob.Humanoid.Health > 0 then
                        tool:Activate()
                    end
                end
                task.wait(0.4)
            end
            Logger:Print("❌", "Auto Level Up désactivé")
        end)
    else
        if UIState.RunningCoroutines["AutoLevelUp"] then
            task.cancel(UIState.RunningCoroutines["AutoLevelUp"])
        end
    end
end

local function AutoQuest(enabled)
    if enabled then
        UIState.RunningCoroutines["AutoQuest"] = task.spawn(function()
            Logger:Print("🏴", "Auto Quest activé!")
            
            while UIState.Features["FARMING_Auto Quest"] do
                for _, npc in ipairs(game.Workspace:GetDescendants()) do
                    if npc.Name:find("NPC") or npc.Name:find("Quest") then
                        if npc:FindFirstChild("HumanoidRootPart") then
                            local distance = (npc.HumanoidRootPart.Position - GetHumanoidRootPart().Position).Magnitude
                            if distance < 100 then
                                GetHumanoidRootPart().CFrame = npc.HumanoidRootPart.CFrame + Vector3.new(0, 0, 5)
                                
                                local prompt = npc:FindFirstChild("ProximityPrompt")
                                if prompt then
                                    prompt:InputHoldBegin()
                                    task.wait(1)
                                    prompt:InputHoldEnd()
                                end
                                task.wait(2)
                            end
                        end
                    end
                end
                task.wait(3)
            end
            Logger:Print("❌", "Auto Quest désactivé")
        end)
    else
        if UIState.RunningCoroutines["AutoQuest"] then
            task.cancel(UIState.RunningCoroutines["AutoQuest"])
        end
    end
end

local function AutoCoinCollect(enabled)
    if enabled then
        UIState.RunningCoroutines["AutoCoinCollect"] = task.spawn(function()
            Logger:Print("🪙", "Auto Coin Collect activé!")
            
            while UIState.Features["FARMING_Auto Coin Collect"] do
                local coins = FindAllNearbyItems(300, "Coin")
                for _, coinData in ipairs(coins) do
                    if UIState.Features["FARMING_Auto Coin Collect"] then
                        GetHumanoidRootPart().CFrame = coinData.obj.CFrame
                        task.wait(0.15)
                    end
                end
                task.wait(0.5)
            end
            Logger:Print("❌", "Auto Coin Collect désactivé")
        end)
    else
        if UIState.RunningCoroutines["AutoCoinCollect"] then
            task.cancel(UIState.RunningCoroutines["AutoCoinCollect"])
        end
    end
end

-- ═══════════════════════════════════════════════════════════════════
-- ⚔️ COMBAT FEATURES
-- ═══════════════════════════════════════════════════════════════════

local function KillAura(enabled)
    if enabled then
        UIState.RunningCoroutines["KillAura"] = task.spawn(function()
            Logger:Print("⚔️", "Kill Aura activé!")
            
            while UIState.Features["COMBAT_Kill Aura"] do
                local workspace = game:GetService("Workspace")
                for _, mob in ipairs(workspace:GetDescendants()) do
                    if mob:IsA("Model") and mob:FindFirstChild("Humanoid") and mob:FindFirstChild("HumanoidRootPart") then
                        if not Players:FindFirstChild(mob.Name) then
                            local distance = (mob.HumanoidRootPart.Position - GetHumanoidRootPart().Position).Magnitude
                            if distance < 100 and mob.Humanoid.Health > 0 then
                                local char = GetCharacter()
                                local tool = char:FindFirstChildOfClass("Tool")
                                if tool then
                                    tool:Activate()
                                end
                            end
                        end
                    end
                end
                task.wait(0.2)
            end
            Logger:Print("❌", "Kill Aura désactivé")
        end)
    else
        if UIState.RunningCoroutines["KillAura"] then
            task.cancel(UIState.RunningCoroutines["KillAura"])
        end
    end
end

local function AimBot(enabled)
    if enabled then
        UIState.RunningCoroutines["AimBot"] = task.spawn(function()
            Logger:Print("🎯", "Aim Bot activé!")
            
            while UIState.Features["COMBAT_Aim Bot"] do
                local mob = FindNearestMob(200)
                if mob then
                    local hrp = GetHumanoidRootPart()
                    local targetPos = mob:FindFirstChild("HumanoidRootPart").Position
                    hrp.CFrame = CFrame.new(hrp.Position, targetPos)
                end
                task.wait(0.05)
            end
            Logger:Print("❌", "Aim Bot désactivé")
        end)
    else
        if UIState.RunningCoroutines["AimBot"] then
            task.cancel(UIState.RunningCoroutines["AimBot"])
        end
    end
end

local function AutoSkills(enabled)
    if enabled then
        UIState.RunningCoroutines["AutoSkills"] = task.spawn(function()
            Logger:Print("⚡", "Auto Skills activé!")
            
            while UIState.Features["COMBAT_Auto Skills"] do
                local mob = FindNearestMob(200)
                if mob then
                    local char = GetCharacter()
                    
                    -- Chercher les skills (varie selon le jeu)
                    for _, skill in ipairs(char:GetDescendants()) do
                        if skill:IsA("Tool") or skill:FindFirstChild("Cooldown") == nil then
                            if skill:IsA("BindableEvent") or skill.Name:find("Skill") then
                                pcall(function()
                                    skill:Activate()
                                end)
                            end
                        end
                    end
                end
                task.wait(0.5)
            end
            Logger:Print("❌", "Auto Skills désactivé")
        end)
    else
        if UIState.RunningCoroutines["AutoSkills"] then
            task.cancel(UIState.RunningCoroutines["AutoSkills"])
        end
    end
end

local function AutoDodge(enabled)
    if enabled then
        UIState.RunningCoroutines["AutoDodge"] = task.spawn(function()
            Logger:Print("🛡️", "Auto Dodge activé!")
            
            while UIState.Features["COMBAT_Auto Dodge"] do
                local char = GetCharacter()
                if char then
                    -- Dodge aléatoire pour éviter les attaques
                    local hrp = GetHumanoidRootPart()
                    local randomDir = Vector3.new(math.random(-50, 50)/50, 0, math.random(-50, 50)/50).Unit
                    hrp.Velocity = randomDir * 50
                end
                task.wait(2)
            end
            Logger:Print("❌", "Auto Dodge désactivé")
        end)
    else
        if UIState.RunningCoroutines["AutoDodge"] then
            task.cancel(UIState.RunningCoroutines["AutoDodge"])
        end
    end
end

local function TargetClosest(enabled)
    if enabled then
        UIState.RunningCoroutines["TargetClosest"] = task.spawn(function()
            Logger:Print("👹", "Target Closest activé!")
            
            while UIState.Features["COMBAT_Target Closest"] do
                local mob = FindNearestMob(200)
                if mob then
                    local hrp = GetHumanoidRootPart()
                    local targetPos = mob:FindFirstChild("HumanoidRootPart").Position
                    
                    -- Marquer la cible avec un ESP
                    local distance = (targetPos - hrp.Position).Magnitude
                    Logger:Print("🎯", "Target: " .. mob.Name .. " (" .. math.floor(distance) .. "m)")
                end
                task.wait(0.5)
            end
            Logger:Print("❌", "Target Closest désactivé")
        end)
    else
        if UIState.RunningCoroutines["TargetClosest"] then
            task.cancel(UIState.RunningCoroutines["TargetClosest"])
        end
    end
end

-- ═══════════════════════════════════════════════════════════════════
-- 📦 COLLECTION FEATURES
-- ═══════════════════════════════════════════════════════════════════

local function AutoCoinPickup(enabled)
    if enabled then
        UIState.RunningCoroutines["AutoCoinPickup"] = task.spawn(function()
            Logger:Print("🪙", "Auto Coin Pickup activé!")
            
            while UIState.Features["COLLECTION_Auto Coin Pickup"] do
                local coins = FindAllNearbyItems(300, "Coin")
                for _, coinData in ipairs(coins) do
                    GetHumanoidRootPart().CFrame = coinData.obj.CFrame
                    task.wait(0.1)
                end
                task.wait(0.3)
            end
            Logger:Print("❌", "Auto Coin Pickup désactivé")
        end)
    else
        if UIState.RunningCoroutines["AutoCoinPickup"] then
            task.cancel(UIState.RunningCoroutines["AutoCoinPickup"])
        end
    end
end

local function AutoDiamondPickup(enabled)
    if enabled then
        UIState.RunningCoroutines["AutoDiamondPickup"] = task.spawn(function()
            Logger:Print("💎", "Auto Diamond Pickup activé!")
            
            while UIState.Features["COLLECTION_Auto Diamond Pickup"] do
                local diamonds = FindAllNearbyItems(300, "Diamond")
                for _, diamondData in ipairs(diamonds) do
                    GetHumanoidRootPart().CFrame = diamondData.obj.CFrame
                    task.wait(0.1)
                end
                task.wait(0.3)
            end
            Logger:Print("❌", "Auto Diamond Pickup désactivé")
        end)
    else
        if UIState.RunningCoroutines["AutoDiamondPickup"] then
            task.cancel(UIState.RunningCoroutines["AutoDiamondPickup"])
        end
    end
end

local function AutoItemPickup(enabled)
    if enabled then
        UIState.RunningCoroutines["AutoItemPickup"] = task.spawn(function()
            Logger:Print("📦", "Auto Item Pickup activé!")
            
            while UIState.Features["COLLECTION_Auto Item Pickup"] do
                local items = FindAllNearbyItems(400)
                for _, itemData in ipairs(items) do
                    if UIState.Features["COLLECTION_Auto Item Pickup"] then
                        GetHumanoidRootPart().CFrame = itemData.obj.CFrame
                        task.wait(0.08)
                    end
                end
                task.wait(0.2)
            end
            Logger:Print("❌", "Auto Item Pickup désactivé")
        end)
    else
        if UIState.RunningCoroutines["AutoItemPickup"] then
            task.cancel(UIState.RunningCoroutines["AutoItemPickup"])
        end
    end
end

local function AutoChestOpen(enabled)
    if enabled then
        UIState.RunningCoroutines["AutoChestOpen"] = task.spawn(function()
            Logger:Print("🎁", "Auto Chest Open activé!")
            
            while UIState.Features["COLLECTION_Auto Chest Open"] do
                for _, chest in ipairs(game.Workspace:GetDescendants()) do
                    if chest.Name:find("Chest") or chest.Name:find("Crate") then
                        if chest:IsA("BasePart") then
                            local distance = (chest.Position - GetHumanoidRootPart().Position).Magnitude
                            if distance < 200 then
                                GetHumanoidRootPart().CFrame = chest.CFrame + Vector3.new(0, 3, 0)
                                
                                local prompt = chest:FindFirstChild("ProximityPrompt")
                                if prompt then
                                    prompt:InputHoldBegin()
                                    task.wait(0.5)
                                    prompt:InputHoldEnd()
                                end
                                task.wait(1)
                            end
                        end
                    end
                end
                task.wait(2)
            end
            Logger:Print("❌", "Auto Chest Open désactivé")
        end)
    else
        if UIState.RunningCoroutines["AutoChestOpen"] then
            task.cancel(UIState.RunningCoroutines["AutoChestOpen"])
        end
    end
end

-- ═══════════════════════════════════════════════════════════════════
-- 🗺️ TELEPORT FEATURES
-- ═══════════════════════════════════════════════════════════════════

local function TeleportSpawn(enabled)
    if enabled then
        Logger:Print("🏠", "Téléportation au Spawn...")
        
        -- Chercher le spawn du jeu
        local spawn = FindObjectByName("Spawn")
        if spawn then
            if spawn:IsA("BasePart") then
                TeleportTo(spawn.Position)
            else
                TeleportTo(spawn:FindFirstChild("HumanoidRootPart").Position)
            end
            Logger:Print("✅", "Téléporation réussie!")
        else
            Logger:Print("❌", "Spawn non trouvé")
        end
    end
end

local function TeleportBoss(enabled)
    if enabled then
        Logger:Print("👑", "Téléportation au Boss...")
        
        local boss = FindObjectByName("Boss")
        if boss then
            if boss:FindFirstChild("HumanoidRootPart") then
                TeleportTo(boss:FindFirstChild("HumanoidRootPart").Position)
            end
            Logger:Print("✅", "Téléporation réussie!")
        else
            Logger:Print("❌", "Boss non trouvé")
        end
    end
end

local function TeleportDungeon(enabled)
    if enabled then
        Logger:Print("🏰", "Téléportation au Dungeon...")
        
        local dungeon = FindObjectByName("Dungeon")
        if dungeon then
            if dungeon:IsA("BasePart") then
                TeleportTo(dungeon.Position)
            else
                TeleportTo(dungeon:FindFirstChild("HumanoidRootPart").Position)
            end
            Logger:Print("✅", "Téléporation réussie!")
        else
            Logger:Print("❌", "Dungeon non trouvé")
        end
    end
end

local function TeleportShop(enabled)
    if enabled then
        Logger:Print("🏪", "Téléportation au Shop...")
        
        local shop = FindObjectByName("Shop")
        if shop then
            TeleportTo(shop:IsA("BasePart") and shop.Position or shop:FindFirstChild("HumanoidRootPart").Position)
            Logger:Print("✅", "Téléporation réussie!")
        else
            Logger:Print("❌", "Shop non trouvé")
        end
    end
end

-- ═══════════════════════════════════════════════════════════════════
-- 👁️ WORLD / ESP FEATURES
-- ═══════════════════════════════════════════════════════════════════

local function ESPPlayers(enabled)
    if enabled then
        UIState.RunningCoroutines["ESPPlayers"] = task.spawn(function()
            Logger:Print("👀", "ESP Players activé!")
            
            while UIState.Features["WORLD_ESP Players"] do
                for _, player_in_game in ipairs(Players:GetPlayers()) do
                    if player_in_game ~= player and player_in_game.Character then
                        local char = player_in_game.Character
                        local hrp = char:FindFirstChild("HumanoidRootPart")
                        
                        if hrp then
                            local distance = (hrp.Position - GetHumanoidRootPart().Position).Magnitude
                            if distance < 500 then
                                print("[ESP] " .. player_in_game.Name .. " à " .. math.floor(distance) .. "m")
                            end
                        end
                    end
                end
                task.wait(2)
            end
            Logger:Print("❌", "ESP Players désactivé")
        end)
    else
        if UIState.RunningCoroutines["ESPPlayers"] then
            task.cancel(UIState.RunningCoroutines["ESPPlayers"])
        end
    end
end

local function ESPMobs(enabled)
    if enabled then
        UIState.RunningCoroutines["ESPMobs"] = task.spawn(function()
            Logger:Print("👾", "ESP Mobs activé!")
            
            while UIState.Features["WORLD_ESP Mobs"] do
                local workspace = game:GetService("Workspace")
                local count = 0
                
                for _, mob in ipairs(workspace:GetDescendants()) do
                    if mob:IsA("Model") and mob:FindFirstChild("Humanoid") and mob:FindFirstChild("HumanoidRootPart") then
                        if not Players:FindFirstChild(mob.Name) then
                            local distance = (mob.HumanoidRootPart.Position - GetHumanoidRootPart().Position).Magnitude
                            if distance < 500 and mob.Humanoid.Health > 0 then
                                count = count + 1
                            end
                        end
                    end
                end
                
                if count > 0 then
                    print("[ESP] " .. count .. " mobs proches")
                end
                task.wait(2)
            end
            Logger:Print("❌", "ESP Mobs désactivé")
        end)
    else
        if UIState.RunningCoroutines["ESPMobs"] then
            task.cancel(UIState.RunningCoroutines["ESPMobs"])
        end
    end
end

local function ESPItems(enabled)
    if enabled then
        UIState.RunningCoroutines["ESPItems"] = task.spawn(function()
            Logger:Print("💎", "ESP Items activé!")
            
            while UIState.Features["WORLD_ESP Items"] do
                local items = FindAllNearbyItems(500)
                if #items > 0 then
                    local topItems = {}
                    for i = 1, math.min(5, #items) do
                        table.insert(topItems, items[i].obj.Name .. " (" .. math.floor(items[i].distance) .. "m)")
                    end
                    print("[ESP Items] " .. table.concat(topItems, " | "))
                end
                task.wait(3)
            end
            Logger:Print("❌", "ESP Items désactivé")
        end)
    else
        if UIState.RunningCoroutines["ESPItems"] then
            task.cancel(UIState.RunningCoroutines["ESPItems"])
        end
    end
end

local function ShowDistance(enabled)
    if enabled then
        UIState.RunningCoroutines["ShowDistance"] = task.spawn(function()
            Logger:Print("📍", "Show Distance activé!")
            
            while UIState.Features["WORLD_Show Distance"] do
                local mob = FindNearestMob(1000)
                if mob then
                    local distance = (mob:FindFirstChild("HumanoidRootPart").Position - GetHumanoidRootPart().Position).Magnitude
                    print("[DISTANCE] " .. mob.Name .. ": " .. math.floor(distance) .. "m")
                end
                task.wait(1)
            end
            Logger:Print("❌", "Show Distance désactivé")
        end)
    else
        if UIState.RunningCoroutines["ShowDistance"] then
            task.cancel(UIState.RunningCoroutines["ShowDistance"])
        end
    end
end

-- ═══════════════════════════════════════════════════════════════════
-- 🛠️ TOOLS FEATURES
-- ═══════════════════════════════════════════════════════════════════

local function SpeedHack(enabled)
    if enabled then
        UIState.RunningCoroutines["SpeedHack"] = task.spawn(function()
            Logger:Print("🚀", "Speed Hack activé! (Speed: " .. UIState.Settings.Speed .. ")")
            local humanoid = GetHumanoid()
            
            while UIState.Features["TOOLS_Speed Hack"] do
                humanoid.WalkSpeed = UIState.Settings.Speed
                task.wait(0.1)
            end
            
            humanoid.WalkSpeed = 16
            Logger:Print("❌", "Speed Hack désactivé")
        end)
    else
        if UIState.RunningCoroutines["SpeedHack"] then
            task.cancel(UIState.RunningCoroutines["SpeedHack"])
        end
    end
end

local function JumpHack(enabled)
    if enabled then
        UIState.RunningCoroutines["JumpHack"] = task.spawn(function()
            Logger:Print("⬆️", "Jump Hack activé! (Power: " .. UIState.Settings.JumpPower .. ")")
            local humanoid = GetHumanoid()
            
            while UIState.Features["TOOLS_Jump Hack"] do
                humanoid.JumpPower = UIState.Settings.JumpPower
                task.wait(0.1)
            end
            
            humanoid.JumpPower = 50
            Logger:Print("❌", "Jump Hack désactivé")
        end)
    else
        if UIState.RunningCoroutines["JumpHack"] then
            task.cancel(UIState.RunningCoroutines["JumpHack"])
        end
    end
end

local function Noclip(enabled)
    if enabled then
        UIState.RunningCoroutines["Noclip"] = task.spawn(function()
            Logger:Print("👻", "Noclip activé!")
            local char = GetCharacter()
            
            while UIState.Features["TOOLS_Noclip"] do
                for _, part in ipairs(char:GetDescendants()) do
                    if part:IsA("BasePart") then
                        part.CanCollide = false
                    end
                end
                task.wait(0.1)
            end
            
            for _, part in ipairs(char:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.CanCollide = true
                end
            end
            Logger:Print("❌", "Noclip désactivé")
        end)
    else
        if UIState.RunningCoroutines["Noclip"] then
            task.cancel(UIState.RunningCoroutines["Noclip"])
        end
    end
end

local function GodMode(enabled)
    if enabled then
        UIState.RunningCoroutines["GodMode"] = task.spawn(function()
            Logger:Print("🛡️", "God Mode activé!")
            local humanoid = GetHumanoid()
            local initialHealth = humanoid.MaxHealth
            
            while UIState.Features["TOOLS_God Mode"] do
                humanoid.Health = initialHealth
                task.wait(0.1)
            end
            Logger:Print("❌", "God Mode désactivé")
        end)
    else
        if UIState.RunningCoroutines["GodMode"] then
            task.cancel(UIState.RunningCoroutines["GodMode"])
        end
    end
end

local function InfiniteStamina(enabled)
    if enabled then
        UIState.RunningCoroutines["InfiniteStamina"] = task.spawn(function()
            Logger:Print("🪜", "Infinite Stamina activé!")
            
            while UIState.Features["TOOLS_Infinite Stamina"] do
                -- Chercher l'attribut Stamina du personnage
                local char = GetCharacter()
                if char:FindFirstChild("Stamina") then
                    char.Stamina.Value = char.Stamina.MaxValue
                end
                task.wait(0.1)
            end
            Logger:Print("❌", "Infinite Stamina désactivé")
        end)
    else
        if UIState.RunningCoroutines["InfiniteStamina"] then
            task.cancel(UIState.RunningCoroutines["InfiniteStamina"])
        end
    end
end

local function AntiStun(enabled)
    if enabled then
        Logger:Print("🔄", "Anti Stun activé!")
        local char = GetCharacter()
        
        -- Désactiver tous les debuffs/effets négatifs
        for _, part in ipairs(char:GetDescendants()) do
            if part:IsA("BasePart") then
                part.Anchored = false
            end
        end
    else
        Logger:Print("❌", "Anti Stun désactivé")
    end
end

-- ═══════════════════════════════════════════════════════════════════
-- 🔧 AUTOMATION FEATURES
-- ═══════════════════════════════════════════════════════════════════

local function AutoSellAll(enabled)
    if enabled then
        UIState.RunningCoroutines["AutoSellAll"] = task.spawn(function()
            Logger:Print("🔄", "Auto Sell All activé!")
            
            while UIState.Features["AUTOMATION_Auto Sell All"] do
                -- Chercher les NPCs vendeurs
                for _, npc in ipairs(game.Workspace:GetDescendants()) do
                    if npc.Name:find("Sell") or npc.Name:find("Vendor") then
                        if npc:FindFirstChild("HumanoidRootPart") then
                            GetHumanoidRootPart().CFrame = npc.HumanoidRootPart.CFrame + Vector3.new(0, 0, 5)
                            
                            local prompt = npc:FindFirstChild("ProximityPrompt")
                            if prompt then
                                prompt:InputHoldBegin()
                                task.wait(UIState.Settings.AutoSellDelay)
                                prompt:InputHoldEnd()
                            end
                        end
                    end
                end
                task.wait(2)
            end
            Logger:Print("❌", "Auto Sell All désactivé")
        end)
    else
        if UIState.RunningCoroutines["AutoSellAll"] then
            task.cancel(UIState.RunningCoroutines["AutoSellAll"])
        end
    end
end

local function AutoClaimReward(enabled)
    if enabled then
        UIState.RunningCoroutines["AutoClaimReward"] = task.spawn(function()
            Logger:Print("🎁", "Auto Claim Reward activé!")
            
            while UIState.Features["AUTOMATION_Auto Claim Reward"] do
                for _, reward in ipairs(game.Workspace:GetDescendants()) do
                    if reward.Name:find("Reward") or reward.Name:find("Chest") then
                        if reward:IsA("BasePart") or reward:FindFirstChild("HumanoidRootPart") then
                            local pos = reward:IsA("BasePart") and reward.Position or reward:FindFirstChild("HumanoidRootPart").Position
                            local distance = (pos - GetHumanoidRootPart().Position).Magnitude
                            
                            if distance < 200 then
                                GetHumanoidRootPart().CFrame = CFrame.new(pos) + Vector3.new(0, 3, 0)
                                
                                local prompt = reward:FindFirstChild("ProximityPrompt")
                                if prompt then
                                    prompt:InputHoldBegin()
                                    task.wait(0.5)
                                    prompt:InputHoldEnd()
                                end
                            end
                        end
                    end
                end
                task.wait(2)
            end
            Logger:Print("❌", "Auto Claim Reward désactivé")
        end)
    else
        if UIState.RunningCoroutines["AutoClaimReward"] then
            task.cancel(UIState.RunningCoroutines["AutoClaimReward"])
        end
    end
end

-- ═══════════════════════════════════════════════════════════════════
-- ⚙️ MISC FEATURES
-- ═══════════════════════════════════════════════════════════════════

local function AntiAFK(enabled)
    if enabled then
        UIState.RunningCoroutines["AntiAFK"] = task.spawn(function()
            Logger:Print("🔄", "Anti AFK activé!")
            
            while UIState.Features["MISC_Anti AFK"] do
                local hrp = GetHumanoidRootPart()
                local randomPos = hrp.Position + Vector3.new(
                    math.random(-10, 10),
                    0,
                    math.random(-10, 10)
                )
                hrp.CFrame = CFrame.new(randomPos)
                task.wait(300)
            end
            Logger:Print("❌", "Anti AFK désactivé")
        end)
    else
        if UIState.RunningCoroutines["AntiAFK"] then
            task.cancel(UIState.RunningCoroutines["AntiAFK"])
        end
    end
end

local function SaveConfig(enabled)
    if enabled then
        Logger:Print("💾", "Configuration sauvegardée!")
        
        -- Convertir UIState en JSON
        local configData = HttpService:JSONEncode(UIState.Features)
        print("[CONFIG SAVED] " .. configData)
    end
end

local function FPSBoost(enabled)
    if enabled then
        UIState.RunningCoroutines["FPSBoost"] = task.spawn(function()
            Logger:Print("🎮", "FPS Boost activé!")
            
            while UIState.Features["MISC_FPS Boost"] do
                -- Réduire les rendus inutiles
                for _, part in ipairs(game.Workspace:GetDescendants()) do
                    if part:IsA("BasePart") and part:FindFirstChild("PointLight") then
                        part.PointLight.Enabled = false
                    end
                end
                task.wait(1)
            end
            Logger:Print("❌", "FPS Boost désactivé")
        end)
    else
        if UIState.RunningCoroutines["FPSBoost"] then
            task.cancel(UIState.RunningCoroutines["FPSBoost"])
        end
    end
end

-- ═══════════════════════════════════════════════════════════════════
-- 🔌 EXÉCUTION DES FEATURES
-- ═══════════════════════════════════════════════════════════════════

function ExecuteFeature(featureKey, isEnabled)
    local parts = {}
    for part in string.gmatch(featureKey, "[^_]+") do
        table.insert(parts, part)
    end
    local category = parts[1]
    local featureName = table.concat(parts, " ", 2)
    
    if category == "FARMING" then
        if featureName == "Auto Farm Exp" then AutoFarmExp(isEnabled)
        elseif featureName == "Auto Farm Money" then AutoFarmMoney(isEnabled)
        elseif featureName == "Auto Fruit Harvest" then AutoFruitHarvest(isEnabled)
        elseif featureName == "Auto Level Up" then AutoLevelUp(isEnabled)
        elseif featureName == "Auto Quest" then AutoQuest(isEnabled)
        elseif featureName == "Auto Coin Collect" then AutoCoinCollect(isEnabled)
        end
        
    elseif category == "COMBAT" then
        if featureName == "Kill Aura" then KillAura(isEnabled)
        elseif featureName == "Aim Bot" then AimBot(isEnabled)
        elseif featureName == "Auto Skills" then AutoSkills(isEnabled)
        elseif featureName == "Auto Dodge" then AutoDodge(isEnabled)
        elseif featureName == "Target Closest" then TargetClosest(isEnabled)
        end
        
    elseif category == "COLLECTION" then
        if featureName == "Auto Coin Pickup" then AutoCoinPickup(isEnabled)
        elseif featureName == "Auto Diamond Pickup" then AutoDiamondPickup(isEnabled)
        elseif featureName == "Auto Item Pickup" then AutoItemPickup(isEnabled)
        elseif featureName == "Auto Chest Open" then AutoChestOpen(isEnabled)
        end
        
    elseif category == "TELEPORT" then
        if featureName == "Teleport Spawn" then TeleportSpawn(isEnabled)
        elseif featureName == "Teleport Boss" then TeleportBoss(isEnabled)
        elseif featureName == "Teleport Dungeon" then TeleportDungeon(isEnabled)
        elseif featureName == "Teleport Shop" then TeleportShop(isEnabled)
        end
        
    elseif category == "WORLD" then
        if featureName == "ESP Players" then ESPPlayers(isEnabled)
        elseif featureName == "ESP Mobs" then ESPMobs(isEnabled)
        elseif featureName == "ESP Items" then ESPItems(isEnabled)
        elseif featureName == "Show Distance" then ShowDistance(isEnabled)
        end
        
    elseif category == "TOOLS" then
        if featureName == "Speed Hack" then SpeedHack(isEnabled)
        elseif featureName == "Jump Hack" then JumpHack(isEnabled)
        elseif featureName == "Noclip" then Noclip(isEnabled)
        elseif featureName == "God Mode" then GodMode(isEnabled)
        elseif featureName == "Infinite Stamina" then InfiniteStamina(isEnabled)
        elseif featureName == "Anti Stun" then AntiStun(isEnabled)
        end
        
    elseif category == "AUTOMATION" then
        if featureName == "Auto Sell All" then AutoSellAll(isEnabled)
        elseif featureName == "Auto Claim Reward" then AutoClaimReward(isEnabled)
        end
        
    elseif category == "MISC" then
        if featureName == "Anti AFK" then AntiAFK(isEnabled)
        elseif featureName == "Save Config" then SaveConfig(isEnabled)
        elseif featureName == "FPS Boost" then FPSBoost(isEnabled)
        end
    end
end

-- ═══════════════════════════════════════════════════════════════════
-- 🖼️ CRÉATION DE L'UI COMPLÈTE
-- ═══════════════════════════════════════════════════════════════════

local screenGui = CreateElement("ScreenGui", {
    Name = "KinderzHub",
    ResetOnSpawn = false,
    IgnoreGuiInset = true,
    Parent = playerGui,
})

local main = CreateElement("Frame", {
    Size = UDim2.new(0, 880, 0, 600),
    Position = UDim2.new(0.5, -440, 0.5, -300),
    BackgroundColor3 = CONFIG.COLORS.DARK_BG,
    Parent = screenGui,
})
Instance.new("UICorner", main).CornerRadius = UDim.new(0, 18)

-- TITRE
local titleContainer = CreateElement("Frame", {
    Size = UDim2.new(1, 0, 0, 80),
    BackgroundColor3 = CONFIG.COLORS.PRIMARY,
    Parent = main,
})
Instance.new("UICorner", titleContainer).CornerRadius = UDim.new(0, 18)

local title = CreateElement("TextLabel", {
    Size = UDim2.new(1, 0, 1, 0),
    BackgroundTransparency = 1,
    Text = "🍫 KinderzHub ULTIMATE 🍫",
    TextColor3 = CONFIG.COLORS.TEXT_PRIMARY,
    Font = Enum.Font.GothamBold,
    TextSize = 32,
    Parent = titleContainer,
})

-- SIDEBAR
local sidebar = CreateElement("Frame", {
    Size = UDim2.new(0, 225, 1, -80),
    Position = UDim2.new(0, 0, 0, 80),
    BackgroundColor3 = CONFIG.COLORS.SIDEBAR,
    Parent = main,
})
Instance.new("UICorner", sidebar).CornerRadius = UDim.new(0, 16)

local sidebarLayout = Instance.new("UIListLayout")
sidebarLayout.Padding = UDim.new(0, 8)
sidebarLayout.SortOrder = Enum.SortOrder.LayoutOrder
sidebarLayout.Parent = sidebar

Instance.new("UIPadding", sidebar).PaddingLeft = UDim.new(0, 8)
Instance.new("UIPadding", sidebar).PaddingTop = UDim.new(0, 8)

-- CONTENU
local content = CreateElement("ScrollingFrame", {
    Size = UDim2.new(1, -233, 1, -90),
    Position = UDim2.new(0, 230, 0, 85),
    BackgroundTransparency = 1,
    ScrollBarThickness = 6,
    Parent = main,
})

local contentLayout = Instance.new("UIListLayout")
contentLayout.Padding = UDim.new(0, 10)
contentLayout.SortOrder = Enum.SortOrder.LayoutOrder
contentLayout.Parent = content

Instance.new("UIPadding", content).PaddingRight = UDim.new(0, 15)
Instance.new("UIPadding", content).PaddingLeft = UDim.new(0, 15)

-- FONCTION CRÉER UN TOGGLE
local function CreateToggle(name, featureKey)
    local frame = CreateElement("Frame", {
        Size = UDim2.new(1, -20, 0, 65),
        BackgroundColor3 = CONFIG.COLORS.CARD_BG,
    })
    Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 12)

    local label = CreateElement("TextLabel", {
        Size = UDim2.new(0.65, 0, 1, 0),
        BackgroundTransparency = 1,
        Text = name,
        TextColor3 = CONFIG.COLORS.TEXT_PRIMARY,
        Font = Enum.Font.GothamSemibold,
        TextSize = 15,
        TextXAlignment = Enum.TextXAlignment.Left,
        Parent = frame,
    })
    Instance.new("UIPadding", label).PaddingLeft = UDim.new(0, 10)

    local btn = CreateElement("TextButton", {
        Size = UDim2.new(0, 100, 0, 45),
        Position = UDim2.new(0.65, 5, 0.5, -22.5),
        BackgroundColor3 = CONFIG.COLORS.BUTTON_OFF,
        Text = "OFF",
        TextSize = 12,
        Font = Enum.Font.GothamSemibold,
        TextColor3 = CONFIG.COLORS.TEXT_PRIMARY,
        Parent = frame,
    })
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 10)

    UIState.Features[featureKey] = false

    btn.MouseButton1Click:Connect(function()
        UIState.Features[featureKey] = not UIState.Features[featureKey]
        local isEnabled = UIState.Features[featureKey]
        
        if isEnabled then
            btn.Text = "ON"
            TweenElement(btn, {BackgroundColor3 = CONFIG.COLORS.BUTTON_ON}, 0.15)
            Logger:Print("✅", name)
        else
            btn.Text = "OFF"
            TweenElement(btn, {BackgroundColor3 = CONFIG.COLORS.BUTTON_OFF}, 0.15)
            Logger:Print("❌", name)
        end
        
        ExecuteFeature(featureKey, isEnabled)
    end)

    btn.MouseEnter:Connect(function()
        TweenElement(btn, {
            BackgroundColor3 = UIState.Features[featureKey] and 
                Color3.fromRGB(255, 200, 100) or CONFIG.COLORS.HOVER
        }, 0.1)
    end)

    btn.MouseLeave:Connect(function()
        TweenElement(btn, {
            BackgroundColor3 = UIState.Features[featureKey] and 
                CONFIG.COLORS.BUTTON_ON or CONFIG.COLORS.BUTTON_OFF
        }, 0.1)
    end)

    frame.Parent = content
    return btn
end

-- CHARGER LES CATÉGORIES
local function LoadCategory(categoryKey)
    for _, child in ipairs(content:GetChildren()) do
        if child:IsA("Frame") and child ~= contentLayout then
            child:Destroy()
        end
    end

    contentLayout = Instance.new("UIListLayout")
    contentLayout.Padding = UDim.new(0, 10)
    contentLayout.SortOrder = Enum.SortOrder.LayoutOrder
    contentLayout.Parent = content

    local features = CONFIG.TOGGLE_FEATURES[categoryKey] or {}
    
    for index, featureName in ipairs(features) do
        local featureKey = categoryKey .. "_" .. featureName:gsub(" ", "_")
        local toggle = CreateToggle(featureName, featureKey)
        toggle.LayoutOrder = index
    end

    task.wait(0.05)
    content.CanvasSize = UDim2.new(0, 0, 0, contentLayout.AbsoluteContentSize.Y + 20)
end

-- CATÉGORIES
local categories = {
    {icon = "🌾", name = "Farming", key = "FARMING"},
    {icon = "⚔️", name = "Combat", key = "COMBAT"},
    {icon = "📦", name = "Collection", key = "COLLECTION"},
    {icon = "🗺️", name = "Teleport", key = "TELEPORT"},
    {icon = "👁️", name = "World", key = "WORLD"},
    {icon = "🛠️", name = "Tools", key = "TOOLS"},
    {icon = "⚙️", name = "Automation", key = "AUTOMATION"},
    {icon = "ℹ️", name = "Misc", key = "MISC"},
}

for index, category in ipairs(categories) do
    local btn = CreateElement("TextButton", {
        Size = UDim2.new(1, 0, 0, 48),
        BackgroundColor3 = CONFIG.COLORS.CARD_BG,
        Text = category.icon .. " " .. category.name,
        TextColor3 = CONFIG.COLORS.TEXT_PRIMARY,
        Font = Enum.Font.GothamSemibold,
        TextSize = 14,
        Parent = sidebar,
        LayoutOrder = index,
    })
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 10)

    UIState.CategoryButtons[category.key] = btn

    btn.MouseButton1Click:Connect(function()
        for key, button in pairs(UIState.CategoryButtons) do
            TweenElement(button, {BackgroundColor3 = CONFIG.COLORS.CARD_BG}, 0.15)
        end

        UIState.ActiveCategory = category.key
        TweenElement(btn, {BackgroundColor3 = CONFIG.COLORS.PRIMARY}, 0.15)
        LoadCategory(category.key)
    end)
    
    btn.MouseEnter:Connect(function()
        if UIState.ActiveCategory ~= category.key then
            TweenElement(btn, {BackgroundColor3 = CONFIG.COLORS.HOVER}, 0.1)
        end
    end)
    
    btn.MouseLeave:Connect(function()
        if UIState.ActiveCategory ~= category.key then
            TweenElement(btn, {BackgroundColor3 = CONFIG.COLORS.CARD_BG}, 0.1)
        end
    end)
end

-- CHARGER FARMING PAR DÉFAUT
task.wait(0.1)
UIState.CategoryButtons["FARMING"].BackgroundColor3 = CONFIG.COLORS.PRIMARY
LoadCategory("FARMING")

-- ═══════════════════════════════════════════════════════════════════
-- 🎮 DRAG & DROP
-- ═══════════════════════════════════════════════════════════════════

local dragging = false
local dragStart = nil
local startPos = nil

title.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = UserInputService:GetMouseLocation()
        startPos = main.Position
    end
end)

title.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = false
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        local currentMouse = UserInputService:GetMouseLocation()
        local delta = currentMouse - dragStart
        main.Position = startPos + UDim2.new(0, delta.X, 0, delta.Y)
    end
end)

-- ═══════════════════════════════════════════════════════════════════
-- ⌨️ CONTRÔLES CLAVIER
-- ═══════════════════════════════════════════════════════════════════

UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    
    if input.KeyCode == Enum.KeyCode.Insert then
        UIState.IsOpen = not UIState.IsOpen
        screenGui.Enabled = UIState.IsOpen
        Logger:Print("👁️", UIState.IsOpen and "UI Affichée" or "UI Cachée")
        
    elseif input.KeyCode == Enum.KeyCode.Delete then
        Logger:Print("🗑️", "KinderzHub fermé")
        screenGui:Destroy()
    end
end)

-- ═══════════════════════════════════════════════════════════════════
-- 🔌 CLEANUP
-- ═══════════════════════════════════════════════════════════════════

player.CharacterAdded:Connect(function(newCharacter)
    for key, coroutine in pairs(UIState.RunningCoroutines) do
        task.cancel(coroutine)
    end
    UIState.RunningCoroutines = {}
    Logger:Print("⚠️", "Réinitialisation suite respawn")
end)

Logger:Print("✅", "KinderzHub ULTIMATE chargé!")
Logger:Print("🎮", "Insert: Toggle UI | Delete: Fermer")

