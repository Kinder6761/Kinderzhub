-- 🍫 KinderzHub ULTIMATE - Version Belle
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local Workspace = game:GetService("Workspace")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

pcall(function() playerGui:FindFirstChild("KinderzHub"):Destroy() end)

local CONFIG = {
    COLORS = {
        PRIMARY = Color3.fromRGB(255, 140, 60),
        DARK_BG = Color3.fromRGB(18, 18, 25),
        SIDEBAR = Color3.fromRGB(22, 22, 30),
        CARD = Color3.fromRGB(28, 28, 37),
        BUTTON_OFF = Color3.fromRGB(60, 60, 70),
        BUTTON_ON = Color3.fromRGB(0, 255, 140),
        ACCENT = Color3.fromRGB(255, 100, 50),
        TEXT = Color3.new(1, 1, 1),
        TEXT2 = Color3.fromRGB(180, 180, 190),
    }
}

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "KinderzHub"
screenGui.ResetOnSpawn = false
screenGui.Parent = playerGui

local main = Instance.new("Frame")
main.Size = UDim2.new(0, 920, 0, 640)
main.Position = UDim2.new(0.5, -460, 0.5, -320)
main.BackgroundColor3 = CONFIG.COLORS.DARK_BG
main.Parent = screenGui
Instance.new("UICorner", main).CornerRadius = UDim.new(0, 20)
Instance.new("UIStroke", main).Color = CONFIG.COLORS.PRIMARY; Instance.new("UIStroke", main).Transparency = 0.7

-- Titre stylé
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 85)
title.BackgroundColor3 = CONFIG.COLORS.PRIMARY
title.Text = "🍫 KinderzHub ULTIMATE 🍫"
title.TextColor3 = Color3.new(1,1,1)
title.Font = Enum.Font.GothamBlack
title.TextSize = 32
title.Parent = main
Instance.new("UICorner", title).CornerRadius = UDim.new(0, 20)

-- Sidebar
local sidebar = Instance.new("Frame")
sidebar.Size = UDim2.new(0, 240, 1, -95)
sidebar.Position = UDim2.new(0, 15, 0, 95)
sidebar.BackgroundColor3 = CONFIG.COLORS.SIDEBAR
sidebar.Parent = main
Instance.new("UICorner", sidebar).CornerRadius = UDim.new(0, 16)

local content = Instance.new("ScrollingFrame")
content.Size = UDim2.new(1, -275, 1, -105)
content.Position = UDim2.new(0, 270, 0, 95)
content.BackgroundTransparency = 1
content.ScrollBarThickness = 6
content.ScrollBarImageColor3 = CONFIG.COLORS.PRIMARY
content.Parent = main

local layout = Instance.new("UIListLayout", content)
layout.Padding = UDim.new(0, 12)
layout.SortOrder = Enum.SortOrder.LayoutOrder

-- Fonction Toggle stylé
local function CreateToggle(name, key)
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(1, -20, 0, 72)
    frame.BackgroundColor3 = CONFIG.COLORS.CARD
    frame.Parent = content
    Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 14)
    Instance.new("UIStroke", frame).Color = Color3.fromRGB(50,50,60); Instance.new("UIStroke", frame).Transparency = 0.6

    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(0.65, 0, 1, 0)
    label.BackgroundTransparency = 1
    label.Text = name
    label.TextColor3 = CONFIG.COLORS.TEXT
    label.Font = Enum.Font.GothamSemibold
    label.TextSize = 17
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = frame
    Instance.new("UIPadding", label).PaddingLeft = UDim.new(0, 18)

    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0, 110, 0, 48)
    btn.Position = UDim2.new(0.68, 0, 0.5, -24)
    btn.BackgroundColor3 = CONFIG.COLORS.BUTTON_OFF
    btn.Text = "OFF"
    btn.TextColor3 = Color3.new(1,1,1)
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 14
    btn.Parent = frame
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 12)

    local enabled = false

    btn.MouseButton1Click:Connect(function()
        enabled = not enabled
        
        TweenService:Create(btn, TweenInfo.new(0.25, Enum.EasingStyle.Quint), {
            BackgroundColor3 = enabled and CONFIG.COLORS.BUTTON_ON or CONFIG.COLORS.BUTTON_OFF
        }):Play()
        
        btn.Text = enabled and "ON" or "OFF"
        print("[".. (enabled and "✅" or "❌") .."] ".. name)
    end)
end

-- Catégories (exemple)
local cats = {"🌾 Farming", "⚔️ Combat", "📦 Collection", "🗺️ Teleport", "👁️ World", "🛠️ Tools"}
for _, cat in ipairs(cats) do
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, -30, 0, 55)
    btn.BackgroundColor3 = CONFIG.COLORS.CARD
    btn.Text = cat
    btn.TextColor3 = CONFIG.COLORS.TEXT
    btn.Font = Enum.Font.GothamSemibold
    btn.TextSize = 16
    btn.Parent = sidebar
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 12)
    
    btn.MouseButton1Click:Connect(function()
        -- Vide le contenu
        for _, v in ipairs(content:GetChildren()) do
            if v:IsA("Frame") then v:Destroy() end
        end
        -- Exemple
        CreateToggle("Auto Farm Exp", "farm")
        CreateToggle("Kill Aura", "killaura")
        CreateToggle("Speed Hack", "speed")
        CreateToggle("Auto Collect Coins", "coins")
    end)
end

-- Toggle avec Insert
UserInputService.InputBegan:Connect(function(i)
    if i.KeyCode == Enum.KeyCode.Insert then
        screenGui.Enabled = not screenGui.Enabled
    end
end)

print("🍫 KinderzHub chargé ! Appuie sur INSERT")
