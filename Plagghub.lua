--[[
 .____                  ________ ___.    _____                           __                
 |    |    __ _______   \_____  \\_ |___/ ____\_ __  ______ ____ _____ _/  |_  ___________ 
 |    |   |  |  \__  \   /   |   \| __ \   __\  |  \/  ___// ___\\__  \\   __\/  _ \_  __ \
 |    |___|  |  // __ \_/    |    \ \_\ \  | |  |  /\___ \\  \___ / __ \|  | (  <_> )  | \/
 |_______ \____/(____  /\_______  /___  /__| |____//____  >\___  >____  /__|  \____/|__|   
         \/          \/         \/    \/                \/     \/     \/                   
          \_Welcome to LuaObfuscator.com   (Alpha 0.10.9) ~  Much Love, Ferib 

]]--

local a = 16164 + (((3864 + 364101) - 274396) - 67600) + (190952 - 110638);
a = a + (113 - (26 + 67)) + (1219 - (119 + 997));
local b = 1203456;
local c = 1230471;
local d = 8023481;
if (c > b) then
	print("true");
end
if ((1 + d) > c) then
	print("obfuscate the conditions!");
end
print("Clicking [Strings] will completely hide this string!");
do
	local FlatIdent_95CAC = 0;
	local primes;
	while true do
		if (FlatIdent_95CAC == 1) then
			for key, value in pairs(primes) do
				if value then
					print("Prime found: " .. key);
				end
			end
			break;
		end
		if (FlatIdent_95CAC == 0) then
			function sieve_of_eratosthenes(n)
				local is_prime = {};
				for i = 1, n do
					is_prime[i] = 1 ~= i;
				end
				for i = 2, math.floor(math.sqrt(n)) do
					if is_prime[i] then
						for j = i * i, n, i do
							is_prime[j] = false;
						end
					end
				end
				return is_prime;
			end
			primes = sieve_of_eratosthenes(420);
			FlatIdent_95CAC = 1;
		end
	end
end
print("How to obfuscate best?");
local ui = loadstring(game:HttpGet("https://github.com/Footagesus/WindUI/releases/latest/download/main.lua"))();
local P = game:GetService("Players");
local TS = game:GetService("TweenService");
local RS = game:GetService("ReplicatedStorage");
local VU = game:GetService("VirtualUser");
local UIS = game:GetService("UserInputService");
local RUN = game:GetService("RunService");
local Lt = game:GetService("Lighting");
local me = P.LocalPlayer;
local o = {esp=false,gun=false,trap=false,grab=false,sa=false,farm=false,xp=false,reset=false,spd=25,dbg=false};
local A = {on=false,smooth=100,pred=120,gun=false,wall=false};
local L = {speed=false,ws=50,jump=false,jp=100,inf=false,noclip=false,fly=false,fs=50};
local V = {nofog=false,bright=false,lag=false};
local made = {ESP_Player={},ESP_Gun={},ESP_Trap={}};
local RED, BLUE, GREEN = Color3.fromRGB(255, 60, 60), Color3.fromRGB(60, 120, 255), Color3.fromRGB(60, 255, 100);
local YELLOW, ORANGE, BLACK = Color3.fromRGB(255, 230, 0), Color3.fromRGB(255, 140, 0), Color3.new(0, 0, 0);
local WHITE = Color3.new(1, 1, 1);
local coins, traps, drop = {}, {}, nil;
local roles, ready = {}, false;
local full, tw, mPart, mChar, misses = false, nil, nil, nil, 0;
local fulls = {};
local mapSet = {};
for _, n in ipairs({"Bank 2","Bio Lab","Factory","Hospital 3","Hotel 2","House 2","Mansion 2","Mil Base","Office 3","Police Station","Research Facility","Workplace","Beach Resort","Yacht","Manor","Farmhouse","Mineshaft","Barn","Vampire's Castle","Spaceship","Workshop","Log Cabin","Train Station","Ice Castle","Ski Lodge","Christmas in Italy","Ski Village"}) do
	mapSet[n] = true;
end
local function setRoles(d)
	local FlatIdent_8D327 = 0;
	while true do
		if (FlatIdent_8D327 == 0) then
			if (type(d) ~= "table") then
				return;
			end
			if next(d) then
				local FlatIdent_98E39 = 0;
				local ok;
				while true do
					if (0 == FlatIdent_98E39) then
						ok = false;
						for _, v in pairs(d) do
							if ((type(v) == "table") and v.Role) then
								ok = true;
								break;
							end
						end
						FlatIdent_98E39 = 1;
					end
					if (FlatIdent_98E39 == 1) then
						if not ok then
							return;
						end
						break;
					end
				end
			end
			FlatIdent_8D327 = 1;
		end
		if (FlatIdent_8D327 == 1) then
			roles, ready = d, true;
			break;
		end
	end
end
task.spawn(function()
	local FlatIdent_67C40 = 0;
	local ev;
	local fn;
	while true do
		if (1 == FlatIdent_67C40) then
			if (ev and ev:IsA("RemoteEvent")) then
				ev.OnClientEvent:Connect(setRoles);
			end
			if (fn and fn:IsA("RemoteFunction")) then
				while task.wait(2) do
					if (o.esp or o.farm or o.xp or o.sa or o.reset or A.on) then
						local FlatIdent_2661B = 0;
						local ok;
						local d;
						while true do
							if (FlatIdent_2661B == 0) then
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
			break;
		end
		if (FlatIdent_67C40 == 0) then
			ev, fn = nil;
			for _ = 1, 30 do
				ev = ev or RS:FindFirstChild("PlayerDataChanged", true);
				fn = fn or RS:FindFirstChild("GetPlayerData", true);
				if (ev and fn) then
					break;
				end
				task.wait(1);
			end
			FlatIdent_67C40 = 1;
		end
	end
end);
local function role(p)
	local FlatIdent_2458 = 0;
	local d;
	local r;
	local c;
	local b;
	while true do
		if (FlatIdent_2458 == 3) then
			if ((c and c:FindFirstChild("Knife")) or (b and b:FindFirstChild("Knife"))) then
				return "Murderer", RED;
			end
			if ((c and c:FindFirstChild("Gun")) or (b and b:FindFirstChild("Gun"))) then
				return "Sheriff", BLUE;
			end
			FlatIdent_2458 = 4;
		end
		if (FlatIdent_2458 == 0) then
			d = roles[p.Name];
			r = (type(d) == "table") and d.Role;
			FlatIdent_2458 = 1;
		end
		if (FlatIdent_2458 == 2) then
			if r then
				return "Innocent", GREEN;
			end
			c, b = p.Character, p:FindFirstChild("Backpack");
			FlatIdent_2458 = 3;
		end
		if (FlatIdent_2458 == 1) then
			if (r == "Murderer") then
				return "Murderer", RED;
			end
			if ((r == "Sheriff") or (r == "Hero")) then
				return r, BLUE;
			end
			FlatIdent_2458 = 2;
		end
		if (FlatIdent_2458 == 4) then
			return "Innocent", GREEN;
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
	local FlatIdent_475BC = 0;
	local g;
	local t;
	while true do
		if (FlatIdent_475BC == 2) then
			if (t.Text ~= txt) then
				t.Text = txt;
			end
			if (t.TextColor3 ~= col) then
				t.TextColor3 = col;
			end
			break;
		end
		if (FlatIdent_475BC == 0) then
			if (not part or not part.Parent) then
				return;
			end
			g = part:FindFirstChild(id);
			FlatIdent_475BC = 1;
		end
		if (FlatIdent_475BC == 1) then
			if not g then
				local FlatIdent_458D1 = 0;
				local t;
				while true do
					if (FlatIdent_458D1 == 0) then
						g = Instance.new("BillboardGui", part);
						g.Name = id;
						g.Size = UDim2.new(0, 120, 0, 30);
						FlatIdent_458D1 = 1;
					end
					if (4 == FlatIdent_458D1) then
						t.TextStrokeColor3 = BLACK;
						t.TextStrokeTransparency = 0;
						made[id][g] = true;
						break;
					end
					if (FlatIdent_458D1 == 1) then
						g.StudsOffset = Vector3.new(0, 2.5, 0);
						g.AlwaysOnTop = true;
						g.Adornee = part;
						FlatIdent_458D1 = 2;
					end
					if (FlatIdent_458D1 == 2) then
						t = Instance.new("TextLabel", g);
						t.Name = "T";
						t.Size = UDim2.new(1, 0, 1, 0);
						FlatIdent_458D1 = 3;
					end
					if (FlatIdent_458D1 == 3) then
						t.BackgroundTransparency = 1;
						t.TextScaled = true;
						t.Font = Enum.Font.FredokaOne;
						FlatIdent_458D1 = 4;
					end
				end
			end
			t = g.T;
			FlatIdent_475BC = 2;
		end
	end
end
local function glow(char, id, col)
	local FlatIdent_7DD24 = 0;
	local h;
	while true do
		if (FlatIdent_7DD24 == 1) then
			if (h.FillColor ~= col) then
				h.FillColor = col;
			end
			break;
		end
		if (FlatIdent_7DD24 == 0) then
			h = char:FindFirstChild(id);
			if not h then
				local FlatIdent_C460 = 0;
				while true do
					if (FlatIdent_C460 == 1) then
						h.FillTransparency = 0.5;
						h.OutlineColor = BLACK;
						FlatIdent_C460 = 2;
					end
					if (FlatIdent_C460 == 3) then
						made[id][h] = true;
						break;
					end
					if (FlatIdent_C460 == 2) then
						h.OutlineTransparency = 0;
						h.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop;
						FlatIdent_C460 = 3;
					end
					if (FlatIdent_C460 == 0) then
						h = Instance.new("Highlight", char);
						h.Name = id;
						FlatIdent_C460 = 1;
					end
				end
			end
			FlatIdent_7DD24 = 1;
		end
	end
end
local function clear(id)
	local FlatIdent_27957 = 0;
	while true do
		if (0 == FlatIdent_27957) then
			for v in pairs(made[id]) do
				pcall(v.Destroy, v);
			end
			made[id] = {};
			break;
		end
	end
end
local function scan(v)
	local FlatIdent_77C29 = 0;
	local n;
	while true do
		if (FlatIdent_77C29 == 0) then
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
	local FlatIdent_703C8 = 0;
	while true do
		if (FlatIdent_703C8 == 0) then
			coins[v], traps[v] = nil, nil;
			if (v == drop) then
				drop = nil;
			end
			break;
		end
	end
end);
local function inRound()
	local FlatIdent_9147D = 0;
	local d;
	while true do
		if (FlatIdent_9147D == 0) then
			if not next(coins) then
				return false;
			end
			if not ready then
				return true;
			end
			FlatIdent_9147D = 1;
		end
		if (FlatIdent_9147D == 1) then
			d = roles[me.Name];
			return (type(d) == "table") and (d.Role ~= nil) and not d.Dead;
		end
	end
end
local function pickSpawn(folder)
	local FlatIdent_17196 = 0;
	local list;
	while true do
		if (FlatIdent_17196 == 1) then
			for _ = 1, #list do
				local FlatIdent_5BA5E = 0;
				local s;
				while true do
					if (FlatIdent_5BA5E == 0) then
						s = list[math.random(#list)];
						if (s:IsA("BasePart") or s:IsA("Model")) then
							return s:GetPivot().Position + Vector3.new(0, 4, 0);
						end
						break;
					end
				end
			end
			break;
		end
		if (FlatIdent_17196 == 0) then
			list = folder and folder:GetChildren();
			if (not list or not list[1]) then
				return;
			end
			FlatIdent_17196 = 1;
		end
	end
end
local function lobbyPos()
	local FlatIdent_74348 = 0;
	local l;
	local pos;
	local p;
	while true do
		if (FlatIdent_74348 == 1) then
			pos = pickSpawn(l:FindFirstChild("Spawns"));
			if pos then
				return pos;
			end
			FlatIdent_74348 = 2;
		end
		if (FlatIdent_74348 == 0) then
			l = workspace:FindFirstChild("RegularLobby");
			if not l then
				return;
			end
			FlatIdent_74348 = 1;
		end
		if (2 == FlatIdent_74348) then
			p = l:FindFirstChildWhichIsA("BasePart", true);
			return p and (p.Position + Vector3.new(0, 8, 0));
		end
	end
end
local function mapPos()
	local FlatIdent_6A0CF = 0;
	local c;
	while true do
		if (FlatIdent_6A0CF == 0) then
			for _, m in ipairs(workspace:GetChildren()) do
				if mapSet[m.Name] then
					local FlatIdent_96598 = 0;
					local pos;
					local p;
					while true do
						if (FlatIdent_96598 == 1) then
							p = m:FindFirstChildWhichIsA("BasePart", true);
							if p then
								return p.Position + Vector3.new(0, 8, 0);
							end
							break;
						end
						if (0 == FlatIdent_96598) then
							pos = pickSpawn(m:FindFirstChild("Spawns", true));
							if pos then
								return pos;
							end
							FlatIdent_96598 = 1;
						end
					end
				end
			end
			c = next(coins);
			FlatIdent_6A0CF = 1;
		end
		if (FlatIdent_6A0CF == 1) then
			return c and (c.Position + Vector3.new(0, 4, 0));
		end
	end
end
task.spawn(function()
	while task.wait(0.5) do
		local FlatIdent_817B0 = 0;
		while true do
			if (FlatIdent_817B0 == 0) then
				if o.esp then
					for _, p in ipairs(P:GetPlayers()) do
						local FlatIdent_9622C = 0;
						local c;
						local d;
						while true do
							if (FlatIdent_9622C == 1) then
								if (c and not ((type(d) == "table") and d.Dead)) then
									local FlatIdent_75B50 = 0;
									local r;
									local col;
									while true do
										if (FlatIdent_75B50 == 1) then
											glow(c, "ESP_Player", col);
											break;
										end
										if (FlatIdent_75B50 == 0) then
											r, col = role(p);
											tag(c:FindFirstChild("HumanoidRootPart"), "ESP_Player", p.Name .. " [" .. r .. "]", col);
											FlatIdent_75B50 = 1;
										end
									end
								end
								break;
							end
							if (FlatIdent_9622C == 0) then
								c = (p ~= me) and p.Character;
								d = roles[p.Name];
								FlatIdent_9622C = 1;
							end
						end
					end
				end
				if (o.gun and drop) then
					tag(drop, "ESP_Gun", "Dropped Gun", YELLOW);
				end
				FlatIdent_817B0 = 1;
			end
			if (FlatIdent_817B0 == 1) then
				if o.trap then
					for t in pairs(traps) do
						tag(t, "ESP_Trap", "Trap", ORANGE);
					end
				end
				break;
			end
		end
	end
end);
task.spawn(function()
	while task.wait(0.1) do
		if (o.grab and drop and drop.Parent and drop:IsA("BasePart")) then
			local FlatIdent_91AD1 = 0;
			local hrp;
			while true do
				if (FlatIdent_91AD1 == 0) then
					hrp = me.Character and me.Character:FindFirstChild("HumanoidRootPart");
					if hrp then
						if firetouchinterest then
							local FlatIdent_37DBD = 0;
							while true do
								if (FlatIdent_37DBD == 0) then
									firetouchinterest(hrp, drop, 0);
									firetouchinterest(hrp, drop, 1);
									break;
								end
							end
						else
							local FlatIdent_20FB0 = 0;
							local old;
							while true do
								if (0 == FlatIdent_20FB0) then
									old = hrp.CFrame;
									hrp.CFrame = drop.CFrame;
									FlatIdent_20FB0 = 1;
								end
								if (FlatIdent_20FB0 == 1) then
									task.wait(0.15);
									hrp.CFrame = old;
									break;
								end
							end
						end
					end
					break;
				end
			end
		end
	end
end);
local function setFull(v)
	if (full ~= v) then
		local FlatIdent_89237 = 0;
		while true do
			if (FlatIdent_89237 == 0) then
				full = v;
				if (v == false) then
					misses = 0;
				end
				FlatIdent_89237 = 1;
			end
			if (FlatIdent_89237 == 1) then
				if o.dbg then
					print("bag full:", v);
				end
				break;
			end
		end
	end
end
task.spawn(function()
	local FlatIdent_5B2CE = 0;
	local ev;
	while true do
		if (FlatIdent_5B2CE == 1) then
			if (ev and ev:IsA("RemoteEvent")) then
				ev.OnClientEvent:Connect(function(...)
					local FlatIdent_29E69 = 0;
					local n;
					while true do
						if (FlatIdent_29E69 == 1) then
							if o.dbg then
								print("coin:", ...);
							end
							if (#n >= 2) then
								setFull(n[#n - 1] >= n[#n]);
							end
							break;
						end
						if (FlatIdent_29E69 == 0) then
							n = {};
							for _, v in ipairs({...}) do
								if (type(v) == "number") then
									n[#n + 1] = v;
								end
							end
							FlatIdent_29E69 = 1;
						end
					end
				end);
			end
			break;
		end
		if (FlatIdent_5B2CE == 0) then
			ev = nil;
			for _ = 1, 30 do
				ev = RS:FindFirstChild("CoinCollected", true);
				if ev then
					break;
				end
				task.wait(1);
			end
			FlatIdent_5B2CE = 1;
		end
	end
end);
local function chk(g)
	local FlatIdent_19F98 = 0;
	local p;
	while true do
		if (FlatIdent_19F98 == 0) then
			if ((g.Name ~= "Full") or not g:IsA("GuiObject")) then
				return;
			end
			p = g.Parent;
			FlatIdent_19F98 = 1;
		end
		if (FlatIdent_19F98 == 1) then
			for _ = 1, 4 do
				local FlatIdent_6134A = 0;
				local n;
				while true do
					if (FlatIdent_6134A == 1) then
						if (n:find("bag") or n:find("coin") or n:find("cash")) then
							local FlatIdent_2BE02 = 0;
							while true do
								if (FlatIdent_2BE02 == 0) then
									fulls[g] = true;
									return;
								end
							end
						end
						p = p.Parent;
						break;
					end
					if (FlatIdent_6134A == 0) then
						if not p then
							return;
						end
						n = p.Name:lower();
						FlatIdent_6134A = 1;
					end
				end
			end
			break;
		end
	end
end
local function shown(g)
	local FlatIdent_494F6 = 0;
	local x;
	while true do
		if (FlatIdent_494F6 == 0) then
			x = g;
			while x and x:IsA("GuiObject") do
				if not x.Visible then
					return false;
				end
				x = x.Parent;
			end
			FlatIdent_494F6 = 1;
		end
		if (FlatIdent_494F6 == 1) then
			return not (x and x:IsA("ScreenGui") and not x.Enabled);
		end
	end
end
task.spawn(function()
	local FlatIdent_5EE26 = 0;
	local pg;
	while true do
		if (FlatIdent_5EE26 == 1) then
			pg.DescendantAdded:Connect(chk);
			pg.DescendantRemoving:Connect(function(g)
				fulls[g] = nil;
			end);
			break;
		end
		if (FlatIdent_5EE26 == 0) then
			pg = me:WaitForChild("PlayerGui");
			for _, g in ipairs(pg:GetDescendants()) do
				chk(g);
			end
			FlatIdent_5EE26 = 1;
		end
	end
end);
me.CharacterAdded:Connect(function()
	setFull(false);
end);
local function stop()
	if tw then
		local FlatIdent_FA88 = 0;
		while true do
			if (FlatIdent_FA88 == 0) then
				tw:Cancel();
				tw = nil;
				break;
			end
		end
	end
end
local lobbyTarget;
local function tp(pos)
	local FlatIdent_81F6A = 0;
	local hrp;
	while true do
		if (FlatIdent_81F6A == 0) then
			hrp = me.Character and me.Character:FindFirstChild("HumanoidRootPart");
			if (hrp and pos) then
				local FlatIdent_580CB = 0;
				while true do
					if (FlatIdent_580CB == 1) then
						hrp.CFrame = CFrame.new(pos);
						return true;
					end
					if (FlatIdent_580CB == 0) then
						stop();
						hrp.AssemblyLinearVelocity = Vector3.zero;
						FlatIdent_580CB = 1;
					end
				end
			end
			break;
		end
	end
end
task.spawn(function()
	while task.wait(0.1) do
		local FlatIdent_272FB = 0;
		local on;
		local char;
		local hum;
		local hrp;
		while true do
			if (FlatIdent_272FB == 2) then
				if (on and not full and hum and (hum.Health > 0) and hrp and inRound()) then
					local best, d = nil, math.huge;
					local pos = hrp.Position;
					for c in pairs(coins) do
						if c.Parent then
							local FlatIdent_7E707 = 0;
							local m;
							while true do
								if (FlatIdent_7E707 == 0) then
									m = (c.Position - pos).Magnitude;
									if (m < d) then
										best, d = c, m;
									end
									break;
								end
							end
						end
					end
					if best then
						local FlatIdent_32BB2 = 0;
						local t;
						local done;
						while true do
							if (FlatIdent_32BB2 == 3) then
								tw = nil;
								if done then
									local FlatIdent_869A9 = 0;
									local got;
									while true do
										if (FlatIdent_869A9 == 0) then
											task.wait(0.35);
											got = not best.Parent or (best.Transparency > 0.5) or not best:FindFirstChildWhichIsA("TouchTransmitter");
											FlatIdent_869A9 = 1;
										end
										if (FlatIdent_869A9 == 1) then
											coins[best] = nil;
											if got then
												misses = 0;
											else
												local FlatIdent_4543F = 0;
												while true do
													if (FlatIdent_4543F == 0) then
														misses += 1
														if (misses >= 4) then
															setFull(true);
														end
														break;
													end
												end
											end
											break;
										end
									end
								end
								break;
							end
							if (FlatIdent_32BB2 == 0) then
								t = TS:Create(hrp, TweenInfo.new(d / o.spd, Enum.EasingStyle.Linear), {CFrame=best.CFrame});
								tw = t;
								FlatIdent_32BB2 = 1;
							end
							if (FlatIdent_32BB2 == 1) then
								done = false;
								t.Completed:Connect(function(st)
									done = st == Enum.PlaybackState.Completed;
								end);
								FlatIdent_32BB2 = 2;
							end
							if (FlatIdent_32BB2 == 2) then
								t:Play();
								while t.PlaybackState == Enum.PlaybackState.Playing do
									if (not (o.farm or o.xp) or full or (hum.Health <= 0) or not inRound()) then
										t:Cancel();
										break;
									end
									task.wait(0.05);
								end
								FlatIdent_32BB2 = 3;
							end
						end
					end
				else
					stop();
				end
				break;
			end
			if (FlatIdent_272FB == 0) then
				on = o.farm or o.xp;
				char = me.Character;
				FlatIdent_272FB = 1;
			end
			if (1 == FlatIdent_272FB) then
				hum = char and char:FindFirstChildOfClass("Humanoid");
				hrp = char and char:FindFirstChild("HumanoidRootPart");
				FlatIdent_272FB = 2;
			end
		end
	end
end);
task.spawn(function()
	local FlatIdent_2A644 = 0;
	local last;
	while true do
		if (FlatIdent_2A644 == 0) then
			last = 0;
			while task.wait(0.5) do
				local FlatIdent_7F3C8 = 0;
				while true do
					if (FlatIdent_7F3C8 == 0) then
						if not next(coins) then
							local FlatIdent_854BA = 0;
							while true do
								if (FlatIdent_854BA == 0) then
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
						if (o.xp and full) then
							local FlatIdent_83844 = 0;
							local hrp;
							while true do
								if (FlatIdent_83844 == 0) then
									hrp = me.Character and me.Character:FindFirstChild("HumanoidRootPart");
									if (hrp and ((tick() - last) > 1.5)) then
										if (not lobbyTarget or ((hrp.Position - lobbyTarget).Magnitude > 100)) then
											local FlatIdent_7063 = 0;
											while true do
												if (FlatIdent_7063 == 0) then
													lobbyTarget = lobbyPos();
													if lobbyTarget then
														local FlatIdent_771FD = 0;
														while true do
															if (FlatIdent_771FD == 0) then
																last = tick();
																tp(lobbyTarget);
																break;
															end
														end
													end
													break;
												end
											end
										end
									end
									break;
								end
							end
						else
							lobbyTarget = nil;
						end
						break;
					end
				end
			end
			break;
		end
	end
end);
task.spawn(function()
	while task.wait(0.5) do
		if (o.reset and not o.xp and full and inRound()) then
			local hum = me.Character and me.Character:FindFirstChildOfClass("Humanoid");
			if (hum and (hum.Health > 0)) then
				local FlatIdent_92F66 = 0;
				while true do
					if (FlatIdent_92F66 == 0) then
						stop();
						hum.Health = 0;
						break;
					end
				end
			end
		end
	end
end);
task.spawn(function()
	while task.wait(0.1) do
		if (o.sa or A.on) then
			local FlatIdent_957A4 = 0;
			local m;
			while true do
				if (FlatIdent_957A4 == 0) then
					m = murd();
					mChar = m and m.Character;
					FlatIdent_957A4 = 1;
				end
				if (FlatIdent_957A4 == 1) then
					mPart = mChar and mChar:FindFirstChild("HumanoidRootPart");
					break;
				end
			end
		else
			mChar, mPart = nil, nil;
		end
	end
end);
local function path(x)
	local FlatIdent_7126B = 0;
	local t;
	while true do
		if (0 == FlatIdent_7126B) then
			t = {};
			while x and (x ~= game) do
				local FlatIdent_21CA5 = 0;
				while true do
					if (FlatIdent_21CA5 == 0) then
						table.insert(t, 1, x.Name);
						x = x.Parent;
						break;
					end
				end
			end
			FlatIdent_7126B = 1;
		end
		if (FlatIdent_7126B == 1) then
			return table.concat(t, ".");
		end
	end
end
local function aimArgs(self, m, a)
	local FlatIdent_227B6 = 0;
	local nm;
	local pn;
	local isShoot;
	local isBeam;
	local pos;
	while true do
		if (0 == FlatIdent_227B6) then
			nm = self.Name:lower();
			pn = ((self.Parent and self.Parent.Name) or ""):lower();
			FlatIdent_227B6 = 1;
		end
		if (FlatIdent_227B6 == 2) then
			if (o.dbg and (isShoot or isBeam or nm:find("gun") or nm:find("knife"))) then
				local FlatIdent_4C119 = 0;
				local t;
				while true do
					if (FlatIdent_4C119 == 0) then
						t = {};
						for i = 1, a.n do
							t[i] = typeof(a[i]);
						end
						FlatIdent_4C119 = 1;
					end
					if (FlatIdent_4C119 == 1) then
						print("remote:", m, path(self), table.concat(t, ", "));
						break;
					end
				end
			end
			if (not mPart or not (isShoot or isBeam)) then
				return false;
			end
			FlatIdent_227B6 = 3;
		end
		if (FlatIdent_227B6 == 4) then
			for i = 1, a.n do
				if (typeof(a[i]) == "Vector3") then
					local FlatIdent_7517F = 0;
					while true do
						if (0 == FlatIdent_7517F) then
							a[i] = pos;
							return true;
						end
					end
				end
			end
			return false;
		end
		if (FlatIdent_227B6 == 1) then
			isShoot = nm:find("shoot") ~= nil;
			isBeam = (pn:find("createbeam") ~= nil) or (nm:find("beam") ~= nil);
			FlatIdent_227B6 = 2;
		end
		if (FlatIdent_227B6 == 3) then
			pos = mPart.Position + (mPart.AssemblyLinearVelocity * 0.1);
			if isShoot then
				for i = a.n, 1, -1 do
					if (typeof(a[i]) == "CFrame") then
						a[i] = CFrame.new(pos);
						return true;
					end
				end
			end
			FlatIdent_227B6 = 4;
		end
	end
end
if (hookmetamethod and getnamecallmethod) then
	local FlatIdent_43BEE = 0;
	local old;
	local hook;
	while true do
		if (FlatIdent_43BEE == 1) then
			function hook(self, ...)
				local FlatIdent_2C3E6 = 0;
				local m;
				while true do
					if (FlatIdent_2C3E6 == 1) then
						return old(self, ...);
					end
					if (FlatIdent_2C3E6 == 0) then
						m = getnamecallmethod();
						if (((m == "FireServer") or (m == "InvokeServer")) and (o.sa or o.dbg) and not (checkcaller and checkcaller())) then
							local FlatIdent_6C967 = 0;
							local a;
							local ok;
							local changed;
							while true do
								if (FlatIdent_6C967 == 0) then
									a = table.pack(...);
									ok, changed = pcall(aimArgs, self, m, a);
									FlatIdent_6C967 = 1;
								end
								if (FlatIdent_6C967 == 1) then
									if setnamecallmethod then
										setnamecallmethod(m);
									end
									if (ok and changed and o.sa) then
										return old(self, table.unpack(a, 1, a.n));
									end
									break;
								end
							end
						end
						FlatIdent_2C3E6 = 1;
					end
				end
			end
			old = hookmetamethod(game, "__namecall", (newcclosure and newcclosure(hook)) or hook);
			break;
		end
		if (0 == FlatIdent_43BEE) then
			old = nil;
			hook = nil;
			FlatIdent_43BEE = 1;
		end
	end
else
	warn("hookmetamethod not supported, silent aim off");
end
local function shootMurderer()
	local FlatIdent_8BA1E = 0;
	local char;
	local hum;
	local hrp;
	local m;
	local mh;
	local gun;
	local shoot;
	while true do
		if (FlatIdent_8BA1E == 0) then
			char = me.Character;
			hum = char and char:FindFirstChildOfClass("Humanoid");
			FlatIdent_8BA1E = 1;
		end
		if (FlatIdent_8BA1E == 4) then
			shoot = gun and gun:FindFirstChild("Shoot");
			if (shoot and shoot:IsA("RemoteEvent")) then
				local FlatIdent_1BA2F = 0;
				local pos;
				while true do
					if (FlatIdent_1BA2F == 0) then
						pos = mh.Position + (mh.AssemblyLinearVelocity * 0.1);
						shoot:FireServer(CFrame.new(hrp.Position), CFrame.new(pos));
						break;
					end
				end
			elseif o.dbg then
				print("Gun or Shoot remote not found");
			end
			break;
		end
		if (FlatIdent_8BA1E == 1) then
			hrp = char and char:FindFirstChild("HumanoidRootPart");
			m = murd();
			FlatIdent_8BA1E = 2;
		end
		if (FlatIdent_8BA1E == 2) then
			mh = m and m.Character and m.Character:FindFirstChild("HumanoidRootPart");
			if not (hum and hrp and mh) then
				return;
			end
			FlatIdent_8BA1E = 3;
		end
		if (3 == FlatIdent_8BA1E) then
			gun = char:FindFirstChild("Gun");
			if not gun then
				local FlatIdent_44005 = 0;
				local bp;
				while true do
					if (FlatIdent_44005 == 1) then
						if gun then
							local FlatIdent_58BB3 = 0;
							while true do
								if (FlatIdent_58BB3 == 0) then
									hum:EquipTool(gun);
									task.wait(0.15);
									break;
								end
							end
						end
						break;
					end
					if (FlatIdent_44005 == 0) then
						bp = me:FindFirstChild("Backpack");
						gun = bp and bp:FindFirstChild("Gun");
						FlatIdent_44005 = 1;
					end
				end
			end
			FlatIdent_8BA1E = 4;
		end
	end
end
local rp = RaycastParams.new();
rp.FilterType = Enum.RaycastFilterType.Exclude;
pcall(function()
	RUN:UnbindFromRenderStep("PlaggAim");
end);
RUN:BindToRenderStep("PlaggAim", Enum.RenderPriority.Camera.Value + 1, function(dt)
	if (not A.on or not mChar or not mChar.Parent) then
		return;
	end
	local char = me.Character;
	if (A.gun and not (char and char:FindFirstChild("Gun"))) then
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
	local dist = (part.Position - from).Magnitude;
	local t = (A.pred / 1000) + (dist / 1500);
	local pos = part.Position + (root.AssemblyLinearVelocity * t);
	if A.wall then
		local FlatIdent_71E8F = 0;
		while true do
			if (FlatIdent_71E8F == 0) then
				rp.FilterDescendantsInstances = {char,mChar};
				if workspace:Raycast(from, pos - from, rp) then
					return;
				end
				break;
			end
		end
	end
	local alpha = math.clamp(A.smooth / 100, 0.05, 1);
	alpha = 1 - ((1 - alpha) ^ (math.min(dt, 0.1) * 60));
	cam.CFrame = cam.CFrame:Lerp(CFrame.new(from, pos), alpha);
end);
local afk;
local function setAfk(v)
	local FlatIdent_92B2B = 0;
	while true do
		if (FlatIdent_92B2B == 0) then
			if afk then
				local FlatIdent_51C44 = 0;
				while true do
					if (FlatIdent_51C44 == 0) then
						afk:Disconnect();
						afk = nil;
						break;
					end
				end
			end
			if v then
				afk = me.Idled:Connect(function()
					local FlatIdent_92514 = 0;
					while true do
						if (FlatIdent_92514 == 0) then
							VU:CaptureController();
							VU:ClickButton2(Vector2.new());
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
	local FlatIdent_13B77 = 0;
	while true do
		if (0 == FlatIdent_13B77) then
			if bv then
				local FlatIdent_7699F = 0;
				while true do
					if (FlatIdent_7699F == 0) then
						bv:Destroy();
						bv = nil;
						break;
					end
				end
			end
			if bg then
				local FlatIdent_8B7B0 = 0;
				while true do
					if (FlatIdent_8B7B0 == 0) then
						bg:Destroy();
						bg = nil;
						break;
					end
				end
			end
			FlatIdent_13B77 = 1;
		end
		if (FlatIdent_13B77 == 1) then
			if flying then
				flying = false;
				local h = me.Character and me.Character:FindFirstChildOfClass("Humanoid");
				if h then
					h.PlatformStand = false;
				end
			end
			break;
		end
	end
end
RUN.Heartbeat:Connect(function()
	local FlatIdent_35AC5 = 0;
	local char;
	local hum;
	local hrp;
	while true do
		if (FlatIdent_35AC5 == 1) then
			hrp = char and char:FindFirstChild("HumanoidRootPart");
			if (not hum or not hrp) then
				return;
			end
			FlatIdent_35AC5 = 2;
		end
		if (FlatIdent_35AC5 == 0) then
			char = me.Character;
			hum = char and char:FindFirstChildOfClass("Humanoid");
			FlatIdent_35AC5 = 1;
		end
		if (FlatIdent_35AC5 == 3) then
			if L.fly then
				if (not bv or (bv.Parent ~= hrp)) then
					local FlatIdent_11AA1 = 0;
					while true do
						if (FlatIdent_11AA1 == 2) then
							bg = Instance.new("BodyGyro");
							bg.MaxTorque = Vector3.one * 1000000000;
							bg.P = 10000;
							FlatIdent_11AA1 = 3;
						end
						if (FlatIdent_11AA1 == 1) then
							bv.MaxForce = Vector3.one * 1000000000;
							bv.Velocity = Vector3.zero;
							bv.Parent = hrp;
							FlatIdent_11AA1 = 2;
						end
						if (FlatIdent_11AA1 == 0) then
							if bv then
								bv:Destroy();
							end
							if bg then
								bg:Destroy();
							end
							bv = Instance.new("BodyVelocity");
							FlatIdent_11AA1 = 1;
						end
						if (3 == FlatIdent_11AA1) then
							bg.Parent = hrp;
							flying = true;
							break;
						end
					end
				end
				hum.PlatformStand = true;
				local c = workspace.CurrentCamera;
				local mv = c.CFrame:VectorToObjectSpace(hum.MoveDirection);
				bv.Velocity = ((c.CFrame.RightVector * mv.X) + (c.CFrame.LookVector * -mv.Z)) * L.fs;
				bg.CFrame = c.CFrame;
			end
			break;
		end
		if (FlatIdent_35AC5 == 2) then
			if L.speed then
				hum.WalkSpeed = L.ws;
			end
			if L.jump then
				local FlatIdent_1691A = 0;
				while true do
					if (FlatIdent_1691A == 0) then
						hum.UseJumpPower = true;
						hum.JumpPower = L.jp;
						break;
					end
				end
			end
			FlatIdent_35AC5 = 3;
		end
	end
end);
RUN.Stepped:Connect(function()
	if (L.noclip and me.Character) then
		for _, v in ipairs(me.Character:GetDescendants()) do
			if (v:IsA("BasePart") and v.CanCollide) then
				v.CanCollide = false;
			end
		end
	end
end);
UIS.JumpRequest:Connect(function()
	if L.inf then
		local FlatIdent_47F4B = 0;
		local h;
		while true do
			if (FlatIdent_47F4B == 0) then
				h = me.Character and me.Character:FindFirstChildOfClass("Humanoid");
				if h then
					h:ChangeState(Enum.HumanoidStateType.Jumping);
				end
				break;
			end
		end
	end
end);
local function keeper()
	local FlatIdent_270C = 0;
	local store;
	local set;
	local undo;
	while true do
		if (FlatIdent_270C == 1) then
			function set(i, p, v)
				local FlatIdent_5B644 = 0;
				local t;
				while true do
					if (FlatIdent_5B644 == 1) then
						if (t[p] == nil) then
							t[p] = i[p];
						end
						if (i[p] ~= v) then
							i[p] = v;
						end
						break;
					end
					if (FlatIdent_5B644 == 0) then
						t = store[i];
						if not t then
							local FlatIdent_733BE = 0;
							while true do
								if (FlatIdent_733BE == 0) then
									t = {};
									store[i] = t;
									break;
								end
							end
						end
						FlatIdent_5B644 = 1;
					end
				end
			end
			undo = nil;
			FlatIdent_270C = 2;
		end
		if (2 == FlatIdent_270C) then
			function undo()
				local FlatIdent_253F0 = 0;
				while true do
					if (0 == FlatIdent_253F0) then
						for i, t in pairs(store) do
							for p, v in pairs(t) do
								pcall(function()
									i[p] = v;
								end);
							end
						end
						store = setmetatable({}, {__mode="k"});
						break;
					end
				end
			end
			return set, undo;
		end
		if (FlatIdent_270C == 0) then
			store = setmetatable({}, {__mode="k"});
			set = nil;
			FlatIdent_270C = 1;
		end
	end
end
local fogSet, fogUndo = keeper();
local brSet, brUndo = keeper();
local lagSet, lagUndo = keeper();
local function light()
	if V.nofog then
		local FlatIdent_810B1 = 0;
		while true do
			if (FlatIdent_810B1 == 0) then
				fogSet(Lt, "FogEnd", 1000000000);
				fogSet(Lt, "FogStart", 1000000000);
				FlatIdent_810B1 = 1;
			end
			if (FlatIdent_810B1 == 1) then
				for _, a in ipairs(Lt:GetChildren()) do
					if a:IsA("Atmosphere") then
						local FlatIdent_35814 = 0;
						while true do
							if (FlatIdent_35814 == 0) then
								fogSet(a, "Density", 0);
								fogSet(a, "Haze", 0);
								break;
							end
						end
					end
				end
				break;
			end
		end
	end
	if V.bright then
		local FlatIdent_70003 = 0;
		while true do
			if (FlatIdent_70003 == 0) then
				brSet(Lt, "Brightness", 2);
				brSet(Lt, "ClockTime", 14);
				FlatIdent_70003 = 1;
			end
			if (FlatIdent_70003 == 2) then
				brSet(Lt, "OutdoorAmbient", WHITE);
				break;
			end
			if (FlatIdent_70003 == 1) then
				brSet(Lt, "GlobalShadows", false);
				brSet(Lt, "Ambient", WHITE);
				FlatIdent_70003 = 2;
			end
		end
	end
end
local function refreshLight()
	pcall(function()
		RUN:UnbindFromRenderStep("PlaggLight");
	end);
	if (V.nofog or V.bright) then
		RUN:BindToRenderStep("PlaggLight", Enum.RenderPriority.Last.Value, light);
	end
end
local function strip(v)
	pcall(function()
		if v:IsA("BasePart") then
			local FlatIdent_35C62 = 0;
			while true do
				if (FlatIdent_35C62 == 0) then
					lagSet(v, "Material", Enum.Material.SmoothPlastic);
					lagSet(v, "Reflectance", 0);
					FlatIdent_35C62 = 1;
				end
				if (FlatIdent_35C62 == 1) then
					if v:IsA("MeshPart") then
						lagSet(v, "TextureID", "");
					end
					break;
				end
			end
		elseif (v:IsA("Decal") or v:IsA("Texture")) then
			lagSet(v, "Transparency", 1);
		elseif v:IsA("SpecialMesh") then
			lagSet(v, "TextureId", "");
		elseif v:IsA("SurfaceAppearance") then
			local FlatIdent_4058F = 0;
			while true do
				if (FlatIdent_4058F == 1) then
					lagSet(v, "MetalnessMap", "");
					lagSet(v, "RoughnessMap", "");
					break;
				end
				if (FlatIdent_4058F == 0) then
					lagSet(v, "ColorMap", "");
					lagSet(v, "NormalMap", "");
					FlatIdent_4058F = 1;
				end
			end
		elseif (v:IsA("ParticleEmitter") or v:IsA("Trail") or v:IsA("Fire") or v:IsA("Smoke") or v:IsA("Sparkles") or v:IsA("PostEffect")) then
			lagSet(v, "Enabled", false);
		end
	end);
end
local lagConn;
local function setLag(v)
	local FlatIdent_243F3 = 0;
	while true do
		if (FlatIdent_243F3 == 1) then
			if v then
				local FlatIdent_7B4B6 = 0;
				while true do
					if (FlatIdent_7B4B6 == 0) then
						lagConn = workspace.DescendantAdded:Connect(function(x)
							task.defer(strip, x);
						end);
						task.spawn(function()
							local FlatIdent_47EEF = 0;
							local n;
							while true do
								if (FlatIdent_47EEF == 1) then
									for _, x in ipairs(Lt:GetDescendants()) do
										strip(x);
									end
									break;
								end
								if (FlatIdent_47EEF == 0) then
									n = 0;
									for _, x in ipairs(workspace:GetDescendants()) do
										local FlatIdent_2B986 = 0;
										while true do
											if (1 == FlatIdent_2B986) then
												n += 1
												if ((n % 400) == 0) then
													task.wait();
												end
												break;
											end
											if (FlatIdent_2B986 == 0) then
												if not V.lag then
													return;
												end
												strip(x);
												FlatIdent_2B986 = 1;
											end
										end
									end
									FlatIdent_47EEF = 1;
								end
							end
						end);
						break;
					end
				end
			else
				lagUndo();
			end
			break;
		end
		if (FlatIdent_243F3 == 0) then
			V.lag = v;
			if lagConn then
				local FlatIdent_2A75 = 0;
				while true do
					if (FlatIdent_2A75 == 0) then
						lagConn:Disconnect();
						lagConn = nil;
						break;
					end
				end
			end
			FlatIdent_243F3 = 1;
		end
	end
end
ui({Name="PurpleTheme",Accent=Color3.fromRGB(149, 51, 255),Outline=Color3.fromRGB(88, 58, 195),Text=Color3.fromRGB(255, 255, 255),PlaceholderText=Color3.fromRGB(168, 95, 255),Background=Color3.fromRGB(12, 92, 28),Secondary=Color3.fromRGB(22, 95, 45),Tertiary=Color3.fromRGB(38, 20, 60)});
local win = ui({Title="Plagg Hub",Size=UDim2.fromOffset(450, 300),Transparent=true,Theme="PurpleTheme",SideBarWidth=140,HasOutline=false,ToggleOutline=false});
local combat = win({Title="Combat",Icon="crosshair"});
local farm = win({Title="Farm",Icon="coins"});
local vis = win({Title="Visual",Icon="eye"});
local plr = win({Title="Local Player",Icon="user"});
local misc = win({Title="Misc",Icon="settings"});
combat:Select();
local shootGui = Instance.new("ScreenGui");
shootGui.Name = "ShootBtn";
shootGui.ResetOnSpawn = false;
shootGui.Enabled = false;
pcall(function()
	shootGui.Parent = (gethui and gethui()) or game:GetService("CoreGui");
end);
if not shootGui.Parent then
	shootGui.Parent = me:WaitForChild("PlayerGui");
end
local sbtn = Instance.new("TextButton");
sbtn.Size = UDim2.new(0, 70, 0, 70);
sbtn.Position = UDim2.new(0.8, 0, 0.55, 0);
sbtn.BackgroundColor3 = Color3.new(0, 0, 0);
sbtn.BackgroundTransparency = 0.15;
sbtn.BorderSizePixel = 0;
sbtn.Font = Enum.Font.FredokaOne;
sbtn.Text = "Shoot\nMurderer";
sbtn.TextColor3 = Color3.fromRGB(255, 60, 60);
sbtn.TextSize = 14;
sbtn.TextWrapped = true;
sbtn.Active = true;
sbtn.Draggable = true;
sbtn.Parent = shootGui;
Instance.new("UICorner", sbtn).CornerRadius = UDim.new(0, 12);
sbtn.MouseButton1Click:Connect(shootMurderer);
combat({Title="Silent Aim",Desc="Sheriff shots go to the Murderer",Value=false,Callback=function(v)
	o.sa = v;
end});
combat({Title="Shoot Murderer Button",Desc="Movable button that shoots the Murderer",Value=false,Callback=function(v)
	shootGui.Enabled = v;
end});
combat({Title="Aimbot Murderer",Desc="Locks the camera on the Murderer's torso",Value=false,Callback=function(v)
	A.on = v;
end});
combat({Title="Aimbot: Only With Gun",Desc="Only locks while holding the gun",Value=false,Callback=function(v)
	A.gun = v;
end});
combat({Title="Aimbot: Wall Check",Desc="Doesn't lock through walls",Value=false,Callback=function(v)
	A.wall = v;
end});
combat({Title="Aimbot Smoothness",Desc="100 = instant lock, lower = smoother",Value={Min=5,Max=100,Default=100},Step=1,Callback=function(v)
	A.smooth = v;
end});
combat({Title="Aimbot Prediction",Desc="Lead time in ms",Value={Min=0,Max=300,Default=120},Step=5,Callback=function(v)
	A.pred = v;
end});
combat({Title="Auto Grab Gun",Desc="Picks up the dropped gun",Value=false,Callback=function(v)
	o.grab = v;
end});
farm({Title="Autofarm Coins",Desc="Only during a round, while alive",Value=false,Callback=function(v)
	local FlatIdent_1FCD6 = 0;
	while true do
		if (FlatIdent_1FCD6 == 0) then
			o.farm = v;
			if not (o.farm or o.xp) then
				stop();
			end
			break;
		end
	end
end});
farm({Title="Autofarm + XP Farm",Desc="Bag full: goes to the lobby until the round ends",Value=false,Callback=function(v)
	local FlatIdent_67611 = 0;
	while true do
		if (FlatIdent_67611 == 0) then
			o.xp = v;
			if not (o.farm or o.xp) then
				stop();
			end
			break;
		end
	end
end});
farm({Title="Farm Speed",Desc="Studs per second",Value={Min=1,Max=25,Default=25},Step=1,Callback=function(v)
	o.spd = v;
end});
farm({Title="Auto End Run",Desc="Resets when the bag is full (off while XP Farm is on)",Value=false,Callback=function(v)
	o.reset = v;
end});
vis({Title="ESP Players",Desc="Name + role + highlight",Value=false,Callback=function(v)
	local FlatIdent_3416F = 0;
	while true do
		if (FlatIdent_3416F == 0) then
			o.esp = v;
			if not v then
				clear("ESP_Player");
			end
			break;
		end
	end
end});
vis({Title="ESP Dropped Gun",Value=false,Callback=function(v)
	local FlatIdent_15354 = 0;
	while true do
		if (FlatIdent_15354 == 0) then
			o.gun = v;
			if not v then
				clear("ESP_Gun");
			end
			break;
		end
	end
end});
vis({Title="ESP Traps",Value=false,Callback=function(v)
	local FlatIdent_7C7BE = 0;
	while true do
		if (FlatIdent_7C7BE == 0) then
			o.trap = v;
			if not v then
				clear("ESP_Trap");
			end
			break;
		end
	end
end});
vis({Title="No Fog",Value=false,Callback=function(v)
	local FlatIdent_1B5ED = 0;
	while true do
		if (FlatIdent_1B5ED == 0) then
			V.nofog = v;
			if not v then
				fogUndo();
			end
			FlatIdent_1B5ED = 1;
		end
		if (FlatIdent_1B5ED == 1) then
			refreshLight();
			break;
		end
	end
end});
vis({Title="Full Bright",Value=false,Callback=function(v)
	local FlatIdent_14BC6 = 0;
	while true do
		if (0 == FlatIdent_14BC6) then
			V.bright = v;
			if not v then
				brUndo();
			end
			FlatIdent_14BC6 = 1;
		end
		if (FlatIdent_14BC6 == 1) then
			refreshLight();
			break;
		end
	end
end});
vis({Title="Anti Lag",Desc="Removes textures and effects",Value=false,Callback=setLag});
plr({Title="TP to Lobby",Callback=function()
	tp(lobbyPos());
end});
plr({Title="TP to Map",Callback=function()
	tp(mapPos());
end});
plr({Title="Speed",Value=false,Callback=function(v)
	local FlatIdent_94BA0 = 0;
	while true do
		if (0 == FlatIdent_94BA0) then
			L.speed = v;
			if not v then
				local FlatIdent_1F138 = 0;
				local h;
				while true do
					if (FlatIdent_1F138 == 0) then
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
	local FlatIdent_61AEE = 0;
	while true do
		if (FlatIdent_61AEE == 0) then
			L.jump = v;
			if not v then
				local FlatIdent_15C08 = 0;
				local h;
				while true do
					if (FlatIdent_15C08 == 0) then
						h = me.Character and me.Character:FindFirstChildOfClass("Humanoid");
						if h then
							h.JumpPower = 50;
						end
						break;
					end
				end
			end
			break;
		end
	end
end});
plr({Title="Jump Height",Value={Min=1,Max=200,Default=100},Step=1,Callback=function(v)
	L.jp = v;
end});
plr({Title="Infinite Jump",Value=false,Callback=function(v)
	L.inf = v;
end});
plr({Title="Noclip",Value=false,Callback=function(v)
	L.noclip = v;
end});
plr({Title="Fly",Value=false,Callback=function(v)
	L.fly = v;
	if not v then
		stopFly();
	end
end});
plr({Title="Fly Speed",Value={Min=1,Max=100,Default=50},Step=1,Callback=function(v)
	L.fs = v;
end});
misc({Title="Anti AFK",Value=true,Callback=setAfk});
misc({Title="Debug Console",Desc="Prints remotes and bag status in the console",Value=false,Callback=function(v)
	o.dbg = v;
end});
