-- KinderzHub 🍫 - Version Complète & Optimisée
print("🍫 KinderzHub Full Version - Chargement...")

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Supprime l'ancien hub
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
main.Size = UDim2.new(0, 880, 0, 580)
main.Position = UDim2.new(0.5, -440, 0.5, -290)
main.BackgroundColor3 = Color3.fromRGB(19, 17, 24)
main.Parent = screenGui
Instance.new("UICorner", main).CornerRadius = UDim.new(0, 18)

-- Titre
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 80)
title.BackgroundColor3 = Color3.fromRGB(255, 125, 45)
title.Text = "🍫 KinderzHub 🍫"
title.TextColor3 = Color3.new(1,1,1)
title.Font = Enum.Font.GothamBold
title.TextSize = 31
title.Parent = main
Instance.new("UICorner", title).CornerRadius = UDim.new(0, 18)

-- Sidebar
local sidebar = Instance.new("Frame")
sidebar.Size = UDim2.new(0, 225, 1, -80)
sidebar.Position = UDim2.new(0, 0, 0, 80)
sidebar.BackgroundColor3 = Color3.fromRGB(24, 22, 30)
sidebar.Parent = main
Instance.new("UICorner", sidebar).CornerRadius = UDim.new(0, 16)

-- Content
local content = Instance.new("ScrollingFrame")
content.Size = UDim2.new(1, -240, 1, -90)
content.Position = UDim2.new(0, 230, 0, 85)
content.BackgroundTransparency = 1
content.ScrollBarThickness = 6
content.Parent = main

local layout = Instance.new("UIListLayout")
layout.Padding = UDim.new(0, 12)
layout.SortOrder = Enum.SortOrder.LayoutOrder
layout.Parent = content

local function CreateToggle(name)
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(1, -30, 0, 72)
    frame.BackgroundColor3 = Color3.fromRGB(32, 29, 38)
    frame.Parent = content
    Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 14)

    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(0.65,0,1,0)
    label.BackgroundTransparency = 1
    label.Text = "   " .. name
    label.TextColor3 = Color3.new(1,1,1)
    label.Font = Enum.Font.GothamSemibold
    label.TextSize = 19
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = frame

    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0, 140, 0, 55)
    btn.Position = UDim2.new(0.7, 0, 0.5, -27.5)
    btn.BackgroundColor3 = Color3.fromRGB(210, 105, 50)
    btn.Text = "🍫"
    btn.TextSize = 34
    btn.Parent = frame
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 14)

    local enabled = false
    btn.MouseButton1Click:Connect(function()
        enabled = not enabled
        if enabled then
            btn.Text = "🍫🥚"
            btn.BackgroundColor3 = Color3.fromRGB(255, 180, 75)
        else
            btn.Text = "🍫"
            btn.BackgroundColor3 = Color3.fromRGB(210, 105, 50)
        end
    end)
end

-- Sidebar Buttons
local categories = {"🏠 Main", "🌾 Farming", "⚔️ Combat", "👑 Boss", "🏰 Dungeon", "🛍️ Shop", "🌊 Sea", "🔀 Teleport", "👁️ ESP", "🛠️ Misc"}

for _, cat in ipairs(categories) do
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, -30, 0, 52)
    btn.Position = UDim2.new(0, 15, 0, 20 + (_-1)*62)
    btn.BackgroundColor3 = Color3.fromRGB(35, 32, 42)
    btn.Text = cat
    btn.TextColor3 = Color3.new(1,1,1)
    btn.Font = Enum.Font.GothamSemibold
    btn.TextSize = 18
    btn.Parent = sidebar
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 12)

    btn.MouseButton1Click:Connect(function()
        content:ClearAllChildren()
        local newLayout = Instance.new("UIListLayout")
        newLayout.Padding = UDim.new(0,12)
        newLayout.Parent = content

        if cat:find("Main") or cat:find("Farming") then
            CreateToggle("🔴 Auto Farm Level")
            CreateToggle("⚡ Auto Farm Near Mobs")
            CreateToggle("🏴 Auto Quest")
            CreateToggle("🍎 Auto Fruit")
            CreateToggle("💰 Auto Sell")
            CreateToggle("🪙 Auto Collect")
        elseif cat:find("Combat") then
            CreateToggle("⚔️ Kill Aura")
            CreateToggle("🎯 Aim Bot")
            CreateToggle("⚡ Auto Skills")
            CreateToggle("🛡️ Auto Haki")
            CreateToggle("🗡️ Auto Sword")
            CreateToggle("🔫 Auto Gun")
        elseif cat:find("Boss") then
            CreateToggle("👑 Auto Boss")
            CreateToggle("🦈 Auto Sea King")
            CreateToggle("🔥 Auto Raid")
        elseif cat:find("ESP") then
            CreateToggle("👀 ESP Players")
            CreateToggle("👀 ESP Mobs")
            CreateToggle("👀 ESP Items")
        elseif cat:find("Misc") then
            CreateToggle("🔄 Anti AFK")
            CreateToggle("🚀 Auto Hop Server")
            CreateToggle("⏩ Auto Click")
        end
    end)
end

print("✅ KinderzHub Complet chargé ! Appuie sur INSERT")

UserInputService.InputBegan:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.Insert then
        screenGui.Enabled = not screenGui.Enabled
    end
end)
