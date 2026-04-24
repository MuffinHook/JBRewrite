-- Reviewed by Claude
local LocalPlayer = game:GetService("Players").LocalPlayer
local PlayerModule = LocalPlayer.PlayerScripts.PlayerModule
local CameraSensitivity = PlayerModule:FindFirstChild("CameraModule"):FindFirstChild("CameraSensitivity")
PlayerModule:FindFirstChild("CameraModule"):FindFirstChild("CameraOffset").Value = Vector3.new(2, 1, 0.25)
local v1 = require(PlayerModule):GetCameras()
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
local v2 = 0
local v3 = 0
local t = {
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
local v4 = nil
local v5 = nil
local function InputChanged(p1)
	if p1.UserInputType == Enum.UserInputType.MouseMovement then
		local Delta = p1.Delta
		v2 = v2 - Delta.X * 0.005
		v3 = v3 - Delta.Y * 0.005
		v3 = math.clamp(v3, -1.4, 1.2)
	end
end
function t.Init()
	v4 = Logic.MakeSpring()
	v4.Target = 70
	v4.v = 0
	v4.p = v4.Target
	v4.Damp = 0.9
	v4.Freq = 20
	v5 = Logic.MakeSpring()
	v5.Target = 0
	v5.v = 0
	v5.p = v5.Target
	v5.Damp = 0.9
	v5.Freq = 40
	UserInputService.InputChanged:Connect(InputChanged)
	local t2 = {
		name = "weaponCamLock",
		title = "Weapon Camera Lock",
		type = gameSettingType.Checkbox,
		defaultValue = true,
		order = 200
	}
	GameSettingsService.add(t2)
	local function handleSetting(p1)
		t.setLocked(p1)
	end
	t.setLocked((t2:getValue()))
	t2.onChanged:Connect(handleSetting)
	t.UISetting = t2
end
local v6 = nil
local v7 = nil
local v8 = false
t.equipped = false
function t.Adjust(p1)
	v2 = v2 + p1.Y
	v3 = v3 + p1.X
end
function t.SetRecoilSpring(p1)
	assert(p1)
	v6 = p1
end
function t.setLocked(p1)
	t.Locked = p1
	t.updateMouseLock()
end
function t.updateMouseLock()
	local v12 = PlayerUtils.getHumanoid(LocalPlayer)
	local activeMouseLockController = v1.activeMouseLockController
	if activeMouseLockController then
		local v2 = UserInputService:GetLastInputType()
		if (t.Locked or (InputUtils.isTouch() or v2 == Enum.UserInputType.Gamepad1)) and (t.equipped and not (v12.Sit or v12.PlatformStand)) then
			if not activeMouseLockController:GetIsMouseLocked() then
				activeMouseLockController:OnMouseLockToggled()
			end
		elseif activeMouseLockController:GetIsMouseLocked() then
			activeMouseLockController:OnMouseLockToggled()
		end
	end
	local v3 = not t.getMouseLocked()
	if v12 and v12.AutoRotate ~= v3 then
		v12.AutoRotate = v3
	end
end
function t.getMouseLocked()
	local activeMouseLockController = v1.activeMouseLockController
	return activeMouseLockController and activeMouseLockController:GetIsMouseLocked()
end
function t.getSensitivity()
	return CameraSensitivity.Value
end
function t.setSensitivity(p1)
	local v1 = t.getSensitivity()
	CameraSensitivity.Value = p1
	return function()
		CameraSensitivity.Value = v1
	end
end
local v9 = os.clock()
function t.Update()
	local v1 = os.clock()
	local v2 = v1 - v9
	v9 = v1
	t.updateMouseLock()
	if t.getMouseLocked() and not MovementRollService.isPlayerRolling(LocalPlayer) then
		local v3 = PlayerUtils.getRootPart(LocalPlayer)
		if v3 then
			v3.CFrame = CFrame.lookAt(Vector3.new(), (CurrentCamera.CFrame.LookVector * Vector3.new(1, 0, 1)).Unit) + v3.CFrame.p
		end
	end
	CurrentCamera.FieldOfView = v4:Update()
	local v5 = if v6 then v6:Update() else nil
	if v5 then
		CurrentCamera.CFrame = CurrentCamera.CFrame * CFrame.Angles(0, v5.Y * v2 * 60, 0) * CFrame.Angles(v5.X * v2 * 60, 0, 0)
	end
end
function t.Zoom(p1)
	v4:SetTarget(p1)
end
function t.GetCameraDistance()
	local activeCameraController = v1.activeCameraController
	if activeCameraController then
		return activeCameraController:GetCameraToSubjectDistance()
	else
		return 0
	end
end
function t.SetCameraDistance(p1)
	local activeCameraController = v1.activeCameraController
	if activeCameraController then
		return activeCameraController:SetCameraToSubjectDistance(p1)
	else
		return 0
	end
end
function t.OnItemEquipped(p1, p2)
	t.equipped = true
	local Character = LocalPlayer.Character
	assert(Character)
	local Humanoid = Character:FindFirstChild("Humanoid")
	assert(Humanoid)
	local v1
	if p1 then
		if not (math.abs(v5.Target - 2) <= 0.01) then
			v1 = v5
			v5.p = 0
			v5.v = 0
			v5.t = tick()
			v5:SetTarget(2)
		end
	else
		v1 = v5
		v5.p = 0
		v5.v = 0
		v5.t = tick()
		v5:SetTarget(2)
	end
	v8 = true
	v7 = { Character, workspace.Items }
	if not p2 then
		for v3, v4 in GetLocalAccessoryParts() do
			v4.LocalTransparencyModifier = 0.8
		end
	end
	t.Update()
	PlayerModule:FindFirstChild("CameraModule"):FindFirstChild("DisableAutoRotate").Value = true
end
function t.OnItemUnequipped()
	t.equipped = false
	v4.p = 70
	v4.Target = v4.p
	CurrentCamera.FieldOfView = 70
	assert(LocalPlayer.Character)
	local v1 = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Head")
	for v3, v42 in GetLocalAccessoryParts() do
		local v2
		v2 = if v1 then v1.LocalTransparencyModifier else 0
		v42.LocalTransparencyModifier = v2
	end
	t.updateMouseLock()
	PlayerModule:FindFirstChild("CameraModule"):FindFirstChild("DisableAutoRotate").Value = false
end
return t
