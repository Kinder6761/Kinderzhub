-- =========================
-- PATCH KINDERZHUB FIX
-- =========================

-- AJOUTER EN HAUT :
local Workspace = game:GetService("Workspace")

local function NormalizeFeatureName(name)
    name = name:gsub("[^\32-\126]", "")
    name = name:gsub("%s+", " ")
    name = name:gsub("^%s+", "")
    name = name:gsub("%s+$", "")
    return name:gsub(" ", "_")
end

-- =========================
-- REMPLACER FindObjectByName
-- =========================

local function FindObjectByName(name, maxDistance)
    maxDistance = maxDistance or 500

    local nearest = nil
    local nearestDist = maxDistance

    for _, obj in ipairs(Workspace:GetDescendants()) do
        if string.find(string.lower(obj.Name), string.lower(name)) then

            local pos = nil

            if obj:IsA("BasePart") then
                pos = obj.Position

            elseif obj:FindFirstChild("HumanoidRootPart") then
                pos = obj.HumanoidRootPart.Position
            end

            if pos then
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

-- =========================
-- AJOUTER CETTE FONCTION
-- =========================

local function StopCoroutine(name)
    if UIState.RunningCoroutines[name] then
        task.cancel(UIState.RunningCoroutines[name])
        UIState.RunningCoroutines[name] = nil
    end
end

-- =========================
-- REMPLACER DANS CreateToggle
-- =========================

-- ANCIEN :
-- local featureKey = categoryKey .. "_" .. featureName:gsub(" ", "_")

-- NOUVEAU :
local cleanName = NormalizeFeatureName(featureName)
local featureKey = categoryKey .. "_" .. cleanName

-- =========================
-- REMPLACER LE DRAG
-- =========================

main.Position = UDim2.new(
    startPos.X.Scale,
    startPos.X.Offset + delta.X,
    startPos.Y.Scale,
    startPos.Y.Offset + delta.Y
)

-- =========================
-- REMPLACER AutoDodge
-- =========================

local vec = Vector3.new(
    math.random(-50,50)/50,
    0,
    math.random(-50,50)/50
)

local randomDir

if vec.Magnitude > 0 then
    randomDir = vec.Unit
else
    randomDir = Vector3.new(1,0,0)
end

hrp.AssemblyLinearVelocity = randomDir * 50

-- =========================
-- REMPLACER LES TP
-- =========================

-- ANCIEN :
-- hrp.CFrame = mob:FindFirstChild("HumanoidRootPart").CFrame + Vector3.new(0, 3, 10)

-- NOUVEAU :
hrp.CFrame = mob.HumanoidRootPart.CFrame * CFrame.new(0, 3, 10)

-- =========================
-- REMPLACER GODMODE
-- =========================

humanoid.Health = humanoid.MaxHealth

-- =========================
-- REMPLACER STAMINA
-- =========================

if char:FindFirstChild("Stamina") then
    char.Stamina.Value = 999999
end

-- =========================
-- REMPLACER DELETE KEY
-- =========================

for _, thread in pairs(UIState.RunningCoroutines) do
    task.cancel(thread)
end

UIState.RunningCoroutines = {}

screenGui:Destroy()

-- =========================
-- REMPLACER ExecuteFeature
-- =========================

function ExecuteFeature(featureKey, isEnabled)

    local category, rawFeature = featureKey:match("^(.-)_(.+)$")

    if not category or not rawFeature then
        return
    end

    local featureName = rawFeature:gsub("_", " ")

    if category == "FARMING" then

        if featureName == "Auto Farm Exp" then
            AutoFarmExp(isEnabled)

        elseif featureName == "Auto Farm Money" then
            AutoFarmMoney(isEnabled)

        elseif featureName == "Auto Fruit Harvest" then
            AutoFruitHarvest(isEnabled)

        elseif featureName == "Auto Level Up" then
            AutoLevelUp(isEnabled)

        elseif featureName == "Auto Quest" then
            AutoQuest(isEnabled)

        elseif featureName == "Auto Coin Collect" then
            AutoCoinCollect(isEnabled)
        end

    elseif category == "COMBAT" then

        if featureName == "Kill Aura" then
            KillAura(isEnabled)

        elseif featureName == "Aim Bot" then
            AimBot(isEnabled)

        elseif featureName == "Auto Skills" then
            AutoSkills(isEnabled)

        elseif featureName == "Auto Dodge" then
            AutoDodge(isEnabled)

        elseif featureName == "Target Closest" then
            TargetClosest(isEnabled)
        end

    elseif category == "COLLECTION" then

        if featureName == "Auto Coin Pickup" then
            AutoCoinPickup(isEnabled)

        elseif featureName == "Auto Diamond Pickup" then
            AutoDiamondPickup(isEnabled)

        elseif featureName == "Auto Item Pickup" then
            AutoItemPickup(isEnabled)

        elseif featureName == "Auto Chest Open" then
            AutoChestOpen(isEnabled)
        end

    elseif category == "TOOLS" then

        if featureName == "Speed Hack" then
            SpeedHack(isEnabled)

        elseif featureName == "Jump Hack" then
            JumpHack(isEnabled)

        elseif featureName == "Noclip" then
            Noclip(isEnabled)

        elseif featureName == "God Mode" then
            GodMode(isEnabled)

        elseif featureName == "Infinite Stamina" then
            InfiniteStamina(isEnabled)

        elseif featureName == "Anti Stun" then
            AntiStun(isEnabled)
        end
    end
end

