print("Remember to join our discord! https://discord.gg/UXgGqZ7w3v (copied to clipboard)")
setclipboard("https://discord.gg/UXgGqZ7w3v")
if game.PlaceId == 111452220770252 then
   local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "Flyxo Hub",
   Icon = 0,
   LoadingTitle = "Loading Flyxo Hub..",
   LoadingSubtitle = "by yxc.f",
   Theme = "Default",
   DisableRayfieldPrompts = false,
   DisableBuildWarnings = false,
   ConfigurationSaving = {Enabled = true, FolderName = nil, FileName = "Big Hub"},
   Discord = {Enabled = true, Invite = "UXgGqZ7w3v", RememberJoins = true},
   KeySystem = false,
   KeySettings = {Title = "Untitled", Subtitle = "Key System", Note = "No method of obtaining the key is provided", FileName = "Key", SaveKey = true, GrabKeyFromSite = false, Key = {"Hello"}}
})

local Tab = Window:CreateTab("Main", 4483362458)

local player = game.Players.LocalPlayer
local target = game.Workspace.Gubbies

local variants = {"RegularGubby", "FatGubby", "PancakeGubby", "StormcellGubby"}
local function getGubby()
    for _, name in ipairs(variants) do
        if target:FindFirstChild(name) then
            return target[name]
        end
    end
    return nil
end

local voidDamage = game:GetService("ReplicatedStorage").Networking.Server.RemoteEvents.DamageEvents.VoidDamage
local airstrikeDamage = game:GetService("ReplicatedStorage").Networking.Server.RemoteEvents.DamageEvents.AirstrikeDamage
local smiteDamage = game:GetService("ReplicatedStorage").Networking.Server.RemoteEvents.DamageEvents.SmiteDamage
local physicsDamage = game:GetService("ReplicatedStorage").Networking.Server.RemoteEvents.DamageEvents.PhysicsDamage
local foodDamage = game:GetService("ReplicatedStorage").Networking.Server.RemoteEvents.DamageEvents.FoodDamage
local purchaseGas = game:GetService("ReplicatedStorage").Networking.Server.RemoteEvents.PurchaseGas

local mainAnchored = false
local fuelRunning = false
local infDamageRunning = false

local function anchorchildren(model)
    for _, child in pairs(model:GetChildren()) do
        if child:IsA("BasePart") then
            child.Anchored = mainAnchored
        elseif #child:GetChildren() > 0 then
            anchorchildren(child)
        end
    end
end

Tab:CreateToggle({
   Name = "Anchor Main Gubby",
   CurrentValue = false,
   Flag = "AnchorMainGubby",
   Callback = function(value)
       mainAnchored = value
       local gubby = getGubby()
       if gubby then
           if gubby:FindFirstChild("RootPart") then
               gubby.RootPart.Anchored = mainAnchored
           end
           anchorchildren(gubby)
       end
   end
})

Tab:CreateToggle({
   Name = "Auto Refill Fuel",
   CurrentValue = false,
   Flag = "AutoRefillFuel",
   Callback = function(value)
       fuelRunning = value
       if fuelRunning then
           task.spawn(function()
               while fuelRunning do
                   purchaseGas:FireServer(10)
                   task.wait()
               end
           end)
       end
   end
})

Tab:CreateToggle({
   Name = "Auto Farm (~700k/s)",
   CurrentValue = false,
   Flag = "InfDamage",
   Callback = function(value)
       infDamageRunning = value
       if infDamageRunning then
           task.spawn(function()
               while infDamageRunning do
                   voidDamage:FireServer(Vector3.new(999, 999, 999))
                   airstrikeDamage:FireServer(Vector3.new(999, 999, 999), 3.11)
                   smiteDamage:FireServer(Vector3.new(999, 999, 999))
                   physicsDamage:FireServer(333.54, Vector3.new(999, 999, 999))
                   foodDamage:FireServer("CherryBomb", Vector3.new(999, 999, 999))
                   foodDamage:FireServer("RatPoison", Vector3.new(999, 999, 999))
                   task.wait()
               end
           end)
       end
   end
})

local TabOthers = Window:CreateTab("Others", 4483362458)

local function getCurrentGubby()
    return getGubby()
end

TabOthers:CreateButton({
    Name = "Burn Gubby",
    Callback = function()
        local gubby = getCurrentGubby()
        if gubby and gubby:FindFirstChild("GubbyEvents") then
            local burnEvent = gubby.GubbyEvents:FindFirstChild("Burn")
            if burnEvent then
                burnEvent:Fire()
            end
        end
    end
})

TabOthers:CreateButton({
    Name = "Knockout Gubby",
    Callback = function()
        local gubby = getCurrentGubby()
        if gubby and gubby:FindFirstChild("GubbyEvents") then
            local koEvent = gubby.GubbyEvents:FindFirstChild("KnockOut")
            if koEvent then
                koEvent:Fire()
            end
        end
    end
})

TabOthers:CreateButton({
    Name = "Ragdoll Gubby",
    Callback = function()
        local gubby = getCurrentGubby()
        if gubby and gubby:FindFirstChild("GubbyEvents") then
            local rdEvent = gubby.GubbyEvents:FindFirstChild("Ragdoll")
            if rdEvent then
                rdEvent:Fire()
            end
        end
    end
})

local soundsDisabled = false
local moneyLoop = nil

TabOthers:CreateToggle({
    Name = "Disable Money SFX",
    CurrentValue = false,
    Flag = "DisableMoneySFX",
    Callback = function(value)
        soundsDisabled = value
        if soundsDisabled then
            if moneyLoop then
                task.cancel(moneyLoop)
            end
            moneyLoop = task.spawn(function()
                while soundsDisabled do
                    local soundsFolder = game.ReplicatedStorage.GameAssets.Sounds
                    if soundsFolder:FindFirstChild("Money1") then
                        soundsFolder.Money1:Destroy()
                    end
                    if soundsFolder:FindFirstChild("Money2") then
                        soundsFolder.Money2:Destroy()
                    end
                    task.wait(0.1)
                end
            end)
        else
            if moneyLoop then
                task.cancel(moneyLoop)
                moneyLoop = nil
            end
            local soundsFolder = game.ReplicatedStorage.GameAssets.Sounds
            if not soundsFolder:FindFirstChild("Money1") then
                local money1 = Instance.new("Sound")
                money1.Name = "Money1"
                money1.SoundId = "rbxassetid://129494277155167"
                money1.Parent = soundsFolder
            end
            if not soundsFolder:FindFirstChild("Money2") then
                local money2 = Instance.new("Sound")
                money2.Name = "Money2"
                money2.SoundId = "rbxassetid://102263010330745"
                money2.Parent = soundsFolder
            end
        end
    end
})

else
   warn("Game not supported. Please join one of our supported games, it's on our Discord (https://discord.gg/UXgGqZ7w3v)")
end
