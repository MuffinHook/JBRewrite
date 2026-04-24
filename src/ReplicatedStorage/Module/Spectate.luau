-- Reviewed by Claude
local CurrentCamera = workspace.CurrentCamera
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CinematicCamera = require(ReplicatedStorage.Module.CinematicCamera)
require(ReplicatedStorage.Std.Signal)
local Maid = require(ReplicatedStorage.Std.Maid)
local SpectateGui = ReplicatedStorage.Resource.SpectateGui
local function GetHumanoid(p1)
	assert(p1)
	local Character = p1.Character
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
local function GetRootPart(p1)
	assert(p1)
	assert(p1)
	local Character = p1.Character
	local v1
	if Character then
		local Humanoid = Character:FindFirstChild("Humanoid")
		v1 = Humanoid or nil
	else
		v1 = nil
	end
	if v1 then
		local RootPart = v1.RootPart
		if RootPart then
			return RootPart
		end
	end
end
local function SetCenterText(p1)
	SpectateGui.Spectate.Center.TextLabel.Text = p1
end
local v1 = CinematicCamera.MakeCinematicCamera()
local t = {
	IsOpen = false,
	NameList = nil,
	SpectatingName = nil,
	Viewing = false,
	Maid = nil,
	Signal = {}
}
local function GetIndexFromName()
	if t.SpectatingName == nil then
		return nil
	end
	if t.NameList == nil then
		return nil
	end
	for i = 1, #t.NameList do
		if t.NameList[i] == t.SpectatingName then
			return i
		end
	end
end
local function CycleRight()
	local v1
	if t.SpectatingName ~= nil and t.NameList ~= nil then
		for i = 1, #t.NameList do
			if t.NameList[i] == t.SpectatingName then
				v1 = i
				break
			end
		end
	end
	v1 = nil
	assert(v1)
	if v1 == #t.NameList then
		t.SpectatingName = t.NameList[1]
	else
		t.SpectatingName = t.NameList[v1 + 1]
	end
	SpectateGui.Spectate.Center.TextLabel.Text = t.SpectatingName
end
local function CycleLeft()
	local v1
	if t.SpectatingName ~= nil and t.NameList ~= nil then
		for i = 1, #t.NameList do
			if t.NameList[i] == t.SpectatingName then
				v1 = i
				break
			end
		end
	end
	v1 = nil
	assert(v1)
	if v1 == 1 then
		t.SpectatingName = t.NameList[#t.NameList]
	else
		t.SpectatingName = t.NameList[v1 - 1]
	end
	SpectateGui.Spectate.Center.TextLabel.Text = t.SpectatingName
end
local function ToggleView()
	if t.Viewing then
		t.Viewing = false
	elseif t.NameList and #t.NameList > 0 then
		print("Cannot spectate, no NameList")
		t.Viewing = true
	end
	if t.Viewing then
		SpectateGui.Spectate.ButtonRight.Visible = true
		SpectateGui.Spectate.ButtonLeft.Visible = true
	else
		SpectateGui.Spectate.ButtonRight.Visible = false
		SpectateGui.Spectate.ButtonLeft.Visible = false
		SpectateGui.Spectate.Center.TextLabel.Text = "Spectate"
	end
	local v1
	if t.Viewing then
		if t.SpectatingName ~= nil and t.NameList ~= nil then
			for i = 1, #t.NameList do
				if t.NameList[i] == t.SpectatingName then
					v1 = i
					break
				end
			end
		end
		v1 = nil
	else
		return
	end
	if v1 == nil then
		t.SpectatingName = t.NameList[1]
	end
	SpectateGui.Spectate.Center.TextLabel.Text = t.SpectatingName
end
local function Heartbeat(p1)
	if t.Viewing then
		if CurrentCamera.CameraType ~= Enum.CameraType.Scriptable then
			CurrentCamera.CameraType = Enum.CameraType.Scriptable
		end
		local var12 = false
		if t.SpectatingName then
			local localPlayer = Players:FindFirstChild(t.SpectatingName)
			if localPlayer then
				assert(localPlayer)
				assert(localPlayer)
				local Character = localPlayer.Character
				local v3
				if Character then
					local Humanoid = Character:FindFirstChild("Humanoid")
					v3 = Humanoid or nil
				else
					v3 = nil
				end
				local var4 = v3 and v3.RootPart or nil
				if var4 then
					v1.TargetFocus = var4.Position
					v1.TargetPosition = var4.Position + var4.CFrame.LookVector * -10 + Vector3.new(0, 5, 0)
					CinematicCamera.StepCinematicCamera(p1, v1, 3, 2)
					var12 = true
				end
			end
		end
		if var12 == false then
			if t.NameList and #t.NameList > 0 then
				print("Choosing new player")
				t.SpectatingName = t.NameList[math.random(1, #t.NameList)]
				SpectateGui.Spectate.Center.TextLabel.Text = t.SpectatingName
			else
				print("Could not find new player")
				t.SpectatingName = nil
				ToggleView()
			end
		end
	elseif CurrentCamera.CameraType ~= Enum.CameraType.Custom then
		CurrentCamera.CameraType = Enum.CameraType.Custom
		local localPlayer = LocalPlayer
		assert(localPlayer)
		local Character = localPlayer.Character
		local v7
		if Character then
			local Humanoid = Character:FindFirstChild("Humanoid")
			v7 = Humanoid or nil
		else
			v7 = nil
		end
		CurrentCamera.CameraSubject = v7
	end
end
function t.Start()
	assert(t.IsOpen == false)
	t.IsOpen = true
	t.Maid = Maid.new()
	SpectateGui.Parent = LocalPlayer.PlayerGui
	SpectateGui.Spectate.Center.TextLabel.Text = "Spectate"
	t.SpectatingName = nil
	t.Viewing = false
	t.Maid:GiveTask(SpectateGui.Spectate.Center.MouseButton1Down:Connect(ToggleView))
	t.Maid:GiveTask(SpectateGui.Spectate.ButtonRight.MouseButton1Down:Connect(CycleRight))
	t.Maid:GiveTask(SpectateGui.Spectate.ButtonLeft.MouseButton1Down:Connect(CycleLeft))
	t.Maid:GiveTask(RunService.Heartbeat:Connect(Heartbeat))
end
function t.Stop()
	assert(t.IsOpen == true)
	SpectateGui.Parent = script
	t.Maid:Destroy()
	t.Maid = nil
	CurrentCamera.CameraType = Enum.CameraType.Custom
	local localPlayer = LocalPlayer
	assert(localPlayer)
	local Character = localPlayer.Character
	local v3
	if Character then
		local Humanoid = Character:FindFirstChild("Humanoid")
		v3 = Humanoid or nil
	else
		v3 = nil
	end
	CurrentCamera.CameraSubject = v3
	t.IsOpen = false
end
function t.Update(p1)
	t.NameList = p1
	local v1
	if t.Viewing and t.SpectatingName then
		if t.SpectatingName ~= nil and t.NameList ~= nil then
			for i = 1, #t.NameList do
				if t.NameList[i] == t.SpectatingName then
					v1 = i
					break
				end
			end
		end
		v1 = nil
	else
		return
	end
	if v1 == nil then
		print("Player no longer exists, will look for new one")
		t.SpectatingName = nil
	end
end
return t
