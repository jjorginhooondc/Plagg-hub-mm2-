local WindUI = loadstring(game:HttpGet("https://github.com/Footagesus/WindUI/releases/latest/download/main.lua"))()
local plrs = game:GetService("Players")
local me = plrs.LocalPlayer
local TS = game:GetService("TweenService")

local s = {esp=false, gun=false, trap=false, grab=false, sa=false, farm=false, flee=false, fleeDist=30, reset=false, farmSpeed=25}
local tracked = {ESP_Player={}, ESP_Gun={}, ESP_Trap={}}

local function role(p)
    local c, b = p.Character, p:FindFirstChild("Backpack")
    if (c and c:FindFirstChild("Knife")) or (b and b:FindFirstChild("Knife")) then return "Murderer", Color3.fromRGB(255,60,60) end
    if (c and c:FindFirstChild("Gun")) or (b and b:FindFirstChild("Gun")) then return "Sheriff", Color3.fromRGB(60,120,255) end
    return "Innocent", Color3.fromRGB(60,255,100)
end

local function label(part, name, txt, col)
    if not part or not part.Parent then return end
    local g = part:FindFirstChild(name)
    if not g then
        g = Instance.new("BillboardGui", part)
        g.Name = name
        g.Size = UDim2.new(0,120,0,30)
        g.StudsOffset = Vector3.new(0,2.5,0)
        g.AlwaysOnTop = true
        g.Adornee = part
        local t = Instance.new("TextLabel", g)
        t.Name = "T"
        t.Size = UDim2.new(1,0,1,0)
        t.BackgroundTransparency = 1
        t.TextScaled = true
        t.Font = Enum.Font.GothamBold
        t.TextStrokeTransparency = 0
        tracked[name][g] = true
    end
    if g.T.Text ~= txt then g.T.Text = txt end
    g.T.TextColor3 = col
end

local function glow(char, name, col)
    if not char then return end
    local h = char:FindFirstChild(name)
    if not h then
        h = Instance.new("Highlight", char)
        h.Name = name
        h.FillTransparency = 0.5
        h.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
        tracked[name][h] = true
    end
    h.FillColor = col
    h.OutlineColor = col
end

local function clear(name)
    for o in pairs(tracked[name]) do pcall(function() o:Destroy() end) end
    tracked[name] = {}
end

local function murd()
    for _, p in ipairs(plrs:GetPlayers()) do
        if p ~= me and p.Character and role(p) == "Murderer" then return p end
    end
end

local traps, coins, gunPart = {}, {}, nil
local function scan(v)
    if v.Name == "Trap" and v:IsA("BasePart") then traps[v] = true
    elseif v.Name == "Coin_Server" and v:IsA("BasePart") then coins[v] = true
    elseif v.Name == "GunDrop" then gunPart = v end
end
for _, v in ipairs(workspace:GetDescendants()) do scan(v) end
workspace.DescendantAdded:Connect(scan)
workspace.DescendantRemoving:Connect(function(v)
    traps[v] = nil
    coins[v] = nil
    if v == gunPart then gunPart = nil end
end)

-- ESP + Auto Grab
task.spawn(function()
    while task.wait(1) do
        if s.esp then
            for _, p in ipairs(plrs:GetPlayers()) do
                if p ~= me and p.Character then
                    local r, c = role(p)
                    label(p.Character:FindFirstChild("HumanoidRootPart"), "ESP_Player", p.Name.." ["..r.."]", c)
                    glow(p.Character, "ESP_Player", c)
                end
            end
        end
        if s.gun and gunPart then label(gunPart, "ESP_Gun", "Dropped Gun", Color3.fromRGB(255,220,0)) end
        if s.trap then
            for t in pairs(traps) do label(t, "ESP_Trap", "Trap", Color3.fromRGB(255,140,0)) end
        end
        if s.grab and gunPart then
            local hrp = me.Character and me.Character:FindFirstChild("HumanoidRootPart")
            if hrp then
                local o = hrp.CFrame
                if firetouchinterest then
                    firetouchinterest(hrp, gunPart, 0)
                    firetouchinterest(hrp, gunPart, 1)
                else
                    hrp.CFrame = gunPart.CFrame
                    task.wait(0.25)
                    hrp.CFrame = o
                end
            end
        end
    end
end)

-- Bag full detection
local bagFull = false

task.spawn(function()
    local ok, ev = pcall(function()
        return game:GetService("ReplicatedStorage"):WaitForChild("Remotes", 10):WaitForChild("Gameplay", 10):WaitForChild("CoinCollected", 10)
    end)
    if ok and ev then
        ev.OnClientEvent:Connect(function(_, cur, max)
            if type(cur) == "number" and type(max) == "number" then
                bagFull = cur >= max
            end
        end)
    end
end)

me.CharacterAdded:Connect(function() bagFull = false end)

-- Coin autofarm (adjustable speed)
local curTween

local function stopFarm()
    if curTween then curTween:Cancel() curTween = nil end
end

task.spawn(function()
    while task.wait(0.1) do
        local char = me.Character
        local hum = char and char:FindFirstChildOfClass("Humanoid")
        local hrp = char and char:FindFirstChild("HumanoidRootPart")
        if s.farm and not bagFull and hum and hum.Health > 0 and hrp then
            local best, d = nil, math.huge
            for c in pairs(coins) do
                if c.Parent then
                    local m = (c.Position - hrp.Position).Magnitude
                    if m < d then best, d = c, m end
                end
            end
            if best then
                local t = TS:Create(hrp, TweenInfo.new(d / s.farmSpeed, Enum.EasingStyle.Linear), {CFrame = best.CFrame})
                curTween = t
                local finished = false
                t.Completed:Connect(function(state)
                    finished = state == Enum.PlaybackState.Completed
                end)
                t:Play()
                while t.PlaybackState == Enum.PlaybackState.Playing do
                    if not s.farm or bagFull or hum.Health <= 0 then
                        t:Cancel()
                        break
                    end
                    task.wait(0.05)
                end
                curTween = nil
                if finished then coins[best] = nil end
            end
        else
            stopFarm()
        end
    end
end)

-- Auto End Run (resets character when bag is full)
task.spawn(function()
    while task.wait(0.5) do
        if s.reset and bagFull then
            local hum = me.Character and me.Character:FindFirstChildOfClass("Humanoid")
            if hum and hum.Health > 0 then
                stopFarm()
                hum.Health = 0
            end
        end
    end
end)

-- Auto Escape
local lastFlee = 0
task.spawn(function()
    while task.wait(0.1) do
        if s.flee then
            local char = me.Character
            local hrp = char and char:FindFirstChild("HumanoidRootPart")
            local m = murd()
            local mh = m and m.Character and m.Character:FindFirstChild("HumanoidRootPart")
            if hrp and mh and (mh.Position - hrp.Position).Magnitude <= s.fleeDist and tick() - lastFlee > 1.5 then
                lastFlee = tick()
                stopFarm()

                local dest, far = nil, 0
                for c in pairs(coins) do
                    if c.Parent then
                        local dd = (c.Position - mh.Position).Magnitude
                        if dd > far then dest, far = c.Position, dd end
                    end
                end
                if not dest then
                    local dir = (hrp.Position - mh.Position).Unit
                    dest = hrp.Position + dir * 70
                end
                hrp.AssemblyLinearVelocity = Vector3.zero
                hrp.CFrame = CFrame.new(dest + Vector3.new(0, 3, 0))
            end
        end
    end
end)

-- Aimbot
pcall(function() game:GetService("RunService"):UnbindFromRenderStep("PlaggAim") end)
game:GetService("RunService"):BindToRenderStep("PlaggAim", Enum.RenderPriority.Camera.Value + 1, function()
    if not s.sa then return end
    local c = workspace.CurrentCamera
    local m = murd()
    local hrp = m and m.Character and m.Character:FindFirstChild("HumanoidRootPart")
    if hrp then
        local pos = hrp.Position + hrp.AssemblyLinearVelocity * 0.13
        c.CFrame = CFrame.new(c.CFrame.Position, pos)
    end
end)

-- GUI
WindUI:AddTheme{
    Name = "PurpleTheme",
    Accent = Color3.fromRGB(149,51,255),
    Outline = Color3.fromRGB(88,58,195),
    Text = Color3.fromRGB(255,255,255),
    PlaceholderText = Color3.fromRGB(168,95,255),
    Background = Color3.fromRGB(12,92,28),
    Secondary = Color3.fromRGB(22,95,45),
    Tertiary = Color3.fromRGB(38,20,60)
}

local win = WindUI:CreateWindow{
    Title = "Plagg Hub",
    Size = UDim2.fromOffset(450,300),
    Transparent = true,
    Theme = "PurpleTheme",
    SideBarWidth = 140,
    HasOutline = false,
    ToggleOutline = false
}

win:Tag{Title="v1.0", Color=Color3.fromRGB(107,132,212)}

local main = win:Tab{Title="Main", Icon="book"}
local vis = win:Tab{Title="Visual", Icon="eye"}
main:Select()

vis:Toggle{Title="ESP Players", Desc="Name + role + highlight", Value=false,
    Callback=function(v) s.esp=v if not v then clear("ESP_Player") end end}
vis:Toggle{Title="ESP Dropped Gun", Value=false,
    Callback=function(v) s.gun=v if not v then clear("ESP_Gun") end end}
vis:Toggle{Title="ESP Traps", Value=false,
    Callback=function(v) s.trap=v if not v then clear("ESP_Trap") end end}

main:Toggle{Title="Auto Grab Gun", Value=false, Callback=function(v) s.grab=v end}
main:Toggle{Title="Autofarm Coins", Desc="Collects the nearest coin", Value=false, Callback=function(v)
    s.farm = v
    if not v then stopFarm() end
end}
main:Slider{Title="Farm Speed", Desc="Studs per second", Value={Min=1, Max=25, Default=25}, Step=1, Callback=function(v) s.farmSpeed=v end}
main:Toggle{Title="Auto End Run", Desc="Resets your character when the bag is full", Value=false, Callback=function(v) s.reset=v end}
main:Toggle{Title="Auto Escape", Desc="Teleports away when the Murderer is close", Value=false, Callback=function(v) s.flee=v end}
main:Slider{Title="Escape Distance", Desc="In studs", Value={Min=10, Max=100, Default=30}, Step=1, Callback=function(v) s.fleeDist=v end}

-- Aimbot button (draggable black square)
local guiParent = (gethui and gethui()) or game:GetService("CoreGui")

local btnGui = Instance.new("ScreenGui")
btnGui.Name = "AimbotBtn"
btnGui.ResetOnSpawn = false
btnGui.Enabled = false
btnGui.Parent = guiParent

local btn = Instance.new("TextButton")
btn.Size = UDim2.new(0,80,0,80)
btn.Position = UDim2.new(0.8,0,0.4,0)
btn.BackgroundColor3 = Color3.new(0,0,0)
btn.BackgroundTransparency = 0.15
btn.BorderSizePixel = 0
btn.Font = Enum.Font.GothamBold
btn.TextSize = 14
btn.TextWrapped = true
btn.Active = true
btn.Draggable = true
btn.Parent = btnGui

local function setAim(v)
    s.sa = v
    btn.Text = "aimbot murder\n" .. (v and "ON" or "OFF")
    btn.TextColor3 = v and Color3.fromRGB(60,255,100) or Color3.fromRGB(255,60,60)
end
setAim(false)

btn.MouseButton1Click:Connect(function() setAim(not s.sa) end)

main:Toggle{Title="Aimbot Murderer", Desc="Shows a button to turn the aimbot on/off", Value=false, Callback=function(v)
    btnGui.Enabled = v
    if not v then setAim(false) end
end}
