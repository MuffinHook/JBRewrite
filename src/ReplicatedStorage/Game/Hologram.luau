-- Reviewed by Claude
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CollectionService = game:GetService("CollectionService")
local Logic = require(ReplicatedStorage.Module.Logic)
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local BountyBoardService = require(ReplicatedStorage.Bounty.BountyBoardService)
local LocalPlayer = Players.LocalPlayer
local CurrentCamera = workspace.CurrentCamera
local Localization = require(ReplicatedStorage.Module.Localization)
local abs = math.abs
local function comma(p1)
	local v1, v2, v3 = string.match(p1, "^([^%d]*%d)(%d*)(.-)$")
	return v1 .. v2:reverse():gsub("(%d%d%d)", "%1,"):reverse() .. v3
end
local function FormatMoney(p1)
	local t = {}
	local v4, v5, v6 = string.match(abs(p1), "^([^%d]*%d)(%d*)(.-)$")
	t[1] = v4 .. v5:reverse():gsub("(%d%d%d)", "%1,"):reverse() .. v6
	return if p1 >= 0 then "" else "-" .. Localization:FormatByKey("General.Cash", t)
end
local function MakeSystem()
	local t = {
		Scale = 0.015625,
		Nodes = {},
		Center = CFrame.new(),
		Model = Instance.new("Model"),
		LastRender = 0,
		PlayerNodes = {}
	}
	t.Model.Name = "Hologram"
	t.Model.Parent = workspace
	return t
end
local t = {}
local function DestroySystem(p1)
	for i = #t, 1, -1 do
		if t[i] == p1 then
			table.remove(t, i)
			break
		end
	end
	p1.Model:Destroy()
end
local function SetNodeColor(p1, p2)
	local Part = p1.Part
	local r = p2.r
	local g = p2.g
	local b = p2.b
	Part.Color = Color3.new(r, g, b)
	Part.SelectionBox.Color3 = Color3.new(r + 0.2, g + 0.2, b + 0.2)
end
local function ConstructNode(p1, p2)
	local Part = Instance.new("Part")
	Part.Transparency = 0
	Part.Material = Enum.Material.SmoothPlastic
	Part.CanCollide = false
	Part.Anchored = true
	Part.TopSurface = 0
	Part.BottomSurface = 0
	local SelectionBox = Instance.new("SelectionBox")
	SelectionBox.Parent = Part
	SelectionBox.Adornee = Part
	SelectionBox.LineThickness = 0.0001
	p1.Part = Part
	local Part_2 = p1.Part
	local r = p2.r
	local g = p2.g
	local b = p2.b
	Part_2.Color = Color3.new(r, g, b)
	Part_2.SelectionBox.Color3 = Color3.new(r + 0.2, g + 0.2, b + 0.2)
end
local function MakeNode(p1, p2)
	return {
		c = p1,
		s = p2
	}
end
local function HorizontalDistance(p1, p2)
	return ((p1 - p2) * Vector3.new(1, 0, 1)).Magnitude
end
local function CloseToAny(p1, p2)
	for v1, v2 in next, p2 do
		if ((v2.Position - p1.Position) * Vector3.new(1, 0, 1)).Magnitude < 100 then
			return true
		end
	end
	return false
end
local function SimplifyCityParts(p1, p2)
	while #p2 > 0 do
		local v1 = table.remove(p2, 1)
		local t = { v1 }
		for i = #p2, 1, -1 do
			local v2 = p2[i]
			if v2.Name ~= "Bank" and v1.Color == v2.Color then
				local v3 = false
				for v4, v5 in next, t do
					if ((v5.Position - v2.Position) * Vector3.new(1, 0, 1)).Magnitude < 100 then
						v3 = true
						break
					end
				end
				if v3 then
					table.insert(t, table.remove(p2, i))
				end
			end
		end
		local v6, v7 = Logic.MultiAABB(t)
		local t2 = {
			c = v6,
			s = v7
		}
		local v9 = math.floor(math.random() * 30)
		ConstructNode(t2, Color3.fromRGB(v9 + 33, v9 + 84, v9 + 185))
		t2.Part.Parent = p1.Model
		table.insert(p1.Nodes, t2)
	end
end
local function SimplifyTrees(p1, p2)
	local v1 = next
	local v2, v3 = p2:GetChildren()
	for v4, v5 in v1, v2, v3 do
		local v6, v7 = Logic.MultiAABB(v5:GetChildren())
		local t = {
			c = v6,
			s = v7
		}
		local v9 = math.floor(math.random() * 30)
		ConstructNode(t, Color3.fromRGB(v9 + 30, v9 + 30, v9 + 30))
		t.Part.Parent = p1.Model
		table.insert(p1.Nodes, t)
	end
end
local t2 = {
	{
		Color = Color3.fromRGB(255, 176, 0),
		Loc = {
			{
				c = CFrame.new(-1306.4353, 27.0160275, -1588.15491, 0, 0, 0.999999821, 0, 1, 0, -0.999999821, 0, 0),
				s = Vector3.new(70.69997, 22.100002, 104.200005)
			},
			{
				c = CFrame.new(-1418.48523, 35.1660271, -1790.30481, 0, 0, 0.999999821, 0, 1, 0, -0.999999821, 0, 0),
				s = Vector3.new(238.19997, 38.4, 130.3)
			},
			{
				c = CFrame.new(-1180.7854, 27.0160275, -1583.95483, 0, 0, 0.999999821, 0, 1, 0, -0.999999821, 0, 0),
				s = Vector3.new(62.299965, 22.100002, 97.70001)
			},
			{
				c = CFrame.new(-1159.08545, 36.4160271, -1572.70496, 0, 0, 0.999999821, 0, 1, 0, -0.999999821, 0, 0),
				s = Vector3.new(57.59996, 40.9, 54.30001)
			}
		}
	},
	{
		Color = Color3.fromRGB(33, 84, 185),
		Loc = {
			{
				c = CFrame.new(-1414.62683, 29.2624836, 240.934875, 0.974374056, 0, -0.224932864, 0, 1, 0, 0.224932864, 0, 0.974374056),
				s = Vector3.new(72.1, 18.149998, 21.249998)
			},
			{
				c = CFrame.new(1626.70471, 23.6678162, 321.181366, -0.0703834072, 3.45619391e-8, 0.997519851, 1.21779853e-9, 1, -3.45619462e-8, -0.99752003, -1.21779953e-9, -0.0703832731),
				s = Vector3.new(98.69996, 20.600004, 32.499996)
			},
			{
				c = CFrame.new(1609.9812, 24.7178154, 236.899399, -0.0703834072, 3.45619391e-8, 0.997519851, 1.21779853e-9, 1, -3.45619462e-8, -0.99752003, -1.21779953e-9, -0.0703832731),
				s = Vector3.new(21.799957, 22.700005, 54)
			}
		}
	},
	{
		Color = Color3.fromRGB(10, 245, 10),
		Loc = {
			{
				c = CFrame.new(261.724365, 22.0178318, -1759.17798, -1.78813934e-7, 0, 0.999999464, 0, 1, 0, -0.999999464, 0, -1.78813934e-7),
				s = Vector3.new(43.299965, 14.7000065, 70.39999)
			},
			{
				c = CFrame.new(-1577.18359, 27.4110489, 703.805176, -0.156434387, 0, 0.987687826, 0, 1, 0, -0.987687826, 0, -0.156434387),
				s = Vector3.new(60.099968, 27.200005, 30.299988)
			},
			{
				c = CFrame.new(119.976921, 55.0110474, 1313.11108, -0.156433716, 0, 0.987683594, 0, 1, 0, -0.987683594, 0, -0.156433716),
				s = Vector3.new(82.19997, 82.40001, 51.19999)
			},
			{
				c = CFrame.new(1084.36975, 116.81105, 1211.08044, 0.615661383, 0, 0.788010776, 0, 1, 0, -0.788010776, 0, 0.615661442),
				s = Vector3.new(148.69997, 40.500008, 85.899994)
			},
			{
				c = CFrame.new(49.8085251, 87.265625, 829.535156, 0.0348739922, 0, 0.999391735, 0, 1, 0, -0.999391735, 0, 0.0348739922),
				s = Vector3.new(68.200005, 145.3, 69.399956)
			}
		}
	},
	{
		Color = Color3.fromRGB(151, 0, 0),
		Loc = {
			{
				c = CFrame.new(1030.40198, 170.611053, 1115.61755, 0.615661263, 0, 0.788010716, 0, 1, 0, -0.788010776, 0, 0.615661502),
				s = Vector3.new(22.099964, 148.1, 21.699997)
			}
		}
	}
}
local function SimplifyExtra(p1)
	for v1, v2 in next, t2 do
		for v3, v4 in next, v2.Loc do
			local v6 = math.floor(math.random() * 30 / 255)
			local t = {
				c = v4.c,
				s = v4.s
			}
			local Color = v2.Color
			ConstructNode(t, Color3.new(Color.r + v6, Color.g + v6, Color.b + v6))
			t.Part.Parent = p1.Model
			table.insert(p1.Nodes, t)
		end
	end
end
local function RenderSystem(p1)
	local Scale = p1.Scale
	local v1 = tick()
	for v2, v3 in next, p1.Nodes do
		local c = v3.c
		local Part = v3.Part
		local v4 = c + c.p * (Scale - 1)
		local _lastSize = v3._lastSize
		local v6 = v3.s * Scale
		if not _lastSize or (_lastSize - v6).Magnitude > 0.001 then
			Part.Size = v6
			v3._lastSize = v6
		end
		Part.CFrame = p1.Center * v4 * CFrame.new(0, math.cos(0.1 * (v4.p.Magnitude / (64 * Scale)) + 2 * v1) * 0.2, 0)
	end
	local PlayerNodes = p1.PlayerNodes
	local v7 = next
	local v8, v9 = Players:GetPlayers()
	local t = {}
	for v11, v12 in v7, v8, v9 do
		local v10
		local v13 = v12.Name
		local Character = v12.Character
		if Character then
			local PrimaryPart = Character.PrimaryPart
			if PrimaryPart then
				t[v13] = true
				local v14 = PrimaryPart.CFrame
				local v15 = PlayerNodes[v13]
				if v15 then
					PlayerNodes[v13].c = v14
				else
					local t2 = {
						c = v14,
						s = PrimaryPart.Size,
						IsPolice = false
					}
					PlayerNodes[v13] = t2
					ConstructNode(t2, Color3.fromRGB(240, 20, 20))
					t2.Part.Parent = p1.Model
					v15 = t2
				end
				local v16 = v1 % 6.283185307179586
				local Part = v15.Part
				local c = v15.c
				Part.Size = Vector3.new(1, 1, 1) * ((math.cos(8 * v16) * 0.5 + 0.5) * 0.5 + 0.3) * 64 * Scale
				Part.CFrame = p1.Center * (c + c.p * (Scale - 1)) * CFrame.Angles(0, 4 * v16, 0) * CFrame.Angles(0.7853981633974483, 0, 0.7853981633974483)
				local TeamValue = v12:FindFirstChild("TeamValue")
				if TeamValue then
					local isValue = TeamValue.Value == "Police"
					if not v15.BountyGui then
						local v18 = ReplicatedStorage.Resource.HologramBounty:Clone()
						v18.Parent = Part
						v18.Frame.Player.Text = v12.DisplayName
						v15.BountyGui = v18
					end
					if v15.Bounty and not isValue then
						v15.BountyGui.Frame.Bounty.Visible = true
						local Bounty_2 = v15.Bounty
						v10 = if Bounty_2 >= 0 then "" else "-"
						local t2 = {}
						local v21, v22, v23 = string.match(abs(Bounty_2), "^([^%d]*%d)(%d*)(.-)$")
						t2[1] = v21 .. v22:reverse():gsub("(%d%d%d)", "%1,"):reverse() .. v23
						v15.BountyGui.Frame.Bounty.Text = v10 .. Localization:FormatByKey("General.Cash", t2)
					else
						v15.BountyGui.Frame.Bounty.Visible = false
					end
					if v15.IsPolice ~= isValue then
						v15.IsPolice = isValue
						local v24 = isValue and Color3.new(255/255, 255/255, 255/255) or Color3.fromRGB(240, 20, 20)
						local Part_2 = v15.Part
						local r = v24.r
						local g = v24.g
						local b = v24.b
						Part_2.Color = Color3.new(r, g, b)
						Part_2.SelectionBox.Color3 = Color3.new(r + 0.2, g + 0.2, b + 0.2)
						v15.BountyGui.Frame.Player.TextColor3 = v24
					end
				end
			end
		end
	end
	for v25, v26 in next, PlayerNodes do
		if not t[v25] then
			local v27 = PlayerNodes[v25]
			if v27.BountyGui then
				v27.BountyGui:Destroy()
			end
			v27.Part:Destroy()
			PlayerNodes[v25] = nil
		end
	end
end
return {
	Init = function()
		BountyBoardService.onBountiesUpdated:Connect(function(p1)
			for v1, v2 in next, t do
				for v3, v4 in p1 do
					local v5 = v2.PlayerNodes[v4.Name]
					if v5 then
						v5.Bounty = v4.Bounty
					end
				end
			end
		end)
		local t2 = {}
		local t3 = {}
		local function AddedFun(p1)
			table.insert(t2, p1)
		end
		local function RemovedFun(p1)
			for i = #t2, 1, -1 do
				if t2[i] == p1 then
					table.remove(t2, i)
					local v1 = t3[p1]
					if v1 then
						DestroySystem(v1)
					end
					break
				end
			end
		end
		local v1 = next
		local v2, v3 = CollectionService:GetTagged("MapHologram")
		for v4, v5 in v1, v2, v3 do
			table.insert(t2, v5)
		end
		CollectionService:GetInstanceAddedSignal("MapHologram"):Connect(AddedFun)
		CollectionService:GetInstanceRemovedSignal("MapHologram"):Connect(RemovedFun)
		local v6 = tick()
		local function Heartbeat()
			debug.profilebegin("Hologram")
			local v1 = tick()
			if v1 - v6 > 1 then
				v6 = v1
				for v2, v3 in next, t2 do
					local v4 = t3[v3]
					if (v3.Position - CurrentCamera.CFrame.p).Magnitude < 500 then
						if not v4 then
							local v62 = MakeSystem()
							v62.Scale = v3.Size.X / 4096
							v62.Center = v3.CFrame * CFrame.new(0, v3.Size.Y * 0.5 + 0.2, 0)
							SimplifyCityParts(v62, CollectionService:GetTagged("BuildingNeon"))
							SimplifyExtra(v62)
							table.insert(t, v62)
							t3[v3] = v62
						end
					elseif v4 then
						t3[v3] = nil
						DestroySystem(v4)
					end
				end
			end
			for v8, v9 in next, t do
				local v10 = 1
				local Magnitude = (v9.Center.p - CurrentCamera.CFrame.p).Magnitude
				if Magnitude < 100 then
					v10 = 0
				elseif Magnitude < 300 then
					v10 = 0.1
				elseif Magnitude < 500 then
					v10 = 0.2
				end
				if v10 < v1 - v9.LastRender then
					v9.LastRender = v1
					RenderSystem(v9)
				end
			end
			debug.profileend()
		end
		RunService.Heartbeat:Connect(Heartbeat)
	end
}