-- KinderzHub - Version Fixée
print("✅ KinderzHub est en train de se charger...")

local player = game.Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Supprime l'ancien GUI s'il existe déjà
if playerGui:FindFirstChild("KinderzHub") then
    playerGui.KinderzHub:Destroy()
end

local gui = Instance.new("ScreenGui")
gui.Name = "KinderzHub"
gui.ResetOnSpawn = false
gui.IgnoreGuiInset = true
gui.Parent = playerGui

-- Main Frame
local main = Instance.new("Frame")
main.Name = "MainFrame"
main.Size = UDim2.new(0, 460, 0, 420)
main.Position = UDim2.new(0.5, -230, 0.5, -210)
main.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
main.BorderSizePixel = 0
main.Parent = gui

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 16)
corner.Parent = main

-- Titre
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 60)
title.BackgroundColor3 = Color3.fromRGB(255, 85, 0)
title.Text = "KinderzHub"
title.TextColor3 = Color3.new(1,1,1)
title.Font = Enum.Font.GothamBold
title.TextSize = 26
title.Parent = main

local titleCorner = Instance.new("UICorner")
titleCorner.CornerRadius = UDim.new(0, 16)
titleCorner.Parent = title

-- Version
local version = Instance.new("TextLabel")
version.Size = UDim2.new(1, 0, 0, 20)
version.Position = UDim2.new(0, 0, 0, 40)
version.BackgroundTransparency = 1
version.Text = "King Legacy • Free"
version.TextColor3 = Color3.fromRGB(255, 180, 80)
version.Font = Enum.Font.Gotham
version.TextSize = 14
version.Parent = main

-- Scrolling
local scroll = Instance.new("ScrollingFrame")
scroll.Size = UDim2.new(1, -20, 1, -100)
scroll.Position = UDim2.new(0, 10, 0, 70)
scroll.BackgroundTransparency = 1
scroll.ScrollBarThickness = 6
scroll.Parent = main

local layout = Instance.new("UIListLayout")
layout.Padding = UDim.new(0, 12)
layout.SortOrder = Enum.SortOrder.LayoutOrder
layout.Parent = scroll

local function CreateToggle(name)
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(1, -10, 0, 58)
    frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    frame.Parent = scroll

    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0, 12)
    c.Parent = frame

    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(0.65, 0, 1, 0)
    label.BackgroundTransparency = 1
    label.Text = "   " .. name
    label.TextColor3 = Color3.new(1,1,1)
    label.Font = Enum.Font.GothamSemibold
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.TextSize = 17
    label.Parent = frame

    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0, 95, 0, 38)
    btn.Position = UDim2.new(0.78, 0, 0.5, -19)
    btn.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
    btn.Text = "OFF"
    btn.TextColor3 = Color3.new(1,1,1)
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 15
    btn.Parent = frame

    local bc = Instance.new("UICorner")
    bc.CornerRadius = UDim.new(0, 20)
    bc.Parent = btn

    local enabled = false
    btn.MouseButton1Click:Connect(function()
        enabled = not enabled
        if enabled then
            btn.BackgroundColor3 = Color3.fromRGB(0, 255, 120)
            btn.Text = "ON"
        else
            btn.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
            btn.Text = "OFF"
        end
    end)
end

-- Boutons
CreateToggle("🔴 Auto Farm Level")
CreateToggle("⚔️ Kill Aura")
CreateToggle("🎯 Aim Bot")
CreateToggle("👑 Auto Boss")
CreateToggle("🍎 Auto Fruit")
CreateToggle("🏴 Auto Quest")
CreateToggle("⚡ Auto Skills")
CreateToggle("🛡️ Auto Haki")
CreateToggle("🌊 Auto Sea Event")

print("✅ KinderzHub chargé avec succès ! Appuie sur INSERT pour ouvrir/fermer")

-- Touche INSERT pour ouvrir/fermer le menu
local UserInputService = game:GetService("UserInputService")
UserInputService.InputBegan:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.Insert then
        gui.Enabled = not gui.Enabled
    end
end)
