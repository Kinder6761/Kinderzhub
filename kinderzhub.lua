-- KinderzHub - King Legacy (Version Stable)
print("✅ KinderzHub est en train de charger...")

local player = game.Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Supprime l'ancien menu
if playerGui:FindFirstChild("KinderzHub") then
    playerGui:FindFirstChild("KinderzHub"):Destroy()
end

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "KinderzHub"
screenGui.ResetOnSpawn = false
screenGui.IgnoreGuiInset = true
screenGui.Parent = playerGui

local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.Size = UDim2.new(0, 480, 0, 440)
mainFrame.Position = UDim2.new(0.5, -240, 0.5, -220)
mainFrame.BackgroundColor3 = Color3.fromRGB(18, 18, 18)
mainFrame.BorderSizePixel = 0
mainFrame.Parent = screenGui

local uiCorner = Instance.new("UICorner")
uiCorner.CornerRadius = UDim.new(0, 14)
uiCorner.Parent = mainFrame

-- Titre
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 65)
title.BackgroundColor3 = Color3.fromRGB(255, 100, 0)
title.Text = "KinderzHub"
title.TextColor3 = Color3.new(1, 1, 1)
title.Font = Enum.Font.GothamBold
title.TextSize = 28
title.Parent = mainFrame

local titleCorner = Instance.new("UICorner")
titleCorner.CornerRadius = UDim.new(0, 14)
titleCorner.Parent = title

-- Version
local ver = Instance.new("TextLabel")
ver.Size = UDim2.new(1,0,0,20)
ver.Position = UDim2.new(0,0,0,45)
ver.BackgroundTransparency = 1
ver.Text = "King Legacy • Free"
ver.TextColor3 = Color3.fromRGB(255, 200, 100)
ver.Font = Enum.Font.Gotham
ver.TextSize = 14
ver.Parent = mainFrame

-- Scrolling
local scrolling = Instance.new("ScrollingFrame")
scrolling.Size = UDim2.new(1, -24, 1, -100)
scrolling.Position = UDim2.new(0, 12, 0, 75)
scrolling.BackgroundTransparency = 1
scrolling.ScrollBarThickness = 6
scrolling.Parent = mainFrame

local listLayout = Instance.new("UIListLayout")
listLayout.Padding = UDim.new(0, 10)
listLayout.SortOrder = Enum.SortOrder.LayoutOrder
listLayout.Parent = scrolling

local function addToggle(text)
    local toggleFrame = Instance.new("Frame")
    toggleFrame.Size = UDim2.new(1, -10, 0, 60)
    toggleFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    toggleFrame.Parent = scrolling

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 10)
    corner.Parent = toggleFrame

    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(0.7, 0, 1, 0)
    label.BackgroundTransparency = 1
    label.Text = "   " .. text
    label.TextColor3 = Color3.new(1,1,1)
    label.Font = Enum.Font.GothamSemibold
    label.TextSize = 18
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = toggleFrame

    local button = Instance.new("TextButton")
    button.Size = UDim2.new(0, 100, 0, 40)
    button.Position = UDim2.new(0.75, 0, 0.5, -20)
    button.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
    button.Text = "OFF"
    button.TextColor3 = Color3.new(1,1,1)
    button.Font = Enum.Font.GothamBold
    button.TextSize = 16
    button.Parent = toggleFrame

    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(0, 20)
    btnCorner.Parent = button

    local state = false
    button.MouseButton1Click:Connect(function()
        state = not state
        if state then
            button.BackgroundColor3 = Color3.fromRGB(0, 255, 100)
            button.Text = "ON"
        else
            button.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
            button.Text = "OFF"
        end
    end)
end

-- Liste des fonctions
addToggle("🔴 Auto Farm Level")
addToggle("⚔️ Kill Aura")
addToggle("🎯 Aim Bot")
addToggle("👑 Auto Boss")
addToggle("🍎 Auto Fruit")
addToggle("🏴 Auto Quest")
addToggle("⚡ Auto Skills")
addToggle("🛡️ Auto Haki")
addToggle("🌊 Auto Sea Event")
addToggle("⚔️ Auto Dungeon")

print("✅ KinderzHub chargé avec succès !")
print("Appuie sur **INSERT** pour ouvrir / fermer le menu")

-- Touche INSERT
game:GetService("UserInputService").InputBegan:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.Insert then
        screenGui.Enabled = not screenGui.Enabled
    end
end)
