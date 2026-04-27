local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UI = require(ReplicatedStorage.Module.UI)
local Maid = require(ReplicatedStorage.Std.Maid)
local GeomUtils = require(ReplicatedStorage.Std.GeomUtils)
local CollectionService = game:GetService("CollectionService")
local RunService = game:GetService("RunService")
local LocalPlayer = game:GetService("Players").LocalPlayer
local function PlaySound(soundParent, soundId)
	local Sound = Instance.new("Sound")
	Sound.SoundId = ("rbxassetid://%d"):format(soundId)
	Sound.Volume = 0.75
	Sound.Parent = soundParent
	Sound:Play()
	delay(1, function()
		game.Debris:AddItem(Sound, Sound.TimeLength)
	end)
end
return function(museumEventConfig)
	local event = museumEventConfig.Event
	local em = museumEventConfig.em
	local ScreenGui = museumEventConfig.ScreenGui
	local Sound = Instance.new("Sound")
	Sound.SoundId = "rbxassetid://1841825097"
	Sound.Looped = true
	Sound.SoundGroup = game:GetService("SoundService").RobberyMusic
	Sound.Parent = LocalPlayer.PlayerGui
	local fadeCounter = 0
	local function FadeInSound()
		local fadeId = fadeCounter + 1
		fadeCounter = fadeId
		Sound:Play()
		for i = 0, 1, 0.015 do
			if fadeId ~= fadeCounter then
				break
			end
			Sound.Volume = i
			wait()
		end
	end
	local function FadeOutSound()
		local fadeId = fadeCounter + 1
		fadeCounter = fadeId
		for i = 1, 0, -0.015 do
			if fadeId ~= fadeCounter then
				return
			end
			Sound.Volume = i
			wait()
		end
		Sound:Stop()
	end
	local isPlayerInRobbery = false
	local function EnterRobbery()
		if isPlayerInRobbery then
			return error("Already in robbery")
		end
		isPlayerInRobbery = true
		PlaySound(LocalPlayer, 1837831244)
		delay(1, function()
			PlaySound(LocalPlayer, 1843025542)
		end)
		spawn(FadeInSound)
	end
	local function ExitRobbery()
		if not isPlayerInRobbery then
			return error("Player not in robbery")
		end
		isPlayerInRobbery = false
		spawn(FadeOutSound)
	end
	function em.dhqg05sg()
		EnterRobbery()
	end
	function em.exsgze3l()
		if isPlayerInRobbery then
			isPlayerInRobbery = false
			spawn(FadeOutSound)
		else
			error("Player not in robbery")
		end
	end
	local function Ease_InOutQuad(progress)
		return progress < 0.5 and 2 * progress * progress or -1 - 2 * (progress - 2) * progress
	end
	local securityState = {}
	local maidCleaner = Maid.new()
	local heartbeatConnection = nil
	function em.aad1ukee(securityNodes)
		if not heartbeatConnection then
			return false
		end
		heartbeatConnection:Disconnect()
		heartbeatConnection = nil
		maidCleaner:DoCleaning()
		for nodeIndex, node in next, securityNodes do
			node.Part.Transparency = 1
			node.Part.Color = Color3.fromRGB(153, 153, 153)
		end
	end
	function em.impi1r3j(securityNodes)
		if heartbeatConnection then
			em.aad1ukee()
		end
		for nodeIndex, node in next, securityNodes do
			node.Part.Transparency = 0
		end
		local initialTime = tick()
		for i, node in ipairs(securityNodes) do
			maidCleaner:GiveTask(node.Part.Touched:Connect(function(touchedPart)
				if touchedPart:IsDescendantOf(LocalPlayer.Character) then
					local currentTime = tick()
					if not (currentTime - initialTime < 0.2) and currentTime - node.LastDamage >= 0.5 then
						initialTime = currentTime
						node.LastDamage = currentTime
						event:FireServer("ypu5apwp")
					end
				end
			end))
		end
		local function getPeriod(node)
			return 0.5 * node.Duration * node._speed
		end
		heartbeatConnection = RunService.Heartbeat:Connect(function()
			for nodeIndex, node in next, securityNodes do
				local colorValue, speedMultiplier
				if not node._speed then
					node._speed = 0
					node._offset = 0
				end
				local Part = node.Part
				colorValue = if securityState.SecurityTripped then Color3.fromRGB(253, 106, 97) else Color3.fromRGB(153, 153, 153)
				Part.Color = colorValue
				speedMultiplier = if securityState.SecurityTripped then 2 else 1
				local serverTime = workspace:GetServerTimeNow()
				local period = 0.5 * node.Duration * node._speed
				if speedMultiplier ~= node._speed then
					node._speed = speedMultiplier
					local newPeriod = 0.5 * node.Duration * node._speed
					node._offset = node._offset + (newPeriod - period) * serverTime
					period = newPeriod
				end
				local waveProgress = GeomUtils.waveTriangle(period * serverTime - node._offset) / 2 + 0.5
				Part.CFrame = node.StartCF:lerp(node.EndCF, waveProgress < 0.5 and 2 * waveProgress * waveProgress or -1 - 2 * (waveProgress - 2) * waveProgress)
			end
		end)
	end
	function em.ckvvbfd2(state)
		securityState = state
	end
	local CircleAction = UI.CircleAction
	local function Action(instance, isCompleted)
		if isCompleted then
			PlaySound(LocalPlayer, 1843025542)
			event:FireServer("r20fuycw", instance.Part)
			return true
		end
	end
	local function PreUpdateFun(instance)
		instance.Enabled = instance.Part.Parent.Arm.Transparency < 0.5
	end
	local function AddedFun(instance)
		CircleAction.Add({
			Part = instance,
			ValidRoot = instance.Parent,
			Name = "Place Dynamite",
			Timed = true,
			Duration = 1,
			Dist = 10,
			Callback = Action,
			PreUpdateFun = PreUpdateFun,
			PreUpdatePeriod = 0.1
		}, instance)
	end
	local function RemovedFun(instance)
		CircleAction.Remove(instance)
	end
	local nextFunc = next
	local initialDynamiteNodes, nodeIndex = CollectionService:GetTagged("Museum_DynamiteNode")
	for dynamiteNodeKey, dynamiteNode in nextFunc, initialDynamiteNodes, nodeIndex do
		CircleAction.Add({
			Part = dynamiteNode,
			ValidRoot = dynamiteNode.Parent,
			Name = "Place Dynamite",
			Timed = true,
			Duration = 1,
			Dist = 10,
			Callback = Action,
			PreUpdateFun = PreUpdateFun,
			PreUpdatePeriod = 0.1
		}, dynamiteNode)
	end
	CollectionService:GetInstanceAddedSignal("Museum_DynamiteNode"):Connect(AddedFun)
	CollectionService:GetInstanceRemovedSignal("Museum_DynamiteNode"):Connect(RemovedFun)
	local function Action_2(instance, isCompleted)
		if isCompleted then
			PlaySound(LocalPlayer, 1988477690)
			PlaySound(LocalPlayer, 8473658289)
			event:FireServer("rwm1ahpj", instance.Part)
			return true
		end
	end
	local function PreUpdateFun_2(instance)
		instance.Enabled = (instance.HidePart or instance.Part).Transparency < 0.999
	end
	local function AddedFun_2(instance)
		local hidePart = nil
		local validRoot = nil
		local duration = 2
		local nodeName = instance.Name
		if nodeName == "DonutNode" then
			hidePart = instance.Parent.Model.Bread
			nodeName = "Giant Donut"
		elseif nodeName == "SpinnerRim" then
			nodeName = "Spinner Rim"
		elseif nodeName == "DinoBone" then
			nodeName = "Bone"
			duration = 1
		elseif nodeName == "MummyNode" then
			hidePart = instance.Parent.Glass
			validRoot = instance.Parent
			nodeName = "Mummy"
			duration = 3
		elseif nodeName == "Picture" then
			validRoot = instance.Parent
		end
		CircleAction.Add({
			Part = instance,
			Name = "Grab " .. nodeName,
			Timed = true,
			Duration = duration,
			Dist = 10,
			Callback = Action_2,
			PreUpdateFun = PreUpdateFun_2,
			PreUpdatePeriod = 0.5,
			HidePart = hidePart,
			ValidRoot = validRoot
		}, instance)
	end
	local function RemovedFun_2(instance)
		local _ = instance.Name
		CircleAction.Remove(instance)
	end
	local nextFunc = next
	local initialMuseumItems, itemIndex = CollectionService:GetTagged("Museum_Item")
	for museumItemKey, museumItem in nextFunc, initialMuseumItems, itemIndex do
		AddedFun_2(museumItem)
	end
	CollectionService:GetInstanceAddedSignal("Museum_Item"):Connect(AddedFun_2)
	CollectionService:GetInstanceRemovedSignal("Museum_Item"):Connect(RemovedFun_2)
	local function Action_3(instance, isCompleted)
		if isCompleted then
			PlaySound(LocalPlayer, 1837831244)
			event:FireServer("zibamr1v", instance.Part)
			return true
		end
	end
	local function PreUpdateFun_3(instance)
		instance.Enabled = instance.Part.Reflectance < 0.15
	end
	local function AddedFun_3(instance)
		CircleAction.Add({
			Part = instance,
			Name = "Pull Lever",
			Timed = true,
			Duration = 1,
			Dist = 10,
			Callback = Action_3,
			PreUpdateFun = PreUpdateFun_3,
			PreUpdatePeriod = 0.5
		}, instance)
	end
	local function RemovedFun_3(instance)
		CircleAction.Remove(instance)
	end
	local nextFunc = next
	local initialLeverNodes, leverIndex = CollectionService:GetTagged("Museum_Lever")
	for leverNodeKey, leverNode in nextFunc, initialLeverNodes, leverIndex do
		CircleAction.Add({
			Part = leverNode,
			Name = "Pull Lever",
			Timed = true,
			Duration = 1,
			Dist = 10,
			Callback = Action_3,
			PreUpdateFun = PreUpdateFun_3,
			PreUpdatePeriod = 0.5
		}, leverNode)
	end
	CollectionService:GetInstanceAddedSignal("Museum_Lever"):Connect(AddedFun_3)
	CollectionService:GetInstanceRemovedSignal("Museum_Lever"):Connect(RemovedFun_3)
end
