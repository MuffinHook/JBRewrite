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
local localPlayer = ReplicatedStorage:WaitForChild(SpectateConsts.SPECTATE_OTHER_REMOTE_NAME)
local SpectateService = {
	_tree = nil,
	guiMaid = Maid.new(),
	active = false,
	spectateMaid = nil,
	onCharacterSpectated = Signal.new()
}
function SpectateService.trackCharacter(targetCharacter)
	if targetCharacter then
		CurrentCamera.CameraSubject = targetCharacter:FindFirstChild("Humanoid")
	else
		CurrentCamera.CameraSubject = nil
	end
	SpectateService.onCharacterSpectated:Fire(targetCharacter)
	localPlayer:FireServer(Players:GetPlayerFromCharacter(targetCharacter))
end
local function getAllCharacters()
	local characters = {}
	for localPlayer, character in CollectionService:GetTagged(SpectateConsts.SPECTATE_TAG_NAME) do
		table.insert(characters, character)
	end
	local Character = Players.LocalPlayer.Character
	if table.find(characters, Character) == nil then
		table.insert(characters, Character)
	end
	table.sort(characters, function(charA, charB)
		return charA.Name < charB.Name
	end)
	return characters
end
function SpectateService.findNewTarget()
	local allCharacters = getAllCharacters()
	assert(#allCharacters > 0, "No characters to spectate")
	SpectateService.trackCharacter(allCharacters[math.random(1, #allCharacters)])
end
function SpectateService.spectate(targetCharacter)
	SpectateService.active = true
	local spectateMaid = SpectateService.spectateMaid
	if spectateMaid then
		spectateMaid:DoCleaning()
	else
		spectateMaid = Maid.new()
		SpectateService.spectateMaid = spectateMaid
	end
	if targetCharacter then
		SpectateService.trackCharacter(targetCharacter)
	else
		SpectateService.findNewTarget()
	end
	local function checkIfNeedNewTarget()
		if not (CurrentCamera.CameraSubject and CurrentCamera.CameraSubject:IsDescendantOf(workspace)) then
			SpectateService.findNewTarget()
		end
	end
	local function handleHumanoid()
		local CameraSubject = CurrentCamera.CameraSubject
		if CameraSubject ~= nil and CameraSubject:IsA("Humanoid") then
			spectateMaid.humanoidDied = CameraSubject.Died:Connect(function()
				SpectateService.findNewTarget()
			end)
		end
	end
	local CameraSubject = CurrentCamera.CameraSubject
	if CameraSubject ~= nil and CameraSubject:IsA("Humanoid") then
		spectateMaid.humanoidDied = CameraSubject.Died:Connect(function()
			SpectateService.findNewTarget()
		end)
	end
	spectateMaid:GiveTask(CurrentCamera:GetAttributeChangedSignal("CameraSubject"):Connect(handleHumanoid))
	spectateMaid:GiveTask(Interval.every(1):Connect(checkIfNeedNewTarget))
	spectateMaid:GiveTask(function()
		SpectateService.active = false
	end)
end
function SpectateService.unspectate()
	if SpectateService.spectateMaid then
		SpectateService.spectateMaid:DoCleaning()
	end
	local Character = Players.LocalPlayer.Character
	if Character then
		local Humanoid = Character:FindFirstChild("Humanoid")
		if Humanoid then
			CurrentCamera.CameraSubject = Humanoid
			localPlayer:FireServer()
		end
	end
end
local function getComponent(guiProps)
	return createElement("ScreenGui", {
		ResetOnSpawn = false,
		IgnoreGuiInset = true,
		ZIndexBehavior = Enum.ZIndexBehavior.Sibling
	}, {
		SpectateSelector = createElement(SpectateSelector, guiProps)
	})
end
function SpectateService.showGui()
	SpectateService.guiMaid:DoCleaning()
	local function getNextCharacter(offsetAmount)
		local allCharacters = getAllCharacters()
		return allCharacters[(table.find(allCharacters, CurrentCamera.CameraSubject.Parent) + offsetAmount - 1) % #allCharacters + 1]
	end
	local guiConfig = {
		size = UDim2.fromScale(1, 0.075),
		position = UDim2.fromScale(0.5, 0.75),
		onClickNext = function()
			local allCharacters = getAllCharacters()
			SpectateService.spectate(allCharacters[(table.find(allCharacters, CurrentCamera.CameraSubject.Parent) + 1 - 1) % #allCharacters + 1])
		end,
		onClickPrev = function()
			local allCharacters = getAllCharacters()
			SpectateService.spectate(allCharacters[(table.find(allCharacters, CurrentCamera.CameraSubject.Parent) + -1 - 1) % #allCharacters + 1])
		end,
		title = "N/A"
	}
	local guiInstance = Roact.mount(getComponent(guiConfig), Players.LocalPlayer:FindFirstChild("PlayerGui"), "Spectate")
	SpectateService.guiMaid:GiveTask(function()
		Roact.unmount(guiInstance)
	end)
	local function updateCameraSubject()
		local CameraSubject = CurrentCamera.CameraSubject
		if CameraSubject ~= nil and CameraSubject:IsA("Humanoid") then
			local targetPlayer = Players:GetPlayerFromCharacter(CameraSubject.Parent)
			if targetPlayer then
				guiConfig.title = targetPlayer.DisplayName
			else
				guiConfig.title = CameraSubject.Parent.Name
			end
			Roact.update(guiInstance, getComponent(guiConfig))
		end
	end
	SpectateService.guiMaid:GiveTask(CurrentCamera:GetPropertyChangedSignal("CameraSubject"):Connect(updateCameraSubject))
	updateCameraSubject()
	SpectateService.guiMaid:GiveTask(SpectateService.unspectate)
	return SpectateService.hideGui
end
function SpectateService.hideGui()
	SpectateService.guiMaid:DoCleaning()
end
return SpectateService
