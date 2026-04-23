local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Maid = require(ReplicatedStorage.Std.Maid)
local ItemCamera = require(ReplicatedStorage.Game.ItemSystem.ItemCamera)
local GameSettingsService = require(ReplicatedStorage.GameSettings.GameSettingsService)
local CurrentCamera = workspace.CurrentCamera
local UserInputService = game:GetService("UserInputService")
local InputUtils = require(ReplicatedStorage.Std.InputUtils)
local Raycast = require(ReplicatedStorage.Std.Raycast)
local RxInstanceUtils = require(ReplicatedStorage.Std.RxInstanceUtils)
local v1 = Random.new()
local v2 = RaycastParams.new()
v2.RespectCanCollide = true
local function customCollideFunc(p1) --[[ Line: 18 ]]
	if p1:GetAttribute("InvisibleToBullets") == true then
		return false
	else
		return p1.CanCollide
	end
end
local t = {
	__ClassName = "Item"
}
t.__index = t
function t.new(p1, p2) --[[ Line: 28 | Upvalues: RxInstanceUtils (copy), t (copy), Maid (copy), customCollideFunc (copy), LocalPlayer (copy), ItemCamera (copy), v1 (copy), RunService (copy) ]]
	assert(p1)
	local Character = p1.Character
	assert(Character)
	local Humanoid = Character:FindFirstChild("Humanoid")
	assert(Humanoid)
	local UpperTorso = Character:FindFirstChild("UpperTorso")
	assert(UpperTorso)
	RxInstanceUtils.yieldForProperty(Character, "PrimaryPart")
	local PrimaryPart = Character.PrimaryPart
	assert(PrimaryPart)
	local Neck = Character:FindFirstChild("Head"):FindFirstChild("Neck")
	assert(Neck)
	local Waist = UpperTorso:FindFirstChild("Waist")
	assert(Waist)
	local Root = Character:FindFirstChild("LowerTorso"):FindFirstChild("Root")
	assert(Root)
	local t2 = {}
	setmetatable(t2, t)
	t2.Maid = Maid.new()
	t2.maid = t2.Maid
	t2.Player = p1
	t2.Character = Character
	t2.Humanoid = Humanoid
	t2.RootPart = PrimaryPart
	t2.UpperTorso = UpperTorso
	t2.JointNeck = Neck
	t2.JointWaist = Waist
	t2.JointRoot = Root
	t2.Locked = false
	t2._customCollideFunc = customCollideFunc
	t2.Local = p1 == LocalPlayer
	if t2.Local then
		t2.Maid:GiveTask(task.defer(function() --[[ Line: 67 | Upvalues: ItemCamera (ref), p2 (copy), t2 (copy) ]]
			ItemCamera.OnItemEquipped(p2 ~= nil, t2.DoNotHide)
		end))
		t2.Maid:GiveTask(function() --[[ Line: 70 | Upvalues: ItemCamera (ref) ]]
			ItemCamera.OnItemUnequipped()
		end)
	end
	if t2.Local then
		local v4 = "GunCamera" .. tostring((v1:NextInteger(1, 1000000000)))
		RunService:BindToRenderStep(v4, Enum.RenderPriority.Camera.Value + 1, function() --[[ Line: 78 | Upvalues: t2 (copy) ]]
			t2:UpdateCamera()
		end)
		t2.Maid:GiveTask(function() --[[ Line: 81 | Upvalues: RunService (ref), v4 (copy) ]]
			RunService:UnbindFromRenderStep(v4)
		end)
	end
	return t2
end
function t.TransformLocalMousePosition(p1, p2) --[[ Line: 88 ]]
	return p2
end
function t.ProjectMouseLocationToWorld(p1, p2) --[[ Line: 91 | Upvalues: CurrentCamera (copy), v2 (copy), Raycast (copy), customCollideFunc (copy) ]]
	local v1 = CurrentCamera:ViewportPointToRay(p2.x, p2.y)
	v2.FilterDescendantsInstances = p1.IgnoreList
	local v22 = Raycast.collidable(v1.Origin, v1.Direction, 999, v2, customCollideFunc)
	return p1:TransformLocalMousePosition(if v22 then v22.Position else v1.Origin + v1.Direction * 999)
end
function t.GetMouseLocation(p1) --[[ Line: 104 | Upvalues: InputUtils (copy), UserInputService (copy) ]]
	if InputUtils.isTouch() then
		local ViewportSize = workspace.CurrentCamera.ViewportSize
		return Vector3.new(ViewportSize.X * 0.5, ViewportSize.Y * 0.5, 0)
	elseif InputUtils.isGamepad() then
		local ViewportSize = workspace.CurrentCamera.ViewportSize
		return Vector3.new(ViewportSize.X * 0.5, ViewportSize.Y * 0.5, 0)
	else
		return UserInputService:GetMouseLocation()
	end
end
local t2 = {}
t2.__index = t2
function t2.new() --[[ Line: 125 | Upvalues: t2 (copy), Maid (copy) ]]
	local t = {}
	setmetatable(t, t2)
	t.maid = Maid.new()
	local function createProgressBarGradient(p1, p2) --[[ Line: 130 ]]
		local Frame = Instance.new("Frame")
		Frame.Size = UDim2.fromScale(0.5, 1)
		Frame.Position = UDim2.fromScale(if p2 then 0 else 0.5, 0)
		Frame.BackgroundTransparency = 1
		Frame.ClipsDescendants = true
		Frame.Parent = p1
		local ImageLabel = Instance.new("ImageLabel")
		ImageLabel.BackgroundTransparency = 1
		ImageLabel.Size = UDim2.fromScale(2, 1)
		ImageLabel.Position = UDim2.fromScale(if p2 then 0 else -1, 0)
		ImageLabel.Image = "rbxasset://textures/ui/Controls/RadialFill.png"
		ImageLabel.Parent = Frame
		local UIGradient = Instance.new("UIGradient")
		UIGradient.Transparency = NumberSequence.new({
			NumberSequenceKeypoint.new(0, 0),
			NumberSequenceKeypoint.new(0.4999, 0),
			NumberSequenceKeypoint.new(0.5, 1),
			NumberSequenceKeypoint.new(1, 1)
		})
		UIGradient.Rotation = if p2 then 180 else 0
		UIGradient.Parent = ImageLabel
		return UIGradient
	end
	local CircularProgressBar = Instance.new("Frame")
	CircularProgressBar.Name = "CircularProgressBar"
	CircularProgressBar.Size = UDim2.fromOffset(58, 58)
	CircularProgressBar.AnchorPoint = Vector2.new(0.5, 0.5)
	CircularProgressBar.Position = UDim2.fromScale(0.5, 0.5)
	CircularProgressBar.BackgroundTransparency = 1
	CircularProgressBar.Visible = true
	local v2 = createProgressBarGradient(CircularProgressBar, true)
	local v3 = createProgressBarGradient(CircularProgressBar, false)
	local Progress = Instance.new("NumberValue")
	Progress.Name = "Progress"
	Progress.Parent = CircularProgressBar
	t.progressBar = CircularProgressBar
	t.gradient1 = v2
	t.gradient2 = v3
	return t
end
function t2.UpdatePosition(p1, p2) --[[ Line: 179 ]]
	p1.progressBar.Position = UDim2.new(0, p2.X, 0, p2.Y)
end
function t2.UpdateProgress(p1, p2) --[[ Line: 182 ]]
	local v1 = math.clamp(p2 * 360, 0, 360)
	p1.gradient1.Rotation = math.clamp(v1, 180, 360)
	p1.gradient2.Rotation = math.clamp(v1, 0, 180)
end
function t2.Destroy(p1) --[[ Line: 187 ]]
	p1.maid:Destroy()
	setmetatable(p1, nil)
end
function t.StartReloadProgressCircle(p1, p2, p3) --[[ Line: 191 | Upvalues: Players (copy), t2 (copy), Maid (copy), RunService (copy) ]]
	local GunReload = Instance.new("ScreenGui")
	GunReload.Name = "GunReload"
	GunReload.Enabled = false
	GunReload.Parent = Players.LocalPlayer.PlayerGui
	local v1 = t2.new()
	GunReload.IgnoreGuiInset = true
	local v2 = Maid.new()
	v2.gunReloadScreenGui = GunReload
	v2.circularProgressBar = v1
	local v4 = p3 or os.clock()
	if not p2 then
		p2 = p1.Config.ReloadTime
	end
	v2.progressBarUpdater = RunService.Heartbeat:Connect(function() --[[ Line: 207 | Upvalues: v4 (ref), p2 (ref), p1 (copy), v1 (copy) ]]
		local v12 = (os.clock() - v4) / p2
		if v12 >= 1 then
			p1.Maid.guiMaid = nil
		else
			v1:UpdateProgress(v12)
			v1:UpdatePosition(p1:GetMouseLocation())
		end
	end)
	p1.Maid.guiMaid = v2
	v1.progressBar.Parent = GunReload
	GunReload.Enabled = true
end
function t.DefaultDisableCamLock(p1) --[[ Line: 223 | Upvalues: ItemCamera (copy) ]]
	if p1.Local then
		local Locked = ItemCamera.Locked
		if ItemCamera.Locked == true then
			ItemCamera.Locked = false
			p1:UpdateCameraLocked()
		end
		if Locked then
			p1.Maid:GiveTask(function() --[[ Line: 232 | Upvalues: ItemCamera (ref), Locked (copy) ]]
				ItemCamera.Locked = Locked
			end)
		end
	end
end
function t.UpdateCamera(p1) --[[ Line: 238 | Upvalues: ItemCamera (copy) ]]
	ItemCamera.Update()
end
function t.UpdateCameraLocked(p1) --[[ Line: 241 | Upvalues: ItemCamera (copy) ]]
	if ItemCamera.Locked then
		ItemCamera.OnItemEquipped(true, p1.DoNotHide)
	else
		ItemCamera.OnItemUnequipped()
	end
end
function t.InputBegan(p1, p2, p3) --[[ Line: 249 | Upvalues: ItemCamera (copy), GameSettingsService (copy) ]]
	if not p3 and if p2.UserInputType == Enum.UserInputType.Keyboard and p2.KeyCode == Enum.KeyCode.V then true elseif p2.UserInputType == Enum.UserInputType.Gamepad1 then p2.KeyCode == Enum.KeyCode.ButtonB else false then
		ItemCamera.setLocked(not ItemCamera.Locked)
		GameSettingsService.setValue(ItemCamera.UISetting, ItemCamera.Locked)
	end
end
function t.InputEnded(p1, ...) --[[ Line: 261 ]]
	error("TODO: Implement")
end
function t.Destroy(p1) --[[ Line: 264 ]]
	p1.Maid:Destroy()
	p1.Maid = nil
	p1.Destroyed = true
	setmetatable(p1, nil)
end
return t