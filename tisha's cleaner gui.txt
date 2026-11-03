local ITEM_OPTIONS = {
    "Research Capsule", "Tapes", "Gumballs", "Chocolate", "Stopwatch",
    "Stamina Candy", "Stealth Candy", "Pop", "Speed Candy", "Protein Bar",
    "Instructions", "Extraction Speed Candy", "Skill Check Candy", "Jumper Cable",
    "Bandage", "Air Horn", "Jawbreaker", "Bonbon", "Christmas Cookie",
    "Dandy Easter Egg", "Dandy Corn", "Bottle o' Pop", "Health Kit",
    "Box o' Chocolates", "Eject Button", "Smoke Bomb", "Valve",
    "Ornament", "Basket", "Pumpkin", "Fake Capsule", "Enigma Candy"
}

local ITEM_LOOKUP = {
    ["Research Capsule"] = "ResearchCapsule",
    ["Tapes"] = "Tapes",
    ["Gumballs"] = "Gumballs",
    ["Chocolate"] = "Chocolate",
    ["Stopwatch"] = "Stopwatch",
    ["Stamina Candy"] = "StaminaCandy",
    ["Stealth Candy"] = "StealthCandy",
    ["Pop"] = "Pop",
    ["Speed Candy"] = "SpeedCandy",
    ["Protein Bar"] = "ProteinBar",
    ["Instructions"] = "Instructions",
    ["Extraction Speed Candy"] = "ExtractionSpeedCandy",
    ["Skill Check Candy"] = "SkillCheckCandy",
    ["Jumper Cable"] = "JumperCable",
    ["Bandage"] = "Bandage",
    ["Air Horn"] = "AirHorn",
    ["Jawbreaker"] = "Jawbreaker",
    ["Bonbon"] = "BonBon",
    ["Christmas Cookie"] = "ChristmasCookie",
    ["Dandy Easter Egg"] = "DandyEasterEgg",
    ["Dandy Corn"] = "DandCorn",
    ["Bottle o' Pop"] = "BottleOPop",
    ["Health Kit"] = "HealthKit",
    ["Box o' Chocolates"] = "BoxOChocolates",
    ["Eject Button"] = "EjectButton",
    ["Smoke Bomb"] = "SmokeBomb",
    ["Valve"] = "Valve",
    ["Ornament"] = "Ornament",
    ["Basket"] = "Basket",
    ["Pumpkin"] = "Pumpkin",
    ["Fake Capsule"] = "FakeCapsule",
    ["Enigma Candy"] = "EnigmaCandy"
}

local okUi, ui = pcall(function()
    return loadstring(game:HttpGet("https://github.com/Footagesus/WindUI/releases/latest/download/main.lua"))()
end)
if not okUi or type(ui) ~= "table" then
    warn("[Tisha] failed to load WindUI:", ui)
    return
end

if not game:IsLoaded() then game.Loaded:Wait() end

local P = game:GetService("Players")
local RS = game:GetService("ReplicatedStorage")
local RUN = game:GetService("RunService")
local UIS = game:GetService("UserInputService")
local Lt = game:GetService("Lighting")
local GS = game:GetService("GuiService")
local me = P.LocalPlayer
local pg = me:WaitForChild("PlayerGui")

local okV, VIM = pcall(function() return game:GetService("VirtualInputManager") end)
if not okV then VIM = nil end

pcall(function()
    if getgenv and getgenv().PlaggDandyBtn then getgenv().PlaggDandyBtn:Destroy() end
end)

local C = {
    bg = Color3.fromRGB(8, 20, 48),
    bar = Color3.fromRGB(16, 48, 110),
    side = Color3.fromRGB(10, 28, 70),
    row = Color3.fromRGB(18, 52, 118),
    rowHi = Color3.fromRGB(30, 90, 190),
    accent = Color3.fromRGB(60, 150, 255),
    cyan = Color3.fromRGB(235, 245, 255),
    sub = Color3.fromRGB(170, 205, 255),
    off = Color3.fromRGB(60, 90, 150)
}

local BLACK, WHITE = Color3.new(0, 0, 0), Color3.new(1, 1, 1)
local PURPLE, MAGENTA, GRAY = Color3.fromRGB(170, 70, 255), Color3.fromRGB(230, 50, 220), Color3.fromRGB(150, 150, 165)
local ORANGE, RED, GREEN = Color3.fromRGB(255, 140, 0), Color3.fromRGB(255, 40, 40), Color3.fromRGB(60, 255, 120)
local YELLOW = Color3.fromRGB(255, 230, 0)
local GOURDY_COLOR = Color3.fromRGB(200, 90, 0)

local S = {
    esItem = false, esTw = false, esGen = false, esPl = false, esTend = false, esHand = false, esPud = false,
    noTags = false, onlyItem = false, size = 14,
    elev = false, tpNearOn = true, tpNear = 35,
    speed = false, ws = 50, tpw = false, tpv = 2, fly = false, fs = 30,
    spin = false, spinv = 20, stam = false, rng = false,
    autoAbility = false,
    noPop = false, noSplot = false, autoCal = false,
    fb = false, nofog = false, lag = false,
    itemBlacklist = {}
}

local grav0 = workspace.Gravity
if grav0 < 1 then grav0 = 196.2 end
local ws0 = 16
local tpStroke
local camPos = Vector3.new(0, 0, 0)

local function notify(txt)
    pcall(function() ui:Notify({Title = "Tisha's Cleaner GUI", Content = txt, Duration = 3}) end)
end

local function loop(delay, fn)
    task.spawn(function()
        local last
        while true do
            local ok, err = pcall(fn)
            if not ok and tostring(err) ~= last then
                last = tostring(err)
                warn("[Tisha]", err)
            end
            task.wait(delay)
        end
    end)
end

local function clean(n)
    return (tostring(n):gsub("Monster", ""))
end

local function pretty(n)
    return (tostring(n):gsub("(%l)(%u)", "%1 %2"))
end

local function itemColor(name)
    local n = tostring(name):lower()
    if n:find("capsule", 1, true) then return RED end
    if n:find("extraction", 1, true) then return PURPLE end
    if n:find("candy", 1, true) or n:find("pop", 1, true) or n:find("gumball", 1, true) or n:find("chocolate", 1, true) then return GREEN end
    if n:find("bandage", 1, true) or n:find("horn", 1, true) then return PURPLE end
    if n:find("kit", 1, true) then return ORANGE end
    return WHITE
end

local function partOf(x)
    if x:IsA("BasePart") then return x end
    if x:IsA("Model") then
        local hrp = x:FindFirstChild("HumanoidRootPart")
        if hrp then return hrp end
        return x.PrimaryPart or x:FindFirstChildWhichIsA("BasePart", true)
    end
    return x:FindFirstChildWhichIsA("BasePart", true)
end

local function hrpOf()
    local c = me.Character
    return c and c:FindFirstChild("HumanoidRootPart"), c and c:FindFirstChildOfClass("Humanoid")
end

local function sv(st, n)
    local x = st and st:FindFirstChild(n)
    if not x then return nil end
    local ok, v = pcall(function() return x.Value end)
    if ok then return v end
end

local function inGame()
    local g = workspace:FindFirstChild("InGamePlayers")
    return g and g:FindFirstChild(me.Name)
end

local snap = {mon = {}, gen = {}, item = {}}

loop(0.3, function()
    local mon, gen, item = {}, {}, {}
    local r = workspace:FindFirstChild("CurrentRoom")
    if r then
        for _, m in ipairs(r:GetChildren()) do
            local a = m:FindFirstChild("Monsters")
            if a then for _, x in ipairs(a:GetChildren()) do mon[#mon + 1] = x end end
            local b = m:FindFirstChild("Generators")
            if b then for _, x in ipairs(b:GetChildren()) do gen[#gen + 1] = x end end
            local c = m:FindFirstChild("Items")
            if c then for _, x in ipairs(c:GetChildren()) do item[#item + 1] = x end end
        end
    end
    snap.mon, snap.gen, snap.item = mon, gen, item
end)

local function genStats(g) return g:FindFirstChild("Stats") end
local function genDone(g) return sv(genStats(g), "Completed") == true end
local function genPivot(g) return g:GetPivot().Position end

local function genBusy(g)
    local st = genStats(g)
    local a, b = sv(st, "ActivePlayer"), sv(st, "ActivePlayer2")
    return (a ~= nil and a ~= "" and a ~= false) or (b ~= nil and b ~= "" and b ~= false)
end

local function genAmt(g)
    local st = genStats(g)
    local c, r = sv(st, "CurrentAmount"), sv(st, "RequiredAmount")
    if type(c) == "number" and type(r) == "number" and r > 0 then return c, r end
end

local function allDone()
    local info = workspace:FindFirstChild("Info")
    local c, r = sv(info, "GeneratorsCompleted"), sv(info, "RequiredGenerators")
    if type(c) == "number" and type(r) == "number" and r > 0 then return c >= r end
    if #snap.gen == 0 then return false end
    for _, g in ipairs(snap.gen) do
        if not genDone(g) then return false end
    end
    return true
end

local function elevPos()
    local e = workspace:FindFirstChild("Elevators")
    e = e and e:FindFirstChild("Elevator")
    if not e then return end
    local b = e:FindFirstChild("Base")
    if b and b:IsA("BasePart") then return b.Position + Vector3.new(0, 4, 0) end
    return e:GetPivot().Position + Vector3.new(0, 4, 0)
end

local haz = {tend = {}, hand = {}, pud = {}}

local function inPlayer(v)
    local a = v
    while a and a ~= workspace do
        if a:IsA("Model") and P:GetPlayerFromCharacter(a) then return true end
        a = a.Parent
    end
    return false
end

local function hazKind(v)
    local n = v.Name:lower()
    if n:find("tendril", 1, true) or n:find("tentacle", 1, true) then return "tend" end
    if n:find("puddle", 1, true) then
        if n:find("ichor", 1, true) then return "pud" end
        local p = v.Parent
        for _ = 1, 4 do
            if not p or p == workspace then break end
            if p.Name:lower():find("ichor", 1, true) then return "pud" end
            p = p.Parent
        end
        return nil
    end
    if n:find("hand", 1, true) then
        local p = v
        for _ = 1, 6 do
            if not p or p == workspace then break end
            if p.Name:lower():find("blot", 1, true) then return "hand" end
            p = p.Parent
        end
    end
end

local function hazScan(v)
    local n = v.Name:lower()
    if not (n:find("tendril", 1, true) or n:find("tentacle", 1, true) or n:find("puddle", 1, true)
        or n:find("hand", 1, true) or n:find("ichor", 1, true) or n:find("blot", 1, true)) then return end
    local isDecal = v:IsA("Decal") or v:IsA("Texture")
    if not (isDecal or v:IsA("BasePart") or v:IsA("Model")) then return end
    local t = isDecal and v.Parent or v
    if not (t and (t:IsA("BasePart") or t:IsA("Model"))) then return end
    local k = hazKind(v)
    if not k then return end
    if v == t then
        local p = t.Parent
        if p and (p:IsA("BasePart") or p:IsA("Model")) and hazKind(p) == k then return end
    end
    if inPlayer(t) then return end
    haz[k][t] = true
end

local hazOn = false
local hazQueue = {}
local hazBusy = false

local function hazQueueAdd(v)
    if #hazQueue > 8000 then return end
    hazQueue[#hazQueue + 1] = v
    if not hazBusy then
        hazBusy = true
        task.spawn(function()
            local n = 0
            while #hazQueue > 0 do
                local item = table.remove(hazQueue, 1)
                if item and item.Parent then pcall(hazScan, item) end
                n = n + 1
                if n % 100 == 0 then task.wait() end
            end
            hazBusy = false
        end)
    end
end

local function hazStart()
    if hazOn then return end
    hazOn = true
    task.spawn(function()
        local n = 0
        for _, v in ipairs(workspace:GetDescendants()) do
            hazScan(v)
            n = n + 1
            if n % 500 == 0 then task.wait() end
        end
    end)
    workspace.DescendantAdded:Connect(hazQueueAdd)
    workspace.DescendantRemoving:Connect(function(v)
        for _, set in pairs(haz) do set[v] = nil end
    end)
end

local HL_MAX = 250
local reg = {item = {}, twist = {}, gen = {}, plr = {}, tend = {}, hand = {}, pud = {}}
local seen = {}
local hlUsed = 0
local sizeCache = {}

local function getSize(sz, lines)
    local key = sz * 100 + lines
    local c = sizeCache[key]
    if not c then
        c = UDim2.new(0, 400, 0, math.ceil(sz * 1.25) * lines)
        sizeCache[key] = c
    end
    return c
end

local function newGui(part)
    local g = Instance.new("BillboardGui")
    g.Name = "PlaggESP"
    g.AlwaysOnTop = true
    g.StudsOffset = Vector3.new(0, 2.5, 0)
    g.Adornee = part
    g.Parent = part
    local t = Instance.new("TextLabel")
    t.Name = "T"
    t.Size = UDim2.new(1, 0, 1, 0)
    t.BackgroundTransparency = 1
    t.TextScaled = false
    t.TextWrapped = false
    t.Font = Enum.Font.FredokaOne
    t.TextStrokeColor3 = BLACK
    t.TextStrokeTransparency = 0
    t.Parent = g
    return g, t
end

local function put(kind, target, part, txt, color, stroke, outline, fill, fillT, noHl)
    local bag = reg[kind]
    local r = bag[target]
    if not r then
        r = {}
        bag[target] = r
    end
    seen[r] = true

    local tagOn = (not S.noTags) or (S.onlyItem and kind == "item")
    if tagOn then
        if not r.gui or not r.gui.Parent or r.part ~= part then
            if r.gui then r.gui:Destroy() end
            r.gui, r.lbl = newGui(part)
            r.part = part
        end
        local lines = txt:find("\n", 1, true) and 2 or 1
        local sz = getSize(S.size, lines)
        if r.gui.Size ~= sz then r.gui.Size = sz end
        if r.lbl.Text ~= txt then r.lbl.Text = txt end
        if r.lbl.TextSize ~= S.size then r.lbl.TextSize = S.size end
        local sc = stroke or BLACK
        if r.lbl.TextStrokeColor3 ~= sc then r.lbl.TextStrokeColor3 = sc end
        if r.lbl.TextColor3 ~= color then r.lbl.TextColor3 = color end
    elseif r.gui then
        r.gui:Destroy()
        r.gui, r.lbl, r.part = nil, nil, nil
    end

    if noHl then
        if r.hl then
            r.hl:Destroy()
            r.hl = nil
        end
    elseif hlUsed < HL_MAX then
        hlUsed = hlUsed + 1
        if not r.hl or not r.hl.Parent then
            local h = Instance.new("Highlight")
            h.Name = "PlaggHL"
            h.OutlineTransparency = 0
            h.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
            h.Parent = target
            r.hl = h
        end
        local oc = outline or color
        local fc = fill or color
        local ft = fillT or 1
        if r.hl.OutlineColor ~= oc then r.hl.OutlineColor = oc end
        if r.hl.FillColor ~= fc then r.hl.FillColor = fc end
        if r.hl.FillTransparency ~= ft then r.hl.FillTransparency = ft end
    elseif r.hl then
        r.hl:Destroy()
        r.hl = nil
    end
end

local function sweep()
    for _, bag in pairs(reg) do
        for target, r in pairs(bag) do
            if not seen[r] or not target.Parent then
                if r.gui then pcall(function() r.gui:Destroy() end) end
                if r.hl then pcall(function() r.hl:Destroy() end) end
                bag[target] = nil
            end
        end
    end
    seen = {}
end

local function nearestN(set, n)
    local list = {}
    for inst in pairs(set) do
        if inst.Parent then
            local part = partOf(inst)
            if part then list[#list + 1] = {inst, part, (part.Position - camPos).Magnitude} end
        else
            set[inst] = nil
        end
    end
    if #list <= n then return list end
    table.sort(list, function(a, b) return a[3] < b[3] end)
    for i = n + 1, #list do list[i] = nil end
    return list
end

local function itemLabel(it)
    local pp = it:FindFirstChildWhichIsA("ProximityPrompt", true)
    local t = pp and pp.ObjectText
    if type(t) == "string" and t ~= "" then return t end
    return pretty(it.Name)
end

local CAP_RAINBOW = {"shelly", "vee", "pebble", "sprout", "astro", "dyle"}

local function numByName(root, key)
    for k, v in pairs(root:GetAttributes()) do
        if type(v) == "number" and k:lower():find(key, 1, true) then return v end
    end
    for _, d in ipairs(root:GetDescendants()) do
        if d:IsA("ValueBase") and d.Name:lower():find(key, 1, true) then
            local ok, v = pcall(function() return d.Value end)
            if ok and type(v) == "number" then return v end
        end
    end
end

local function capsuleKind(it)
    local texts = {it.Name:lower()}
    for k, v in pairs(it:GetAttributes()) do
        texts[#texts + 1] = tostring(k):lower()
        if type(v) == "string" then texts[#texts + 1] = v:lower() end
    end
    for _, d in ipairs(it:GetDescendants()) do
        texts[#texts + 1] = d.Name:lower()
        if d:IsA("StringValue") then texts[#texts + 1] = d.Value:lower() end
        if d:IsA("ObjectValue") and d.Value then texts[#texts + 1] = d.Value.Name:lower() end
        for _, v in pairs(d:GetAttributes()) do
            if type(v) == "string" then texts[#texts + 1] = v:lower() end
        end
    end
    for _, t in ipairs(texts) do
        for _, name in ipairs(CAP_RAINBOW) do
            if t:find(name, 1, true) then return "rainbow" end
        end
    end
    for _, t in ipairs(texts) do
        if t:find("gourdy", 1, true) then return "gourdy" end
    end
    return "dandy"
end

local function itemText(it)
    local n = it.Name:lower()
    if n:find("capsule", 1, true) and not n:find("fake", 1, true) then
        local res = numByName(it, "research") or 0
        return "Research Capsule\n("..#snap.mon.."/"..math.floor(res)..")", capsuleKind(it)
    end
    if n:find("pumpkin", 1, true) then
        return "Pumpkin", "pumpkin"
    end
    return itemLabel(it), nil
end

local function animColor(kind)
    if kind == "rainbow" then
        return Color3.fromHSV((tick() * 0.5) % 1, 1, 1)
    elseif kind == "pumpkin" then
        local t = (math.sin(tick() * 3) + 1) / 2
        return ORANGE:Lerp(YELLOW, t)
    end
end

loop(0.03, function()
    if not S.esItem then return end
    for _, r in pairs(reg.item) do
        if r.lbl and r.anim then
            local c = animColor(r.anim)
            if c then r.lbl.TextColor3 = c end
        end
    end
end)

local hadEsp = false
loop(0.35, function()
    local any = S.esTw or S.esGen or S.esPl or S.esTend or S.esHand or S.esPud or S.esItem
    if not any then
        if hadEsp then
            hadEsp = false
            sweep()
        end
        return
    end
    hadEsp = true
    hlUsed = 0

    if S.esTend or S.esHand or S.esPud then
        local cam = workspace.CurrentCamera
        if cam then camPos = cam.CFrame.Position end
    end

    if S.esTw then
        for _, m in ipairs(snap.mon) do
            local part = partOf(m)
            if part then put("twist", m, part, clean(m.Name), RED, WHITE, WHITE, RED, 0.5) end
        end
    end
    if S.esGen then
        for _, g in ipairs(snap.gen) do
            if not genDone(g) then
                local part = partOf(g)
                if part then
                    local c, r = genAmt(g)
                    local head = genBusy(g) and "Machine | Being Extracted" or "Machine"
                    local txt = head
                    if c then
                        txt = head.."\n("..math.floor(c).."/"..math.floor(r)..")"
                    end
                    put("gen", g, part, txt, GRAY, WHITE, WHITE, GRAY, 0.5)
                end
            end
        end
    end
    if S.esPl then
        for _, p in ipairs(P:GetPlayers()) do
            local c = p ~= me and p.Character
            if c then
                local hum = c:FindFirstChildOfClass("Humanoid")
                local part = c:FindFirstChild("HumanoidRootPart")
                if hum and part and hum.Health > 0 then put("plr", c, part, p.Name, GREEN, BLACK, WHITE) end
            end
        end
    end
    if S.esTend then
        for _, e in ipairs(nearestN(haz.tend, 20)) do put("tend", e[1], e[2], "Sprout Tendril", PURPLE) end
    end
    if S.esHand then
        for _, e in ipairs(nearestN(haz.hand, 20)) do put("hand", e[1], e[2], "Blot's Hand", WHITE) end
    end
    if S.esPud then
        for _, e in ipairs(nearestN(haz.pud, 12)) do put("pud", e[1], e[2], "Ichor Puddle", MAGENTA) end
    end
    if S.esItem then
        for _, it in ipairs(snap.item) do
            local label, kind = itemText(it)
            local internalName = it.Name
            if not S.itemBlacklist[internalName] and not S.itemBlacklist[label] then
                local part = partOf(it)
                if part then
                    local color, stroke = itemColor(it.Name), BLACK
                    if kind == "dandy" then
                        color, stroke = RED, WHITE
                    elseif kind == "gourdy" then
                        color, stroke = GOURDY_COLOR, WHITE
                    elseif kind == "rainbow" then
                        color, stroke = animColor("rainbow"), WHITE
                    elseif kind == "pumpkin" then
                        color = animColor("pumpkin")
                    end
                    put("item", it, part, label, color, stroke, nil, nil, nil, true)
                    local r = reg.item[it]
                    if r then r.anim = (kind == "rainbow" or kind == "pumpkin") and kind or nil end
                end
            end
        end
    end
    sweep()
end)

local function tp(pos)
    local hrp = hrpOf()
    if not (hrp and pos) then return false end
    if hrp.Anchored then hrp.Anchored = false end
    hrp.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
    hrp.CFrame = CFrame.new(pos)
    return true
end

local function twistedNear(pos, dist)
    for _, m in ipairs(snap.mon) do
        if m.Parent then
            local part = partOf(m)
            if part and (part.Position - pos).Magnitude <= dist then return true end
        end
    end
    return false
end

local function scanTendrils()
    local list = {}
    local room = workspace:FindFirstChild("CurrentRoom")
    if not room then return list end
    for _, v in ipairs(room:GetDescendants()) do
        local n = v.Name:lower()
        if n:find("tendril", 1, true) or n:find("tentacle", 1, true) then
            local part = partOf(v)
            if part and not inPlayer(v) then list[#list + 1] = part end
        end
    end
    return list
end

local function tendrilNearFromList(list, pos, dist)
    for _, part in ipairs(list) do
        if part.Parent and (part.Position - pos).Magnitude <= dist then return true end
    end
    return false
end

local function tpGen()
    local hrp = hrpOf()
    if not hrp then return end

    local tendrils = scanTendrils()

    local best, bd, any, tendrilBlocked
    for pass = 1, 2 do
        for _, g in ipairs(snap.gen) do
            if not genDone(g) and (pass == 2 or not genBusy(g)) then
                any = true
                local gp = genPivot(g)
                if tendrilNearFromList(tendrils, gp, 10) then
                    tendrilBlocked = true
                elseif not (S.tpNearOn and twistedNear(gp, S.tpNear)) then
                    local d = (gp - hrp.Position).Magnitude
                    if not bd or d < bd then best, bd = g, d end
                end
            end
        end
        if best then break end
    end
    if best then
        -- Procura pela part "Valve" dentro do gerador (best)
        local valve = best:FindFirstChild("Valve", true)
        local targetPos
        if valve then
            if valve:IsA("BasePart") then
                targetPos = valve.Position
            else
                local p = partOf(valve)
                targetPos = p and p.Position or genPivot(best)
            end
        else
            targetPos = genPivot(best)
        end
        tp(targetPos + Vector3.new(0, 3, 0))
    elseif tendrilBlocked then
        notify("All machines have a Sprout Tendril within 10 studs or less")
    elseif any then
        notify("All machines have a twisted less than "..S.tpNear.." studs away")
    else
        notify("No machines found")
    end
end

do
    local fired, lastPos = false, nil
    RUN.Heartbeat:Connect(function()
        if not S.elev then
            fired = false
            lastPos = nil
            return
        end
        if not allDone() then
            fired = false
            return
        end
        local hrp, hum = hrpOf()
        if not (hum and hum.Health > 0 and hrp and inGame()) then return end
        local pos = elevPos()
        if not pos then return end
        if lastPos and (pos - lastPos).Magnitude > 10 then fired = false end
        lastPos = pos
        if fired then
            if (pos - hrp.Position).Magnitude > 8 then tp(pos) end
            return
        end
        if tp(pos) then fired = true end
    end)
end

local tpGui = Instance.new("ScreenGui")
tpGui.Name = "PlaggTpGen"
tpGui.ResetOnSpawn = false
tpGui.Enabled = false
local okP = pcall(function() tpGui.Parent = (gethui and gethui()) or pg end)
if not okP or not tpGui.Parent then tpGui.Parent = pg end
pcall(function() if getgenv then getgenv().PlaggDandyBtn = tpGui end end)

local tpBtn = Instance.new("TextButton")
tpBtn.Size = UDim2.fromOffset(150, 40)
tpBtn.Position = UDim2.new(0.75, 0, 0.6, 0)
tpBtn.BackgroundColor3 = C.bg
tpBtn.BorderSizePixel = 0
tpBtn.Text = "tp generator"
tpBtn.Font = Enum.Font.FredokaOne
tpBtn.TextColor3 = C.cyan
tpBtn.TextScaled = true
tpBtn.Active = true
tpBtn.Draggable = true
tpBtn.Parent = tpGui
local tpPad = Instance.new("UIPadding", tpBtn)
tpPad.PaddingLeft = UDim.new(0, 8)
tpPad.PaddingRight = UDim.new(0, 8)
tpPad.PaddingTop = UDim.new(0, 6)
tpPad.PaddingBottom = UDim.new(0, 6)
Instance.new("UICorner", tpBtn).CornerRadius = UDim.new(0, 4)
tpStroke = Instance.new("UIStroke", tpBtn)
tpStroke.Thickness = 3
tpStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
tpStroke.Color = C.accent
tpBtn.MouseButton1Click:Connect(tpGen)

loop(0.08, function()
    if not tpGui.Enabled then return end
    tpStroke.Color = Color3.fromHSV((tick() * 0.5) % 1, 1, 1)
end)

local function setFly(v)
    S.fly = v
    if v then
        if workspace.Gravity > 0 then grav0 = workspace.Gravity end
        workspace.Gravity = 0
    else
        workspace.Gravity = grav0
    end
end

RUN.Heartbeat:Connect(function(dt)
    if not (S.speed or S.tpw or S.fly or S.spin) then return end
    local hrp, hum = hrpOf()
    if not (hrp and hum) then return end

    if S.speed and hum.WalkSpeed ~= S.ws then hum.WalkSpeed = S.ws end

    local dir = hum.MoveDirection
    if S.fly then
        if workspace.Gravity ~= 0 then workspace.Gravity = 0 end
        local cam = workspace.CurrentCamera
        local look = cam.CFrame.LookVector
        local flat = Vector3.new(look.X, 0, look.Z)
        flat = flat.Magnitude > 0.01 and flat.Unit or Vector3.new(0, 0, -1)
        local right = Vector3.new(-flat.Z, 0, flat.X)
        local mv = Vector3.new(0, 0, 0)
        if dir.Magnitude > 0.01 then
            mv = look * dir:Dot(flat) + cam.CFrame.RightVector * dir:Dot(right)
        else
            local f = (UIS:IsKeyDown(Enum.KeyCode.W) and 1 or 0) - (UIS:IsKeyDown(Enum.KeyCode.S) and 1 or 0)
            local r = (UIS:IsKeyDown(Enum.KeyCode.D) and 1 or 0) - (UIS:IsKeyDown(Enum.KeyCode.A) and 1 or 0)
            local u = (UIS:IsKeyDown(Enum.KeyCode.Space) and 1 or 0) - (UIS:IsKeyDown(Enum.KeyCode.LeftShift) and 1 or 0)
            mv = look * f + cam.CFrame.RightVector * r + Vector3.new(0, u, 0)
        end
        hrp.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
        hrp.AssemblyAngularVelocity = Vector3.new(0, 0, 0)
        if mv.Magnitude > 0.01 and S.fs > 0 then
            hrp.CFrame = hrp.CFrame + mv.Unit * (S.fs * dt)
        end
    elseif S.tpw and S.tpv > 0 and dir.Magnitude > 0.01 then
        hrp.CFrame = hrp.CFrame + dir * (S.tpv * 10 * dt)
    end

    if S.spin and S.spinv > 0 then
        if hum.AutoRotate then hum.AutoRotate = false end
        local v = hrp.AssemblyLinearVelocity
        hrp.CFrame = hrp.CFrame * CFrame.Angles(0, math.rad(S.spinv * 20) * dt, 0)
        hrp.AssemblyLinearVelocity = v
    elseif not hum.AutoRotate then
        hum.AutoRotate = true
    end
end)

local NoclipConnection = nil
local noclipOriginal = setmetatable({}, {__mode = "k"})

local function applyNoclip()
    local character = me.Character or me.CharacterAdded:Wait()
    for _, part in ipairs(character:GetDescendants()) do
        if part:IsA("BasePart") then
            if getconnections then
                pcall(function()
                    for _, conn in ipairs(getconnections(part:GetPropertyChangedSignal("CanQuery"))) do conn:Disconnect() end
                    for _, conn in ipairs(getconnections(part:GetPropertyChangedSignal("CanCollide"))) do conn:Disconnect() end
                    for _, conn in ipairs(getconnections(part:GetPropertyChangedSignal("CanTouch"))) do conn:Disconnect() end
                    for _, conn in ipairs(getconnections(part.Changed)) do conn:Disconnect() end
                end)
            end
            if noclipOriginal[part] == nil then noclipOriginal[part] = part.CanCollide end
            part.CanCollide = false
        end
    end
end

local function setNoclip(state)
    if state then
        applyNoclip()
        if not NoclipConnection then
            NoclipConnection = RUN.Stepped:Connect(function()
                local character = me.Character
                if character then
                    for _, part in ipairs(character:GetDescendants()) do
                        if part:IsA("BasePart") then
                            if noclipOriginal[part] == nil then noclipOriginal[part] = part.CanCollide end
                            part.CanCollide = false
                        end
                    end
                end
            end)
        end
    else
        if NoclipConnection then
            NoclipConnection:Disconnect()
            NoclipConnection = nil
        end
        local character = me.Character
        if character then
            for _, part in ipairs(character:GetDescendants()) do
                if part:IsA("BasePart") then
                    local orig = noclipOriginal[part]
                    part.CanCollide = orig ~= nil and orig or true
                end
            end
        end
        noclipOriginal = setmetatable({}, {__mode = "k"})
    end
end

local function pressButton(btn)
    if getconnections then
        for _, key in ipairs({"Activated", "MouseButton1Click", "TouchTap", "MouseButton1Down"}) do
            local ok, conns = pcall(getconnections, btn[key])
            if ok and conns and #conns > 0 then
                for _, c in ipairs(conns) do pcall(function() c:Fire() end) end
                return true
            end
        end
    end
    if firesignal then
        local ok = pcall(firesignal, btn.Activated)
        if ok then return true end
    end
    return false
end

local function topGui(inst)
    local a = inst
    while a and a.Parent and a.Parent ~= pg do a = a.Parent end
    return a
end

local function own(inst)
    local t = topGui(inst)
    if not t then return false end
    local n = t.Name:lower()
    return n:find("windui", 1, true) ~= nil or n:find("plagg", 1, true) ~= nil
end

local stam = {
    cur = {}, max = {}, flag = {}, curA = {}, maxA = {}, flagA = {},
    gc = {}, guiMax = nil, gt = 0, busy = false,
    top = setmetatable({}, {__mode = "k"}), at = 0
}
local STAM_SKIP = {"regen", "drain", "cost", "rate", "speed", "delay", "cooldown", "loss", "recover", "gain", "decay"}
local STAM_KEYS = {"Stamina", "stamina", "CurrentStamina", "currentStamina", "Stam"}
local STAM_MAX = {"MaxStamina", "maxStamina", "StaminaMax", "staminaMax", "MaxStam"}

local function stamKind(name)
    local n = name:lower()
    if n:find("exhaust", 1, true) or n:find("tired", 1, true) or n:find("winded", 1, true) then return "flag" end
    if not n:find("stamina", 1, true) then return nil end
    for _, s in ipairs(STAM_SKIP) do
        if n:find(s, 1, true) then return nil end
    end
    if n:find("max", 1, true) or n == "stamina" then return "max" end
    return "cur"
end

local function stamRoots()
    local list, g = {}, inGame()
    if g then list[#list + 1] = {g, true} end
    local c = me.Character
    if c and c ~= g then list[#list + 1] = {c, true} end
    list[#list + 1] = {me, false}
    return list
end

local function stamScan()
    local cur, max, flag, curA, maxA, flagA = {}, {}, {}, {}, {}, {}

    local function inst(d)
        if not d:IsA("ValueBase") then return end
        local k = stamKind(d.Name)
        if not k then return end
        local ok, v = pcall(function() return d.Value end)
        if not ok then return end
        if k == "flag" then
            if type(v) == "boolean" then flag[#flag + 1] = d end
        elseif type(v) == "number" then
            if k == "max" then max[#max + 1] = d
            else cur[#cur + 1] = d end
        end
    end

    local function attrs(o)
        for key, v in pairs(o:GetAttributes()) do
            local k = stamKind(key)
            if k == "flag" then
                if type(v) == "boolean" then flagA[#flagA + 1] = {o, key} end
            elseif k and type(v) == "number" then
                if k == "max" then maxA[#maxA + 1] = {o, key} else curA[#curA + 1] = {o, key} end
            end
        end
    end

    for _, e in ipairs(stamRoots()) do
        local root, deep = e[1], e[2]
        attrs(root)
        if deep then
            for _, d in ipairs(root:GetDescendants()) do
                inst(d)
                attrs(d)
            end
        else
            for _, d in ipairs(root:GetChildren()) do inst(d) end
        end
    end

    stam.cur, stam.max, stam.flag, stam.curA, stam.maxA, stam.flagA = cur, max, flag, curA, maxA, flagA
end

local function stamGc()
    for _, d in ipairs(pg:GetDescendants()) do
        if d:IsA("TextLabel") and not own(d) then
            local mx = d.Text:match("[Ss]tamina:?%s*[%d%.]+%s*/%s*([%d%.]+)")
            if mx then
                stam.guiMax = tonumber(mx)
                break
            end
        end
    end
    if not getgc then return end
    local ok, all = pcall(getgc, true)
    if not ok or type(all) ~= "table" then return end
    local out, n = {}, 0
    for _, t in ipairs(all) do
        if type(t) == "table" then
            for _, k in ipairs(STAM_KEYS) do
                local v = rawget(t, k)
                if type(v) == "number" then
                    local mk
                    for _, m in ipairs(STAM_MAX) do
                        if type(rawget(t, m)) == "number" then mk = m break end
                    end
                    out[#out + 1] = {t, k, mk, top = v}
                    break
                end
            end
        end
        n = n + 1
        if n % 3000 == 0 then task.wait() end
    end
    stam.gc = out
end

local function stamApply()
    if tick() - stam.at > 1 then
        stam.at = tick()
        stamScan()
    end
    if not stam.busy and tick() - stam.gt > 60 then
        stam.gt = tick()
        stam.busy = true
        task.spawn(function()
            pcall(stamGc)
            stam.busy = false
        end)
    end

    local mx = 0
    for _, d in ipairs(stam.max) do
        local v = d.Parent and d.Value
        if type(v) == "number" and v > mx then mx = v end
    end
    for _, e in ipairs(stam.maxA) do
        local v = e[1]:GetAttribute(e[2])
        if type(v) == "number" and v > mx then mx = v end
    end

    for _, d in ipairs(stam.cur) do
        if d.Parent then
            local v = d.Value
            if type(v) == "number" then
                local t = math.max(stam.top[d] or 0, v)
                stam.top[d] = t
                local target = mx > 0 and mx or math.max(t, 100)
                if v < target then d.Value = target end
            end
        end
    end
    for _, e in ipairs(stam.curA) do
        local o, k = e[1], e[2]
        local v = o:GetAttribute(k)
        if type(v) == "number" then
            local t = math.max(stam.top[e] or 0, v)
            stam.top[e] = t
            local target = mx > 0 and mx or math.max(t, 100)
            if v < target then o:SetAttribute(k, target) end
        end
    end

    for _, d in ipairs(stam.flag) do
        if d.Parent and d.Value ~= false then d.Value = false end
    end
    for _, e in ipairs(stam.flagA) do
        if e[1]:GetAttribute(e[2]) ~= false then e[1]:SetAttribute(e[2], false) end
    end

    for _, e in ipairs(stam.gc) do
        local t = e[1]
        local v = rawget(t, e[2])
        if type(v) == "number" then
            if v > e.top then e.top = v end
            local m2 = e[3] and rawget(t, e[3]) or nil
            if type(m2) ~= "number" then m2 = nil end
            local target = m2 or stam.guiMax or e.top
            if target < e.top and not m2 then target = e.top end
            if v < target then pcall(rawset, t, e[2], target) end
        end
    end
end

RUN.RenderStepped:Connect(function()
    if S.stam then pcall(stamApply) end
end)

local function uiKind(inst)
    if not (inst:IsA("GuiObject") or inst:IsA("ScreenGui")) then return end
    local n = inst.Name:lower()
    if n:find("splotch", 1, true) or n:find("stain", 1, true) or n:find("splat", 1, true)
        or (n:find("ichor", 1, true) and (n:find("screen", 1, true) or n:find("overlay", 1, true) or n:find("vignette", 1, true))) then
        return "splot"
    end
    if n:find("popup", 1, true) or n:find("pop_up", 1, true) or n:find("pop-up", 1, true) or n:find("pop up", 1, true)
        or n:find("advert", 1, true) or n == "ad" or n == "ads" or n:find("^ad[%d_]") or n:find("^vee") then
        return "pop"
    end
end

local function kindOn(kind)
    return (kind == "pop" and S.noPop) or (kind == "splot" and S.noSplot)
end

local hooked = setmetatable({}, {__mode = "k"})

local function closeAd(inst)
    for _, d in ipairs(inst:GetDescendants()) do
        if d:IsA("GuiButton") then
            local n = d.Name:lower()
            local t = d:IsA("TextButton") and d.Text:lower() or ""
            if n:find("close", 1, true) or n == "x" or t == "x" then pressButton(d) end
        end
    end
end

local function hideUi(inst, kind)
    if hooked[inst] then
        hooked[inst].apply()
        return
    end
    local prop = inst:IsA("ScreenGui") and "Enabled" or "Visible"
    local function apply()
        if kindOn(kind) and inst[prop] then inst[prop] = false end
    end
    hooked[inst] = {apply = apply}
    if kind == "pop" then pcall(closeAd, inst) end
    apply()
    inst:GetPropertyChangedSignal(prop):Connect(apply)
end

pg.DescendantAdded:Connect(function(d)
    if not (S.noPop or S.noSplot) then return end
    local k = uiKind(d)
    if k and kindOn(k) and not own(d) then pcall(hideUi, d, k) end
end)

local function scanUi()
    local n = 0
    for _, d in ipairs(pg:GetDescendants()) do
        local k = uiKind(d)
        if k and kindOn(k) and not own(d) then pcall(hideUi, d, k) end
        n = n + 1
        if n % 400 == 0 then task.wait() end
    end
end

task.spawn(function()
    getgenv().scinstant = false
    pcall(function()
        local events = game:GetService("ReplicatedStorage"):FindFirstChild("Events")
        if events then
            local event = events:FindFirstChild("SkillcheckUpdate")
            if event and getcallbackvalue then
                local ogcb = getcallbackvalue(event, "OnClientInvoke")
                if ogcb then
                    local hook
                    hook = hookfunction(ogcb, function(...)
                        if getgenv().scinstant then return "supercomplete" end
                        return hook(...)
                    end)
                end
            end
        end
    end)
end)

local RANGE_TOONS = {Shelly = true, Sprout = true, Cosmo = true, Scraps = true, Glisten = true}
local RANGE_BIG = 500
local rngOrig = setmetatable({}, {__mode = "k"})

local function rangeScan(restore)
    if not (getconnections and getupvalues) then return end
    for _, conn in pairs(getconnections(RUN.RenderStepped)) do
        local func = conn.Function
        if func then
            local ok, upvals = pcall(getupvalues, func)
            if ok and upvals then
                for _, val in pairs(upvals) do
                    if typeof(val) == "table" and val.Name and RANGE_TOONS[val.Name] and val.PlayerRadius then
                        if restore then
                            local o = rngOrig[val]
                            if o then
                                val.PlayerRadius = o
                                rngOrig[val] = nil
                            end
                        else
                            if rngOrig[val] == nil then rngOrig[val] = val.PlayerRadius end
                            val.PlayerRadius = RANGE_BIG
                        end
                    end
                end
            end
        end
    end
end

loop(2, function()
    if S.rng then rangeScan(false) end
end)

task.spawn(function()
    while true do
        if S.autoAbility then
            pcall(function()
                local char = me.Character
                local hrp = char and char:FindFirstChild("HumanoidRootPart")
                local ev = RS:FindFirstChild("Events")
                local ab = ev and ev:FindFirstChild("AbilityEvent")
                if char and hrp and ab then
                    ab:InvokeServer(char, hrp.CFrame, false)
                end
            end)
        end
        task.wait(1)
    end
end)

local function keeper()
    local store = setmetatable({}, {__mode = "k"})
    local function set(i, p, v)
        local t = store[i]
        if not t then
            t = {}
            store[i] = t
        end
        if t[p] == nil then t[p] = i[p] end
        if i[p] ~= v then i[p] = v end
    end
    local function undo()
        for i, t in pairs(store) do
            for p, v in pairs(t) do
                pcall(function() i[p] = v end)
            end
        end
        store = setmetatable({}, {__mode = "k"})
    end
    return set, undo
end

local fogSet, fogUndo = keeper()
local brSet, brUndo = keeper()
local lagSet, lagUndo = keeper()

local function world()
    if S.nofog then
        fogSet(Lt, "FogEnd", 1e9)
        fogSet(Lt, "FogStart", 1e9)
        for _, a in ipairs(Lt:GetChildren()) do
            if a:IsA("Atmosphere") then
                fogSet(a, "Density", 0)
                fogSet(a, "Offset", 0)
                fogSet(a, "Haze", 0)
                fogSet(a, "Glare", 0)
            end
        end
    end
    if S.fb then
        brSet(Lt, "Brightness", 2)
        brSet(Lt, "ClockTime", 14)
        brSet(Lt, "GlobalShadows", false)
        brSet(Lt, "Ambient", WHITE)
        brSet(Lt, "OutdoorAmbient", WHITE)
    end
end

local function refreshWorld()
    pcall(function() RUN:UnbindFromRenderStep("PlaggDandyWorld") end)
    if S.nofog or S.fb then
        RUN:BindToRenderStep("PlaggDandyWorld", Enum.RenderPriority.Last.Value, world)
    end
end

local function strip(v)
    pcall(function()
        if v:IsA("BasePart") then
            lagSet(v, "Material", Enum.Material.SmoothPlastic)
            lagSet(v, "Reflectance", 0)
            if v:IsA("MeshPart") then lagSet(v, "TextureID", "") end
        elseif v:IsA("Decal") or v:IsA("Texture") then
            lagSet(v, "Transparency", 1)
        elseif v:IsA("SpecialMesh") then
            lagSet(v, "TextureId", "")
        elseif v:IsA("SurfaceAppearance") then
            lagSet(v, "ColorMap", "")
            lagSet(v, "NormalMap", "")
            lagSet(v, "MetalnessMap", "")
            lagSet(v, "RoughnessMap", "")
        elseif v:IsA("ParticleEmitter") or v:IsA("Trail") or v:IsA("Fire") or v:IsA("Smoke") or v:IsA("Sparkles") or v:IsA("PostEffect") then
            lagSet(v, "Enabled", false)
        end
    end)
end

local lagQueue = {}
local lagBusy = false
local lagConn
local function lagQueueAdd(x)
    if #lagQueue > 8000 then return end
    lagQueue[#lagQueue + 1] = x
    if not lagBusy then
        lagBusy = true
        task.spawn(function()
            local n = 0
            while #lagQueue > 0 do
                local v = table.remove(lagQueue, 1)
                if v and v.Parent and S.lag then pcall(strip, v) end
                n = n + 1
                if n % 100 == 0 then task.wait() end
            end
            lagBusy = false
        end)
    end
end

local function setLag(v)
    S.lag = v
    if lagConn then
        lagConn:Disconnect()
        lagConn = nil
    end
    if v then
        lagConn = workspace.DescendantAdded:Connect(lagQueueAdd)
        task.spawn(function()
            local n = 0
            for _, x in ipairs(workspace:GetDescendants()) do
                if not S.lag then return end
                strip(x)
                n = n + 1
                if n % 400 == 0 then task.wait() end
            end
            for _, x in ipairs(Lt:GetDescendants()) do strip(x) end
        end)
    else
        lagQueue = {}
        lagUndo()
    end
end

ui:AddTheme({
    Name = "TishaBlue",
    Accent = C.accent,
    Outline = C.accent,
    Text = C.cyan,
    PlaceholderText = C.sub,
    Background = C.bg,
    Secondary = C.side,
    Tertiary = C.bar
})

local win = ui:CreateWindow({
    Title = "Tisha's Cleaner GUI",
    Size = UDim2.fromOffset(450, 300),
    Transparent = true,
    Theme = "TishaBlue",
    SideBarWidth = 140,
    HasOutline = false,
    ToggleOutline = false
})

local function sec(tab, title)
    pcall(function() tab:Section({Title = title}) end)
end

local vis = win:Tab({Title = "Visual", Icon = "eye"})
local plr = win:Tab({Title = "Player", Icon = "user"})
local tpt = win:Tab({Title = "Teleport", Icon = "map-pin"})
local aut = win:Tab({Title = "Automation", Icon = "cpu"})
vis:Select()

sec(vis, "ESP")
vis:Toggle({Title = "ESP Items", Value = false, Callback = function(v) S.esItem = v end})
vis:Toggle({Title = "ESP Twisteds", Value = false, Callback = function(v) S.esTw = v end})
vis:Toggle({Title = "ESP Generators", Value = false, Callback = function(v) S.esGen = v end})
vis:Toggle({Title = "ESP Players", Value = false, Callback = function(v) S.esPl = v end})
sec(vis, "Twisted Attacks")
vis:Toggle({Title = "Sprout Tendril ESP", Value = false, Callback = function(v)
    S.esTend = v
    if v then hazStart() end
end})
vis:Toggle({Title = "Blot Hands ESP", Value = false, Callback = function(v)
    S.esHand = v
    if v then hazStart() end
end})
vis:Toggle({Title = "Ichor Puddles ESP", Value = false, Callback = function(v)
    S.esPud = v
    if v then hazStart() end
end})
sec(vis, "ESP Settings")
vis:Toggle({Title = "Remove ESP Nametags", Value = false, Callback = function(v) S.noTags = v end})
vis:Toggle({Title = "Only Item Nametag On Disable ESP Nametag", Value = false, Callback = function(v) S.onlyItem = v end})
vis:Slider({Title = "ESP Text Size", Value = {Min = 8, Max = 60, Default = 14}, Step = 1, Callback = function(v) S.size = v end})

sec(vis, "ESP Items Blacklist")
vis:Dropdown({
    Title = "Blacklisted Items",
    Values = ITEM_OPTIONS,
    Multi = true,
    Callback = function(selected)
        S.itemBlacklist = {}
        for _, friendly in ipairs(selected) do
            local internal = ITEM_LOOKUP[friendly]
            if internal then
                S.itemBlacklist[internal] = true
            end
        end
    end
})

sec(vis, "Lighting")
vis:Toggle({Title = "Full Bright", Value = false, Callback = function(v)
    S.fb = v
    if not v then brUndo() end
    refreshWorld()
end})
vis:Toggle({Title = "No Fog", Value = false, Callback = function(v)
    S.nofog = v
    if not v then fogUndo() end
    refreshWorld()
end})

sec(vis, "Screen")
vis:Toggle({Title = "No Pop-ups (Vee)", Value = false, Callback = function(v)
    S.noPop = v
    if v then
        for _, h in pairs(hooked) do h.apply() end
        task.spawn(scanUi)
    end
end})
vis:Toggle({Title = "Anti Splotches", Value = false, Callback = function(v)
    S.noSplot = v
    if v then
        for _, h in pairs(hooked) do h.apply() end
        task.spawn(scanUi)
    end
end})

sec(vis, "Performance")
vis:Toggle({Title = "Anti Lag", Value = false, Callback = setLag})

sec(plr, "Speed")
plr:Toggle({Title = "Speed", Value = false, Callback = function(v)
    S.speed = v
    local _, hum = hrpOf()
    if v then
        if hum and hum.WalkSpeed ~= S.ws then ws0 = hum.WalkSpeed end
    elseif hum then
        hum.WalkSpeed = ws0 > 0 and ws0 or 16
    end
end})
plr:Slider({Title = "Walk Speed", Value = {Min = 0, Max = 100, Default = 50}, Step = 1, Callback = function(v) S.ws = v end})
plr:Toggle({Title = "TP Walk", Value = false, Callback = function(v) S.tpw = v end})
plr:Slider({Title = "TP Walk Speed", Value = {Min = 0, Max = 10, Default = 2}, Step = 0.1, Callback = function(v) S.tpv = v end})
sec(plr, "Movement")
plr:Toggle({Title = "Fly", Value = false, Callback = setFly})
plr:Slider({Title = "Fly Speed", Value = {Min = 0, Max = 50, Default = 30}, Step = 1, Callback = function(v) S.fs = v end})
plr:Toggle({Title = "Noclip", Value = false, Callback = setNoclip})
plr:Toggle({Title = "Spin", Value = false, Callback = function(v)
    S.spin = v
    local _, hum = hrpOf()
    if hum then hum.AutoRotate = not v end
end})
plr:Slider({Title = "Spin Speed", Value = {Min = 0, Max = 67, Default = 20}, Step = 1, Callback = function(v) S.spinv = v end})
sec(plr, "Abilities")
plr:Toggle({Title = "Infinite Stamina", Value = false, Callback = function(v)
    S.stam = v
    if v then
        stam.at = 0
        stam.gt = 0
    end
end})
plr:Toggle({Title = "Infinite Ability Range", Value = false, Callback = function(v)
    S.rng = v
    if not v then pcall(rangeScan, true) end
end})

sec(tpt, "Generators")
tpt:Button({Title = "TP To Generator", Callback = tpGen})
tpt:Toggle({Title = "Skip Machines With Twisted Near", Value = true, Callback = function(v) S.tpNearOn = v end})
tpt:Slider({Title = "Twisted Distance", Value = {Min = 5, Max = 150, Default = 35}, Step = 1, Callback = function(v) S.tpNear = v end})
tpt:Toggle({Title = "TP Generator Button", Value = false, Callback = function(v) tpGui.Enabled = v end})

sec(aut, "Abilities")
aut:Toggle({Title = "Auto Use Ability", Value = false, Callback = function(v) S.autoAbility = v end})
sec(aut, "Machines")
aut:Toggle({Title = "Auto Calibration", Value = false, Callback = function(v)
    S.autoCal = v
    getgenv().scinstant = v
end})
aut:Button({Title = "AutoBarnaby", Icon = "pointer", Callback = function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/christmas-cookie/extensions/refs/heads/main/arcademachine", true))()
end})
sec(aut, "Elevator")
aut:Toggle({Title = "Auto TP Elevator", Value = false, Callback = function(v) S.elev = v end})

notify("Tisha's Cleaner GUI loaded")
