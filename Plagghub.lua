local ui = loadstring(game:HttpGet("https://github.com/Footagesus/WindUI/releases/latest/download/main.lua"))()
local P = game:GetService("Players")
local TS = game:GetService("TweenService")
local RS = game:GetService("ReplicatedStorage")
local VU = game:GetService("VirtualUser")
local me = P.LocalPlayer

local o = {esp=false, gun=false, trap=false, grab=false, sa=false, farm=false, reset=false, spd=25, dbg=false}
local made = {ESP_Player={}, ESP_Gun={}, ESP_Trap={}}
local RED, BLUE, GREEN = Color3.fromRGB(255,60,60), Color3.fromRGB(60,120,255), Color3.fromRGB(60,255,100)
local coins, traps, drop = {}, {}, nil
local roles, ready = {}, false
local full, tw, mPart = false, nil, nil

local function setRoles(d)
    if type(d) ~= "table" then return end
    if next(d) then
        local ok = false
        for _, v in pairs(d) do
            if type(v) == "table" and v.Role then ok = true break end
        end
        if not ok then return end
    end
    roles, ready = d, true
end

task.spawn(function()
    local ev, fn
    for _ = 1, 30 do
        ev = ev or RS:FindFirstChild("PlayerDataChanged", true)
        fn = fn or RS:FindFirstChild("GetPlayerData", true)
        if ev and fn then break end
        task.wait(1)
    end
    if ev and ev:IsA("RemoteEvent") then ev.OnClientEvent:Connect(setRoles) end
    if fn and fn:IsA("RemoteFunction") then
        while task.wait(2) do
            if o.esp or o.farm or o.sa or o.reset then
                local ok, d = pcall(fn.InvokeServer, fn)
                if ok then setRoles(d) end
            end
        end
    end
end)

local function role(p)
    local d = roles[p.Name]
    local r = type(d) == "table" and d.Role
    if r == "Murderer" then return "Murderer", RED end
    if r == "Sheriff" or r == "Hero" then return r, BLUE end
    if r then return "Innocent", GREEN end
    local c, b = p.Character, p:FindFirstChild("Backpack")
    if (c and c:FindFirstChild("Knife")) or (b and b:FindFirstChild("Knife")) then return "Murderer", RED end
    if (c and c:FindFirstChild("Gun")) or (b and b:FindFirstChild("Gun")) then return "Sheriff", BLUE end
    return "Innocent", GREEN
end

local function murd()
    for _, p in ipairs(P:GetPlayers()) do
        if p ~= me and p.Character and role(p) == "Murderer" then return p end
    end
end

local function tag(part, id, txt, col)
    if not part or not part.Parent then return end
    local g = part:FindFirstChild(id)
    if not g then
        g = Instance.new("BillboardGui", part)
        g.Name = id
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
        made[id][g] = true
    end
    local t = g.T
    if t.Text ~= txt then t.Text = txt end
    if t.TextColor3 ~= col then t.TextColor3 = col end
end

local function glow(char, id, col)
    local h = char:FindFirstChild(id)
    if not h then
        h = Instance.new("Highlight", char)
        h.Name = id
        h.FillTransparency = 0.5
        h.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
        made[id][h] = true
    end
    if h.FillColor ~= col then
        h.FillColor = col
        h.OutlineColor = col
    end
end

local function clear(id)
    for v in pairs(made[id]) do pcall(v.Destroy, v) end
    made[id] = {}
end

local function scan(v)
    local n = v.Name
    if n == "Coin_Server" and v:IsA("BasePart") then coins[v] = true
    elseif n == "Trap" and v:IsA("BasePart") then traps[v] = true
    elseif n == "GunDrop" then drop = v end
end
for _, v in ipairs(workspace:GetDescendants()) do scan(v) end
workspace.DescendantAdded:Connect(scan)
workspace.DescendantRemoving:Connect(function(v)
    coins[v], traps[v] = nil, nil
    if v == drop then drop = nil end
end)

local function inRound()
    if not next(coins) then return false end
    if not ready then return true end
    local d = roles[me.Name]
    return type(d) == "table" and d.Role ~= nil and not d.Dead
end

task.spawn(function()
    while task.wait(0.5) do
        if o.esp then
            for _, p in ipairs(P:GetPlayers()) do
                local c = p ~= me and p.Character
                local d = roles[p.Name]
                if c and not (type(d) == "table" and d.Dead) then
                    local r, col = role(p)
                    tag(c:FindFirstChild("HumanoidRootPart"), "ESP_Player", p.Name.." ["..r.."]", col)
                    glow(c, "ESP_Player", col)
                end
            end
        end
        if o.gun and drop then tag(drop, "ESP_Gun", "Dropped Gun", Color3.fromRGB(255,220,0)) end
        if o.trap then
            for t in pairs(traps) do tag(t, "ESP_Trap", "Trap", Color3.fromRGB(255,140,0)) end
        end
    end
end)

task.spawn(function()
    while task.wait(0.1) do
        if o.grab and drop and drop.Parent and drop:IsA("BasePart") then
            local hrp = me.Character and me.Character:FindFirstChild("HumanoidRootPart")
            if hrp then
                if firetouchinterest then
                    firetouchinterest(hrp, drop, 0)
                    firetouchinterest(hrp, drop, 1)
                else
                    local old = hrp.CFrame
                    hrp.CFrame = drop.CFrame
                    task.wait(0.15)
                    hrp.CFrame = old
                end
            end
        end
    end
end)

task.spawn(function()
    local ok, ev = pcall(function()
        return RS:WaitForChild("Remotes", 10):WaitForChild("Gameplay", 10):WaitForChild("CoinCollected", 10)
    end)
    if ok and ev then
        ev.OnClientEvent:Connect(function(_, cur, max)
            if type(cur) == "number" and type(max) == "number" then full = cur >= max end
        end)
    end
end)
me.CharacterAdded:Connect(function() full = false end)

local function stop()
    if tw then tw:Cancel() tw = nil end
end

task.spawn(function()
    while task.wait(0.1) do
        local char = me.Character
        local hum = char and char:FindFirstChildOfClass("Humanoid")
        local hrp = char and char:FindFirstChild("HumanoidRootPart")
        if o.farm and not full and hum and hum.Health > 0 and hrp and inRound() then
            local best, d = nil, math.huge
            local pos = hrp.Position
            for c in pairs(coins) do
                if c.Parent then
                    local m = (c.Position - pos).Magnitude
                    if m < d then best, d = c, m end
                end
            end
            if best then
                local t = TS:Create(hrp, TweenInfo.new(d / o.spd, Enum.EasingStyle.Linear), {CFrame = best.CFrame})
                tw = t
                local done = false
                t.Completed:Connect(function(st) done = st == Enum.PlaybackState.Completed end)
                t:Play()
                while t.PlaybackState == Enum.PlaybackState.Playing do
                    if not o.farm or full or hum.Health <= 0 or not inRound() then t:Cancel() break end
                    task.wait(0.05)
                end
                tw = nil
                if done then coins[best] = nil end
            end
        else
            stop()
        end
    end
end)

task.spawn(function()
    while task.wait(0.5) do
        if o.reset and full and inRound() then
            local hum = me.Character and me.Character:FindFirstChildOfClass("Humanoid")
            if hum and hum.Health > 0 then
                stop()
                hum.Health = 0
            end
        end
    end
end)

task.spawn(function()
    while task.wait(0.1) do
        if o.sa then
            local m = murd()
            mPart = m and m.Character and m.Character:FindFirstChild("HumanoidRootPart")
        else
            mPart = nil
        end
    end
end)

if hookmetamethod and getnamecallmethod then
    local old
    local function hook(self, ...)
        local m = getnamecallmethod()
        if mPart and (m == "FireServer" or m == "InvokeServer") and not (checkcaller and checkcaller()) then
            local a = table.pack(...)
            local hit = false
            pcall(function()
                local nm = self.Name
                local pn = self.Parent and self.Parent.Name or ""
                if o.dbg then print("remote:", m, nm, pn, typeof(a[1]), typeof(a[2]), typeof(a[3])) end
                local pos = mPart.Position + mPart.AssemblyLinearVelocity * 0.1
                if m == "FireServer" and string.find(nm, "Shoot") and typeof(a[2]) == "CFrame" then
                    a[2] = CFrame.new(pos)
                    hit = true
                elseif m == "InvokeServer" and pn == "CreateBeam" and typeof(a[2]) == "Vector3" then
                    a[2] = pos
                    hit = true
                end
            end)
            if hit then return old(self, table.unpack(a, 1, a.n)) end
        end
        return old(self, ...)
    end
    old = hookmetamethod(game, "__namecall", newcclosure and newcclosure(hook) or hook)
else
    warn("hookmetamethod not supported, silent aim off")
end

local afk
local function setAfk(v)
    if afk then afk:Disconnect() afk = nil end
    if v then
        afk = me.Idled:Connect(function()
            VU:CaptureController()
            VU:ClickButton2(Vector2.new())
        end)
    end
end
setAfk(true)

ui:AddTheme{
    Name = "PurpleTheme",
    Accent = Color3.fromRGB(149,51,255),
    Outline = Color3.fromRGB(88,58,195),
    Text = Color3.fromRGB(255,255,255),
    PlaceholderText = Color3.fromRGB(168,95,255),
    Background = Color3.fromRGB(12,92,28),
    Secondary = Color3.fromRGB(22,95,45),
    Tertiary = Color3.fromRGB(38,20,60)
}

local win = ui:CreateWindow{
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
    Callback=function(v) o.esp=v if not v then clear("ESP_Player") end end}
vis:Toggle{Title="ESP Dropped Gun", Value=false,
    Callback=function(v) o.gun=v if not v then clear("ESP_Gun") end end}
vis:Toggle{Title="ESP Traps", Value=false,
    Callback=function(v) o.trap=v if not v then clear("ESP_Trap") end end}

main:Toggle{Title="Auto Grab Gun", Value=false, Callback=function(v) o.grab=v end}
main:Toggle{Title="Silent Aim", Desc="Sheriff shots go to the Murderer", Value=false, Callback=function(v) o.sa=v end}
main:Toggle{Title="Autofarm Coins", Desc="Only during a round, while alive", Value=false,
    Callback=function(v) o.farm=v if not v then stop() end end}
main:Slider{Title="Farm Speed", Desc="Studs per second", Value={Min=1, Max=25, Default=25}, Step=1, Callback=function(v) o.spd=v end}
main:Toggle{Title="Auto End Run", Desc="Resets when the bag is full", Value=false, Callback=function(v) o.reset=v end}
main:Toggle{Title="Anti AFK", Value=true, Callback=setAfk}
main:Toggle{Title="Debug Remotes", Desc="Prints shot remotes in the console", Value=false, Callback=function(v) o.dbg=v end}
