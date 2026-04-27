local LocalPlayer = game:GetService("Players").LocalPlayer
local PlayerModule = LocalPlayer.PlayerScripts.PlayerModule
local CameraSensitivity = PlayerModule:FindFirstChild("CameraModule"):FindFirstChild("CameraSensitivity")
PlayerModule:FindFirstChild("CameraModule"):FindFirstChild("CameraOffset").Value = Vector3.new(2, 1, 0.25)
local cameras = require(PlayerModule):GetCameras()
local UserInputService = game:GetService("UserInputService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
require(ReplicatedStorage.Game.Paraglide)
local GameSettingsService = require(ReplicatedStorage.GameSettings.GameSettingsService)
local gameSettingType = require(ReplicatedStorage.GameSettings.gameSettingType)
local PlayerUtils = require(ReplicatedStorage.Game.PlayerUtils)
require(ReplicatedStorage.EzUi.Utils)
local Logic = require(ReplicatedStorage.Module.Logic)
local MovementRollService = require(ReplicatedStorage.MovementRoll.MovementRollService)
local InputUtils = require(ReplicatedStorage.Std.InputUtils)
local CurrentCamera = workspace.CurrentCamera
local yaw = 0
local pitch = 0
local module = {
	Locked = true
}
local function GetLocalAccessoryParts()
	local accessoryParts = {}
	if LocalPlayer.Character then
		for index, part in LocalPlayer.Character:QueryDescendants("BasePart#Handle") do
			if part.Parent:IsA("Accessory") and (part:FindFirstChild("BodyBackAttachment") or part:FindFirstChild("NeckAttachment")) then
				table.insert(accessoryParts, part)
			end
		end
	end
	return accessoryParts
end
local function HideAccessories()
	for index, accessoryPart in GetLocalAccessoryParts() do
		accessoryPart.LocalTransparencyModifier = 0.8
	end
end
local function ShowAccessories()
	local head = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Head")
	for index, accessoryPart in GetLocalAccessoryParts() do
		local transparency
		transparency = if head then head.LocalTransparencyModifier else 0
		accessoryPart.LocalTransparencyModifier = transparency
	end
end
local fovSpring = nil
local recoilSpring = nil
local function InputChanged(inputData)
	if inputData.UserInputType == Enum.UserInputType.MouseMovement then
		local mouseDelta = inputData.Delta
		yaw = yaw - mouseDelta.X * 0.005
		pitch = pitch - mouseDelta.Y * 0.005
		pitch = math.clamp(pitch, -1.4, 1.2)
	end
end
function module.Init()
	fovSpring = Logic.MakeSpring()
	fovSpring.Target = 70
	fovSpring.v = 0
	fovSpring.p = fovSpring.Target
	fovSpring.Damp = 0.9
	fovSpring.Freq = 20
	recoilSpring = Logic.MakeSpring()
	recoilSpring.Target = 0
	recoilSpring.v = 0
	recoilSpring.p = recoilSpring.Target
	recoilSpring.Damp = 0.9
	recoilSpring.Freq = 40
	UserInputService.InputChanged:Connect(InputChanged)
	local weaponCamLockSetting = {
		name = "weaponCamLock",
		title = "Weapon Camera Lock",
		type = gameSettingType.Checkbox,
		defaultValue = true,
		order = 200
	}
	GameSettingsService.add(weaponCamLockSetting)
	local function handleSetting(isWeaponCamLocked)
		module.setLocked(isWeaponCamLocked)
	end
	module.setLocked((weaponCamLockSetting:getValue()))
	weaponCamLockSetting.onChanged:Connect(handleSetting)
	module.UISetting = weaponCamLockSetting
end
local currentRecoilSpring = nil
local ignoreParts = nil
local isAimingDown = false
module.equipped = false
function module.Adjust(recoilVector)
	yaw = yaw + recoilVector.Y
	pitch = pitch + recoilVector.X
end
function module.SetRecoilSpring(spring)
	assert(spring)
	currentRecoilSpring = spring
end
function module.setLocked(locked)
	module.Locked = locked
	module.updateMouseLock()
end
function module.updateMouseLock()
	local humanoid = PlayerUtils.getHumanoid(LocalPlayer)
	local activeMouseLockController = cameras.activeMouseLockController
	if activeMouseLockController then
		local lastInputType = UserInputService:GetLastInputType()
		if (module.Locked or (InputUtils.isTouch() or lastInputType == Enum.UserInputType.Gamepad1)) and (module.equipped and not (humanoid.Sit or humanoid.PlatformStand)) then
			if not activeMouseLockController:GetIsMouseLocked() then
				activeMouseLockController:OnMouseLockToggled()
			end
		elseif activeMouseLockController:GetIsMouseLocked() then
			activeMouseLockController:OnMouseLockToggled()
		end
	end
	local shouldDisableAutoRotate = not module.getMouseLocked()
	if humanoid and humanoid.AutoRotate ~= shouldDisableAutoRotate then
		humanoid.AutoRotate = shouldDisableAutoRotate
	end
end
function module.getMouseLocked()
	local activeMouseLockController = cameras.activeMouseLockController
	return activeMouseLockController and activeMouseLockController:GetIsMouseLocked()
end
function module.getSensitivity()
	return CameraSensitivity.Value
end
function module.setSensitivity(newSensitivity)
	local previousSensitivity = module.getSensitivity()
	CameraSensitivity.Value = newSensitivity
	return function()
		CameraSensitivity.Value = previousSensitivity
	end
end
local lastUpdateTime = os.clock()
function module.Update()
	local currentTime = os.clock()
	local deltaTime = currentTime - lastUpdateTime
	lastUpdateTime = currentTime
	module.updateMouseLock()
	if module.getMouseLocked() and not MovementRollService.isPlayerRolling(LocalPlayer) then
		local rootPart = PlayerUtils.getRootPart(LocalPlayer)
		if rootPart then
			rootPart.CFrame = CFrame.lookAt(Vector3.new(), (CurrentCamera.CFrame.LookVector * Vector3.new(1, 0, 1)).Unit) + rootPart.CFrame.p
		end
	end
	CurrentCamera.FieldOfView = fovSpring:Update()
	local recoilOffset = if currentRecoilSpring then currentRecoilSpring:Update() else nil
	if recoilOffset then
		CurrentCamera.CFrame = CurrentCamera.CFrame * CFrame.Angles(0, recoilOffset.Y * deltaTime * 60, 0) * CFrame.Angles(recoilOffset.X * deltaTime * 60, 0, 0)
	end
end
function module.Zoom(targetFOV)
	fovSpring:SetTarget(targetFOV)
end
function module.GetCameraDistance()
	local activeCameraController = cameras.activeCameraController
	if activeCameraController then
		return activeCameraController:GetCameraToSubjectDistance()
	else
		return 0
	end
end
function module.SetCameraDistance(distanceValue)
	local activeCameraController = cameras.activeCameraController
	if activeCameraController then
		return activeCameraController:SetCameraToSubjectDistance(distanceValue)
	else
		return 0
	end
end
function module.OnItemEquipped(isAiming, hideAccessories)
	module.equipped = true
	local Character = LocalPlayer.Character
	assert(Character)
	local Humanoid = Character:FindFirstChild("Humanoid")
	assert(Humanoid)
	local spring
	if isAiming then
		if not (math.abs(recoilSpring.Target - 2) <= 0.01) then
			spring = recoilSpring
			recoilSpring.p = 0
			recoilSpring.v = 0
			recoilSpring.t = tick()
			recoilSpring:SetTarget(2)
		end
	else
		spring = recoilSpring
		recoilSpring.p = 0
		recoilSpring.v = 0
		recoilSpring.t = tick()
		recoilSpring:SetTarget(2)
	end
	isAimingDown = true
	ignoreParts = { Character, workspace.Items }
	if not hideAccessories then
		for index, accessoryPart in GetLocalAccessoryParts() do
			accessoryPart.LocalTransparencyModifier = 0.8
		end
	end
	module.Update()
	PlayerModule:FindFirstChild("CameraModule"):FindFirstChild("DisableAutoRotate").Value = true
end
function module.OnItemUnequipped()
	module.equipped = false
	fovSpring.p = 70
	fovSpring.Target = fovSpring.p
	CurrentCamera.FieldOfView = 70
	assert(LocalPlayer.Character)
	local head = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Head")
	for index, accessoryPart in GetLocalAccessoryParts() do
		local transparency
		transparency = if head then head.LocalTransparencyModifier else 0
		accessoryPart.LocalTransparencyModifier = transparency
	end
	module.updateMouseLock()
	PlayerModule:FindFirstChild("CameraModule"):FindFirstChild("DisableAutoRotate").Value = false
end
return module
