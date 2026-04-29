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
local function comma(numberString)
	local leadingDigits, middleDigits, suffixPart = string.match(numberString, "^([^%d]*%d)(%d*)(.-)$")
	return leadingDigits .. middleDigits:reverse():gsub("(%d%d%d)", "%1,"):reverse() .. suffixPart
end
local function FormatMoney(amount)
	local formatTable = {}
	local leadingDigits, middleDigits, suffixPart = string.match(abs(amount), "^([^%d]*%d)(%d*)(.-)$")
	formatTable[1] = leadingDigits .. middleDigits:reverse():gsub("(%d%d%d)", "%1,"):reverse() .. suffixPart
	return if amount >= 0 then "" else "-" .. Localization:FormatByKey("General.Cash", formatTable)
end
local function MakeSystem()
	local hologramSystem = {
		Scale = 0.015625,
		Nodes = {},
		Center = CFrame.new(),
		Model = Instance.new("Model"),
		LastRender = 0,
		PlayerNodes = {}
	}
	hologramSystem.Model.Name = "Hologram"
	hologramSystem.Model.Parent = workspace
	return hologramSystem
end
local holoSystems = {}
local function DestroySystem(system)
	for i = #holoSystems, 1, -1 do
		if holoSystems[i] == system then
			table.remove(holoSystems, i)
			break
		end
	end
	system.Model:Destroy()
end
local function SetNodeColor(node, colorData)
	local Part = node.Part
	local r = colorData.r
	local g = colorData.g
	local b = colorData.b
	Part.Color = Color3.new(r, g, b)
	Part.SelectionBox.Color3 = Color3.new(r + 0.2, g + 0.2, b + 0.2)
end
local function ConstructNode(node, colorData)
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
	node.Part = Part
	local Part_2 = node.Part
	local r = colorData.r
	local g = colorData.g
	local b = colorData.b
	Part_2.Color = Color3.new(r, g, b)
	Part_2.SelectionBox.Color3 = Color3.new(r + 0.2, g + 0.2, b + 0.2)
end
local function MakeNode(centerCFrame, size)
	return {
		c = centerCFrame,
		s = size
	}
end
local function HorizontalDistance(pos1, pos2)
	return ((pos1 - pos2) * Vector3.new(1, 0, 1)).Magnitude
end
local function CloseToAny(position, positionsList)
	for index, otherPos in next, positionsList do
		if ((otherPos.Position - position.Position) * Vector3.new(1, 0, 1)).Magnitude < 100 then
			return true
		end
	end
	return false
end
local function SimplifyCityParts(system, cityParts)
	while #cityParts > 0 do
		local currentPart = table.remove(cityParts, 1)
		local groupedParts = { currentPart }
		for i = #cityParts, 1, -1 do
			local checkPart = cityParts[i]
			if checkPart.Name ~= "Bank" and currentPart.Color == checkPart.Color then
				local isClose = false
				for groupIndex, groupPart in next, groupedParts do
					if ((groupPart.Position - checkPart.Position) * Vector3.new(1, 0, 1)).Magnitude < 100 then
						isClose = true
						break
					end
				end
				if isClose then
					table.insert(groupedParts, table.remove(cityParts, i))
				end
			end
		end
		local boundingCFrame, boundingSize = Logic.MultiAABB(groupedParts)
		local nodeData = {
			c = boundingCFrame,
			s = boundingSize
		}
		local randomColorComponent = math.floor(math.random() * 30)
		ConstructNode(nodeData, Color3.fromRGB(randomColorComponent + 33, randomColorComponent + 84, randomColorComponent + 185))
		nodeData.Part.Parent = system.Model
		table.insert(system.Nodes, nodeData)
	end
end
local function SimplifyTrees(system, treesParent)
	local iteratorFunc = next
	local treeChildren = treesParent:GetChildren()
	for treeIndex, treeNode in iteratorFunc, treeChildren, nil do
		local boundingCFrame, boundingSize = Logic.MultiAABB(treeNode:GetChildren())
		local nodeData = {
			c = boundingCFrame,
			s = boundingSize
		}
		local randomColorComponent = math.floor(math.random() * 30)
		ConstructNode(nodeData, Color3.fromRGB(randomColorComponent + 30, randomColorComponent + 30, randomColorComponent + 30))
		nodeData.Part.Parent = system.Model
		table.insert(system.Nodes, nodeData)
	end
end
local predefinedLocations = {
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
local function SimplifyExtra(system)
	for colorIndex, colorEntry in next, predefinedLocations do
		for locIndex, locationData in next, colorEntry.Loc do
			local colorComponentOffset = math.floor(math.random() * 30 / 255)
			local nodeData = {
				c = locationData.c,
				s = locationData.s
			}
			local Color = colorEntry.Color
			ConstructNode(nodeData, Color3.new(Color.r + colorComponentOffset, Color.g + colorComponentOffset, Color.b + colorComponentOffset))
			nodeData.Part.Parent = system.Model
			table.insert(system.Nodes, nodeData)
		end
	end
end
local function RenderSystem(system)
	local Scale = system.Scale
	local currentTime = tick()
	for nodeIndex, node in next, system.Nodes do
		local centerCFrame = node.c
		local Part = node.Part
		local offsetCFrame = centerCFrame + centerCFrame.p * (Scale - 1)
		local _lastSize = node._lastSize
		local scaledSize = node.s * Scale
		if not _lastSize or (_lastSize - scaledSize).Magnitude > 0.001 then
			Part.Size = scaledSize
			node._lastSize = scaledSize
		end
		Part.CFrame = system.Center * offsetCFrame * CFrame.new(0, math.cos(0.1 * (offsetCFrame.p.Magnitude / (64 * Scale)) + 2 * currentTime) * 0.2, 0)
	end
	local PlayerNodes = system.PlayerNodes
	local iteratorFunc = next
	local playersList = Players:GetPlayers()
	local activePlayerNames = {}
	for playerIndex, player in iteratorFunc, playersList, nil do
		local signalColor
		local playerName = player.Name
		local Character = player.Character
		if Character then
			local PrimaryPart = Character.PrimaryPart
			if PrimaryPart then
				activePlayerNames[playerName] = true
				local primaryPartCFrame = PrimaryPart.CFrame
				local existingPlayerNode = PlayerNodes[playerName]
				if existingPlayerNode then
					PlayerNodes[playerName].c = primaryPartCFrame
				else
					local playerNodeData = {
						c = primaryPartCFrame,
						s = PrimaryPart.Size,
						IsPolice = false
					}
					PlayerNodes[playerName] = playerNodeData
					ConstructNode(playerNodeData, Color3.fromRGB(240, 20, 20))
					playerNodeData.Part.Parent = system.Model
					existingPlayerNode = playerNodeData
				end
				local phaseValue = currentTime % math.tau
				local Part = existingPlayerNode.Part
				local centerCFrame = existingPlayerNode.c
				Part.Size = Vector3.new(1, 1, 1) * ((math.cos(8 * phaseValue) * 0.5 + 0.5) * 0.5 + 0.3) * 64 * Scale
				Part.CFrame = system.Center * (centerCFrame + centerCFrame.p * (Scale - 1)) * CFrame.Angles(0, 4 * phaseValue, 0) * CFrame.Angles(math.pi / 4, 0, math.pi / 4)
				local TeamValue = player:FindFirstChild("TeamValue")
				if TeamValue then
					local isPoliceTeam = TeamValue.Value == "Police"
					if not existingPlayerNode.BountyGui then
						local bountyGuiClone = ReplicatedStorage.Resource.HologramBounty:Clone()
						bountyGuiClone.Parent = Part
						bountyGuiClone.Frame.Player.Text = player.DisplayName
						existingPlayerNode.BountyGui = bountyGuiClone
					end
					if existingPlayerNode.Bounty and not isPoliceTeam then
						existingPlayerNode.BountyGui.Frame.Bounty.Visible = true
						local BountyValue = existingPlayerNode.Bounty
						signalColor = if BountyValue >= 0 then "" else "-"
						local bountyFormatTable = {}
						local bountyLeadingDigits, bountyMiddleDigits, bountySuffixPart = string.match(abs(BountyValue), "^([^%d]*%d)(%d*)(.-)$")
						bountyFormatTable[1] = bountyLeadingDigits .. bountyMiddleDigits:reverse():gsub("(%d%d%d)", "%1,"):reverse() .. bountySuffixPart
						existingPlayerNode.BountyGui.Frame.Bounty.Text = signalColor .. Localization:FormatByKey("General.Cash", bountyFormatTable)
					else
						existingPlayerNode.BountyGui.Frame.Bounty.Visible = false
					end
					if existingPlayerNode.IsPolice ~= isPoliceTeam then
						existingPlayerNode.IsPolice = isPoliceTeam
						local teamColor = isPoliceTeam and Color3.new(255/255, 255/255, 255/255) or Color3.fromRGB(240, 20, 20)
						local Part_2 = existingPlayerNode.Part
						local r = teamColor.r
						local g = teamColor.g
						local b = teamColor.b
						Part_2.Color = Color3.new(r, g, b)
						Part_2.SelectionBox.Color3 = Color3.new(r + 0.2, g + 0.2, b + 0.2)
						existingPlayerNode.BountyGui.Frame.Player.TextColor3 = teamColor
					end
				end
			end
		end
	end
	for playerName, playerNode in next, PlayerNodes do
		if not activePlayerNames[playerName] then
			local nodeToRemove = PlayerNodes[playerName]
			if nodeToRemove.BountyGui then
				nodeToRemove.BountyGui:Destroy()
			end
			nodeToRemove.Part:Destroy()
			PlayerNodes[playerName] = nil
		end
	end
end
return {
	Init = function()
		BountyBoardService.onBountiesUpdated:Connect(function(bountyUpdates)
			for systemIndex, system in next, holoSystems do
				for bountyIndex, bountyData in bountyUpdates do
					local playerNode = system.PlayerNodes[bountyData.Name]
					if playerNode then
						playerNode.Bounty = bountyData.Bounty
					end
				end
			end
		end)
		local taggedHolograms = {}
		local systemMap = {}
		local function AddedFun(hologramInstance)
			table.insert(taggedHolograms, hologramInstance)
		end
		local function RemovedFun(hologramInstance)
			for i = #taggedHolograms, 1, -1 do
				if taggedHolograms[i] == hologramInstance then
					table.remove(taggedHolograms, i)
					local system = systemMap[hologramInstance]
					if system then
						DestroySystem(system)
					end
					break
				end
			end
		end
		local iteratorFunc = next
		local initialHolograms = CollectionService:GetTagged("MapHologram")
		for hologramIndex, hologramInstance in iteratorFunc, initialHolograms, nil do
			table.insert(taggedHolograms, hologramInstance)
		end
		CollectionService:GetInstanceAddedSignal("MapHologram"):Connect(AddedFun)
		CollectionService:GetInstanceRemovedSignal("MapHologram"):Connect(RemovedFun)
		local lastUpdateTime = tick()
		local function Heartbeat()
			debug.profilebegin("Hologram")
			local currentTime = tick()
			if currentTime - lastUpdateTime > 1 then
				lastUpdateTime = currentTime
				for hologramIndex, hologramInstance in next, taggedHolograms do
					local system = systemMap[hologramInstance]
					if (hologramInstance.Position - CurrentCamera.CFrame.p).Magnitude < 500 then
						if not system then
							local newSystem = MakeSystem()
							newSystem.Scale = hologramInstance.Size.X / 4096
							newSystem.Center = hologramInstance.CFrame * CFrame.new(0, hologramInstance.Size.Y * 0.5 + 0.2, 0)
							SimplifyCityParts(newSystem, CollectionService:GetTagged("BuildingNeon"))
							SimplifyExtra(newSystem)
							table.insert(holoSystems, newSystem)
							systemMap[hologramInstance] = newSystem
						end
					elseif system then
						systemMap[hologramInstance] = nil
						DestroySystem(system)
					end
				end
			end
			for systemIndex, system in next, holoSystems do
				local renderAlpha = 1
				local cameraDistance = (system.Center.p - CurrentCamera.CFrame.p).Magnitude
				if cameraDistance < 100 then
					renderAlpha = 0
				elseif cameraDistance < 300 then
					renderAlpha = 0.1
				elseif cameraDistance < 500 then
					renderAlpha = 0.2
				end
				if renderAlpha < currentTime - system.LastRender then
					system.LastRender = currentTime
					RenderSystem(system)
				end
			end
			debug.profileend()
		end
		RunService.Heartbeat:Connect(Heartbeat)
	end
}
