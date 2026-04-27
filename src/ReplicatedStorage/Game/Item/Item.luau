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
local randomGenerator = Random.new()
local raycastParams = RaycastParams.new()
raycastParams.RespectCanCollide = true
local function customCollideFunc(part)
	if part:GetAttribute("InvisibleToBullets") == true then
		return false
	else
		return part.CanCollide
	end
end
local Item = {
	__ClassName = "Item"
}
Item.__index = Item
function Item.new(player, config)
	assert(player)
	local Character = player.Character
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
	local itemInstance = {}
	setmetatable(itemInstance, Item)
	itemInstance.Maid = Maid.new()
	itemInstance.maid = itemInstance.Maid
	itemInstance.Player = player
	itemInstance.Character = Character
	itemInstance.Humanoid = Humanoid
	itemInstance.RootPart = PrimaryPart
	itemInstance.UpperTorso = UpperTorso
	itemInstance.JointNeck = Neck
	itemInstance.JointWaist = Waist
	itemInstance.JointRoot = Root
	itemInstance.Locked = false
	itemInstance._customCollideFunc = customCollideFunc
	itemInstance.Local = player == LocalPlayer
	if itemInstance.Local then
		itemInstance.Maid:GiveTask(task.defer(function()
			ItemCamera.OnItemEquipped(config ~= nil, itemInstance.DoNotHide)
		end))
		itemInstance.Maid:GiveTask(function()
			ItemCamera.OnItemUnequipped()
		end)
	end
	if itemInstance.Local then
		local cameraRenderBindingName = "GunCamera" .. tostring((randomGenerator:NextInteger(1, 1000000000)))
		RunService:BindToRenderStep(cameraRenderBindingName, Enum.RenderPriority.Camera.Value + 1, function()
			itemInstance:UpdateCamera()
		end)
		itemInstance.Maid:GiveTask(function()
			RunService:UnbindFromRenderStep(cameraRenderBindingName)
		end)
	end
	return itemInstance
end
function Item.TransformLocalMousePosition(player, position)
	return position
end
function Item.ProjectMouseLocationToWorld(player, mousePos)
	local viewportRay = CurrentCamera:ViewportPointToRay(mousePos.x, mousePos.y)
	raycastParams.FilterDescendantsInstances = player.IgnoreList
	local raycastHit = Raycast.collidable(viewportRay.Origin, viewportRay.Direction, 999, raycastParams, customCollideFunc)
	return player:TransformLocalMousePosition(if raycastHit then raycastHit.Position else viewportRay.Origin + viewportRay.Direction * 999)
end
function Item.GetMouseLocation(player)
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
local ProgressBar = {}
ProgressBar.__index = ProgressBar
function ProgressBar.new()
	local progressBarInstance = {}
	setmetatable(progressBarInstance, ProgressBar)
	progressBarInstance.maid = Maid.new()
	local function createProgressBarGradient(parentContainer, isLeftSide)
		local Frame = Instance.new("Frame")
		Frame.Size = UDim2.fromScale(0.5, 1)
		Frame.Position = UDim2.fromScale(if isLeftSide then 0 else 0.5, 0)
		Frame.BackgroundTransparency = 1
		Frame.ClipsDescendants = true
		Frame.Parent = parentContainer
		local ImageLabel = Instance.new("ImageLabel")
		ImageLabel.BackgroundTransparency = 1
		ImageLabel.Size = UDim2.fromScale(2, 1)
		ImageLabel.Position = UDim2.fromScale(if isLeftSide then 0 else -1, 0)
		ImageLabel.Image = "rbxasset://textures/ui/Controls/RadialFill.png"
		ImageLabel.Parent = Frame
		local UIGradient = Instance.new("UIGradient")
		UIGradient.Transparency = NumberSequence.new({
			NumberSequenceKeypoint.new(0, 0),
			NumberSequenceKeypoint.new(0.4999, 0),
			NumberSequenceKeypoint.new(0.5, 1),
			NumberSequenceKeypoint.new(1, 1)
		})
		UIGradient.Rotation = if isLeftSide then 180 else 0
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
	local leftGradient = createProgressBarGradient(CircularProgressBar, true)
	local rightGradient = createProgressBarGradient(CircularProgressBar, false)
	local Progress = Instance.new("NumberValue")
	Progress.Name = "Progress"
	Progress.Parent = CircularProgressBar
	progressBarInstance.progressBar = CircularProgressBar
	progressBarInstance.gradient1 = leftGradient
	progressBarInstance.gradient2 = rightGradient
	return progressBarInstance
end
function ProgressBar.UpdatePosition(progressBarInstance, mousePos)
	progressBarInstance.progressBar.Position = UDim2.new(0, mousePos.X, 0, mousePos.Y)
end
function ProgressBar.UpdateProgress(progressBarInstance, progress)
	local rotationDegrees = math.clamp(progress * 360, 0, 360)
	progressBarInstance.gradient1.Rotation = math.clamp(rotationDegrees, 180, 360)
	progressBarInstance.gradient2.Rotation = math.clamp(rotationDegrees, 0, 180)
end
function ProgressBar.Destroy(progressBarInstance)
	progressBarInstance.maid:Destroy()
	setmetatable(progressBarInstance, nil)
end
function Item.StartReloadProgressCircle(player, reloadDuration, startTime)
	local GunReload = Instance.new("ScreenGui")
	GunReload.Name = "GunReload"
	GunReload.Enabled = false
	GunReload.Parent = Players.LocalPlayer.PlayerGui
	local progressBarInstance = ProgressBar.new()
	GunReload.IgnoreGuiInset = true
	local guiMaid = Maid.new()
	guiMaid.gunReloadScreenGui = GunReload
	guiMaid.circularProgressBar = progressBarInstance
	local reloadStartTime = startTime or os.clock()
	if not reloadDuration then
		reloadDuration = player.Config.ReloadTime
	end
	guiMaid.progressBarUpdater = RunService.Heartbeat:Connect(function()
		local progressRatio = (os.clock() - reloadStartTime) / reloadDuration
		if progressRatio >= 1 then
			player.Maid.guiMaid = nil
		else
			progressBarInstance:UpdateProgress(progressRatio)
			progressBarInstance:UpdatePosition(player:GetMouseLocation())
		end
	end)
	player.Maid.guiMaid = guiMaid
	progressBarInstance.progressBar.Parent = GunReload
	GunReload.Enabled = true
end
function Item.DefaultDisableCamLock(player)
	if player.Local then
		local Locked = ItemCamera.Locked
		if ItemCamera.Locked == true then
			ItemCamera.Locked = false
			player:UpdateCameraLocked()
		end
		if Locked then
			player.Maid:GiveTask(function()
				ItemCamera.Locked = Locked
			end)
		end
	end
end
function Item.UpdateCamera(player)
	ItemCamera.Update()
end
function Item.UpdateCameraLocked(player)
	if ItemCamera.Locked then
		ItemCamera.OnItemEquipped(true, player.DoNotHide)
	else
		ItemCamera.OnItemUnequipped()
	end
end
function Item.InputBegan(player, inputObject, gameProcessed)
	if not gameProcessed and if inputObject.UserInputType == Enum.UserInputType.Keyboard and inputObject.KeyCode == Enum.KeyCode.V then true elseif inputObject.UserInputType == Enum.UserInputType.Gamepad1 then inputObject.KeyCode == Enum.KeyCode.ButtonB else false then
		ItemCamera.setLocked(not ItemCamera.Locked)
		GameSettingsService.setValue(ItemCamera.UISetting, ItemCamera.Locked)
	end
end
function Item.InputEnded(player, ...)
	error("TODO: Implement")
end
function Item.Destroy(player)
	player.Maid:Destroy()
	player.Maid = nil
	player.Destroyed = true
	setmetatable(player, nil)
end
return Item
