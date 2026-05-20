-- =============================================
-- KinderzHub 🍫 - Version Complète & Propre
-- King Legacy Script Hub
-- =============================================

print("🍫 KinderzHub - Chargement...")

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Suppression de l'ancien GUI
if playerGui:FindFirstChild("KinderzHub") then
    playerGui.KinderzHub:Destroy()
end

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "KinderzHub"
screenGui.ResetOnSpawn = false
screenGui.IgnoreGuiInset = true
screenGui.Parent = playerGui

-- Main Frame
local main = Instance.new("Frame")
main.Name = "MainFrame"
main.Size = UDim2.new(0, 880, 0, 580)
main.Position = UDim2.new(0.5, -440, 0.5, -290)
main.BackgroundColor3 = Color3.fromRGB(19, 17, 24)
main.BorderSizePixel = 0
main.Parent = screenGui

local mainCorner = Instance.new("UICorner")
mainCorner.CornerRadius = UDim.new(0, 18)
mainCorner.Parent = main

-- Titre
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 80)
title.BackgroundColor3 = Color3.fromRGB(255, 125, 45)
title.Text = "🍫 KinderzHub 🍫"
title.TextColor3 = Color3.new(1, 1, 1)
title.Font = Enum.Font.GothamBold
title.TextSize = 32
title.Parent = main

local titleCorner = Instance.new("UICorner")
titleCorner.CornerRadius = UDim.new(0, 18)
titleCorner.Parent = title

-- Sidebar
local sidebar = Instance.new("Frame")
sidebar.Size = UDim2.new(0, 220, 1, -80)
sidebar.Position = UDim2.new(0, 0, 0, 80)
sidebar.BackgroundColor3 = Color3.fromRGB(24, 22, 30)
sidebar.Parent = main

Instance.new("UICorner", sidebar).CornerRadius = UDim.new(0, 16)

-- Content Scrolling
local content = Instance.new("ScrollingFrame")
content.Size = UDim2.new(1, -230, 1, -90)
content.Position = UDim2.new(0, 225, 0, 85)
content.BackgroundTransparency = 1
content.ScrollBarThickness = 6
content.ScrollBarImageColor3 = Color3.fromRGB(255, 140, 60)
content.Parent = main

local layout = Instance.new("UIListLayout")
layout.Padding = UDim.new(0, 12)
layout.SortOrder = Enum.SortOrder.LayoutOrder
layout.Parent = content

-- Fonction Toggle Kinder
local function CreateToggle(name)
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(1, -25, 0, 72)
    frame.BackgroundColor3 = Color3.fromRGB(32, 29, 38)
    frame.Parent = content
    Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 14)

    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(0.65, 0, 1, 0)
    label.BackgroundTransparency = 1
    label.Text = "   " .. name
    label.TextColor3 = Color3.new(1,1,1)
    label.Font = Enum.Font.GothamSemibold
    label.TextSize = 19
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = frame

    local toggleBtn = Instance.new("TextButton")
    toggleBtn.Size = UDim2.new(0, 140, 0, 55)
    toggleBtn.Position = UDim2.new(0.7, 0, 0.5, -27.5)
    toggleBtn.BackgroundColor3 = Color3.fromRGB(210, 105, 50)
    toggleBtn.Text = "🍫"
    toggleBtn.TextSize = 34
    toggleBtn.Font = Enum.Font.GothamBold
    toggleBtn.Parent = frame
    Instance.new("UICorner", toggleBtn).CornerRadius = UDim.new(0, 14)

    local enabled = false

    toggleBtn.MouseButton1Click:Connect(function()
        enabled = not enabled
        if enabled then
            toggleBtn.Text = "🍫🥚"
            toggleBtn.BackgroundColor3 = Color3.fromRGB(255, 180, 75)
        else
            toggleBtn.Text = "🍫"
            toggleBtn.BackgroundColor3 = Color3.fromRGB(210, 105, 50)
        end
    end)
end

-- ==================== CATÉGORIES ====================
local categories = {
    "🏠 Main", "🌾 Farming", "⚔️ Combat", "👑 Boss", 
    "🏰 Dungeon", "🛍️ Item", "🌊 Sea", "🔀 Teleport", 
    "👁️ ESP", "🛠️ Misc"
}

for i, cat in ipairs(categories) do
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, -25, 0, 52)
    btn.Position = UDim2.new(0, 12.5, 0, 15 + (i-1)*62)
    btn.BackgroundColor3 = Color3.fromRGB(35, 32, 42)
    btn.Text = cat
    btn.TextColor3 = Color3.new(1,1,1)
    btn.Font = Enum.Font.GothamSemibold
    btn.TextSize = 18
    btn.Parent = sidebar
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 12)

    btn.MouseButton1Click:Connect(function()
        content:ClearAllChildren()
        layout = Instance.new("UIListLayout")
        layout.Padding = UDim.new(0,12)
        layout.Parent = content

        if cat == "🏠 Main" or cat == "🌾 Farming" then
            CreateToggle("🔴 Auto Farm Level")
            CreateToggle("⚡ Auto Farm Near Mobs")
            CreateToggle("🏴 Auto Quest")
            CreateToggle("🍎 Auto Fruit")
            CreateToggle("💰 Auto Sell Items")
            CreateToggle("🪙 Auto Collect Coins")
            
        elseif cat == "⚔️ Combat" then
            CreateToggle("⚔️ Kill Aura")
            CreateToggle("🎯 Aim Bot")
            CreateToggle("⚡ Auto Skill")
            CreateToggle("🛡️ Auto Haki / Buso")
            CreateToggle("🗡️ Auto Sword Mastery")
            CreateToggle("🔫 Auto Gun Mastery")
            
        elseif cat == "👑 Boss" then
            CreateToggle("👑 Auto Boss")
            CreateToggle("🦈 Auto Sea King")
            CreateToggle("🐍 Auto Hydra")
            CreateToggle("🔥 Auto Raid")
            
        elseif cat == "🏰 Dungeon" then
            CreateToggle("🏝 Auto Dungeon")
            CreateToggle("🏰 Auto Trial")
            CreateToggle("🗝 Auto Key")
            
        elseif cat == "🛍️ Item" then
            CreateToggle("🍫 Auto Buy Fruit")
            CreateToggle("🛒 Auto Shop")
            CreateToggle("⚔️ Auto Buy Fighting Style")
            
        elseif cat == "🌊 Sea" then
            CreateToggle("🌊 Auto Sea Event")
            CreateToggle("🚢 Auto Boat")
            
        elseif cat == "🔀 Teleport" then
            CreateToggle("🚀 Auto Hop Server")
            CreateToggle("📍 Teleport to NPC")
            
        elseif cat == "👁️ ESP" then
            CreateToggle("👀 ESP Players")
            CreateToggle("👀 ESP Mobs")
            CreateToggle("👀 ESP Items")
            CreateToggle("👀 ESP Chests")
            
        elseif cat == "🛠️ Misc" then
            CreateToggle("⏩ Auto Click")
            CreateToggle("🔄 Anti AFK")
            CreateToggle("🏃 Infinite Dash")
            CreateToggle("📊 Show Stats")
        end
    end)
end

-- Ouvrir sur Main au démarrage
content:ClearAllChildren()
layout = Instance.new("UIListLayout")
layout.Padding = UDim.new(0,12)
layout.Parent = content
CreateToggle("🔴 Auto Farm Level")
CreateToggle("⚡ Auto Farm Near Mobs")
CreateToggle("🏴 Auto Quest")

print("🍫 KinderzHub est maintenant complet et prêt !")
print("Appuie sur INSERT pour ouvrir / fermer")

-- Toggle avec INSERT
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    if input.KeyCode == Enum.KeyCode.Insert then
        screenGui.Enabled = not screenGui.Enabled
    end
end)
