--[[
 .____                  ________ ___.    _____                           __                
 |    |    __ _______   \_____  \\_ |___/ ____\_ __  ______ ____ _____ _/  |_  ___________ 
 |    |   |  |  \__  \   /   |   \| __ \   __\  |  \/  ___// ___\\__  \\   __\/  _ \_  __ \
 |    |___|  |  // __ \_/    |    \ \_\ \  | |  |  /\___ \\  \___ / __ \|  | (  <_> )  | \/
 |_______ \____/(____  /\_______  /___  /__| |____//____  >\___  >____  /__|  \____/|__|   
         \/          \/         \/    \/                \/     \/     \/                   
          \_Welcome to LuaObfuscator.com   (Alpha 0.10.9) ~  Much Love, Ferib 

]]--

local okUi, ui = pcall(function()
	return loadstring(game:HttpGet("https://github.com/Footagesus/WindUI/releases/latest/download/main.lua"))();
end);
if (not okUi or (type(ui) ~= "table")) then
	local FlatIdent_95CAC = 0;
	while true do
		if (FlatIdent_95CAC == 0) then
			warn("[Plagg] WindUI failed to load:", ui);
			return;
		end
	end
end
local P = game:GetService("Players");
local TS = game:GetService("TweenService");
local RS = game:GetService("ReplicatedStorage");
local VU = game:GetService("VirtualUser");
local UIS = game:GetService("UserInputService");
local RUN = game:GetService("RunService");
local Lt = game:GetService("Lighting");
local TPS = game:GetService("TeleportService");
local TCS = game:GetService("TextChatService");
local me = P.LocalPlayer;
local MSG_M = "%s é o murder";
local MSG_S = "%s é o sheriff";
local o = {esp=false,gun=false,trap=false,grab=false,sa=false,farm=false,xp=false,reset=false,spd=25,dbg=false};
local K = {on=false};
local F = {hold=0.03};
local L = {speed=false,ws=50,jump=false,jp=100,inf=false,noclip=false,fly=false,fs=50};
local W = {nofog=false,bright=false,lag=false,fov=false,fovv=90,grav=false,gv=196};
local S = {coins=0,elapsed=0,since=nil};
local made = {ESP_Player={},ESP_Gun={},ESP_Trap={}};
local RED, BLUE, GREEN = Color3.fromRGB(255, 60, 60), Color3.fromRGB(60, 140, 255), Color3.fromRGB(60, 255, 120);
local YELLOW, ORANGE, BLACK, WHITE = Color3.fromRGB(255, 230, 0), Color3.fromRGB(255, 140, 0), Color3.new(0, 0, 0), Color3.new(1, 1, 1);
local MAGENTA, CYAN, AMBER = Color3.fromRGB(255, 60, 200), Color3.fromRGB(0, 200, 255), Color3.fromRGB(255, 150, 20);
local coins, traps, drop = {}, {}, nil;
local roles, ready = {}, false;
local full, tw, mChar, mPart, misses = false, nil, nil, nil, 0;
local fulls = {};
local lobbyTarget;
local grav0 = workspace.Gravity;
local fov0 = nil;
local flicking = false;
local pauseUntil = 0;
local mapSet = {};
for _, n in ipairs({"Bank 2","Bio Lab","Factory","Hospital 3","Hotel 2","House 2","Mansion 2","Mil Base","Office 3","Police Station","Research Facility","Workplace","Beach Resort","Yacht","Manor","Farmhouse","Mineshaft","Barn","Vampire's Castle","Spaceship","Workshop","Log Cabin","Train Station","Ice Castle","Ski Lodge","Christmas in Italy","Ski Village"}) do
	mapSet[n] = true;
end
local function notify(txt)
	pcall(function()
		ui({Title="Plagg Hub",Content=txt,Duration=4});
	end);
end
local function loop(delay, fn)
	task.spawn(function()
		local FlatIdent_76979 = 0;
		local last;
		while true do
			if (FlatIdent_76979 == 0) then
				last = nil;
				while true do
					local ok, err = pcall(fn);
					if (not ok and (tostring(err) ~= last)) then
						last = tostring(err);
						warn("[Plagg]", err);
					end
					task.wait(delay);
				end
				break;
			end
		end
	end);
end
local function farmOn()
	return o.farm or o.xp;
end
local function clock()
	if farmOn() then
		if not S.since then
			S.since = tick();
		end
	elseif S.since then
		local FlatIdent_69270 = 0;
		while true do
			if (FlatIdent_69270 == 0) then
				S.elapsed = S.elapsed + (tick() - S.since);
				S.since = nil;
				break;
			end
		end
	end
end
local function secs()
	return S.elapsed + ((S.since and (tick() - S.since)) or 0);
end
local function fmt(t)
	local FlatIdent_6D4CB = 0;
	while true do
		if (FlatIdent_6D4CB == 0) then
			t = math.floor(t);
			return string.format("%02d:%02d:%02d", math.floor(t / 3600), math.floor((t % 3600) / 60), t % 60);
		end
	end
end
local function setRoles(d)
	local FlatIdent_10BCC = 0;
	while true do
		if (0 == FlatIdent_10BCC) then
			if (type(d) ~= "table") then
				return;
			end
			if next(d) then
				local FlatIdent_2BD95 = 0;
				local ok;
				while true do
					if (FlatIdent_2BD95 == 1) then
						if not ok then
							return;
						end
						break;
					end
					if (FlatIdent_2BD95 == 0) then
						ok = false;
						for _, v in pairs(d) do
							if ((type(v) == "table") and v.Role) then
								ok = true;
								break;
							end
						end
						FlatIdent_2BD95 = 1;
					end
				end
			end
			FlatIdent_10BCC = 1;
		end
		if (FlatIdent_10BCC == 1) then
			roles, ready = d, true;
			break;
		end
	end
end
task.spawn(function()
	local ev, fn;
	for _ = 1, 30 do
		ev = ev or RS:FindFirstChild("PlayerDataChanged", true);
		fn = fn or RS:FindFirstChild("GetPlayerData", true);
		if (ev and fn) then
			break;
		end
		task.wait(1);
	end
	if (ev and ev:IsA("RemoteEvent")) then
		ev.OnClientEvent:Connect(setRoles);
	end
	if (fn and fn:IsA("RemoteFunction")) then
		while task.wait(2) do
			if (o.esp or o.farm or o.xp or o.sa or o.reset or K.on) then
				local FlatIdent_25011 = 0;
				local ok;
				local d;
				while true do
					if (FlatIdent_25011 == 0) then
						ok, d = pcall(fn.InvokeServer, fn);
						if ok then
							setRoles(d);
						end
						break;
					end
				end
			end
		end
	end
end);
local function role(p)
	local FlatIdent_7DD24 = 0;
	local d;
	local r;
	local c;
	local b;
	while true do
		if (3 == FlatIdent_7DD24) then
			if ((c and c:FindFirstChild("Knife")) or (b and b:FindFirstChild("Knife"))) then
				return "Murderer", RED;
			end
			if ((c and c:FindFirstChild("Gun")) or (b and b:FindFirstChild("Gun"))) then
				return "Sheriff", BLUE;
			end
			FlatIdent_7DD24 = 4;
		end
		if (FlatIdent_7DD24 == 1) then
			if (r == "Murderer") then
				return "Murderer", RED;
			end
			if ((r == "Sheriff") or (r == "Hero")) then
				return r, BLUE;
			end
			FlatIdent_7DD24 = 2;
		end
		if (4 == FlatIdent_7DD24) then
			return "Innocent", GREEN;
		end
		if (FlatIdent_7DD24 == 2) then
			if r then
				return "Innocent", GREEN;
			end
			c, b = p.Character, p:FindFirstChild("Backpack");
			FlatIdent_7DD24 = 3;
		end
		if (FlatIdent_7DD24 == 0) then
			d = roles[p.Name];
			r = (type(d) == "table") and d.Role;
			FlatIdent_7DD24 = 1;
		end
	end
end
local function murd()
	for _, p in ipairs(P:GetPlayers()) do
		if ((p ~= me) and p.Character and (role(p) == "Murderer")) then
			return p;
		end
	end
end
local function tag(part, id, txt, col)
	if (not part or not part.Parent) then
		return;
	end
	local g = part:FindFirstChild(id);
	if not g then
		g = Instance.new("BillboardGui");
		g.Name = id;
		g.Size = UDim2.new(0, 120, 0, 30);
		g.StudsOffset = Vector3.new(0, 2.5, 0);
		g.AlwaysOnTop = true;
		g.Adornee = part;
		g.Parent = part;
		local t = Instance.new("TextLabel");
		t.Name = "T";
		t.Size = UDim2.new(1, 0, 1, 0);
		t.BackgroundTransparency = 1;
		t.TextScaled = true;
		t.Font = Enum.Font.Bangers;
		t.TextStrokeColor3 = BLACK;
		t.TextStrokeTransparency = 0;
		t.Parent = g;
		made[id][g] = true;
	end
	local t = g:FindFirstChild("T");
	if not t then
		return;
	end
	if (t.Text ~= txt) then
		t.Text = txt;
	end
	if (t.TextColor3 ~= col) then
		t.TextColor3 = col;
	end
end
local function glow(char, id, col)
	local FlatIdent_27957 = 0;
	local h;
	while true do
		if (FlatIdent_27957 == 1) then
			if (h.FillColor ~= col) then
				h.FillColor = col;
			end
			break;
		end
		if (0 == FlatIdent_27957) then
			h = char:FindFirstChild(id);
			if not h then
				local FlatIdent_8F59B = 0;
				while true do
					if (FlatIdent_8F59B == 1) then
						h.FillTransparency = 0.5;
						h.OutlineColor = BLACK;
						FlatIdent_8F59B = 2;
					end
					if (FlatIdent_8F59B == 0) then
						h = Instance.new("Highlight");
						h.Name = id;
						FlatIdent_8F59B = 1;
					end
					if (FlatIdent_8F59B == 3) then
						h.Parent = char;
						made[id][h] = true;
						break;
					end
					if (FlatIdent_8F59B == 2) then
						h.OutlineTransparency = 0;
						h.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop;
						FlatIdent_8F59B = 3;
					end
				end
			end
			FlatIdent_27957 = 1;
		end
	end
end
local function clear(id)
	local FlatIdent_2D2B8 = 0;
	while true do
		if (FlatIdent_2D2B8 == 0) then
			for v in pairs(made[id]) do
				pcall(function()
					v:Destroy();
				end);
			end
			made[id] = {};
			break;
		end
	end
end
local function scan(v)
	local FlatIdent_E0D0 = 0;
	local n;
	while true do
		if (FlatIdent_E0D0 == 0) then
			n = v.Name;
			if ((n == "Coin_Server") and v:IsA("BasePart")) then
				coins[v] = true;
			elseif ((n == "Trap") and v:IsA("BasePart")) then
				traps[v] = true;
			elseif (n == "GunDrop") then
				drop = v;
			end
			break;
		end
	end
end
for _, v in ipairs(workspace:GetDescendants()) do
	scan(v);
end
workspace.DescendantAdded:Connect(scan);
workspace.DescendantRemoving:Connect(function(v)
	local FlatIdent_8DCA9 = 0;
	while true do
		if (FlatIdent_8DCA9 == 1) then
			if (v == drop) then
				drop = nil;
			end
			break;
		end
		if (FlatIdent_8DCA9 == 0) then
			coins[v] = nil;
			traps[v] = nil;
			FlatIdent_8DCA9 = 1;
		end
	end
end);
local function inRound()
	local FlatIdent_39764 = 0;
	local d;
	while true do
		if (FlatIdent_39764 == 0) then
			if not next(coins) then
				return false;
			end
			if not ready then
				return true;
			end
			FlatIdent_39764 = 1;
		end
		if (FlatIdent_39764 == 1) then
			d = roles[me.Name];
			return (type(d) == "table") and (d.Role ~= nil) and not d.Dead;
		end
	end
end
local function pickSpawn(folder)
	local FlatIdent_35A31 = 0;
	local list;
	while true do
		if (FlatIdent_35A31 == 0) then
			list = folder and folder:GetChildren();
			if (not list or not list[1]) then
				return;
			end
			FlatIdent_35A31 = 1;
		end
		if (FlatIdent_35A31 == 1) then
			for _ = 1, #list do
				local s = list[math.random(#list)];
				if (s:IsA("BasePart") or s:IsA("Model")) then
					return s:GetPivot().Position + Vector3.new(0, 4, 0);
				end
			end
			break;
		end
	end
end
local function topModel(x)
	local FlatIdent_64E40 = 0;
	while true do
		if (FlatIdent_64E40 == 0) then
			while x and x.Parent and (x.Parent ~= workspace) do
				x = x.Parent;
			end
			return x;
		end
	end
end
local function findLobby()
	local FlatIdent_8D1A5 = 0;
	local l;
	while true do
		if (0 == FlatIdent_8D1A5) then
			l = workspace:FindFirstChild("RegularLobby");
			if l then
				return l;
			end
			FlatIdent_8D1A5 = 1;
		end
		if (1 == FlatIdent_8D1A5) then
			for _, m in ipairs(workspace:GetChildren()) do
				if (m:IsA("Model") and m.Name:lower():find("lobby", 1, true)) then
					return m;
				end
			end
			break;
		end
	end
end
local function lobbyPos()
	local FlatIdent_6DC53 = 0;
	local l;
	local pos;
	local p;
	while true do
		if (0 == FlatIdent_6DC53) then
			l = findLobby();
			if not l then
				return;
			end
			FlatIdent_6DC53 = 1;
		end
		if (1 == FlatIdent_6DC53) then
			pos = pickSpawn(l:FindFirstChild("Spawns", true));
			if pos then
				return pos;
			end
			FlatIdent_6DC53 = 2;
		end
		if (2 == FlatIdent_6DC53) then
			p = l:FindFirstChildWhichIsA("BasePart", true);
			return p and (p.Position + Vector3.new(0, 8, 0));
		end
	end
end
local function mapPos()
	local FlatIdent_28F3E = 0;
	local c;
	while true do
		if (FlatIdent_28F3E == 0) then
			for _, m in ipairs(workspace:GetChildren()) do
				if mapSet[m.Name] then
					local FlatIdent_98388 = 0;
					local pos;
					local p;
					while true do
						if (FlatIdent_98388 == 1) then
							p = m:FindFirstChildWhichIsA("BasePart", true);
							if p then
								return p.Position + Vector3.new(0, 8, 0);
							end
							break;
						end
						if (FlatIdent_98388 == 0) then
							pos = pickSpawn(m:FindFirstChild("Spawns", true));
							if pos then
								return pos;
							end
							FlatIdent_98388 = 1;
						end
					end
				end
			end
			c = next(coins);
			FlatIdent_28F3E = 1;
		end
		if (FlatIdent_28F3E == 1) then
			if (c and c.Parent) then
				local FlatIdent_3CF36 = 0;
				local m;
				while true do
					if (0 == FlatIdent_3CF36) then
						m = topModel(c);
						if (m and (m ~= c)) then
							local FlatIdent_1A54 = 0;
							local pos;
							while true do
								if (0 == FlatIdent_1A54) then
									pos = pickSpawn(m:FindFirstChild("Spawns", true));
									if pos then
										return pos;
									end
									break;
								end
							end
						end
						FlatIdent_3CF36 = 1;
					end
					if (FlatIdent_3CF36 == 1) then
						return c.Position + Vector3.new(0, 4, 0);
					end
				end
			end
			break;
		end
	end
end
loop(0.5, function()
	local FlatIdent_61800 = 0;
	while true do
		if (FlatIdent_61800 == 0) then
			if o.esp then
				for _, p in ipairs(P:GetPlayers()) do
					local FlatIdent_DFF4 = 0;
					local c;
					local d;
					while true do
						if (FlatIdent_DFF4 == 0) then
							c = (p ~= me) and p.Character;
							d = roles[p.Name];
							FlatIdent_DFF4 = 1;
						end
						if (FlatIdent_DFF4 == 1) then
							if (c and not ((type(d) == "table") and d.Dead)) then
								local r, col = role(p);
								tag(c:FindFirstChild("HumanoidRootPart"), "ESP_Player", p.Name .. " [" .. r .. "]", col);
								glow(c, "ESP_Player", col);
							end
							break;
						end
					end
				end
			end
			if (o.gun and drop) then
				tag(drop, "ESP_Gun", "Dropped Gun", YELLOW);
			end
			FlatIdent_61800 = 1;
		end
		if (FlatIdent_61800 == 1) then
			if o.trap then
				for t in pairs(traps) do
					tag(t, "ESP_Trap", "Trap", ORANGE);
				end
			end
			break;
		end
	end
end);
loop(0.1, function()
	local FlatIdent_1B881 = 0;
	local hrp;
	while true do
		if (FlatIdent_1B881 == 1) then
			if not hrp then
				return;
			end
			if firetouchinterest then
				local FlatIdent_1FC27 = 0;
				while true do
					if (FlatIdent_1FC27 == 0) then
						firetouchinterest(hrp, drop, 0);
						firetouchinterest(hrp, drop, 1);
						break;
					end
				end
			else
				local FlatIdent_691EB = 0;
				local old;
				while true do
					if (FlatIdent_691EB == 1) then
						task.wait(0.15);
						hrp.CFrame = old;
						break;
					end
					if (FlatIdent_691EB == 0) then
						old = hrp.CFrame;
						hrp.CFrame = drop.CFrame;
						FlatIdent_691EB = 1;
					end
				end
			end
			break;
		end
		if (FlatIdent_1B881 == 0) then
			if not (o.grab and drop and drop.Parent and drop:IsA("BasePart")) then
				return;
			end
			hrp = me.Character and me.Character:FindFirstChild("HumanoidRootPart");
			FlatIdent_1B881 = 1;
		end
	end
end);
local function setFull(v)
	if (full ~= v) then
		full = v;
		if not v then
			misses = 0;
		end
		if o.dbg then
			print("[Plagg] bag full:", v);
		end
	end
end
task.spawn(function()
	local FlatIdent_578E3 = 0;
	local ev;
	while true do
		if (FlatIdent_578E3 == 0) then
			ev = nil;
			for _ = 1, 30 do
				ev = RS:FindFirstChild("CoinCollected", true);
				if ev then
					break;
				end
				task.wait(1);
			end
			FlatIdent_578E3 = 1;
		end
		if (FlatIdent_578E3 == 1) then
			if (ev and ev:IsA("RemoteEvent")) then
				ev.OnClientEvent:Connect(function(...)
					local FlatIdent_70B9A = 0;
					local n;
					while true do
						if (FlatIdent_70B9A == 0) then
							n = {};
							for _, v in ipairs({...}) do
								if (type(v) == "number") then
									n[#n + 1] = v;
								end
							end
							FlatIdent_70B9A = 1;
						end
						if (FlatIdent_70B9A == 1) then
							if o.dbg then
								print("[Plagg] coin:", ...);
							end
							if (#n >= 2) then
								setFull(n[#n - 1] >= n[#n]);
							end
							break;
						end
					end
				end);
			end
			break;
		end
	end
end);
local function chk(g)
	local FlatIdent_81225 = 0;
	local p;
	while true do
		if (FlatIdent_81225 == 1) then
			for _ = 1, 4 do
				local FlatIdent_6679B = 0;
				local n;
				while true do
					if (FlatIdent_6679B == 1) then
						if (n:find("bag") or n:find("coin") or n:find("cash")) then
							local FlatIdent_2DA99 = 0;
							while true do
								if (FlatIdent_2DA99 == 0) then
									fulls[g] = true;
									return;
								end
							end
						end
						p = p.Parent;
						break;
					end
					if (FlatIdent_6679B == 0) then
						if not p then
							return;
						end
						n = p.Name:lower();
						FlatIdent_6679B = 1;
					end
				end
			end
			break;
		end
		if (FlatIdent_81225 == 0) then
			if ((g.Name ~= "Full") or not g:IsA("GuiObject")) then
				return;
			end
			p = g.Parent;
			FlatIdent_81225 = 1;
		end
	end
end
local function shown(g)
	local x = g;
	while x and x:IsA("GuiObject") do
		local FlatIdent_31ECC = 0;
		while true do
			if (FlatIdent_31ECC == 0) then
				if not x.Visible then
					return false;
				end
				x = x.Parent;
				break;
			end
		end
	end
	return not (x and x:IsA("ScreenGui") and not x.Enabled);
end
task.spawn(function()
	local pg = me:WaitForChild("PlayerGui");
	for _, g in ipairs(pg:GetDescendants()) do
		chk(g);
	end
	pg.DescendantAdded:Connect(chk);
	pg.DescendantRemoving:Connect(function(g)
		fulls[g] = nil;
	end);
end);
me.CharacterAdded:Connect(function()
	setFull(false);
end);
local function stop()
	if tw then
		local FlatIdent_2A644 = 0;
		while true do
			if (FlatIdent_2A644 == 0) then
				tw:Cancel();
				tw = nil;
				break;
			end
		end
	end
end
local function tp(pos)
	local hrp = me.Character and me.Character:FindFirstChild("HumanoidRootPart");
	if (hrp and pos) then
		stop();
		hrp.AssemblyLinearVelocity = Vector3.new(0, 0, 0);
		hrp.CFrame = CFrame.new(pos);
		return true;
	end
	return false;
end
local function manualTp(pos, what)
	local FlatIdent_7F3C8 = 0;
	while true do
		if (FlatIdent_7F3C8 == 0) then
			if not pos then
				local FlatIdent_3F7F4 = 0;
				while true do
					if (0 == FlatIdent_3F7F4) then
						notify(what .. " is not loaded");
						return;
					end
				end
			end
			pauseUntil = tick() + 2;
			FlatIdent_7F3C8 = 1;
		end
		if (1 == FlatIdent_7F3C8) then
			if not tp(pos) then
				notify("Character not ready");
			end
			break;
		end
	end
end
local function verify(coin)
	task.delay(0.35, function()
		local got = not coin.Parent or (coin.Transparency > 0.5) or not coin:FindFirstChildWhichIsA("TouchTransmitter");
		if got then
			misses = 0;
			if farmOn() then
				S.coins = S.coins + 1;
			end
		else
			local FlatIdent_43626 = 0;
			while true do
				if (0 == FlatIdent_43626) then
					misses = misses + 1;
					if (misses >= 4) then
						setFull(true);
					end
					break;
				end
			end
		end
	end);
end
local function farmStep()
	local char = me.Character;
	local hum = char and char:FindFirstChildOfClass("Humanoid");
	local hrp = char and char:FindFirstChild("HumanoidRootPart");
	if ((tick() < pauseUntil) or not (farmOn() and not full and hum and (hum.Health > 0) and hrp and inRound())) then
		local FlatIdent_957A4 = 0;
		while true do
			if (FlatIdent_957A4 == 0) then
				stop();
				return false;
			end
		end
	end
	local best, d = nil, math.huge;
	local pos = hrp.Position;
	for c in pairs(coins) do
		if c.Parent then
			local FlatIdent_71EE8 = 0;
			local m;
			while true do
				if (FlatIdent_71EE8 == 0) then
					m = (c.Position - pos).Magnitude;
					if (m < d) then
						best, d = c, m;
					end
					break;
				end
			end
		end
	end
	if not best then
		return false;
	end
	local t = TS:Create(hrp, TweenInfo.new(d / o.spd, Enum.EasingStyle.Linear), {CFrame=best.CFrame});
	tw = t;
	local done = false;
	t.Completed:Connect(function(st)
		done = st == Enum.PlaybackState.Completed;
	end);
	t:Play();
	while t.PlaybackState == Enum.PlaybackState.Playing do
		if (not farmOn() or full or (hum.Health <= 0) or not inRound() or (tick() < pauseUntil)) then
			t:Cancel();
			break;
		end
		task.wait(0.02);
	end
	tw = nil;
	if done then
		local FlatIdent_956D = 0;
		while true do
			if (FlatIdent_956D == 0) then
				coins[best] = nil;
				verify(best);
				break;
			end
		end
	end
	return true;
end
task.spawn(function()
	local FlatIdent_3B868 = 0;
	local last;
	while true do
		if (FlatIdent_3B868 == 0) then
			last = nil;
			while true do
				local FlatIdent_D14D = 0;
				local ok;
				local res;
				while true do
					if (1 == FlatIdent_D14D) then
						task.wait((ok and res and 0.02) or 0.2);
						break;
					end
					if (FlatIdent_D14D == 0) then
						ok, res = pcall(farmStep);
						if (not ok and (tostring(res) ~= last)) then
							local FlatIdent_89562 = 0;
							while true do
								if (FlatIdent_89562 == 0) then
									last = tostring(res);
									warn("[Plagg]", res);
									break;
								end
							end
						end
						FlatIdent_D14D = 1;
					end
				end
			end
			break;
		end
	end
end);
local lastTp = 0;
loop(0.5, function()
	if not next(coins) then
		local FlatIdent_10DED = 0;
		while true do
			if (FlatIdent_10DED == 0) then
				setFull(false);
				lobbyTarget = nil;
				break;
			end
		end
	else
		for g in pairs(fulls) do
			if (g.Parent and shown(g)) then
				setFull(true);
				break;
			end
		end
	end
	local hrp = me.Character and me.Character:FindFirstChild("HumanoidRootPart");
	if (o.xp and full and hrp) then
		if (((tick() - lastTp) > 1.5) and (not lobbyTarget or ((hrp.Position - lobbyTarget).Magnitude > 100))) then
			local FlatIdent_2FBBD = 0;
			while true do
				if (0 == FlatIdent_2FBBD) then
					lobbyTarget = lobbyPos();
					if lobbyTarget then
						local FlatIdent_90113 = 0;
						while true do
							if (FlatIdent_90113 == 0) then
								lastTp = tick();
								tp(lobbyTarget);
								break;
							end
						end
					end
					break;
				end
			end
		end
	else
		local FlatIdent_67F21 = 0;
		while true do
			if (FlatIdent_67F21 == 0) then
				lobbyTarget = nil;
				if (o.reset and full and inRound()) then
					local FlatIdent_8EA6E = 0;
					local hum;
					while true do
						if (FlatIdent_8EA6E == 0) then
							hum = me.Character and me.Character:FindFirstChildOfClass("Humanoid");
							if (hum and (hum.Health > 0)) then
								stop();
								hum.Health = 0;
							end
							break;
						end
					end
				end
				break;
			end
		end
	end
end);
loop(0.1, function()
	if (o.sa or K.on) then
		local FlatIdent_33DE6 = 0;
		local m;
		while true do
			if (0 == FlatIdent_33DE6) then
				m = murd();
				mChar = m and m.Character;
				FlatIdent_33DE6 = 1;
			end
			if (FlatIdent_33DE6 == 1) then
				mPart = mChar and mChar:FindFirstChild("HumanoidRootPart");
				break;
			end
		end
	else
		mChar, mPart = nil, nil;
	end
end);
local function pathOf(x)
	local FlatIdent_1512 = 0;
	local t;
	while true do
		if (FlatIdent_1512 == 1) then
			return table.concat(t, ".");
		end
		if (0 == FlatIdent_1512) then
			t = {};
			while x and (x ~= game) do
				local FlatIdent_1DFAF = 0;
				while true do
					if (FlatIdent_1DFAF == 0) then
						table.insert(t, 1, x.Name);
						x = x.Parent;
						break;
					end
				end
			end
			FlatIdent_1512 = 1;
		end
	end
end
local function aimArgs(self, m, a)
	local nm = self.Name:lower();
	local pn = ((self.Parent and self.Parent.Name) or ""):lower();
	local isShoot = nm:find("shoot") ~= nil;
	local isBeam = (pn:find("createbeam") ~= nil) or (nm:find("beam") ~= nil);
	if (o.dbg and (isShoot or isBeam or nm:find("gun") or nm:find("knife"))) then
		local t = {};
		for i = 1, a.n do
			t[i] = typeof(a[i]);
		end
		print("[Plagg] remote:", m, pathOf(self), table.concat(t, ", "));
	end
	if (not mPart or not (isShoot or isBeam)) then
		return false;
	end
	local pos = mPart.Position + (mPart.AssemblyLinearVelocity * 0.1);
	if isShoot then
		for i = a.n, 1, -1 do
			if (typeof(a[i]) == "CFrame") then
				local FlatIdent_699E4 = 0;
				while true do
					if (FlatIdent_699E4 == 0) then
						a[i] = CFrame.new(pos);
						return true;
					end
				end
			end
		end
	end
	for i = 1, a.n do
		if (typeof(a[i]) == "Vector3") then
			local FlatIdent_5AB84 = 0;
			while true do
				if (FlatIdent_5AB84 == 0) then
					a[i] = pos;
					return true;
				end
			end
		end
	end
	return false;
end
if (hookmetamethod and getnamecallmethod) then
	local FlatIdent_1BAD7 = 0;
	local old;
	local hook;
	while true do
		if (FlatIdent_1BAD7 == 0) then
			old = nil;
			hook = nil;
			FlatIdent_1BAD7 = 1;
		end
		if (FlatIdent_1BAD7 == 1) then
			function hook(self, ...)
				local FlatIdent_6EF7B = 0;
				local m;
				while true do
					if (FlatIdent_6EF7B == 0) then
						m = getnamecallmethod();
						if (((m == "FireServer") or (m == "InvokeServer")) and (o.sa or o.dbg) and not (checkcaller and checkcaller())) then
							local a = table.pack(...);
							local ok, changed = pcall(aimArgs, self, m, a);
							if setnamecallmethod then
								setnamecallmethod(m);
							end
							if (ok and changed and o.sa) then
								return old(self, table.unpack(a, 1, a.n));
							end
						end
						FlatIdent_6EF7B = 1;
					end
					if (FlatIdent_6EF7B == 1) then
						return old(self, ...);
					end
				end
			end
			old = hookmetamethod(game, "__namecall", (newcclosure and newcclosure(hook)) or hook);
			break;
		end
	end
else
	warn("[Plagg] hookmetamethod not supported, Silent Aim is off");
end
local function equipGun()
	local char = me.Character;
	local hum = char and char:FindFirstChildOfClass("Humanoid");
	if not char then
		return;
	end
	local gun = char:FindFirstChild("Gun");
	if gun then
		return gun;
	end
	local bp = me:FindFirstChild("Backpack");
	gun = bp and bp:FindFirstChild("Gun");
	if (gun and hum) then
		hum:EquipTool(gun);
		RUN.Heartbeat:Wait();
		return gun;
	end
end
local function shootMurderer()
	local char = me.Character;
	local hrp = char and char:FindFirstChild("HumanoidRootPart");
	local m = murd();
	local mh = m and m.Character and m.Character:FindFirstChild("HumanoidRootPart");
	if not (hrp and mh) then
		return;
	end
	local gun = equipGun();
	local shoot = gun and gun:FindFirstChild("Shoot");
	if (shoot and shoot:IsA("RemoteEvent")) then
		local FlatIdent_6E214 = 0;
		local pos;
		while true do
			if (FlatIdent_6E214 == 0) then
				pos = mh.Position + (mh.AssemblyLinearVelocity * 0.1);
				shoot:FireServer(CFrame.new(hrp.Position), CFrame.new(pos));
				break;
			end
		end
	elseif o.dbg then
		print("[Plagg] Gun or Shoot remote not found");
	end
end
local function flickShoot()
	if flicking then
		return;
	end
	local m = murd();
	local ch = m and m.Character;
	local part = ch and (ch:FindFirstChild("UpperTorso") or ch:FindFirstChild("Torso") or ch:FindFirstChild("HumanoidRootPart"));
	if not part then
		local FlatIdent_8A9D7 = 0;
		while true do
			if (FlatIdent_8A9D7 == 0) then
				notify("Murderer not found");
				return;
			end
		end
	end
	flicking = true;
	pcall(equipGun);
	local cam = workspace.CurrentCamera;
	local back = cam.CFrame;
	pcall(function()
		RUN:UnbindFromRenderStep("PlaggFlick");
	end);
	RUN:BindToRenderStep("PlaggFlick", Enum.RenderPriority.Camera.Value + 2, function()
		if part.Parent then
			local c = workspace.CurrentCamera;
			c.CFrame = CFrame.new(c.CFrame.Position, part.Position + (part.AssemblyLinearVelocity * 0.1));
		end
	end);
	RUN.RenderStepped:Wait();
	pcall(shootMurderer);
	local t0 = tick();
	repeat
		RUN.RenderStepped:Wait();
	until (tick() - t0) >= F.hold 
	pcall(function()
		RUN:UnbindFromRenderStep("PlaggFlick");
	end);
	workspace.CurrentCamera.CFrame = back;
	flicking = false;
end
pcall(function()
	RUN:UnbindFromRenderStep("PlaggLock");
end);
RUN:BindToRenderStep("PlaggLock", Enum.RenderPriority.Camera.Value + 1, function()
	if (not K.on or flicking or not mChar or not mChar.Parent) then
		return;
	end
	local hum = mChar:FindFirstChildOfClass("Humanoid");
	if (hum and (hum.Health <= 0)) then
		return;
	end
	local part = mChar:FindFirstChild("UpperTorso") or mChar:FindFirstChild("Torso") or mPart;
	local root = mPart or part;
	if (not part or not root) then
		return;
	end
	local cam = workspace.CurrentCamera;
	local from = cam.CFrame.Position;
	local t = 0.12 + ((part.Position - from).Magnitude / 1500);
	cam.CFrame = CFrame.new(from, part.Position + (root.AssemblyLinearVelocity * t));
end);
local function say(msg)
	local FlatIdent_21E03 = 0;
	local ok;
	while true do
		if (FlatIdent_21E03 == 0) then
			ok = pcall(function()
				local FlatIdent_1F620 = 0;
				while true do
					if (FlatIdent_1F620 == 0) then
						if (TCS.ChatVersion == Enum.ChatVersion.TextChatService) then
							local ch = TCS.TextChannels:FindFirstChild("RBXGeneral");
							if ch then
								ch:SendAsync(msg);
								return;
							end
						end
						error("legacy");
						break;
					end
				end
			end);
			if not ok then
				local ev = RS:FindFirstChild("DefaultChatSystemChatEvents");
				local sm = ev and ev:FindFirstChild("SayMessageRequest");
				if sm then
					sm:FireServer(msg, "All");
				end
			end
			break;
		end
	end
end
local lastSay = {};
local function sayRole(kind)
	if ((tick() - (lastSay[kind] or 0)) < 3) then
		local FlatIdent_8BE54 = 0;
		while true do
			if (FlatIdent_8BE54 == 0) then
				notify("Wait a few seconds before sending again");
				return;
			end
		end
	end
	local target;
	for _, p in ipairs(P:GetPlayers()) do
		local FlatIdent_6F99F = 0;
		local r;
		while true do
			if (FlatIdent_6F99F == 0) then
				r = role(p);
				if ((kind == "M") and (r == "Murderer")) then
					target = p;
				elseif ((kind == "S") and ((r == "Sheriff") or (r == "Hero"))) then
					target = p;
				end
				break;
			end
		end
	end
	if not target then
		local FlatIdent_15034 = 0;
		while true do
			if (FlatIdent_15034 == 0) then
				notify(((kind == "M") and "No Murderer found yet") or "No Sheriff found yet");
				return;
			end
		end
	end
	lastSay[kind] = tick();
	say(string.format(((kind == "M") and MSG_M) or MSG_S, target.Name));
end
local afk;
local function setAfk(v)
	local FlatIdent_23FF9 = 0;
	while true do
		if (FlatIdent_23FF9 == 0) then
			if afk then
				local FlatIdent_61084 = 0;
				while true do
					if (FlatIdent_61084 == 0) then
						afk:Disconnect();
						afk = nil;
						break;
					end
				end
			end
			if v then
				afk = me.Idled:Connect(function()
					local FlatIdent_69D54 = 0;
					while true do
						if (FlatIdent_69D54 == 0) then
							VU:CaptureController();
							VU:ClickButton2(Vector2.new(0, 0));
							break;
						end
					end
				end);
			end
			break;
		end
	end
end
setAfk(true);
local bv, bg, flying;
local function stopFly()
	if bv then
		local FlatIdent_7C57C = 0;
		while true do
			if (FlatIdent_7C57C == 0) then
				bv:Destroy();
				bv = nil;
				break;
			end
		end
	end
	if bg then
		bg:Destroy();
		bg = nil;
	end
	if flying then
		local FlatIdent_23B66 = 0;
		local h;
		while true do
			if (FlatIdent_23B66 == 1) then
				if h then
					h.PlatformStand = false;
				end
				break;
			end
			if (FlatIdent_23B66 == 0) then
				flying = false;
				h = me.Character and me.Character:FindFirstChildOfClass("Humanoid");
				FlatIdent_23B66 = 1;
			end
		end
	end
end
RUN.Heartbeat:Connect(function()
	local FlatIdent_30B1F = 0;
	local char;
	local hum;
	local hrp;
	while true do
		if (FlatIdent_30B1F == 0) then
			if not (L.speed or L.jump or L.fly) then
				return;
			end
			char = me.Character;
			FlatIdent_30B1F = 1;
		end
		if (FlatIdent_30B1F == 2) then
			if (not hum or not hrp) then
				return;
			end
			if L.speed then
				hum.WalkSpeed = L.ws;
			end
			FlatIdent_30B1F = 3;
		end
		if (1 == FlatIdent_30B1F) then
			hum = char and char:FindFirstChildOfClass("Humanoid");
			hrp = char and char:FindFirstChild("HumanoidRootPart");
			FlatIdent_30B1F = 2;
		end
		if (FlatIdent_30B1F == 3) then
			if L.jump then
				local FlatIdent_FBDE = 0;
				while true do
					if (FlatIdent_FBDE == 0) then
						hum.UseJumpPower = true;
						hum.JumpPower = L.jp;
						break;
					end
				end
			end
			if L.fly then
				if (not bv or (bv.Parent ~= hrp)) then
					if bv then
						bv:Destroy();
					end
					if bg then
						bg:Destroy();
					end
					bv = Instance.new("BodyVelocity");
					bv.MaxForce = Vector3.new(1000000000, 1000000000, 1000000000);
					bv.Velocity = Vector3.new(0, 0, 0);
					bv.Parent = hrp;
					bg = Instance.new("BodyGyro");
					bg.MaxTorque = Vector3.new(1000000000, 1000000000, 1000000000);
					bg.P = 10000;
					bg.Parent = hrp;
					flying = true;
				end
				hum.PlatformStand = true;
				local c = workspace.CurrentCamera;
				local mv = c.CFrame:VectorToObjectSpace(hum.MoveDirection);
				bv.Velocity = ((c.CFrame.RightVector * mv.X) + (c.CFrame.LookVector * -mv.Z)) * L.fs;
				bg.CFrame = c.CFrame;
			end
			break;
		end
	end
end);
local ncConn;
local function setNoclip(v)
	local FlatIdent_47EEF = 0;
	while true do
		if (FlatIdent_47EEF == 1) then
			if v then
				ncConn = RUN.Stepped:Connect(function()
					local FlatIdent_2B986 = 0;
					local c;
					while true do
						if (1 == FlatIdent_2B986) then
							for _, p in ipairs(c:GetDescendants()) do
								if (p:IsA("BasePart") and p.CanCollide) then
									p.CanCollide = false;
								end
							end
							break;
						end
						if (FlatIdent_2B986 == 0) then
							c = me.Character;
							if not c then
								return;
							end
							FlatIdent_2B986 = 1;
						end
					end
				end);
			end
			break;
		end
		if (FlatIdent_47EEF == 0) then
			L.noclip = v;
			if ncConn then
				ncConn:Disconnect();
				ncConn = nil;
			end
			FlatIdent_47EEF = 1;
		end
	end
end
local ijConn;
local function setInf(v)
	local FlatIdent_3416F = 0;
	while true do
		if (FlatIdent_3416F == 1) then
			if v then
				ijConn = UIS.JumpRequest:Connect(function()
					local FlatIdent_437D4 = 0;
					local h;
					while true do
						if (FlatIdent_437D4 == 0) then
							h = me.Character and me.Character:FindFirstChildOfClass("Humanoid");
							if h then
								h:ChangeState(Enum.HumanoidStateType.Jumping);
							end
							break;
						end
					end
				end);
			end
			break;
		end
		if (FlatIdent_3416F == 0) then
			L.inf = v;
			if ijConn then
				local FlatIdent_87C42 = 0;
				while true do
					if (0 == FlatIdent_87C42) then
						ijConn:Disconnect();
						ijConn = nil;
						break;
					end
				end
			end
			FlatIdent_3416F = 1;
		end
	end
end
local function keeper()
	local FlatIdent_94BA0 = 0;
	local store;
	local set;
	local undo;
	while true do
		if (0 == FlatIdent_94BA0) then
			store = setmetatable({}, {__mode="k"});
			set = nil;
			FlatIdent_94BA0 = 1;
		end
		if (FlatIdent_94BA0 == 2) then
			function undo()
				for i, t in pairs(store) do
					for p, v in pairs(t) do
						pcall(function()
							i[p] = v;
						end);
					end
				end
				store = setmetatable({}, {__mode="k"});
			end
			return set, undo;
		end
		if (FlatIdent_94BA0 == 1) then
			function set(i, p, v)
				local FlatIdent_12B71 = 0;
				local t;
				while true do
					if (FlatIdent_12B71 == 1) then
						if (t[p] == nil) then
							t[p] = i[p];
						end
						if (i[p] ~= v) then
							i[p] = v;
						end
						break;
					end
					if (FlatIdent_12B71 == 0) then
						t = store[i];
						if not t then
							local FlatIdent_8BF78 = 0;
							while true do
								if (0 == FlatIdent_8BF78) then
									t = {};
									store[i] = t;
									break;
								end
							end
						end
						FlatIdent_12B71 = 1;
					end
				end
			end
			undo = nil;
			FlatIdent_94BA0 = 2;
		end
	end
end
local fogSet, fogUndo = keeper();
local brSet, brUndo = keeper();
local lagSet, lagUndo = keeper();
local function world()
	local FlatIdent_1E844 = 0;
	while true do
		if (FlatIdent_1E844 == 0) then
			if W.nofog then
				fogSet(Lt, "FogEnd", 1000000000);
				fogSet(Lt, "FogStart", 1000000000);
				for _, a in ipairs(Lt:GetChildren()) do
					if a:IsA("Atmosphere") then
						local FlatIdent_FC26 = 0;
						while true do
							if (FlatIdent_FC26 == 0) then
								fogSet(a, "Density", 0);
								fogSet(a, "Haze", 0);
								break;
							end
						end
					end
				end
			end
			if W.bright then
				local FlatIdent_98E39 = 0;
				while true do
					if (FlatIdent_98E39 == 1) then
						brSet(Lt, "GlobalShadows", false);
						brSet(Lt, "Ambient", WHITE);
						FlatIdent_98E39 = 2;
					end
					if (FlatIdent_98E39 == 2) then
						brSet(Lt, "OutdoorAmbient", WHITE);
						break;
					end
					if (0 == FlatIdent_98E39) then
						brSet(Lt, "Brightness", 2);
						brSet(Lt, "ClockTime", 14);
						FlatIdent_98E39 = 1;
					end
				end
			end
			FlatIdent_1E844 = 1;
		end
		if (FlatIdent_1E844 == 1) then
			if W.fov then
				local c = workspace.CurrentCamera;
				if (c and (c.FieldOfView ~= W.fovv)) then
					c.FieldOfView = W.fovv;
				end
			end
			break;
		end
	end
end
local function refreshWorld()
	local FlatIdent_8CF9A = 0;
	while true do
		if (0 == FlatIdent_8CF9A) then
			pcall(function()
				RUN:UnbindFromRenderStep("PlaggWorld");
			end);
			if (W.nofog or W.bright or W.fov) then
				RUN:BindToRenderStep("PlaggWorld", Enum.RenderPriority.Last.Value, world);
			end
			break;
		end
	end
end
local function strip(v)
	pcall(function()
		if v:IsA("BasePart") then
			local FlatIdent_76EB7 = 0;
			while true do
				if (1 == FlatIdent_76EB7) then
					if v:IsA("MeshPart") then
						lagSet(v, "TextureID", "");
					end
					break;
				end
				if (FlatIdent_76EB7 == 0) then
					lagSet(v, "Material", Enum.Material.SmoothPlastic);
					lagSet(v, "Reflectance", 0);
					FlatIdent_76EB7 = 1;
				end
			end
		elseif (v:IsA("Decal") or v:IsA("Texture")) then
			lagSet(v, "Transparency", 1);
		elseif v:IsA("SpecialMesh") then
			lagSet(v, "TextureId", "");
		elseif v:IsA("SurfaceAppearance") then
			local FlatIdent_16F8D = 0;
			while true do
				if (FlatIdent_16F8D == 1) then
					lagSet(v, "MetalnessMap", "");
					lagSet(v, "RoughnessMap", "");
					break;
				end
				if (FlatIdent_16F8D == 0) then
					lagSet(v, "ColorMap", "");
					lagSet(v, "NormalMap", "");
					FlatIdent_16F8D = 1;
				end
			end
		elseif (v:IsA("ParticleEmitter") or v:IsA("Trail") or v:IsA("Fire") or v:IsA("Smoke") or v:IsA("Sparkles") or v:IsA("PostEffect")) then
			lagSet(v, "Enabled", false);
		end
	end);
end
local lagConn;
local function setLag(v)
	W.lag = v;
	if lagConn then
		local FlatIdent_8EF6C = 0;
		while true do
			if (0 == FlatIdent_8EF6C) then
				lagConn:Disconnect();
				lagConn = nil;
				break;
			end
		end
	end
	if v then
		lagConn = workspace.DescendantAdded:Connect(function(x)
			task.defer(strip, x);
		end);
		task.spawn(function()
			local FlatIdent_81DE9 = 0;
			local n;
			while true do
				if (FlatIdent_81DE9 == 0) then
					n = 0;
					for _, x in ipairs(workspace:GetDescendants()) do
						local FlatIdent_7DB9E = 0;
						while true do
							if (FlatIdent_7DB9E == 1) then
								n = n + 1;
								if ((n % 400) == 0) then
									task.wait();
								end
								break;
							end
							if (FlatIdent_7DB9E == 0) then
								if not W.lag then
									return;
								end
								strip(x);
								FlatIdent_7DB9E = 1;
							end
						end
					end
					FlatIdent_81DE9 = 1;
				end
				if (FlatIdent_81DE9 == 1) then
					for _, x in ipairs(Lt:GetDescendants()) do
						strip(x);
					end
					break;
				end
			end
		end);
	else
		lagUndo();
	end
end
local function makeFloat(name, text, color, pos)
	local g = Instance.new("ScreenGui");
	g.Name = name;
	g.ResetOnSpawn = false;
	g.Enabled = false;
	pcall(function()
		g.Parent = (gethui and gethui()) or game:GetService("CoreGui");
	end);
	if not g.Parent then
		g.Parent = me:WaitForChild("PlayerGui");
	end
	local b = Instance.new("TextButton");
	b.Size = UDim2.new(0, 96, 0, 76);
	b.Position = pos;
	b.BackgroundColor3 = color;
	b.BorderSizePixel = 0;
	b.Font = Enum.Font.Michroma;
	b.Text = text;
	b.TextColor3 = WHITE;
	b.TextStrokeColor3 = BLACK;
	b.TextStrokeTransparency = 0;
	b.TextScaled = true;
	b.TextWrapped = true;
	b.Active = true;
	b.Draggable = true;
	b.Parent = g;
	Instance.new("UICorner", b).CornerRadius = UDim.new(0, 14);
	local pad = Instance.new("UIPadding", b);
	pad.PaddingLeft = UDim.new(0, 6);
	pad.PaddingRight = UDim.new(0, 6);
	pad.PaddingTop = UDim.new(0, 6);
	pad.PaddingBottom = UDim.new(0, 6);
	local st = Instance.new("UIStroke", b);
	st.ApplyStrokeMode = Enum.ApplyStrokeMode.Border;
	st.Color = BLACK;
	st.Thickness = 3;
	return g, b;
end
local shootGui, shootBtn = makeFloat("PlaggShoot", "Shoot Murderer Button", MAGENTA, UDim2.new(0.8, 0, 0.3, 0));
shootBtn.MouseButton1Click:Connect(function()
	task.spawn(shootMurderer);
end);
local flickGui, flickBtn = makeFloat("PlaggFlick", "Flick Shoot Murderer Button", AMBER, UDim2.new(0.8, 0, 0.5, 0));
flickBtn.MouseButton1Click:Connect(function()
	task.spawn(flickShoot);
end);
local lockGui, lockBtn = makeFloat("PlaggLockGui", "Lock Murderer Button\nOFF", CYAN, UDim2.new(0.8, 0, 0.7, 0));
local function setLock(v)
	K.on = v;
	lockBtn.Text = "Lock Murderer Button\n" .. ((v and "ON") or "OFF");
end
lockBtn.MouseButton1Click:Connect(function()
	setLock(not K.on);
end);
ui({Name="PlaggNeon",Accent=Color3.fromRGB(255, 60, 200),Outline=Color3.fromRGB(0, 220, 255),Text=Color3.fromRGB(255, 255, 255),PlaceholderText=Color3.fromRGB(180, 140, 255),Background=Color3.fromRGB(14, 10, 36),Secondary=Color3.fromRGB(34, 18, 78),Tertiary=Color3.fromRGB(64, 26, 116)});
local win = ui({Title="Plagg Hub",Size=UDim2.fromOffset(450, 300),Transparent=true,Theme="PlaggNeon",SideBarWidth=140,HasOutline=false,ToggleOutline=false});
local function sec(tab, title)
	pcall(function()
		tab({Title=title});
	end);
end
local combat = win({Title="Combat",Icon="crosshair"});
local farm = win({Title="Farm",Icon="coins"});
local vis = win({Title="Visual",Icon="eye"});
local world_ = win({Title="World",Icon="globe"});
local plr = win({Title="Local Player",Icon="user"});
local infoTab = win({Title="Info",Icon="info"});
local misc = win({Title="Misc",Icon="settings"});
combat:Select();
sec(combat, "Aim");
combat({Title="Silent Aim",Desc="Sheriff shots go to the Murderer",Value=false,Callback=function(v)
	o.sa = v;
end});
combat({Title="Auto Grab Gun",Desc="Picks up the dropped gun",Value=false,Callback=function(v)
	o.grab = v;
end});
sec(combat, "Floating Buttons");
combat({Title="Shoot Murderer Button",Desc="Shoots the Murderer when tapped",Value=false,Callback=function(v)
	shootGui.Enabled = v;
end});
combat({Title="Flick Shoot Murderer Button",Desc="Snaps the camera to the Murderer, shoots and snaps back",Value=false,Callback=function(v)
	flickGui.Enabled = v;
end});
combat({Title="Flick Hold Time",Desc="Milliseconds the camera stays on the Murderer",Value={Min=0,Max=200,Default=30},Step=5,Callback=function(v)
	F.hold = v / 1000;
end});
combat({Title="Lock Murderer Button",Desc="Locks the camera on the Murderer when tapped",Value=false,Callback=function(v)
	local FlatIdent_67408 = 0;
	while true do
		if (FlatIdent_67408 == 0) then
			lockGui.Enabled = v;
			if not v then
				setLock(false);
			end
			break;
		end
	end
end});
sec(combat, "Chat");
combat({Title="Say Murderer in Chat",Desc="Sends who the Murderer is",Callback=function()
	task.spawn(sayRole, "M");
end});
combat({Title="Say Sheriff in Chat",Desc="Sends who the Sheriff is",Callback=function()
	task.spawn(sayRole, "S");
end});
sec(farm, "Coins");
farm({Title="Autofarm Coins",Desc="Only during a round, while alive",Value=false,Callback=function(v)
	o.farm = v;
	clock();
	if not farmOn() then
		stop();
	end
end});
farm({Title="Autofarm + XP Farm",Desc="Bag full: goes to the lobby until the round ends",Value=false,Callback=function(v)
	o.xp = v;
	clock();
	if not farmOn() then
		stop();
	end
end});
farm({Title="Auto End Run",Desc="Resets when the bag is full (off while XP Farm is on)",Value=false,Callback=function(v)
	o.reset = v;
end});
farm({Title="Farm Speed",Desc="Studs per second",Value={Min=1,Max=25,Default=25},Step=1,Callback=function(v)
	o.spd = v;
end});
sec(vis, "Players");
vis({Title="ESP Players",Desc="Name + role + highlight",Value=false,Callback=function(v)
	local FlatIdent_79F35 = 0;
	while true do
		if (FlatIdent_79F35 == 0) then
			o.esp = v;
			if not v then
				clear("ESP_Player");
			end
			break;
		end
	end
end});
sec(vis, "Objects");
vis({Title="ESP Dropped Gun",Value=false,Callback=function(v)
	local FlatIdent_C758 = 0;
	while true do
		if (FlatIdent_C758 == 0) then
			o.gun = v;
			if not v then
				clear("ESP_Gun");
			end
			break;
		end
	end
end});
vis({Title="ESP Traps",Value=false,Callback=function(v)
	local FlatIdent_602BB = 0;
	while true do
		if (FlatIdent_602BB == 0) then
			o.trap = v;
			if not v then
				clear("ESP_Trap");
			end
			break;
		end
	end
end});
sec(world_, "Lighting");
world_({Title="No Fog",Value=false,Callback=function(v)
	W.nofog = v;
	if not v then
		fogUndo();
	end
	refreshWorld();
end});
world_({Title="Full Bright",Value=false,Callback=function(v)
	W.bright = v;
	if not v then
		brUndo();
	end
	refreshWorld();
end});
world_({Title="Anti Lag",Desc="Removes textures and effects",Value=false,Callback=setLag});
sec(world_, "Camera & Physics");
world_({Title="Custom FOV",Value=false,Callback=function(v)
	W.fov = v;
	local c = workspace.CurrentCamera;
	if v then
		fov0 = fov0 or (c and c.FieldOfView);
	elseif (c and fov0) then
		c.FieldOfView = fov0;
	end
	refreshWorld();
end});
world_({Title="FOV",Value={Min=40,Max=120,Default=90},Step=1,Callback=function(v)
	W.fovv = v;
end});
world_({Title="Custom Gravity",Value=false,Callback=function(v)
	W.grav = v;
	workspace.Gravity = (v and W.gv) or grav0;
end});
world_({Title="Gravity",Value={Min=0,Max=300,Default=196},Step=1,Callback=function(v)
	local FlatIdent_6038 = 0;
	while true do
		if (FlatIdent_6038 == 0) then
			W.gv = v;
			if W.grav then
				workspace.Gravity = v;
			end
			break;
		end
	end
end});
sec(plr, "Teleport");
plr({Title="TP to Lobby",Desc="Works any time, if the lobby is loaded",Callback=function()
	manualTp(lobbyPos(), "Lobby");
end});
plr({Title="TP to Map",Desc="Works any time, if a map is loaded",Callback=function()
	manualTp(mapPos(), "Map");
end});
plr({Title="TP to Dropped Gun",Callback=function()
	if (drop and drop.Parent and drop:IsA("BasePart")) then
		manualTp(drop.Position + Vector3.new(0, 3, 0), "Gun");
	else
		notify("Gun is not on the map");
	end
end});
sec(plr, "Movement");
plr({Title="Speed",Value=false,Callback=function(v)
	local FlatIdent_2F3FA = 0;
	while true do
		if (FlatIdent_2F3FA == 0) then
			L.speed = v;
			if not v then
				local FlatIdent_1FA0 = 0;
				local h;
				while true do
					if (0 == FlatIdent_1FA0) then
						h = me.Character and me.Character:FindFirstChildOfClass("Humanoid");
						if h then
							h.WalkSpeed = 16;
						end
						break;
					end
				end
			end
			break;
		end
	end
end});
plr({Title="Walk Speed",Value={Min=1,Max=100,Default=50},Step=1,Callback=function(v)
	L.ws = v;
end});
plr({Title="Jump Power",Value=false,Callback=function(v)
	local FlatIdent_2B407 = 0;
	while true do
		if (FlatIdent_2B407 == 0) then
			L.jump = v;
			if not v then
				local h = me.Character and me.Character:FindFirstChildOfClass("Humanoid");
				if h then
					h.JumpPower = 50;
				end
			end
			break;
		end
	end
end});
plr({Title="Jump Height",Value={Min=1,Max=200,Default=100},Step=1,Callback=function(v)
	L.jp = v;
end});
plr({Title="Infinite Jump",Value=false,Callback=setInf});
plr({Title="Fly",Value=false,Callback=function(v)
	L.fly = v;
	if not v then
		stopFly();
	end
end});
plr({Title="Fly Speed",Value={Min=1,Max=100,Default=50},Step=1,Callback=function(v)
	L.fs = v;
end});
plr({Title="Noclip",Value=false,Callback=setNoclip});
local function render()
	local FlatIdent_7EE98 = 0;
	local t;
	local cpm;
	while true do
		if (FlatIdent_7EE98 == 0) then
			t = secs();
			cpm = ((t > 5) and ((S.coins / t) * 60)) or 0;
			FlatIdent_7EE98 = 1;
		end
		if (1 == FlatIdent_7EE98) then
			return string.format("Autofarm: %s\nTime on: %s\nCoins collected: %d\nCoins per minute: %.1f\nBag: %s", (farmOn() and "ON") or "OFF", fmt(t), S.coins, cpm, (full and "full") or "not full");
		end
	end
end
sec(infoTab, "Autofarm Stats");
local okP, infoPara = pcall(function()
	return infoTab({Title="Stats",Desc=render()});
end);
infoTab({Title="Show Stats",Desc="Shows the stats in a notification",Callback=function()
	notify(render());
end});
infoTab({Title="Reset Stats",Desc="Resets the timer and the coin counter",Callback=function()
	local FlatIdent_5B476 = 0;
	while true do
		if (FlatIdent_5B476 == 0) then
			S.coins = 0;
			S.elapsed = 0;
			FlatIdent_5B476 = 1;
		end
		if (FlatIdent_5B476 == 1) then
			S.since = (farmOn() and tick()) or nil;
			notify("Stats reset");
			break;
		end
	end
end});
loop(1, function()
	clock();
	if (okP and infoPara) then
		pcall(function()
			infoPara:SetDesc(render());
		end);
	end
end);
sec(misc, "General");
misc({Title="Anti AFK",Value=true,Callback=setAfk});
misc({Title="Debug Console",Desc="Prints remotes and bag status in the console",Value=false,Callback=function(v)
	o.dbg = v;
end});
misc({Title="Rejoin Server",Callback=function()
	TPS:Teleport(game.PlaceId, me);
end});
notify("Loaded successfully");
