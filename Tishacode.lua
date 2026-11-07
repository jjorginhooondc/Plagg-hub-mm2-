local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local RS = game:GetService("RunService")
local Lighting = game:GetService("Lighting")
local TweenService = game:GetService("TweenService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local me = Players.LocalPlayer
local pg = me:WaitForChild("PlayerGui")
local IMG = "rbxassetid://125702985812849"
local genv = (getgenv and getgenv()) or {}
pcall(function() if genv.TishaUI then genv.TishaUI:Destroy() end end)
pcall(function() if genv.TishaConn then genv.TishaConn:Disconnect() end end)
pcall(function() if genv.TishaConn2 then genv.TishaConn2:Disconnect() end end)
local WHITE = Color3.fromRGB(255, 255, 255)
local BG = Color3.fromRGB(244, 250, 255)
local PANEL = Color3.fromRGB(226, 242, 255)
local BLUE = Color3.fromRGB(56, 160, 255)
local CYAN = Color3.fromRGB(0, 215, 245)
local TEXT = Color3.fromRGB(24, 52, 92)
local SUB = Color3.fromRGB(96, 134, 184)
local BLACK = Color3.new(0, 0, 0)
local PURPLE = Color3.fromRGB(170, 70, 255)
local MAGENTA = Color3.fromRGB(230, 50, 220)
local GRAY = Color3.fromRGB(150, 150, 165)
local ORANGE = Color3.fromRGB(255, 140, 0)
local RED = Color3.fromRGB(255, 40, 40)
local GREEN = Color3.fromRGB(60, 255, 120)
local YELLOW = Color3.fromRGB(255, 230, 0)
local LIGHT_BLUE = Color3.fromRGB(110, 200, 255)
local ZERO = Vector3.new(0, 0, 0)
local TAG_UP = Vector3.new(0, 2.5, 0)
local THEMES = {
White = {
bg = BG, mainBg = BG, surface = WHITE, panel = PANEL, text = TEXT, sub = SUB,
accent = BLUE, border = Color3.fromRGB(150, 205, 255),
stroke = ColorSequence.new(CYAN, BLUE),
iconStroke = ColorSequence.new(WHITE, Color3.fromRGB(160, 215, 255)),
grad = ColorSequence.new(Color3.fromRGB(252, 254, 255), Color3.fromRGB(210, 234, 255)),
},
Black = {
bg = Color3.fromRGB(18, 20, 26), mainBg = WHITE, surface = Color3.fromRGB(29, 32, 41),
panel = Color3.fromRGB(46, 51, 64), text = Color3.fromRGB(226, 234, 248),
sub = Color3.fromRGB(128, 144, 172), accent = Color3.fromRGB(58, 134, 255),
border = Color3.fromRGB(66, 96, 142),
grad = ColorSequence.new(Color3.fromRGB(30, 33, 42), Color3.fromRGB(14, 16, 22)),
stroke = ColorSequence.new({
ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 229, 255)),
ColorSequenceKeypoint.new(0.5, Color3.fromRGB(124, 84, 255)),
ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 229, 255)),
}),
iconStroke = ColorSequence.new({
ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 229, 255)),
ColorSequenceKeypoint.new(0.5, Color3.fromRGB(124, 84, 255)),
ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 229, 255)),
}),
},
}
local T = THEMES.White
local themed = {}
local themeHooks = {}
local function paint(o, prop, key)
themed[#themed + 1] = {o, prop, key}
o[prop] = T[key]
end
local function applyTheme(name)
T = THEMES[name] or THEMES.White
for i = #themed, 1, -1 do
local e = themed[i]
if e[1].Parent then
e[1][e[2]] = T[e[3]]
else
table.remove(themed, i)
end
end
for _, f in ipairs(themeHooks) do pcall(f) end
end
local function mk(class, props, parent)
local o = Instance.new(class)
for k, v in pairs(props) do o[k] = v end
o.Parent = parent
return o
end
local function round(o, r)
local c = Instance.new("UICorner")
c.CornerRadius = UDim.new(0, r)
c.Parent = o
end
local function grad(o, a, b, rot)
local g = Instance.new("UIGradient")
g.Color = ColorSequence.new(a, b)
g.Rotation = rot or 0
g.Parent = o
return g
end
local function stroke(o, th)
local s = Instance.new("UIStroke")
s.Thickness = th
s.Color = WHITE
s.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
s.Parent = o
return s
end
local function outline(o)
local s = Instance.new("UIStroke")
s.Thickness = 1.5
s.Parent = o
paint(s, "Color", "border")
end
local function makeDraggable(btn)
local dragging, dragInput, dragStart, startPos
local state = {moved = false}
btn.InputBegan:Connect(function(input)
if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
dragging = true
state.moved = false
dragStart = input.Position
startPos = btn.Position
input.Changed:Connect(function()
if input.UserInputState == Enum.UserInputState.End then
dragging = false
end
end)
end
end)
btn.InputChanged:Connect(function(input)
if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
dragInput = input
end
end)
UIS.InputChanged:Connect(function(input)
if input == dragInput and dragging then
local delta = input.Position - dragStart
if delta.Magnitude > 8 then state.moved = true end
if state.moved then
btn.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
end
end
end)
return state
end
task.wait(5)
local gui = Instance.new("ScreenGui")
gui.Name = "TishaCleanerGui"
gui.ResetOnSpawn = false
gui.IgnoreGuiInset = true
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
local okParent = pcall(function() gui.Parent = (gethui and gethui()) or pg end)
if not okParent or not gui.Parent then gui.Parent = pg end
genv.TishaUI = gui
local main = mk("Frame", {
Name = "Main",
Size = UDim2.fromOffset(470, 300),
AnchorPoint = Vector2.new(0.5, 0.5),
Position = UDim2.fromScale(0.5, 0.5),
BorderSizePixel = 0,
Active = true,
Visible = true,
}, gui)
paint(main, "BackgroundColor3", "mainBg")
round(main, 16)
paint(grad(main, WHITE, WHITE, 90), "Color", "grad")
local uiScale = mk("UIScale", {}, main)
local mStroke = stroke(main, 3)
local mGrad = grad(mStroke, CYAN, BLUE, 45)
paint(mGrad, "Color", "stroke")
grad(mk("TextLabel", {
Size = UDim2.fromOffset(300, 34),
Position = UDim2.fromOffset(18, 8),
BackgroundTransparency = 1,
Text = "TISHA'S CLEANER GUI",
Font = Enum.Font.FredokaOne,
TextSize = 19,
TextColor3 = WHITE,
TextXAlignment = Enum.TextXAlignment.Left,
}, main), CYAN, Color3.fromRGB(40, 120, 235), 0)
local version = mk("TextLabel", {
Size = UDim2.fromOffset(70, 34),
AnchorPoint = Vector2.new(1, 0),
Position = UDim2.new(1, -52, 0, 8),
BackgroundTransparency = 1,
Text = "V:1.0",
Font = Enum.Font.GothamBold,
TextSize = 14,
TextXAlignment = Enum.TextXAlignment.Right,
}, main)
paint(version, "TextColor3", "sub")
local closeBtn = mk("TextButton", {
Size = UDim2.fromOffset(34, 34),
AnchorPoint = Vector2.new(0.5, 0.5),
Position = UDim2.new(1, -6, 0, 6),
Text = "X",
Font = Enum.Font.GothamBold,
TextSize = 16,
TextColor3 = BLUE,
AutoButtonColor = true,
BorderSizePixel = 0,
ZIndex = 5,
}, main)
paint(closeBtn, "BackgroundColor3", "surface")
round(closeBtn, 17)
grad(stroke(closeBtn, 2.5), CYAN, BLUE, 45)
local dragZone = mk("Frame", {
Size = UDim2.new(1, -60, 0, 44),
BackgroundTransparency = 1,
}, main)
local activeDragInput, dragStart, startPos = nil, nil, nil
dragZone.InputBegan:Connect(function(input)
if (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) and not activeDragInput then
activeDragInput = input
dragStart = input.Position
startPos = main.Position
end
end)
UIS.InputChanged:Connect(function(input)
if input == activeDragInput then
local d = (input.Position - dragStart) / uiScale.Scale
main.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + d.X,
startPos.Y.Scale, startPos.Y.Offset + d.Y)
end
end)
UIS.InputEnded:Connect(function(input)
if input == activeDragInput then
activeDragInput = nil
end
end)
local GAP = 8
local ROW_H = 36
local TABS = {"Player", "Visuals", "Automations", "Teleport", "Config"}
local contentPages = {}
for _, name in ipairs(TABS) do
local page = mk("ScrollingFrame", {
Position = UDim2.fromOffset(176, 96),
Size = UDim2.new(1, -190, 1, -110),
BackgroundTransparency = 1,
BorderSizePixel = 0,
CanvasSize = UDim2.new(0, 0, 0, 0),
AutomaticCanvasSize = Enum.AutomaticSize.Y,
ScrollBarThickness = 4,
Visible = false,
}, main)
mk("UIListLayout", {Padding = UDim.new(0, GAP), SortOrder = Enum.SortOrder.LayoutOrder}, page)
mk("UIPadding", {PaddingRight = UDim.new(0, 8)}, page)
contentPages[name] = page
end
local tabsFrame = mk("ScrollingFrame", {
Position = UDim2.fromOffset(14, 52),
Size = UDim2.fromOffset(136, 160),
BackgroundTransparency = 1,
BorderSizePixel = 0,
CanvasSize = UDim2.new(0, 0, 0, 0),
AutomaticCanvasSize = Enum.AutomaticSize.Y,
ScrollBarThickness = 3,
ScrollingDirection = Enum.ScrollingDirection.Y,
}, main)
mk("UIListLayout", {Padding = UDim.new(0, GAP), SortOrder = Enum.SortOrder.LayoutOrder}, tabsFrame)
mk("UIPadding", {PaddingRight = UDim.new(0, 8)}, tabsFrame)
local currentSelectedTab = "Player"
local tabButtons = {}
local searchBox
local function filterElements()
if not searchBox then return end
local query = searchBox.Text:lower()
local activePage = contentPages[currentSelectedTab]
if not activePage then return end
for _, child in ipairs(activePage:GetChildren()) do
if child:IsA("GuiObject") and child.Name == "ItemContainer" then
local textLabel = child:FindFirstChild("SearchText", true)
if textLabel and not (textLabel:IsA("TextButton") or textLabel:IsA("TextLabel") or textLabel:IsA("TextBox")) then
textLabel = textLabel:FindFirstChildWhichIsA("TextLabel", true)
end
if textLabel then
child.Visible = query == "" or textLabel.Text:lower():find(query, 1, true) ~= nil
end
end
end
end
local function selectTab(name)
currentSelectedTab = name
for n, b in pairs(tabButtons) do
local on = (n == name)
b.BackgroundColor3 = on and T.accent or T.surface
b.TextColor3 = on and WHITE or T.text
contentPages[n].Visible = on
end
filterElements()
end
themeHooks[#themeHooks + 1] = function() selectTab(currentSelectedTab) end
for i, name in ipairs(TABS) do
local b = mk("TextButton", {
Size = UDim2.new(1, 0, 0, ROW_H),
Text = name,
Font = Enum.Font.FredokaOne,
TextSize = 15,
AutoButtonColor = false,
BorderSizePixel = 0,
LayoutOrder = i,
}, tabsFrame)
round(b, 10)
outline(b)
tabButtons[name] = b
b.Activated:Connect(function() selectTab(name) end)
end
selectTab("Player")
local sep = mk("Frame", {
Position = UDim2.fromOffset(160, 52),
Size = UDim2.new(0, 3, 1, -70),
BackgroundColor3 = WHITE,
BorderSizePixel = 0,
}, main)
round(sep, 2)
grad(sep, CYAN, BLUE, 90)
searchBox = mk("TextBox", {
Position = UDim2.fromOffset(176, 52),
Size = UDim2.new(1, -176 - 14, 0, 34),
Text = "",
PlaceholderText = "Search",
Font = Enum.Font.GothamMedium,
TextSize = 14,
TextXAlignment = Enum.TextXAlignment.Left,
ClearTextOnFocus = false,
BorderSizePixel = 0,
}, main)
paint(searchBox, "BackgroundColor3", "surface")
paint(searchBox, "TextColor3", "text")
paint(searchBox, "PlaceholderColor3", "sub")
round(searchBox, 10)
mk("UIPadding", {PaddingLeft = UDim.new(0, 12), PaddingRight = UDim.new(0, 12)}, searchBox)
outline(searchBox)
searchBox:GetPropertyChangedSignal("Text"):Connect(filterElements)
local ComponentBuilder = {}
local rowCount = 0
local function newRow(tabName, height, order)
rowCount = rowCount + 1
return mk("Frame", {
Name = "ItemContainer",
LayoutOrder = order or (100 + rowCount),
Size = UDim2.new(1, 0, 0, height),
BackgroundTransparency = 1,
BorderSizePixel = 0,
}, contentPages[tabName])
end
function ComponentBuilder:CreateToggle(tabName, config)
local name = config.Name or "Toggle"
local callback = config.Callback or function() end
local currentValue = config.CurrentValue or false
local toggleBtn = mk("TextButton", {
Name = "SearchText",
Size = UDim2.new(1, 0, 1, 0),
Font = Enum.Font.GothamBold,
TextSize = 14,
AutoButtonColor = false,
BorderSizePixel = 0,
}, newRow(tabName, ROW_H, config.Order))
round(toggleBtn, 8)
outline(toggleBtn)
local function refresh()
toggleBtn.Text = "  " .. name .. ": " .. (currentValue and "ON" or "OFF")
toggleBtn.BackgroundColor3 = currentValue and T.accent or T.surface
toggleBtn.TextColor3 = currentValue and WHITE or T.text
end
themeHooks[#themeHooks + 1] = refresh
refresh()
if currentValue then pcall(callback, true) end
toggleBtn.Activated:Connect(function()
currentValue = not currentValue
refresh()
pcall(callback, currentValue)
end)
end
function ComponentBuilder:CreateButton(tabName, config)
local name = config.Name or "Button"
local callback = config.Callback or function() end
local btn = mk("TextButton", {
Name = "SearchText",
Size = UDim2.new(1, 0, 1, 0),
Text = "  " .. name,
Font = Enum.Font.GothamBold,
TextSize = 14,
AutoButtonColor = false,
BorderSizePixel = 0,
}, newRow(tabName, ROW_H))
paint(btn, "BackgroundColor3", "surface")
paint(btn, "TextColor3", "text")
round(btn, 8)
outline(btn)
btn.Activated:Connect(function()
pcall(callback)
end)
end
function ComponentBuilder:CreateSlider(tabName, config)
local name = config.Name or "Slider"
local min = config.Min or 1
local max = config.Max or 50
local default = config.Default or 25
local step = config.Step or 1
local callback = config.Callback or function() end
local currentVal = default
local sliderFrame = mk("Frame", {
Name = "SearchText",
Size = UDim2.new(1, 0, 1, 0),
BorderSizePixel = 0,
}, newRow(tabName, 54))
paint(sliderFrame, "BackgroundColor3", "surface")
round(sliderFrame, 8)
outline(sliderFrame)
local label = mk("TextLabel", {
Size = UDim2.new(1, -84, 0, 22),
Position = UDim2.fromOffset(6, 4),
BackgroundTransparency = 1,
Text = "  " .. name,
Font = Enum.Font.GothamBold,
TextSize = 13,
TextXAlignment = Enum.TextXAlignment.Left,
}, sliderFrame)
paint(label, "TextColor3", "text")
local box = mk("TextBox", {
AnchorPoint = Vector2.new(1, 0),
Position = UDim2.new(1, -8, 0, 5),
Size = UDim2.fromOffset(62, 22),
Font = Enum.Font.GothamBold,
TextSize = 13,
ClearTextOnFocus = true,
BorderSizePixel = 0,
}, sliderFrame)
paint(box, "BackgroundColor3", "panel")
paint(box, "TextColor3", "text")
round(box, 6)
local bar = mk("TextButton", {
Size = UDim2.new(1, -16, 0, 14),
Position = UDim2.fromOffset(8, 32),
Text = "",
AutoButtonColor = false,
BorderSizePixel = 0,
}, sliderFrame)
paint(bar, "BackgroundColor3", "panel")
round(bar, 6)
local fill = mk("Frame", {
Size = UDim2.new((default - min) / (max - min), 0, 1, 0),
BorderSizePixel = 0,
}, bar)
paint(fill, "BackgroundColor3", "accent")
round(fill, 6)
local function formatVal(v)
if step < 1 then
return string.format("%.1f", v)
end
return tostring(math.floor(v + 0.5))
end
box.Text = formatVal(currentVal)
local function setVal(v)
currentVal = math.clamp(min + math.floor((v - min) / step + 0.5) * step, min, max)
fill.Size = UDim2.new((currentVal - min) / (max - min), 0, 1, 0)
box.Text = formatVal(currentVal)
pcall(callback, currentVal)
end
box.FocusLost:Connect(function()
local n = tonumber(box.Text)
if n then setVal(n) else box.Text = formatVal(currentVal) end
end)
local activeSliderInput = nil
bar.InputBegan:Connect(function(input)
if (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) and not activeSliderInput then
activeSliderInput = input
end
end)
UIS.InputChanged:Connect(function(input)
if input == activeSliderInput then
local pos = math.clamp((input.Position.X - bar.AbsolutePosition.X) / bar.AbsoluteSize.X, 0, 1)
setVal(min + pos * (max - min))
end
end)
UIS.InputEnded:Connect(function(input)
if input == activeSliderInput then
activeSliderInput = nil
end
end)
end
function ComponentBuilder:CreateDropdown(tabName, config)
local name = config.Name or "Dropdown"
local options = config.Options or {}
local callback = config.Callback or function() end
local current = config.Default or options[1]
local HEAD, ROW = ROW_H, 30
local open = false
local wrapper = newRow(tabName, HEAD)
wrapper.ClipsDescendants = true
local head = mk("TextButton", {
Name = "SearchText",
Size = UDim2.new(1, 0, 0, HEAD),
Font = Enum.Font.GothamBold,
TextSize = 14,
TextXAlignment = Enum.TextXAlignment.Left,
AutoButtonColor = false,
BorderSizePixel = 0,
}, wrapper)
paint(head, "BackgroundColor3", "surface")
paint(head, "TextColor3", "text")
round(head, 8)
outline(head)
local arrow = mk("TextLabel", {
Size = UDim2.fromOffset(28, HEAD),
AnchorPoint = Vector2.new(1, 0),
Position = UDim2.new(1, -4, 0, 0),
BackgroundTransparency = 1,
Text = "▼",
Font = Enum.Font.GothamBold,
TextSize = 12,
}, head)
paint(arrow, "TextColor3", "sub")
local buttons = {}
local function refresh()
head.Text = "  " .. name .. ": " .. tostring(current)
for opt, b in pairs(buttons) do
local on = opt == current
b.BackgroundColor3 = on and T.accent or T.panel
b.TextColor3 = on and WHITE or T.text
end
end
local function setOpen(state)
open = state
arrow.Text = open and "▲" or "▼"
local h = open and (HEAD + 4 + #options * ROW) or HEAD
TweenService:Create(wrapper, TweenInfo.new(0.15, Enum.EasingStyle.Quad), {Size = UDim2.new(1, 0, 0, h)}):Play()
end
for i, opt in ipairs(options) do
local b = mk("TextButton", {
Name = "Option",
Size = UDim2.new(1, 0, 0, ROW - 4),
Position = UDim2.fromOffset(0, HEAD + 4 + (i - 1) * ROW),
Text = opt,
Font = Enum.Font.GothamBold,
TextSize = 13,
AutoButtonColor = false,
BorderSizePixel = 0,
}, wrapper)
round(b, 8)
buttons[opt] = b
b.Activated:Connect(function()
current = opt
refresh()
setOpen(false)
pcall(callback, opt)
end)
end
themeHooks[#themeHooks + 1] = refresh
refresh()
head.Activated:Connect(function() setOpen(not open) end)
end
local S = {
esItem = false, esTw = false, esGen = false, esPl = false, esTend = false, esHand = false, esPud = false, esPil = false,
noTags = false, onlyItem = false, size = 14
}
local camPos = ZERO
local torsoCache = {}
local itemCache = {}
local genCompleteTimes = {}
local genProg = {}
local function inWorld(i)
return i.Parent ~= nil and i:IsDescendantOf(workspace)
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
local function torsoOf(x)
local t = torsoCache[x]
if t and t.Parent then return t end
t = x:FindFirstChild("UpperTorso") or x:FindFirstChild("Torso")
or x:FindFirstChild("HumanoidRootPart") or partOf(x)
torsoCache[x] = t
return t
end
local HEAD_UP = Vector3.new(0, 1, 0)
local function plateOf(g)
local valve = g:FindFirstChild("Valve", true)
if valve then
if valve:IsA("BasePart") then return valve end
local bp = valve:FindFirstChildWhichIsA("BasePart", true)
if bp then return bp end
end
local p = g:FindFirstChild("Top_Diamond_Plate", true)
if p and not p:IsA("BasePart") then
p = p:FindFirstChildWhichIsA("BasePart", true)
end
return p or partOf(g)
end
local function topPlateOf(g)
local plate = g:FindFirstChild("Top_Diamond_Plate", true)
if plate then
if plate:IsA("BasePart") then return plate end
local bp = plate:FindFirstChildWhichIsA("BasePart", true)
if bp then return bp end
end
return plateOf(g)
end
local snap = {mon = {}, gen = {}, item = {}}
task.spawn(function()
while true do
local mon, gen, item = {}, {}, {}
local r = workspace:FindFirstChild("CurrentRoom")
if r then
local function scanFolder(folder)
if not folder then return end
for _, x in ipairs(folder:GetChildren()) do
if x:IsA("Model") or x:IsA("BasePart") then
item[#item + 1] = x
end
end
end
for _, m in ipairs(r:GetChildren()) do
local a = m:FindFirstChild("Monsters")
if a then for _, x in ipairs(a:GetChildren()) do mon[#mon + 1] = x end end
local b = m:FindFirstChild("Generators")
if b then for _, x in ipairs(b:GetChildren()) do gen[#gen + 1] = x end end
local c = m:FindFirstChild("Items")
if c then scanFolder(c) end
local d = m:FindFirstChild("StarPillows")
if d then scanFolder(d) end
local e = m:FindFirstChild("StarPillow")
if e then scanFolder(e) end
end
end
for _, x in ipairs(workspace:GetChildren()) do
local name = x.Name:lower()
if name:find("starpillow", 1, true) then
item[#item + 1] = x
end
end
snap.mon, snap.gen, snap.item = mon, gen, item
task.wait(0.15)
end
end)
local haz = {tend = {}, hand = {}, pud = {}}
local function inPlayer(v)
local a = v
while a and a ~= workspace do
if a:IsA("Model") and Players:GetPlayerFromCharacter(a) then return true end
a = a.Parent
end
return false
end
local function hazKind(v, n)
n = n or v.Name:lower()
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
if n:find("hand", 1, true) and not n:find("handle", 1, true) then
local p = v
for _ = 1, 6 do
if not p or p == workspace then break end
if p.Name:lower():find("blot", 1, true) then return "hand" end
p = p.Parent
end
end
end
local function hazClass(v)
return v:IsA("BasePart") or v:IsA("Model") or v:IsA("Decal") or v:IsA("Texture")
end
local function isHandOrInsideHand(t)
local a = t
for _ = 1, 7 do
if not a or a == workspace then break end
if hazKind(a) == "hand" then return true end
a = a.Parent
end
return false
end
local function hazScan(v)
if not hazClass(v) then return end
local n = v.Name:lower()
if not (n:find("tendril", 1, true) or n:find("tentacle", 1, true) or n:find("puddle", 1, true)
or n:find("hand", 1, true) or n:find("ichor", 1, true) or n:find("blot", 1, true)) then return end
local isDecal = v:IsA("Decal") or v:IsA("Texture")
local t = isDecal and v.Parent or v
if not (t and (t:IsA("BasePart") or t:IsA("Model"))) then return end
local k = hazKind(v, n)
if not k then return end
if v == t then
local p = t.Parent
if p and (p:IsA("BasePart") or p:IsA("Model")) and hazKind(p) == k then return end
end
if k == "pud" and isHandOrInsideHand(t) then return end
if inPlayer(t) then return end
haz[k][t] = true
end
local hazStarted = false
local function hazStart()
if hazStarted then return end
hazStarted = true
task.spawn(function()
for _, v in ipairs(workspace:GetDescendants()) do hazScan(v) end
end)
workspace.DescendantAdded:Connect(hazScan)
end
local pillowSet = {}
local pillowStarted = false
local function pillowAdd(v)
if v.Name:find("StarPillow", 1, true) and (v:IsA("Model") or v:IsA("BasePart"))
and not (v.Parent and v.Parent.Name:find("StarPillow", 1, true)) then
pillowSet[v] = true
end
end
local function pillowStart()
if pillowStarted then return end
pillowStarted = true
task.spawn(function()
for _, v in ipairs(workspace:GetDescendants()) do pillowAdd(v) end
end)
workspace.DescendantAdded:Connect(pillowAdd)
end
local reg = {item = {}, twist = {}, gen = {}, plr = {}, tend = {}, hand = {}, pud = {}, pillow = {}}
local seen = {}
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
local function newGui(part, off)
local g = Instance.new("BillboardGui")
g.Name = "PlaggESP"
g.AlwaysOnTop = true
g.StudsOffset = off
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
local function put(kind, target, part, txt, color, stroke, outline, fill, fillT, noHl, offOverride)
local bag = reg[kind]
local r = bag[target]
if not r then
r = {}
bag[target] = r
end
seen[r] = true
local tagOn = (not S.noTags) or (S.onlyItem and kind == "item")
if tagOn then
local off = offOverride or ((kind == "plr" or kind == "twist") and ZERO or TAG_UP)
if not r.gui or not r.gui.Parent or r.part ~= part then
if r.gui then r.gui:Destroy() end
r.gui, r.lbl = newGui(part, off)
r.part = part
end
if r.gui.StudsOffset ~= off then r.gui.StudsOffset = off end
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
if not noHl then
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
local function footprint(inst, part)
local ok, size = pcall(function()
if inst:IsA("Model") then return inst:GetExtentsSize() end
return part.Size
end)
if not ok or not size then size = part.Size end
return math.max(math.max(size.X, size.Z) / 2, 2)
end
local function nearestN(set, n, overlap)
local list = {}
for inst in pairs(set) do
if inWorld(inst) then
local part = partOf(inst)
if part then list[#list + 1] = {inst, part, (part.Position - camPos).Magnitude} end
else
set[inst] = nil
end
end
local cap = overlap and 120 or 400
if #list > cap then
table.sort(list, function(a, b) return a[3] < b[3] end)
for i = #list, cap + 1, -1 do list[i] = nil end
end
if overlap then
local top = {}
for _, e in ipairs(list) do
local hidden = false
local a = e[1].Parent
local depth = 0
while a and a ~= workspace and depth < 12 do
if set[a] then hidden = true break end
a = a.Parent
depth = depth + 1
end
if not hidden then
e[4] = footprint(e[1], e[2])
top[#top + 1] = e
end
end
table.sort(top, function(a, b) return a[3] < b[3] end)
local out = {}
for _, e in ipairs(top) do
local dup = false
local ep = e[2].Position
for _, k in ipairs(out) do
local kp = k[2].Position
local dx, dz = ep.X - kp.X, ep.Z - kp.Z
local reach = e[4] + k[4]
if dx * dx + dz * dz <= reach * reach then
dup = true
break
end
end
if not dup then
out[#out + 1] = e
if #out >= n then break end
end
end
return out
end
if #list <= n then return list end
table.sort(list, function(a, b) return a[3] < b[3] end)
for i = n + 1, #list do list[i] = nil end
return list
end
local function dropPudsOnHands(puds, hands)
if #hands == 0 then return puds end
local out = {}
for _, pe in ipairs(puds) do
local bad = false
for _, h in ipairs(hands) do
if pe[1] == h[1] or pe[1]:IsDescendantOf(h[1]) or h[1]:IsDescendantOf(pe[1]) then
bad = true
break
end
if not h[4] then h[4] = footprint(h[1], h[2]) end
local hp, pp = h[2].Position, pe[2].Position
local dx, dz = hp.X - pp.X, hp.Z - pp.Z
if dx * dx + dz * dz <= h[4] * h[4] then
bad = true
break
end
end
if not bad then out[#out + 1] = pe end
end
return out
end
local function itemLabel(it)
local pp = it:FindFirstChildWhichIsA("ProximityPrompt", true)
local t = pp and pp.ObjectText
if type(t) == "string" and t ~= "" then return t end
return (tostring(it.Name):gsub("(%l)(%u)", "%1 %2"))
end
local ITEM_STYLES = {
{"skillcheck", ORANGE, WHITE},
{"extraction", PURPLE, WHITE},
{"jumper", YELLOW, BLACK},
{"instruction", CYAN, BLACK},
{"bandage", Color3.fromRGB(255, 120, 190), BLACK},
{"healthkit", Color3.fromRGB(255, 70, 70), WHITE},
{"kit", ORANGE, BLACK},
{"chocolate", Color3.fromRGB(205, 130, 70), BLACK},
{"candy", GREEN, BLACK},
{"pop", GREEN, BLACK},
{"gumball", GREEN, BLACK},
{"horn", PURPLE, BLACK},
{"tape", Color3.fromRGB(110, 200, 255), BLACK},
{"ornament", RED, WHITE},
{"basket", YELLOW, BLACK},
{"starpillow", Color3.fromRGB(255, 200, 60), WHITE},
{"stopwatch", GRAY, BLACK},
}
local function itemStyle(name)
local n = tostring(name):lower()
for _, st in ipairs(ITEM_STYLES) do
if n:find(st[1], 1, true) then return st[2], st[3] end
end
return WHITE, BLACK
end
local function shortName(b)
if b == "RazzleDazzle" then return "R&D" end
return b
end
local function researchOf(raw)
raw = tostring(raw)
local pd = ReplicatedStorage:FindFirstChild("PlayerData")
local mine = pd and pd:FindFirstChild(tostring(me.UserId))
local rs = mine and mine:FindFirstChild("Research")
if not rs then return nil end
local base = raw:gsub("Monster", "")
local e = rs:FindFirstChild(base .. "Monster") or rs:FindFirstChild(raw) or rs:FindFirstChild(base)
if not e then
local want = (base .. "monster"):lower()
for _, c in ipairs(rs:GetChildren()) do
local cn = c.Name:lower()
if cn == want or cn == base:lower() then e = c break end
end
end
if not e then return 0 end
local v = e
if not e:IsA("ValueBase") then
v = e:FindFirstChild("Value") or e:FindFirstChildWhichIsA("ValueBase", true)
end
if v and v:IsA("ValueBase") then
local x = v.Value
if type(x) == "number" then return math.floor(x * 100 + 0.5) / 100 end
if type(x) == "string" then return tonumber(x) end
end
return nil
end
local function capTwisted(it)
local pr = it:FindFirstChild("Prompt", true)
local m = pr and pr:FindFirstChild("Monster", true)
local v = m
if m and not m:IsA("ValueBase") then v = m:FindFirstChild("Value", true) end
if v and v:IsA("ValueBase") then
local x = v.Value
if typeof(x) == "Instance" then x = x.Name end
if x ~= nil and tostring(x) ~= "" then
local raw = tostring(x)
local base = raw:gsub("Monster", "")
local txt = shortName(base)
local pct = researchOf(raw)
if pct then txt = txt .. " | " .. math.floor(pct + 0.5) .. "%" end
return txt, base
end
end
end
local function itemData(it)
local now = tick()
local c = itemCache[it]
if not c then
local n = it.Name:lower()
c = {t = -100}
if n:find("capsule", 1, true) and n:find("fake", 1, true) then
c.fake = true
c.label = "Fake Capsule"
c.color = GREEN
elseif n:find("capsule", 1, true) then
c.cap = true
c.label = "Research Capsule"
elseif n:find("pumpkin", 1, true) then
c.pump = true
c.kind = "pumpkin"
c.label = "Pumpkin"
end
itemCache[it] = c
end
if not c.part or not c.part.Parent then c.part = partOf(it) end
if not c.cap and not c.pump and not c.fake and not it.Name:lower():find("fake", 1, true) and now - (c.t3 or -100) >= 1 then
c.t3 = now
if capTwisted(it) then
c.cap = true
c.label = "Research Capsule"
end
end
if now - c.t >= 3 then
c.t = now
if not c.cap and not c.pump and not c.fake then
c.label = itemLabel(it)
c.color, c.stroke = itemStyle(it.Name)
end
end
if c.cap and now - (c.t2 or -100) >= 1 then
c.t2 = now
local tw, base = capTwisted(it)
c.twBase = base
c.label = tw and ("Research Capsule\n" .. tw) or "Research Capsule"
end
return c, c.label
end
local RARITY = {}
for rarity, list in pairs({
common = {"Boxten", "Brusha", "Cosmo", "Looey", "Poppy", "Shrimpo", "Tisha", "Yatta"},
uncommon = {"Brightney", "Connie", "Finn", "RazzleDazzle", "Razzle", "Dazzle", "Rodger", "Teagan", "Toodles"},
rare = {"Blot", "Flutter", "Gigi", "Glisten", "Goob", "Scraps", "Squirm", "Waxwell"},
main = {"Astro", "Pebble", "Shelly", "Sprout", "Vee"},
lethal = {"Dandy", "Dyle"},
}) do
for _, n in ipairs(list) do RARITY[n:lower()] = rarity end
end
local RARE_BLUE = Color3.fromRGB(40, 130, 255)
local COMMON_GREEN = Color3.fromRGB(150, 235, 40)
local function capColor(base)
local r = RARITY[tostring(base):lower()]
if r == "common" then return COMMON_GREEN end
if r == "uncommon" then return GREEN end
if r == "rare" then return RARE_BLUE end
if r == "main" then return Color3.fromHSV((tick() * 0.5) % 1, 1, 1) end
if r == "lethal" then return RED end
return WHITE
end
local function pumpColor()
local t = (math.sin(tick() * 3) + 1) / 2
return ORANGE:Lerp(YELLOW, t)
end
local S_nofog = false
local S_fb = false
local function keeper()
local store = setmetatable({}, {__mode = "k"})
local function set(i, p, v)
local t = store[i]
if not t then t = {} store[i] = t end
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
local atmosAt = 0
local function worldLighting()
if S_nofog then
local now = tick()
if now - atmosAt > 2 then
atmosAt = now
for _, a in ipairs(Lighting:GetChildren()) do
if a:IsA("Atmosphere") then
fogSet(a, "Density", 0)
fogSet(a, "Offset", 0)
fogSet(a, "Haze", 0)
fogSet(a, "Glare", 0)
end
end
end
fogSet(Lighting, "FogEnd", 1e9)
fogSet(Lighting, "FogStart", 1e9)
end
if S_fb then
brSet(Lighting, "Brightness", 2)
brSet(Lighting, "ClockTime", 14)
brSet(Lighting, "GlobalShadows", false)
brSet(Lighting, "Ambient", WHITE)
brSet(Lighting, "OutdoorAmbient", WHITE)
end
end
RS.RenderStepped:Connect(function(dt)
local any = S.esTw or S.esGen or S.esPl or S.esTend or S.esHand or S.esPud or S.esItem or S.esPil
if any then
if S.esTend or S.esHand or S.esPud then
local cam = workspace.CurrentCamera
if cam then camPos = cam.CFrame.Position end
end
if S.esTw then
for _, m in ipairs(snap.mon) do
local part = torsoOf(m)
if part then
put("twist", m, part, shortName((tostring(m.Name):gsub("Monster", ""))), RED, WHITE, RED, RED, 0.5, nil, HEAD_UP) end
end
end
if S.esGen then
local nowTick = tick()
for _, g in ipairs(snap.gen) do
local st = g:FindFirstChild("Stats")
local completed = st and st:FindFirstChild("Completed") and st.Completed.Value == true
if completed then
if not genCompleteTimes[g] then
genCompleteTimes[g] = nowTick + 1
end
else
genCompleteTimes[g] = nil
end
if not completed or (genCompleteTimes[g] and nowTick < genCompleteTimes[g]) then
local part = topPlateOf(g)
if part then
local curAmt, reqAmt = 0, 0
if st then
local cVal = st:FindFirstChild("CurrentAmount")
local rVal = st:FindFirstChild("RequiredAmount")
if cVal and rVal then
curAmt, reqAmt = math.floor(cVal.Value or 0), math.floor(rVal.Value or 0)
end
end
local pr = genProg[g]
if not pr then
pr = {v = curAmt, t = -100}
genProg[g] = pr
end
if pr.v ~= curAmt then
pr.v = curAmt
pr.t = nowTick
end
local txt
if nowTick - pr.t < 1.5 then
txt = "Generator (" .. curAmt .. "/" .. reqAmt .. ")\nbeing completed"
else
txt = "Generator\n(" .. curAmt .. "/" .. reqAmt .. ")"
end
put("gen", g, part, txt, GRAY, WHITE, WHITE, GRAY, 0.5, false)
end
end
end
end
if S.esPl then
for _, p in ipairs(Players:GetPlayers()) do
local c = p ~= me and p.Character
if c then
local hum = c:FindFirstChildOfClass("Humanoid")
local part = torsoOf(c)
if hum and part and hum.Health > 0 then put("plr", c, part, p.Name, GREEN, BLACK, WHITE, nil, nil, nil, HEAD_UP) end
end
end
end
if S.esTend then
for _, e in ipairs(nearestN(haz.tend, 20)) do put("tend", e[1], e[2], "Sprout Tendril", PURPLE) end
end
local hands = {}
if S.esHand or S.esPud then
hands = nearestN(haz.hand, 20)
end
if S.esHand then
for _, e in ipairs(hands) do put("hand", e[1], e[2], "Blot's Hand", WHITE) end
end
if S.esPud then
local puds = dropPudsOnHands(nearestN(haz.pud, 12, true), hands)
for _, e in ipairs(puds) do
put("pud", e[1], e[2], "Ichor Puddle", MAGENTA, BLACK, MAGENTA, MAGENTA, 0.5, false)
end
end
if S.esPil then
for v in pairs(pillowSet) do
if inWorld(v) then
local part = partOf(v)
if part then put("pillow", v, part, "Star Pillow", LIGHT_BLUE, WHITE, WHITE, LIGHT_BLUE, 0.5, false) end
else
pillowSet[v] = nil
end
end
end
if S.esItem then
local pc = pumpColor()
for _, it in ipairs(snap.item) do
local c, label = itemData(it)
if c.part then
local color, stroke, hl = c.color or WHITE, c.stroke or BLACK, nil
if c.cap then
color, stroke, hl = capColor(c.twBase), WHITE, GREEN
elseif c.kind == "pumpkin" then
color = pc
end
hl = hl or color
put("item", it, c.part, label, color, stroke, hl, hl, 1, false)
local r = reg.item[it]
if r then
r.anim = (c.kind == "pumpkin") and "pumpkin" or nil
end
end
end
end
sweep()
end
if S_nofog or S_fb then
worldLighting()
end
end)
local noclipEnabled = false
local noclipConns = {}
local noclipOrig = setmetatable({}, {__mode = "k"})
local noclipCleaned = setmetatable({}, {__mode = "k"})
local function cleanPart(part)
if noclipCleaned[part] or not getconnections then return end
noclipCleaned[part] = true
local signals = {
part:GetPropertyChangedSignal("CanQuery"),
part:GetPropertyChangedSignal("CanCollide"),
part:GetPropertyChangedSignal("CanTouch"),
part.Changed,
}
for _, sig in ipairs(signals) do
pcall(function()
for _, conn in ipairs(getconnections(sig)) do conn:Disconnect() end
end)
end
end
local function noclipStep()
local character = me.Character
if not character then return end
for _, part in ipairs(character:GetDescendants()) do
if part:IsA("BasePart") then
if noclipOrig[part] == nil then noclipOrig[part] = part.CanCollide end
cleanPart(part)
if part.CanCollide then part.CanCollide = false end
end
end
end
local function stopNoclip()
for _, c in ipairs(noclipConns) do pcall(function() c:Disconnect() end) end
noclipConns = {}
for part, was in pairs(noclipOrig) do
pcall(function()
if part.Parent and part.Name ~= "HumanoidRootPart" then part.CanCollide = was end
end)
end
noclipOrig = setmetatable({}, {__mode = "k"})
end
local function updateNoclip()
stopNoclip()
if noclipEnabled then
noclipConns[#noclipConns + 1] = RS.Stepped:Connect(noclipStep)
noclipConns[#noclipConns + 1] = RS.Heartbeat:Connect(noclipStep)
noclipConns[#noclipConns + 1] = RS.RenderStepped:Connect(noclipStep)
end
end
local function setNoclip(state)
noclipEnabled = state
updateNoclip()
end
me.CharacterAdded:Connect(function(char)
char:WaitForChild("HumanoidRootPart")
noclipOrig = setmetatable({}, {__mode = "k"})
noclipCleaned = setmetatable({}, {__mode = "k"})
if noclipEnabled then
updateNoclip()
end
end)
ComponentBuilder:CreateToggle("Player", {
Name = "Noclip",
CurrentValue = false,
Callback = function(Value)
setNoclip(Value)
end,
})
local flyActive = false
local flySpeed = 25
local gravityOriginal = workspace.Gravity
if gravityOriginal < 1 then gravityOriginal = 196.2 end
local function setFly(state)
flyActive = state
if state then
if workspace.Gravity > 0 then gravityOriginal = workspace.Gravity end
workspace.Gravity = 0
else
workspace.Gravity = gravityOriginal
end
end
local tpwActive = false
local tpwSpeed = 2
RS.Heartbeat:Connect(function(dt)
local character = me.Character
local hrp = character and character:FindFirstChild("HumanoidRootPart")
local humanoid = character and character:FindFirstChildOfClass("Humanoid")
if not (hrp and humanoid) then return end
if flyActive then
if workspace.Gravity ~= 0 then workspace.Gravity = 0 end
local cam = workspace.CurrentCamera
local look = cam.CFrame.LookVector
local flat = Vector3.new(look.X, 0, look.Z).Unit
local right = Vector3.new(-flat.Z, 0, flat.X)
local dir = humanoid.MoveDirection
local mv = ZERO
if dir.Magnitude > 0.01 then
mv = look * dir:Dot(flat) + cam.CFrame.RightVector * dir:Dot(right)
else
local f = (UIS:IsKeyDown(Enum.KeyCode.W) and 1 or 0) - (UIS:IsKeyDown(Enum.KeyCode.S) and 1 or 0)
local r = (UIS:IsKeyDown(Enum.KeyCode.D) and 1 or 0) - (UIS:IsKeyDown(Enum.KeyCode.A) and 1 or 0)
local u = (UIS:IsKeyDown(Enum.KeyCode.Space) and 1 or 0) - (UIS:IsKeyDown(Enum.KeyCode.LeftShift) and 1 or 0)
mv = look * f + cam.CFrame.RightVector * r + Vector3.new(0, u, 0)
end
hrp.AssemblyLinearVelocity = ZERO
if mv.Magnitude > 0.01 and flySpeed > 0 then
hrp.CFrame = hrp.CFrame + mv.Unit * (flySpeed * dt)
end
end
local dir = humanoid.MoveDirection
if tpwActive and tpwSpeed > 0 and dir.Magnitude > 0.01 then
hrp.CFrame = hrp.CFrame + dir * (tpwSpeed * 10 * dt)
end
end)
ComponentBuilder:CreateToggle("Player", {
Name = "Fly",
CurrentValue = false,
Callback = setFly,
})
ComponentBuilder:CreateSlider("Player", {
Name = "Fly Speed",
Min = 1,
Max = 40,
Default = 25,
Callback = function(Value) flySpeed = Value end,
})
local speedActive = false
local walkSpeedValue = 25
RS.Heartbeat:Connect(function()
if not speedActive then return end
local character = me.Character
local humanoid = character and character:FindFirstChildOfClass("Humanoid")
if humanoid and humanoid.WalkSpeed ~= walkSpeedValue then
humanoid.WalkSpeed = walkSpeedValue
end
end)
ComponentBuilder:CreateToggle("Player", {
Name = "Speed",
CurrentValue = false,
Callback = function(Value)
speedActive = Value
local character = me.Character
local humanoid = character and character:FindFirstChildOfClass("Humanoid")
if humanoid and not Value then
humanoid.WalkSpeed = 16
end
end,
})
ComponentBuilder:CreateSlider("Player", {
Name = "Speed",
Min = 1,
Max = 50,
Default = 25,
Callback = function(Value)
walkSpeedValue = Value
end,
})
ComponentBuilder:CreateToggle("Player", {
Name = "TP Walk",
CurrentValue = false,
Callback = function(v) tpwActive = v end,
})
ComponentBuilder:CreateSlider("Player", {
Name = "TP Walk Speed",
Min = 0,
Max = 10,
Default = 2,
Step = 0.1,
Callback = function(v) tpwSpeed = v end,
})
local rngOrig = {}
local function rangeScan(restore)
if not (getconnections and getupvalues) then return end
for _, conn in pairs(getconnections(RS.RenderStepped)) do
local func = conn.Function
if func then
local ok, upvals = pcall(getupvalues, func)
if ok and upvals then
for _, val in pairs(upvals) do
if typeof(val) == "table" and val.Name and (val.Name == "Shelly" or val.Name == "Sprout" or val.Name == "Cosmo" or val.Name == "Scraps" or val.Name == "Glisten") and val.PlayerRadius then
if restore then
local o = rngOrig[val]
if o then val.PlayerRadius = o rngOrig[val] = nil end
else
if rngOrig[val] == nil then rngOrig[val] = val.PlayerRadius end
val.PlayerRadius = 500
end
end
end
end
end
end
end
ComponentBuilder:CreateToggle("Player", {
Name = "Infinite Ability Range",
CurrentValue = false,
Callback = function(v)
if v then rangeScan(false) else pcall(rangeScan, true) end
end,
})
ComponentBuilder:CreateToggle("Visuals", {Name = "ESP Items", CurrentValue = false, Callback = function(v) S.esItem = v end})
ComponentBuilder:CreateToggle("Visuals", {Name = "ESP Twisteds", CurrentValue = false, Callback = function(v) S.esTw = v end})
ComponentBuilder:CreateToggle("Visuals", {Name = "ESP Generators", CurrentValue = false, Callback = function(v) S.esGen = v end})
ComponentBuilder:CreateToggle("Visuals", {Name = "ESP Players", CurrentValue = false, Callback = function(v) S.esPl = v end})
ComponentBuilder:CreateToggle("Visuals", {Name = "Sprout Tendril ESP", CurrentValue = false, Callback = function(v) S.esTend = v if v then hazStart() end end})
ComponentBuilder:CreateToggle("Visuals", {Name = "Blot Hands ESP", CurrentValue = false, Callback = function(v) S.esHand = v if v then hazStart() end end})
ComponentBuilder:CreateToggle("Visuals", {Name = "ESP Star Pillows", CurrentValue = false, Callback = function(v) S.esPil = v if v then pillowStart() end end})
ComponentBuilder:CreateToggle("Visuals", {Name = "Ichor Puddles ESP", CurrentValue = false, Callback = function(v) S.esPud = v if v then hazStart() end end})
ComponentBuilder:CreateToggle("Visuals", {Name = "Remove ESP Nametags", CurrentValue = false, Callback = function(v) S.noTags = v end})
ComponentBuilder:CreateToggle("Visuals", {Name = "Only Item Nametag On Disable", CurrentValue = false, Callback = function(v) S.onlyItem = v end})
ComponentBuilder:CreateSlider("Visuals", {Name = "ESP Text Size", Min = 8, Max = 60, Default = 14, Step = 1, Callback = function(v) S.size = v end})
ComponentBuilder:CreateToggle("Visuals", {Name = "Full Bright", CurrentValue = false, Callback = function(v) S_fb = v if not v then brUndo() end end})
ComponentBuilder:CreateToggle("Visuals", {Name = "No Fog", CurrentValue = false, Callback = function(v) S_nofog = v if not v then fogUndo() end end})
local autoAbilityEnabled = false
local veeEnabled, veeBusy = false, false
local autoCalibrationEnabled = false
local autoElevatorEnabled = false
RS.Heartbeat:Connect(function()
if autoAbilityEnabled then
pcall(function()
local char = me.Character
local hrp = char and char:FindFirstChild("HumanoidRootPart")
local ev = ReplicatedStorage:FindFirstChild("Events")
local ab = ev and ev:FindFirstChild("AbilityEvent")
if char and hrp and ab then
ab:InvokeServer(char, hrp.CFrame, false)
end
end)
end
end)
ComponentBuilder:CreateToggle("Automations", {
Name = "Auto Use Ability",
CurrentValue = false,
Callback = function(v) autoAbilityEnabled = v end,
})
task.spawn(function()
pcall(function()
local events = ReplicatedStorage:FindFirstChild("Events")
if events then
local event = events:FindFirstChild("SkillcheckUpdate")
if event and getcallbackvalue then
local ogcb = getcallbackvalue(event, "OnClientInvoke")
if ogcb then
local safeOrig = clonefunction and clonefunction(ogcb) or ogcb
local oldcb
oldcb = hookfunction(ogcb, function(...)
if autoCalibrationEnabled then return "supercomplete" end
return (oldcb or safeOrig)(...)
end)
end
end
end
end)
end)
ComponentBuilder:CreateToggle("Automations", {
Name = "Auto Calibration",
CurrentValue = false,
Callback = function(v) autoCalibrationEnabled = v end,
})
local function getElevatorPos()
local e = workspace:FindFirstChild("Elevators")
e = e and e:FindFirstChild("Elevator")
if not e then return nil end
local b = e:FindFirstChild("Base")
if b and b:IsA("BasePart") then return b.Position + Vector3.new(0, 4, 0) end
return e:GetPivot().Position + Vector3.new(0, 4, 0)
end
local function allGeneratorsDone()
local info = workspace:FindFirstChild("Info")
local c = info and info:FindFirstChild("GeneratorsCompleted") and info.GeneratorsCompleted.Value
local r = info and info:FindFirstChild("RequiredGenerators") and info.RequiredGenerators.Value
if type(c) == "number" and type(r) == "number" and r > 0 then return c >= r end
return false
end
local function isInsideElevator(hrp)
local e = workspace:FindFirstChild("Elevators")
e = e and e:FindFirstChild("Elevator")
if not e then return false end
local ok, cf, size = pcall(function() return e:GetBoundingBox() end)
if not ok or not cf then return false end
local rel = cf:PointToObjectSpace(hrp.Position)
return math.abs(rel.X) <= size.X / 2 + 2
and math.abs(rel.Z) <= size.Z / 2 + 2
and math.abs(rel.Y) <= size.Y / 2 + 8
end
local elevatorArmed = true
local elevatorNotDoneSince = nil
local elevatorFirstTp = nil
RS.Stepped:Connect(function()
if not autoElevatorEnabled or veeBusy then return end
if not allGeneratorsDone() then
elevatorNotDoneSince = elevatorNotDoneSince or tick()
if tick() - elevatorNotDoneSince >= 3 then
elevatorArmed = true
elevatorFirstTp = nil
end
return
end
elevatorNotDoneSince = nil
if not elevatorArmed then return end
local hrp = me.Character and me.Character:FindFirstChild("HumanoidRootPart")
if not hrp then return end
if isInsideElevator(hrp) then
elevatorArmed = false
return
end
if elevatorFirstTp and tick() - elevatorFirstTp > 1.5 then
elevatorArmed = false
return
end
local pos = getElevatorPos()
if pos then
elevatorFirstTp = elevatorFirstTp or tick()
hrp.CFrame = CFrame.new(pos)
end
end)
ComponentBuilder:CreateToggle("Automations", {
Name = "Auto TP Elevator",
CurrentValue = false,
Callback = function(v)
autoElevatorEnabled = v
elevatorArmed = true
elevatorNotDoneSince = nil
elevatorFirstTp = nil
end,
})
local savedPosition = nil
local originalGravity = 196.2
local collectingState = false
local RANK = {caps = 1, heal = 2, tape = 3, event = 4, extr = 5}
local PICK = {caps = false, event = false, heal = false, extr = false, tape = false}
local INVENTORY_MAX = 3
local function slotFilled(slot)
local v = slot
if not slot:IsA("ValueBase") then v = slot:FindFirstChild("Value") end
if not (v and v:IsA("ValueBase")) then return false end
local x = v.Value
return x ~= nil and x ~= "" and x ~= false and tostring(x):lower() ~= "none"
end
local function getInventory()
local igp = workspace:FindFirstChild("InGamePlayers")
local mine = igp and (igp:FindFirstChild(me.Name) or igp:FindFirstChild(tostring(me.UserId)))
return mine and mine:FindFirstChild("Inventory")
end
local function inventoryFull()
local inv = getInventory()
if not inv then return false end
local filled, cap = 0, INVENTORY_MAX
for _, slot in ipairs(inv:GetChildren()) do
if slot.Name:match("^Slot%d+$") and slotFilled(slot) then
filled = filled + 1
if slot.Name == "Slot4" then cap = 4 end
end
end
return filled >= cap
end
local function hasAny(n, list)
for _, w in ipairs(list) do
if n:find(w, 1, true) then return true end
end
return false
end
local function pickKind(it)
local n = it.Name
if n:find("Fake", 1, true) or n:find("Stopwatch", 1, true) then return nil end
if PICK.event and hasAny(n, {"Pumpkin", "Ornament", "Basket", "StarPillow"}) then return "event", false end
if PICK.heal and hasAny(n, {"Bandage", "HealthKit"}) then return "heal", true end
if PICK.extr and hasAny(n, {"JumperCable", "SkillCheckCandy", "ExtractionSpeedCandy", "Instructions"}) then return "extr", true end
if PICK.tape and n:find("Tape", 1, true) then return "tape", false end
return nil
end
local function anyPickEnabled()
return PICK.caps or PICK.event or PICK.heal or PICK.extr or PICK.tape
end
local function endCollecting(hrp)
if collectingState then
collectingState = false
workspace.Gravity = originalGravity
local h = hrp or (me.Character and me.Character:FindFirstChild("HumanoidRootPart"))
if savedPosition and h then h.CFrame = savedPosition end
savedPosition = nil
end
end
task.spawn(function()
while true do
task.wait(0.05)
if anyPickEnabled() then
pcall(function()
local char = me.Character
local hrp = char and char:FindFirstChild("HumanoidRootPart")
local room = workspace:FindFirstChild("CurrentRoom")
if not (hrp and room) or veeBusy then return end
local targets = {}
if PICK.caps then
for _, m in ipairs(room:GetDescendants()) do
if m.Name:find("ResearchCapsule", 1, true) then
local part = partOf(m)
if part then
targets[#targets + 1] = {
part = part,
prompt = m:FindFirstChildWhichIsA("ProximityPrompt", true),
rank = RANK.caps,
}
end
end
end
end
if PICK.event or PICK.heal or PICK.extr or PICK.tape then
local full = nil
for _, it in ipairs(snap.item) do
if it.Parent then
local kind, needsInv = pickKind(it)
if kind then
if needsInv then
if full == nil then full = inventoryFull() end
end
if not (needsInv and full) then
local part = partOf(it)
local prompt = it:FindFirstChildWhichIsA("ProximityPrompt", true)
if part and prompt and prompt.Enabled then
targets[#targets + 1] = {part = part, prompt = prompt, rank = RANK[kind]}
end
end
end
end
end
end
if #targets > 0 then
if not collectingState then
collectingState = true
savedPosition = hrp.CFrame
if workspace.Gravity > 0 then
originalGravity = workspace.Gravity
end
workspace.Gravity = 0
end
local t = targets[1]
for i = 2, #targets do
if targets[i].rank < t.rank then t = targets[i] end
end
hrp.CFrame = CFrame.new(t.part.Position - Vector3.new(0, 7, 0))
task.wait(0.02)
if t.prompt and fireproximityprompt then
fireproximityprompt(t.prompt)
end
else
endCollecting(hrp)
end
end)
else
endCollecting()
end
end
end)
ComponentBuilder:CreateToggle("Automations", {
Name = "Auto Pick Up Capsules",
Order = 2,
CurrentValue = false,
Callback = function(v) PICK.caps = v end,
})
ComponentBuilder:CreateToggle("Automations", {
Name = "Auto Pick Up Event Currency",
Order = 6,
CurrentValue = false,
Callback = function(v) PICK.event = v end,
})
ComponentBuilder:CreateToggle("Automations", {
Name = "Auto Pick Up Heals",
Order = 4,
CurrentValue = false,
Callback = function(v) PICK.heal = v end,
})
ComponentBuilder:CreateToggle("Automations", {
Name = "Auto Pick Up Extraction Items",
Order = 7,
CurrentValue = false,
Callback = function(v) PICK.extr = v end,
})
ComponentBuilder:CreateToggle("Automations", {
Name = "Auto Pick Up Tapes",
Order = 5,
CurrentValue = false,
Callback = function(v) PICK.tape = v end,
})
local veeSeen = setmetatable({}, {__mode = "k"})
local veePending = {}
local veeDone = false
local function veeThreshold(m)
local n = m.Name
return (n:find("Dyle", 1, true) or n:find("Dandy", 1, true)) and 70 or 35
end
local function veeMargin(part)
local best = math.huge
for _, m in ipairs(snap.mon) do
local mp = torsoOf(m)
if mp then
best = math.min(best, (mp.Position - part.Position).Magnitude - veeThreshold(m))
end
end
return best
end
local function startMachine(g)
local valve = g:FindFirstChild("Valve", true)
local prompt = valve and valve:FindFirstChildWhichIsA("ProximityPrompt", true)
if not prompt then
for _, d in ipairs(g:GetDescendants()) do
if d:IsA("ProximityPrompt") and d.Enabled then prompt = d break end
end
end
if prompt and prompt.Enabled and fireproximityprompt then
fireproximityprompt(prompt)
end
end
local VEE_STAY, VEE_TRIES = 1.5, 20
local function machineDone(g)
local st = g:FindFirstChild("Stats")
local c = st and st:FindFirstChild("Completed")
return c ~= nil and c.Value == true
end
local function machineAmount(g)
local st = g:FindFirstChild("Stats")
local c = st and st:FindFirstChild("CurrentAmount")
return c and tonumber(c.Value) or 0
end
local function useVee(g)
local char = me.Character
local hrp = char and char:FindFirstChild("HumanoidRootPart")
local part = plateOf(g)
if not (hrp and part) then return false end
veeBusy = true
local back = hrp.CFrame
local ok = false
pcall(function()
for _ = 1, VEE_TRIES do
if not g.Parent or machineDone(g) then ok = true break end
local startAmount = machineAmount(g)
local t0 = tick()
local fired1, fired2 = false, false
while tick() - t0 < VEE_STAY do
local h = me.Character and me.Character:FindFirstChild("HumanoidRootPart")
local p = plateOf(g)
if not (h and p) then return end
local target = p.CFrame + Vector3.new(0, 3, 0)
if (h.Position - target.Position).Magnitude > 6 then
h.AssemblyLinearVelocity = ZERO
h.CFrame = target
end
local el = tick() - t0
if not fired1 and el >= 0.3 then fired1 = true startMachine(g) end
if not fired2 and el >= 0.8 then fired2 = true startMachine(g) end
task.wait(0.05)
end
if not g.Parent or machineDone(g) or machineAmount(g) > startAmount then ok = true break end
end
end)
local h2 = me.Character and me.Character:FindFirstChild("HumanoidRootPart")
if h2 then
h2.AssemblyLinearVelocity = ZERO
h2.CFrame = back
end
veeBusy = false
return ok
end
task.spawn(function()
while true do
task.wait(0.3)
if #snap.gen == 0 then veeDone = false end
if veeEnabled and not veeDone and not veeBusy then
pcall(function()
for _, g in ipairs(snap.gen) do
if not veeSeen[g] then
veeSeen[g] = true
veePending[#veePending + 1] = g
end
end
local bestIdx, bestMargin
for i = #veePending, 1, -1 do
local g = veePending[i]
local st = g:FindFirstChild("Stats")
local done = st and st:FindFirstChild("Completed") and st.Completed.Value == true
if not g.Parent or done then
table.remove(veePending, i)
else
local part = plateOf(g)
if part then
local mg = veeMargin(part)
if mg >= 0 and (not bestMargin or mg > bestMargin) then
bestIdx, bestMargin = i, mg
end
end
end
end
if bestIdx then
endCollecting()
veeDone = useVee(table.remove(veePending, bestIdx))
end
end)
end
end
end)
ComponentBuilder:CreateToggle("Automations", {
Name = "Auto Use Vee Remote",
Order = 1,
CurrentValue = false,
Callback = function(v)
veeEnabled = v
veePending = {}
veeDone = false
if v then veeSeen = setmetatable({}, {__mode = "k"}) end
end,
})
ComponentBuilder:CreateButton("Automations", {
Name = "Auto Barnaby",
Callback = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/christmas-cookie/extensions/refs/heads/main/arcademachine", true))()
end,
})
local tpSkipMonster = true
local tpMonsterDist = 35
local GEN_BUSY_TIME = 1.5
task.spawn(function()
while true do
task.wait(0.25)
local now = tick()
for _, g in ipairs(snap.gen) do
local st = g:FindFirstChild("Stats")
local cVal = st and st:FindFirstChild("CurrentAmount")
if cVal then
local amt = math.floor(tonumber(cVal.Value) or 0)
local pr = genProg[g]
if not pr then
genProg[g] = {v = amt, t = -100}
elseif pr.v ~= amt then
pr.v = amt
pr.t = now
end
end
end
end
end)
local function getClosestGen()
local bestGen, shortestDist = nil, math.huge
local hrp = me.Character and me.Character:FindFirstChild("HumanoidRootPart")
if not hrp then return nil end
for _, g in ipairs(snap.gen) do
local st = g:FindFirstChild("Stats")
local completed = st and st:FindFirstChild("Completed") and st.Completed.Value == true
local pr = genProg[g]
local busy = pr ~= nil and tick() - pr.t < GEN_BUSY_TIME
if not completed and not busy then
local part = plateOf(g)
if part then
local dist = (part.Position - hrp.Position).Magnitude
if dist < shortestDist then
if tpSkipMonster then
local safe = true
for _, m in ipairs(snap.mon) do
local mPart = torsoOf(m)
if mPart and (mPart.Position - part.Position).Magnitude <= tpMonsterDist then
safe = false
break
end
end
if safe then
shortestDist = dist
bestGen = part
end
else
shortestDist = dist
bestGen = part
end
end
end
end
end
return bestGen
end
local function getClosestTopPlate()
local bestPart, shortestDist = nil, math.huge
local hrp = me.Character and me.Character:FindFirstChild("HumanoidRootPart")
if not hrp then return nil end
for _, g in ipairs(snap.gen) do
local part = topPlateOf(g)
if part then
local dist = (part.Position - hrp.Position).Magnitude
if dist < shortestDist then
shortestDist = dist
bestPart = part
end
end
end
return bestPart
end
local function tpTo(part)
local hrp = me.Character and me.Character:FindFirstChild("HumanoidRootPart")
if hrp and part then hrp.CFrame = part.CFrame + Vector3.new(0, 3, 0) end
end
ComponentBuilder:CreateButton("Teleport", {
Name = "TP To Generator",
Callback = function() tpTo(getClosestGen()) end,
})
ComponentBuilder:CreateButton("Teleport", {
Name = "TP Above Gen",
Callback = function() tpTo(getClosestTopPlate()) end,
})
ComponentBuilder:CreateToggle("Teleport", {
Name = "Skip Machines With Twisted Near",
CurrentValue = true,
Callback = function(v) tpSkipMonster = v end,
})
ComponentBuilder:CreateSlider("Teleport", {
Name = "Twisted Distance",
Min = 10,
Max = 100,
Default = 35,
Step = 1,
Callback = function(v) tpMonsterDist = v end,
})
local floatBtns = {}
local function floatToggle(text, textSize, yScale, getTarget)
return function(v)
local b = floatBtns[text]
if v and not b then
b = mk("TextButton", {
Name = "Float" .. text:gsub(" ", ""),
Size = UDim2.fromOffset(110, 40),
Position = UDim2.new(0.5, -55, yScale, 0),
BackgroundColor3 = BLUE,
Text = text,
Font = Enum.Font.FredokaOne,
TextSize = textSize,
TextColor3 = WHITE,
AutoButtonColor = true,
BorderSizePixel = 0,
ZIndex = 25,
}, gui)
round(b, 10)
stroke(b, 2)
local drag = makeDraggable(b)
b.Activated:Connect(function()
if not drag.moved then tpTo(getTarget()) end
end)
floatBtns[text] = b
end
if b then b.Visible = v end
end
end
ComponentBuilder:CreateToggle("Teleport", {
Name = "TP Generator Button",
CurrentValue = false,
Callback = floatToggle("TP Generator", 14, 0.85, getClosestGen),
})
ComponentBuilder:CreateToggle("Teleport", {
Name = "TP Above Gen Button",
CurrentValue = false,
Callback = floatToggle("TP Above Gen", 13, 0.78, getClosestTopPlate),
})
local footImg = mk("ImageLabel", {
Position = UDim2.fromOffset(14, 222),
Size = UDim2.fromOffset(64, 64),
Image = IMG,
ScaleType = Enum.ScaleType.Fit,
BorderSizePixel = 0,
}, main)
paint(footImg, "BackgroundColor3", "surface")
round(footImg, 8)
grad(stroke(footImg, 2.5), CYAN, BLUE, 45)
local openBtn = mk("ImageButton", {
Name = "Open",
Size = UDim2.fromOffset(54, 54),
Position = UDim2.new(0, 12, 0.4, 0),
Image = IMG,
ScaleType = Enum.ScaleType.Fit,
AutoButtonColor = false,
BorderSizePixel = 0,
Active = true,
}, gui)
paint(openBtn, "BackgroundColor3", "bg")
round(openBtn, 4)
local oGrad = grad(stroke(openBtn, 3), WHITE, WHITE, 45)
paint(oGrad, "Color", "iconStroke")
do
local activeOpenInput, moved = nil, false
local sPos, sBtn
openBtn.InputBegan:Connect(function(input)
if (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) and not activeOpenInput then
activeOpenInput = input
moved = false
sPos = input.Position
sBtn = openBtn.Position
end
end)
genv.TishaConn2 = UIS.InputChanged:Connect(function(input)
if input == activeOpenInput then
local d = input.Position - sPos
if d.Magnitude > 8 then moved = true end
if moved then
openBtn.Position = UDim2.new(sBtn.X.Scale, sBtn.X.Offset + d.X,
sBtn.Y.Scale, sBtn.Y.Offset + d.Y)
end
end
end)
UIS.InputEnded:Connect(function(input)
if input == activeOpenInput then
if not moved then main.Visible = not main.Visible end
activeOpenInput = nil
end
end)
end
closeBtn.Activated:Connect(function()
main.Visible = false
end)
genv.TishaConn = RS.Heartbeat:Connect(function()
local r = (tick() * 45) % 360
if main.Visible then mGrad.Rotation = r end
oGrad.Rotation = r
end)
local SIZE_OPTIONS = {"Small", "Medium", "Large"}
local GUI_SCALES = {Small = 0.8, Medium = 1, Large = 1.2}
local ICON_SIZES = {Small = 40, Medium = 54, Large = 72}
ComponentBuilder:CreateDropdown("Config", {
Name = "GUI Size",
Options = SIZE_OPTIONS,
Default = "Medium",
Callback = function(v) uiScale.Scale = GUI_SCALES[v] or 1 end,
})
ComponentBuilder:CreateDropdown("Config", {
Name = "Icon Size",
Options = SIZE_OPTIONS,
Default = "Medium",
Callback = function(v)
local s = ICON_SIZES[v] or 54
openBtn.Size = UDim2.fromOffset(s, s)
end,
})
ComponentBuilder:CreateDropdown("Config", {
Name = "Color GUI Sections",
Options = {"White", "Black"},
Default = "White",
Callback = applyTheme,
})
local NOTIF_OUT = UDim2.new(1, 20, 1, -70)
local notifFrame = mk("Frame", {
Size = UDim2.fromOffset(260, 50),
Position = NOTIF_OUT,
BorderSizePixel = 0,
ZIndex = 10,
}, gui)
paint(notifFrame, "BackgroundColor3", "mainBg")
round(notifFrame, 12)
paint(grad(notifFrame, WHITE, WHITE, 90), "Color", "grad")
grad(stroke(notifFrame, 2), CYAN, BLUE, 45)
paint(mk("TextLabel", {
Size = UDim2.new(1, -40, 1, 0),
Position = UDim2.fromOffset(12, 0),
BackgroundTransparency = 1,
Text = "tisha's cleaner gui loaded",
Font = Enum.Font.FredokaOne,
TextSize = 13,
TextXAlignment = Enum.TextXAlignment.Left,
ZIndex = 11,
}, notifFrame), "TextColor3", "text")
local notifClose = mk("TextButton", {
Size = UDim2.fromOffset(24, 24),
AnchorPoint = Vector2.new(1, 0.5),
Position = UDim2.new(1, -8, 0.5, 0),
Text = "X",
Font = Enum.Font.GothamBold,
TextSize = 12,
TextColor3 = BLUE,
AutoButtonColor = true,
BorderSizePixel = 0,
ZIndex = 12,
}, notifFrame)
paint(notifClose, "BackgroundColor3", "surface")
round(notifClose, 12)
grad(stroke(notifClose, 1.5), CYAN, BLUE, 45)
local function removeNotif()
local tweenOut = TweenService:Create(notifFrame, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Position = NOTIF_OUT})
tweenOut:Play()
tweenOut.Completed:Connect(function()
pcall(function() notifFrame:Destroy() end)
end)
end
notifClose.Activated:Connect(removeNotif)
task.spawn(function()
task.wait(0.1)
TweenService:Create(notifFrame, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
Position = UDim2.new(1, -275, 1, -70)
}):Play()
task.wait(7)
removeNotif()
end)
