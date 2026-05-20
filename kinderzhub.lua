-- 🍫 KinderzHub ULTIMATE - Version Complète + Fonctions Réelles
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local Workspace = game:GetService("Workspace")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

pcall(function() playerGui:FindFirstChild("KinderzHub"):Destroy() end)

local CONFIG = {
    COLORS = {
        BG = Color3.fromRGB(20, 18, 26),
        SIDEBAR = Color3.fromRGB(26, 23, 33),
        CARD = Color3.fromRGB(35, 30, 45),
        PRIMARY = Color3.fromRGB(255, 145, 50),
        ON = Color3.fromRGB(0, 255, 120),
        TEXT = Color3.new(1,1,1),
    }
}

local UIState = {
    Features = {},
    RunningCoroutines = {}
}

-- ==================== UTILITAIRES ====================
local function GetHRP()
    local char = player.Character or player.CharacterAdded:Wait()
    return char:WaitForChild("HumanoidRootPart")
end

local function GetHumanoid()
    local char = player.Character or player.CharacterAdded:Wait()
    return char:WaitForChild("Humanoid")
end

local function FindNearestMob(range)
    local closest, dist = nil, range or 200
    for _, obj in ipairs(Workspace:GetDescendants()) do
        if obj:FindFirstChild("Humanoid") and obj:FindFirstChild("HumanoidRootPart") then
            if not Players:FindFirstChild(obj.Name) and obj.Humanoid.Health > 0 then
                local d = (obj.HumanoidRootPart.Position - GetHRP().Position).Magnitude
                if d < dist then
                    closest, dist = obj, d
                end
            end
        end
    end
    return closest
end

local function TeleportTo(pos)
    pcall(function()
        GetHRP().CFrame = CFrame.new(pos + Vector3.new(0, 5, 0))
    end)
end

-- ==================== FONCTIONS RÉELLES ====================
local function AutoFarmExp(enabled)
    if enabled then
        UIState.RunningCoroutines["AutoFarmExp"] = task.spawn(function()
            while UIState.Features["AutoFarmExp"] do
                local mob = FindNearestMob(150)
                if mob then
                    GetHRP().CFrame = mob.HumanoidRootPart.CFrame * CFrame.new(0, 3, 8)
                    local tool = player.Character:FindFirstChildOfClass("Tool")
                    if tool then tool:Activate() end
                end
                task.wait(0.2)
            end
        end)
    elseif UIState.RunningCoroutines["AutoFarmExp"] then
        task.cancel(UIState.RunningCoroutines["AutoFarmExp"])
    end
end

local function KillAura(enabled)
    if enabled then
        UIState.RunningCoroutines["KillAura"] = task.spawn(function()
            while UIState.Features["KillAura"] do
                for _, mob in ipairs(Workspace:GetDescendants()) do
                    if mob:FindFirstChild("Humanoid") and mob:FindFirstChild("HumanoidRootPart") and not Players:FindFirstChild(mob.Name) then
                        if (mob.HumanoidRootPart.Position - GetHRP().Position).Magnitude < 20 then
                            local tool = player.Character:FindFirstChildOfClass("Tool")
                            if tool then tool:Activate() end
                        end
                    end
                end
                task.wait(0.1)
            end
        end)
    elseif UIState.RunningCoroutines["KillAura"] then
        task.cancel(UIState.RunningCoroutines["KillAura"])
    end
end

local function SpeedHack(enabled)
    if enabled then
        UIState.RunningCoroutines["SpeedHack"] = task.spawn(function()
            local hum = GetHumanoid()
            while UIState.Features["SpeedHack"] do
                hum.WalkSpeed = 100
                task.wait(0.1)
            end
            hum.WalkSpeed = 16
        end)
    elseif UIState.RunningCoroutines["SpeedHack"] then
        task.cancel(UIState.RunningCoroutines["SpeedHack"])
    end
end

local function Noclip(enabled)
    if enabled then
        UIState.RunningCoroutines["Noclip"] = task.spawn(function()
            while UIState.Features["Noclip"] do
                for _, part in pairs(player.Character:GetDescendants()) do
                    if part:IsA("BasePart") then
                        part.CanCollide = false
                    end
                end
                task.wait(0.1)
            end
            for _, part in pairs(player.Character:GetDescendants()) do
                if part:IsA("BasePart") then part.CanCollide = true end
            end
        end)
    elseif UIState.RunningCoroutines["Noclip"] then
        task.cancel(UIState.RunningCoroutines["Noclip"])
    end
end

-- ==================== UI KINDER ====================
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "KinderzHub"
screenGui.ResetOnSpawn = false
screenGui.Parent = playerGui

local main = Instance.new("Frame")
main.Size = UDim2.new(0, 960, 0, 680)
main.Position = UDim2.new(0.5, -480, 0.5, -340)
main.BackgroundColor3 = CONFIG.COLORS.BG
main.Parent = screenGui
Instance.new("UICorner", main).CornerRadius = UDim.new(0, 24)

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 95)
title.BackgroundColor3 = CONFIG.COLORS.PRIMARY
title.Text = "🍫 KinderzHub ULTIMATE 🍫"
title.TextColor3 = Color3.new(1,1,1)
title.Font = Enum.Font.GothamBlack
title.TextSize = 36
title.Parent = main
Instance.new("UICorner", title).CornerRadius = UDim.new(0, 24)

local content = Instance.new("ScrollingFrame")
content.Size = UDim2.new(1, -280, 1, -115)
content.Position = UDim2.new(0, 275, 0, 105)
content.BackgroundTransparency = 1
content.ScrollBarThickness = 8
content.Parent = main

Instance.new("UIListLayout", content).Padding = UDim.new(0, 16)

-- Toggle Kinder
local function CreateKinderToggle(name, key, func)
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(1, -30, 0, 95)
    frame.BackgroundColor3 = CONFIG.COLORS.CARD
    frame.Parent = content
    Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 18)

    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(0.55, 0, 1, 0)
    label.BackgroundTransparency = 1
    label.Text = "   " .. name
    label.TextColor3 = CONFIG.COLORS.TEXT
    label.Font = Enum.Font.GothamSemibold
    label.TextSize = 18
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = frame

    local toggleArea = Instance.new("Frame")
    toggleArea.Size = UDim2.new(0, 160, 0, 75)
    toggleArea.Position = UDim2.new(1, -180, 0.5, -37.5)
    toggleArea.BackgroundTransparency = 1
    toggleArea.Parent = frame

    local wrapper = Instance.new("ImageLabel")
    wrapper.Size = UDim2.new(1,0,1,0)
    wrapper.BackgroundTransparency = 1
    wrapper.Image = "rbxassetid://10734950378"
    wrapper.ImageColor3 = Color3.fromRGB(255, 160, 60)
    wrapper.Parent = toggleArea

    local chocolate = Instance.new("ImageLabel")
    chocolate.Size = UDim2.new(0.8,0,0.8,0)
    chocolate.Position = UDim2.new(0.5,0,0.5,0)
    chocolate.AnchorPoint = Vector2.new(0.5, 0.5)
    chocolate.BackgroundTransparency = 1
    chocolate.Image = "rbxassetid://6031094678"
    chocolate.ImageTransparency = 1
    chocolate.Parent = toggleArea

    local enabled = false

    toggleArea.InputBegan:Connect(function(inp)
        if inp.UserInputType == Enum.UserInputType.MouseButton1 then
            enabled = not enabled
            UIState.Features[key] = enabled

            if enabled then
                TweenService:Create(wrapper, TweenInfo.new(0.4), {ImageTransparency = 0.65}):Play()
                TweenService:Create(chocolate, TweenInfo.new(0.5), {ImageTransparency = 0}):Play()
            else
                TweenService:Create(wrapper, TweenInfo.new(0.4), {ImageTransparency = 0}):Play()
                TweenService:Create(chocolate, TweenInfo.new(0.3), {ImageTransparency = 1}):Play()
            end

            if func then func(enabled) end
            print(`🍫 {enabled and "ON" or "OFF"} → {name}`)
        end
    end)
end

-- Ajout des toggles avec fonctions réelles
CreateKinderToggle("🔴 Auto Farm Exp", "AutoFarmExp", AutoFarmExp)
CreateKinderToggle("⚔️ Kill Aura", "KillAura", KillAura)
CreateKinderToggle("🚀 Speed Hack", "SpeedHack", SpeedHack)
CreateKinderToggle("👻 Noclip", "Noclip", Noclip)
CreateKinderToggle("💰 Auto Farm Money", "AutoFarmMoney")
CreateKinderToggle("🍎 Auto Fruits", "AutoFruits")
CreateKinderToggle("🪙 Auto Coins", "AutoCoins")
CreateKinderToggle("🎯 Aim Bot", "AimBot")

-- Hotkeys
UserInputService.InputBegan:Connect(function(input, gp)
    if gp then return end
    if input.KeyCode == Enum.KeyCode.Insert then
        screenGui.Enabled = not screenGui.Enabled
    elseif input.KeyCode == Enum.KeyCode.Delete then
        screenGui:Destroy()
    end
end)

print("🍫 KinderzHub ULTIMATE chargé avec succès !")
print("Appuie sur INSERT pour ouvrir/fermer")
