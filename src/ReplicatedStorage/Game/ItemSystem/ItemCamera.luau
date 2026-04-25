-- Reviewed by Claude
-- variables reassigned
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
	local t = {}
	if LocalPlayer.Character then
		for v1, v2 in LocalPlayer.Character:QueryDescendants("BasePart#Handle") do
			if v2.Parent:IsA("Accessory") and (v2:FindFirstChild("BodyBackAttachment") or v2:FindFirstChild("NeckAttachment")) then
				table.insert(t, v2)
			end
		end
	end
	return t
end
local function HideAccessories()
	for v1, v2 in GetLocalAccessoryParts() do
		v2.LocalTransparencyModifier = 0.8
	end
end
local function ShowAccessories()
	local v1 = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Head")
	for v3, v4 in GetLocalAccessoryParts() do
		local v2
		v2 = if v1 then v1.LocalTransparencyModifier else 0
		v4.LocalTransparencyModifier = v2
	end
end
local fovSpring = nil
local recoilSpring = nil
local function InputChanged(p1)
	if p1.UserInputType == Enum.UserInputType.MouseMovement then
		local Delta = p1.Delta
		yaw = yaw - Delta.X * 0.005
		pitch = pitch - Delta.Y * 0.005
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
	local function handleSetting(p1)
		module.setLocked(p1)
	end
	module.setLocked((weaponCamLockSetting:getValue()))
	weaponCamLockSetting.onChanged:Connect(handleSetting)
	module.UISetting = weaponCamLockSetting
end
local currentRecoilSpring = nil
local ignoreParts = nil
local isAimingDown = false
module.equipped = false
function module.Adjust(p1)
	yaw = yaw + p1.Y
	pitch = pitch + p1.X
end
function module.SetRecoilSpring(p1)
	assert(p1)
	currentRecoilSpring = p1
end
function module.setLocked(p1)
	module.Locked = p1
	module.updateMouseLock()
end
function module.updateMouseLock()
	local v12 = PlayerUtils.getHumanoid(LocalPlayer)
	local activeMouseLockController = cameras.activeMouseLockController
	if activeMouseLockController then
		local v2 = UserInputService:GetLastInputType()
		if (module.Locked or (InputUtils.isTouch() or v2 == Enum.UserInputType.Gamepad1)) and (module.equipped and not (v12.Sit or v12.PlatformStand)) then
			if not activeMouseLockController:GetIsMouseLocked() then
				activeMouseLockController:OnMouseLockToggled()
			end
		elseif activeMouseLockController:GetIsMouseLocked() then
			activeMouseLockController:OnMouseLockToggled()
		end
	end
	local v3 = not module.getMouseLocked()
	if v12 and v12.AutoRotate ~= v3 then
		v12.AutoRotate = v3
	end
end
function module.getMouseLocked()
	local activeMouseLockController = cameras.activeMouseLockController
	return activeMouseLockController and activeMouseLockController:GetIsMouseLocked()
end
function module.getSensitivity()
	return CameraSensitivity.Value
end
function module.setSensitivity(p1)
	local v1 = module.getSensitivity()
	CameraSensitivity.Value = p1
	return function()
		CameraSensitivity.Value = v1
	end
end
local lastUpdateTime = os.clock()
function module.Update()
	local v1 = os.clock()
	local v2 = v1 - lastUpdateTime
	lastUpdateTime = v1
	module.updateMouseLock()
	if module.getMouseLocked() and not MovementRollService.isPlayerRolling(LocalPlayer) then
		local v3 = PlayerUtils.getRootPart(LocalPlayer)
		if v3 then
			v3.CFrame = CFrame.lookAt(Vector3.new(), (CurrentCamera.CFrame.LookVector * Vector3.new(1, 0, 1)).Unit) + v3.CFrame.p
		end
	end
	CurrentCamera.FieldOfView = fovSpring:Update()
	local v5 = if currentRecoilSpring then currentRecoilSpring:Update() else nil
	if v5 then
		CurrentCamera.CFrame = CurrentCamera.CFrame * CFrame.Angles(0, v5.Y * v2 * 60, 0) * CFrame.Angles(v5.X * v2 * 60, 0, 0)
	end
end
function module.Zoom(p1)
	fovSpring:SetTarget(p1)
end
function module.GetCameraDistance()
	local activeCameraController = cameras.activeCameraController
	if activeCameraController then
		return activeCameraController:GetCameraToSubjectDistance()
	else
		return 0
	end
end
function module.SetCameraDistance(p1)
	local activeCameraController = cameras.activeCameraController
	if activeCameraController then
		return activeCameraController:SetCameraToSubjectDistance(p1)
	else
		return 0
	end
end
function module.OnItemEquipped(p1, p2)
	module.equipped = true
	local Character = LocalPlayer.Character
	assert(Character)
	local Humanoid = Character:FindFirstChild("Humanoid")
	assert(Humanoid)
	local v1
	if p1 then
		if not (math.abs(recoilSpring.Target - 2) <= 0.01) then
			v1 = recoilSpring
			recoilSpring.p = 0
			recoilSpring.v = 0
			recoilSpring.t = tick()
			recoilSpring:SetTarget(2)
		end
	else
		v1 = recoilSpring
		recoilSpring.p = 0
		recoilSpring.v = 0
		recoilSpring.t = tick()
		recoilSpring:SetTarget(2)
	end
	isAimingDown = true
	ignoreParts = { Character, workspace.Items }
	if not p2 then
		for v3, v4 in GetLocalAccessoryParts() do
			v4.LocalTransparencyModifier = 0.8
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
	local v1 = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Head")
	for v3, v42 in GetLocalAccessoryParts() do
		local v2
		v2 = if v1 then v1.LocalTransparencyModifier else 0
		v42.LocalTransparencyModifier = v2
	end
	module.updateMouseLock()
	PlayerModule:FindFirstChild("CameraModule"):FindFirstChild("DisableAutoRotate").Value = false
end
return module
