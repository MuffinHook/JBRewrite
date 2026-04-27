local CurrentCamera = workspace.CurrentCamera
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CinematicCamera = require(ReplicatedStorage.Module.CinematicCamera)
require(ReplicatedStorage.Std.Signal)
local Maid = require(ReplicatedStorage.Std.Maid)
local SpectateGui = ReplicatedStorage.Resource.SpectateGui
local function GetHumanoid(player)
	assert(player)
	local Character = player.Character
	if Character then
		local Humanoid = Character:FindFirstChild("Humanoid")
		if Humanoid then
			return Humanoid
		else
			return nil
		end
	else
		return nil
	end
end
local function GetRootPart(player)
	assert(player)
	assert(player)
	local Character = player.Character
	local humanoid
	if Character then
		local Humanoid = Character:FindFirstChild("Humanoid")
		humanoid = Humanoid or nil
	else
		humanoid = nil
	end
	if humanoid then
		local RootPart = humanoid.RootPart
		if RootPart then
			return RootPart
		end
	end
end
local function SetCenterText(text)
	SpectateGui.Spectate.Center.TextLabel.Text = text
end
local cinematicCamera = CinematicCamera.MakeCinematicCamera()
local SpectateModule = {
	IsOpen = false,
	NameList = nil,
	SpectatingName = nil,
	Viewing = false,
	Maid = nil,
	Signal = {}
}
local function GetIndexFromName()
	if SpectateModule.SpectatingName == nil then
		return nil
	end
	if SpectateModule.NameList == nil then
		return nil
	end
	for i = 1, #SpectateModule.NameList do
		if SpectateModule.NameList[i] == SpectateModule.SpectatingName then
			return i
		end
	end
end
local function CycleRight()
	local currentIndex
	if SpectateModule.SpectatingName ~= nil and SpectateModule.NameList ~= nil then
		for i = 1, #SpectateModule.NameList do
			if SpectateModule.NameList[i] == SpectateModule.SpectatingName then
				currentIndex = i
				break
			end
		end
	end
	currentIndex = nil
	assert(currentIndex)
	if currentIndex == #SpectateModule.NameList then
		SpectateModule.SpectatingName = SpectateModule.NameList[1]
	else
		SpectateModule.SpectatingName = SpectateModule.NameList[currentIndex + 1]
	end
	SpectateGui.Spectate.Center.TextLabel.Text = SpectateModule.SpectatingName
end
local function CycleLeft()
	local currentIndex
	if SpectateModule.SpectatingName ~= nil and SpectateModule.NameList ~= nil then
		for i = 1, #SpectateModule.NameList do
			if SpectateModule.NameList[i] == SpectateModule.SpectatingName then
				currentIndex = i
				break
			end
		end
	end
	currentIndex = nil
	assert(currentIndex)
	if currentIndex == 1 then
		SpectateModule.SpectatingName = SpectateModule.NameList[#SpectateModule.NameList]
	else
		SpectateModule.SpectatingName = SpectateModule.NameList[currentIndex - 1]
	end
	SpectateGui.Spectate.Center.TextLabel.Text = SpectateModule.SpectatingName
end
local function ToggleView()
	if SpectateModule.Viewing then
		SpectateModule.Viewing = false
	elseif SpectateModule.NameList and #SpectateModule.NameList > 0 then
		print("Cannot spectate, no NameList")
		SpectateModule.Viewing = true
	end
	if SpectateModule.Viewing then
		SpectateGui.Spectate.ButtonRight.Visible = true
		SpectateGui.Spectate.ButtonLeft.Visible = true
	else
		SpectateGui.Spectate.ButtonRight.Visible = false
		SpectateGui.Spectate.ButtonLeft.Visible = false
		SpectateGui.Spectate.Center.TextLabel.Text = "Spectate"
	end
	local currentIndex
	if SpectateModule.Viewing then
		if SpectateModule.SpectatingName ~= nil and SpectateModule.NameList ~= nil then
			for i = 1, #SpectateModule.NameList do
				if SpectateModule.NameList[i] == SpectateModule.SpectatingName then
					currentIndex = i
					break
				end
			end
		end
		currentIndex = nil
	else
		return
	end
	if currentIndex == nil then
		SpectateModule.SpectatingName = SpectateModule.NameList[1]
	end
	SpectateGui.Spectate.Center.TextLabel.Text = SpectateModule.SpectatingName
end
local function Heartbeat(deltaTime)
	if SpectateModule.Viewing then
		if CurrentCamera.CameraType ~= Enum.CameraType.Scriptable then
			CurrentCamera.CameraType = Enum.CameraType.Scriptable
		end
		local foundTarget = false
		if SpectateModule.SpectatingName then
			local localPlayer = Players:FindFirstChild(SpectateModule.SpectatingName)
			if localPlayer then
				assert(localPlayer)
				assert(localPlayer)
				local Character = localPlayer.Character
				local humanoid
				if Character then
					local Humanoid = Character:FindFirstChild("Humanoid")
					humanoid = Humanoid or nil
				else
					humanoid = nil
				end
				local targetRootPart = humanoid and humanoid.RootPart or nil
				if targetRootPart then
					cinematicCamera.TargetFocus = targetRootPart.Position
					cinematicCamera.TargetPosition = targetRootPart.Position + targetRootPart.CFrame.LookVector * -10 + Vector3.new(0, 5, 0)
					CinematicCamera.StepCinematicCamera(deltaTime, cinematicCamera, 3, 2)
					foundTarget = true
				end
			end
		end
		if foundTarget == false then
			if SpectateModule.NameList and #SpectateModule.NameList > 0 then
				print("Choosing new player")
				SpectateModule.SpectatingName = SpectateModule.NameList[math.random(1, #SpectateModule.NameList)]
				SpectateGui.Spectate.Center.TextLabel.Text = SpectateModule.SpectatingName
			else
				print("Could not find new player")
				SpectateModule.SpectatingName = nil
				ToggleView()
			end
		end
	elseif CurrentCamera.CameraType ~= Enum.CameraType.Custom then
		CurrentCamera.CameraType = Enum.CameraType.Custom
		local localPlayer = LocalPlayer
		assert(localPlayer)
		local Character = localPlayer.Character
		local humanoid
		if Character then
			local Humanoid = Character:FindFirstChild("Humanoid")
			humanoid = Humanoid or nil
		else
			humanoid = nil
		end
		CurrentCamera.CameraSubject = humanoid
	end
end
function SpectateModule.Start()
	assert(SpectateModule.IsOpen == false)
	SpectateModule.IsOpen = true
	SpectateModule.Maid = Maid.new()
	SpectateGui.Parent = LocalPlayer.PlayerGui
	SpectateGui.Spectate.Center.TextLabel.Text = "Spectate"
	SpectateModule.SpectatingName = nil
	SpectateModule.Viewing = false
	SpectateModule.Maid:GiveTask(SpectateGui.Spectate.Center.MouseButton1Down:Connect(ToggleView))
	SpectateModule.Maid:GiveTask(SpectateGui.Spectate.ButtonRight.MouseButton1Down:Connect(CycleRight))
	SpectateModule.Maid:GiveTask(SpectateGui.Spectate.ButtonLeft.MouseButton1Down:Connect(CycleLeft))
	SpectateModule.Maid:GiveTask(RunService.Heartbeat:Connect(Heartbeat))
end
function SpectateModule.Stop()
	assert(SpectateModule.IsOpen == true)
	SpectateGui.Parent = script
	SpectateModule.Maid:Destroy()
	SpectateModule.Maid = nil
	CurrentCamera.CameraType = Enum.CameraType.Custom
	local localPlayer = LocalPlayer
	assert(localPlayer)
	local Character = localPlayer.Character
	local humanoid
	if Character then
		local Humanoid = Character:FindFirstChild("Humanoid")
		humanoid = Humanoid or nil
	else
		humanoid = nil
	end
	CurrentCamera.CameraSubject = humanoid
	SpectateModule.IsOpen = false
end
function SpectateModule.Update(playerNameList)
	SpectateModule.NameList = playerNameList
	local currentIndex
	if SpectateModule.Viewing and SpectateModule.SpectatingName then
		if SpectateModule.SpectatingName ~= nil and SpectateModule.NameList ~= nil then
			for i = 1, #SpectateModule.NameList do
				if SpectateModule.NameList[i] == SpectateModule.SpectatingName then
					currentIndex = i
					break
				end
			end
		end
		currentIndex = nil
	else
		return
	end
	if currentIndex == nil then
		print("Player no longer exists, will look for new one")
		SpectateModule.SpectatingName = nil
	end
end
return SpectateModule
