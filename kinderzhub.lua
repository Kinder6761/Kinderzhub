-- 🍫 KinderzHub ULTIMATE - Version Fix Définitive
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local Workspace = game:GetService("Workspace")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

pcall(function() playerGui:FindFirstChild("KinderzHub"):Destroy() end)

local main = Instance.new("ScreenGui")
main.Name = "KinderzHub"
main.ResetOnSpawn = false
main.Parent = playerGui

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 920, 0, 620)
frame.Position = UDim2.new(0.5, -460, 0.5, -310)
frame.BackgroundColor3 = Color3.fromRGB(18, 18, 24)
frame.Parent = main
Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 20)

-- Titre
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1,0,0,90)
title.BackgroundColor3 = Color3.fromRGB(255, 140, 40)
title.Text = "🍫 KinderzHub ULTIMATE 🍫"
title.TextColor3 = Color3.new(1,1,1)
title.Font = Enum.Font.GothamBlack
title.TextSize = 34
title.Parent = frame
Instance.new("UICorner", title).CornerRadius = UDim.new(0, 20)

local scrolling = Instance.new("ScrollingFrame")
scrolling.Size = UDim2.new(1, -40, 1, -110)
scrolling.Position = UDim2.new(0, 20, 0, 100)
scrolling.BackgroundTransparency = 1
scrolling.ScrollBarThickness = 6
scrolling.Parent = frame

local layout = Instance.new("UIListLayout", scrolling)
layout.Padding = UDim.new(0, 14)
layout.SortOrder = Enum.SortOrder.LayoutOrder

-- ==================== TOGGLE CHOCOLAT RÉEL ====================
local function CreateKinderToggle(text)
    local card = Instance.new("Frame")
    card.Size = UDim2.new(1, -20, 0, 85)
    card.BackgroundColor3 = Color3.fromRGB(30, 28, 40)
    card.Parent = scrolling
    Instance.new("UICorner", card).CornerRadius = UDim.new(0, 16)

    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(0.6, 0, 1, 0)
    label.BackgroundTransparency = 1
    label.Text = text
    label.TextColor3 = Color3.new(1,1,1)
    label.Font = Enum.Font.GothamSemibold
    label.TextSize = 18
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = card
    Instance.new("UIPadding", label).PaddingLeft = UDim.new(0, 20)

    -- Toggle Kinder
    local toggle = Instance.new("Frame")
    toggle.Size = UDim2.new(0, 150, 0, 70)
    toggle.Position = UDim2.new(1, -170, 0.5, -35)
    toggle.BackgroundTransparency = 1
    toggle.Parent = card

    local wrapper = Instance.new("ImageLabel") -- Emballage
    wrapper.Size = UDim2.new(1,0,1,0)
    wrapper.BackgroundTransparency = 1
    wrapper.Image = "rbxassetid://10734950378" 
    wrapper.ImageColor3 = Color3.fromRGB(255, 165, 50)
    wrapper.Parent = toggle

    local choc = Instance.new("ImageLabel") -- Chocolat
    choc.Size = UDim2.new(0.75,0,0.75,0)
    choc.Position = UDim2.new(0.5,0,0.5,0)
    choc.AnchorPoint = Vector2.new(0.5,0.5)
    choc.BackgroundTransparency = 1
    choc.Image = "rbxassetid://6031094678"
    choc.ImageTransparency = 1
    choc.Parent = toggle

    local on = false

    toggle.InputBegan:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.MouseButton1 then
            on = not on
            
            if on then
                TweenService:Create(wrapper, TweenInfo.new(0.35), {ImageTransparency = 0.7}):Play()
                TweenService:Create(choc, TweenInfo.new(0.45, Enum.EasingStyle.Back), {ImageTransparency = 0, Size = UDim2.new(0.9,0,0.9,0)}):Play()
            else
                TweenService:Create(wrapper, TweenInfo.new(0.35), {ImageTransparency = 0}):Play()
                TweenService:Create(choc, TweenInfo.new(0.3), {ImageTransparency = 1, Size = UDim2.new(0.75,0,0.75,0)}):Play()
            end
            
            print("🍫 " .. (on and "ON" or "OFF") .. " → " .. text)
        end
    end)
end

-- Ajout des toggles
CreateKinderToggle("🔴 Auto Farm Exp")
CreateKinderToggle("⚔️ Kill Aura")
CreateKinderToggle("🚀 Speed Hack")
CreateKinderToggle("👻 Noclip")
CreateKinderToggle("💰 Auto Farm Money")
CreateKinderToggle("🍎 Auto Fruit Harvest")
CreateKinderToggle("🪙 Auto Coin Collect")
CreateKinderToggle("🎯 Aim Bot")

UserInputService.InputBegan:Connect(function(i)
    if i.KeyCode == Enum.KeyCode.Insert then
        main.Enabled = not main.Enabled
    end
end)

print("🍫 KinderzHub chargé ! Appuie sur INSERT")
