-- Reviewed by Claude
local CollectionService = game:GetService("CollectionService")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Roact = require(ReplicatedStorage.Roact)
local SpectateSelector = require(ReplicatedStorage.Spectate.UI.SpectateSelector)
local SpectateConsts = require(script.Parent.SpectateConsts)
local Maid = require(ReplicatedStorage.Std.Maid)
local Interval = require(ReplicatedStorage.Std.Interval)
local Signal = require(ReplicatedStorage.Std.Signal)
local CurrentCamera = workspace.CurrentCamera
local createElement = Roact.createElement
local v1 = ReplicatedStorage:WaitForChild(SpectateConsts.SPECTATE_OTHER_REMOTE_NAME)
local t = {
	_tree = nil,
	guiMaid = Maid.new(),
	active = false,
	spectateMaid = nil,
	onCharacterSpectated = Signal.new()
}
function t.trackCharacter(p1)
	if p1 then
		CurrentCamera.CameraSubject = p1:FindFirstChild("Humanoid")
	else
		CurrentCamera.CameraSubject = nil
	end
	t.onCharacterSpectated:Fire(p1)
	v1:FireServer(Players:GetPlayerFromCharacter(p1))
end
local function getAllCharacters()
	local t = {}
	for v1, v2 in CollectionService:GetTagged(SpectateConsts.SPECTATE_TAG_NAME) do
		table.insert(t, v2)
	end
	local Character = Players.LocalPlayer.Character
	if table.find(t, Character) == nil then
		table.insert(t, Character)
	end
	table.sort(t, function(p1, p2)
		return p1.Name < p2.Name
	end)
	return t
end
function t.findNewTarget()
	local v1 = getAllCharacters()
	assert(#v1 > 0, "No characters to spectate")
	t.trackCharacter(v1[math.random(1, #v1)])
end
function t.spectate(p1)
	t.active = true
	local spectateMaid = t.spectateMaid
	if spectateMaid then
		spectateMaid:DoCleaning()
	else
		spectateMaid = Maid.new()
		t.spectateMaid = spectateMaid
	end
	if p1 then
		t.trackCharacter(p1)
	else
		t.findNewTarget()
	end
	local function checkIfNeedNewTarget()
		if not (CurrentCamera.CameraSubject and CurrentCamera.CameraSubject:IsDescendantOf(workspace)) then
			t.findNewTarget()
		end
	end
	local function handleHumanoid()
		local CameraSubject = CurrentCamera.CameraSubject
		if CameraSubject ~= nil and CameraSubject:IsA("Humanoid") then
			spectateMaid.humanoidDied = CameraSubject.Died:Connect(function()
				t.findNewTarget()
			end)
		end
	end
	local CameraSubject = CurrentCamera.CameraSubject
	if CameraSubject ~= nil and CameraSubject:IsA("Humanoid") then
		spectateMaid.humanoidDied = CameraSubject.Died:Connect(function()
			t.findNewTarget()
		end)
	end
	spectateMaid:GiveTask(CurrentCamera:GetAttributeChangedSignal("CameraSubject"):Connect(handleHumanoid))
	spectateMaid:GiveTask(Interval.every(1):Connect(checkIfNeedNewTarget))
	spectateMaid:GiveTask(function()
		t.active = false
	end)
end
function t.unspectate()
	if t.spectateMaid then
		t.spectateMaid:DoCleaning()
	end
	local Character = Players.LocalPlayer.Character
	if Character then
		local Humanoid = Character:FindFirstChild("Humanoid")
		if Humanoid then
			CurrentCamera.CameraSubject = Humanoid
			v1:FireServer()
		end
	end
end
local function getComponent(p1)
	return createElement("ScreenGui", {
		ResetOnSpawn = false,
		IgnoreGuiInset = true,
		ZIndexBehavior = Enum.ZIndexBehavior.Sibling
	}, {
		SpectateSelector = createElement(SpectateSelector, p1)
	})
end
function t.showGui()
	t.guiMaid:DoCleaning()
	local function getNextCharacter(p1)
		local v1 = getAllCharacters()
		return v1[(table.find(v1, CurrentCamera.CameraSubject.Parent) + p1 - 1) % #v1 + 1]
	end
	local t2 = {
		size = UDim2.fromScale(1, 0.075),
		position = UDim2.fromScale(0.5, 0.75),
		onClickNext = function()
			local v1 = getAllCharacters()
			t.spectate(v1[(table.find(v1, CurrentCamera.CameraSubject.Parent) + 1 - 1) % #v1 + 1])
		end,
		onClickPrev = function()
			local v1 = getAllCharacters()
			t.spectate(v1[(table.find(v1, CurrentCamera.CameraSubject.Parent) + -1 - 1) % #v1 + 1])
		end,
		title = "N/A"
	}
	local v1 = Roact.mount(getComponent(t2), Players.LocalPlayer:FindFirstChild("PlayerGui"), "Spectate")
	t.guiMaid:GiveTask(function()
		Roact.unmount(v1)
	end)
	local function updateCameraSubject()
		local CameraSubject = CurrentCamera.CameraSubject
		if CameraSubject ~= nil and CameraSubject:IsA("Humanoid") then
			local v12 = Players:GetPlayerFromCharacter(CameraSubject.Parent)
			if v12 then
				t2.title = v12.DisplayName
			else
				t2.title = CameraSubject.Parent.Name
			end
			Roact.update(v1, getComponent(t2))
		end
	end
	t.guiMaid:GiveTask(CurrentCamera:GetPropertyChangedSignal("CameraSubject"):Connect(updateCameraSubject))
	updateCameraSubject()
	t.guiMaid:GiveTask(t.unspectate)
	return t.hideGui
end
function t.hideGui()
	t.guiMaid:DoCleaning()
end
return t
