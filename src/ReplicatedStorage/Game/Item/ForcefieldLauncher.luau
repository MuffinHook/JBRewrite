local CurrentCamera = workspace.CurrentCamera
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local ForcefieldConsts = require(ReplicatedStorage.Forcefield.ForcefieldConsts)
local SimulatedPhysicsProjectile = require(ReplicatedStorage.Module.SimulatedPhysicsProjectile)
local ForcefieldService = require(ReplicatedStorage.Forcefield.ForcefieldService)
local DisplayDamage = require(ReplicatedStorage.Game.DisplayDamage)
local R15IKv2 = require(ReplicatedStorage.Module.R15IKv2)
local Joint = require(ReplicatedStorage.Std.Joint)
local Audio = require(ReplicatedStorage.Std.Audio)
local Spring = require(ReplicatedStorage.Std.Spring)
local InventoryItemUtils = require(ReplicatedStorage.Inventory.InventoryItemUtils)
local Maid = require(ReplicatedStorage.Std.Maid)
local Interval = require(ReplicatedStorage.Std.Interval)
local String = require(ReplicatedStorage.Std.String)
local Item = require(script.Parent.Item)
local function RandomVector()
	local randomX = math.random() * 2 - 1
	local randomY = math.random() * 2 - 1
	return Vector3.new(randomX, randomY, math.random() * 2 - 1).Unit
end
local function Ease_OutBack(progress)
	return 1 + (progress - 1) * (progress - 1) * (-1 + progress + 1.70158 * progress)
end
local function Ease_InOutQuad(progress)
	return progress < 0.5 and 2 * progress * progress or -1 - 2 * (progress - 2) * progress
end
local eventSignal = nil
local ForcefieldLauncher = require(ReplicatedStorage.Game.ItemConfig.ForcefieldLauncher)
local InputUtils = require(ReplicatedStorage.Std.InputUtils)
local ForcefieldInstance = {}
ForcefieldInstance.__index = ForcefieldInstance
function ForcefieldInstance.new(isLocalPlayer)
	local forcefieldInstance = setmetatable({}, ForcefieldInstance)
	forcefieldInstance.maid = Maid.new()
	local meshPartClone = ReplicatedStorage.Resource.ForcefieldMesh:Clone()
	meshPartClone.Size = Vector3.new(0, 0, 0)
	forcefieldInstance.MeshPartForcefield = meshPartClone
	local Part = Instance.new("Part")
	Part.Anchored = true
	Part.CanCollide = false
	Part.Color = Color3.fromRGB(255, 0, 255)
	Part.Transparency = 0.7
	Part.Shape = Enum.PartType.Ball
	Part.TopSurface = 0
	Part.BottomSurface = 0
	Part.Size = Vector3.new(0, 0, 0)
	forcefieldInstance.PartShell = Part
	forcefieldInstance.Radius = ForcefieldConsts.RADIUS
	forcefieldInstance.Local = isLocalPlayer
	return forcefieldInstance
end
function ForcefieldInstance.AttemptLaunch(forcefield, targetPosition, projectileSpeed)
	local projectile = SimulatedPhysicsProjectile.new(targetPosition)
	projectile:HitTargetWithSpeed(projectileSpeed, 75, false)
	forcefield.PartShell.Parent = workspace
	local collisionPosition, collisionTime = projectile:CalculateNextInstantCollision(0.03333333333333333)
	if ForcefieldService.getIsPositionAllowed(collisionPosition) then
		local startTime = os.clock()
		local heartbeatConnection = nil
		heartbeatConnection = RunService.Heartbeat:Connect(function()
			local growthProgress = math.min((os.clock() - startTime) * 5, 1)
			local currentPosition, hasCollided = projectile:Update()
			forcefield.PartShell.Size = Vector3.new(growthProgress, growthProgress, growthProgress)
			local shellPosition = currentPosition - Vector3.new(0, forcefield.Radius, 0)
			forcefield.PartShell.CFrame = CFrame.new(shellPosition)
			if collisionTime < projectile:GetElapsed() or hasCollided then
				heartbeatConnection:Disconnect()
				local forcefieldId = String.base85UUID(10)
				local serverTime = workspace:GetServerTimeNow()
				forcefield:Grow(shellPosition, forcefieldId, serverTime)
				eventSignal:FireServer("oy0cfqfm", shellPosition, forcefieldId, serverTime)
			end
		end)
		return true
	else
		return false
	end
end
function ForcefieldInstance.SetSize(forcefield, progress)
	local easedProgress = 1 + (progress - 1) * (progress - 1) * (-1 + progress + 1.70158 * progress)
	local Radius = forcefield.Radius
	local sizeVector = Vector3.new(easedProgress * Radius * 2, easedProgress * Radius * 2, easedProgress * Radius * 2)
	local positionCFrame = CFrame.new(forcefield.Position)
	local rotatedCFrame = positionCFrame * CFrame.Angles(0, (progress < 0.5 and 2 * progress * progress or -1 - 2 * (progress - 2) * progress) * math.pi, 0)
	local finalCFrame = rotatedCFrame + Vector3.new(0, easedProgress * forcefield.Radius, 0)
	forcefield.PartShell.Size = sizeVector * 1.075
	forcefield.PartShell.CFrame = finalCFrame
	forcefield.MeshPartForcefield.Size = sizeVector
	forcefield.MeshPartForcefield.CFrame = finalCFrame
end
function ForcefieldInstance.Grow(forcefield, position, forcefieldId, spawnTime)
	forcefield.Position = position
	forcefield.PartShell.Parent = workspace
	forcefield.MeshPartForcefield.Parent = workspace
	local startTime = os.clock()
	local heartbeatConnection = nil
	heartbeatConnection = RunService.Heartbeat:Connect(function(deltaTime)
		local elapsedTime = (os.clock() - startTime) * 2
		forcefield:SetSize(elapsedTime)
		if elapsedTime > 1 then
			heartbeatConnection:Disconnect()
		end
	end)
	forcefield.maid:GiveTask(heartbeatConnection)
	if ForcefieldService.add(forcefield.Position + Vector3.new(0, forcefield.Radius, 0), forcefield.Radius, forcefieldId) then
		forcefield.ForcefieldId = forcefieldId
		local healthUpdateRemote = ReplicatedStorage.Forcefield:FindFirstChild(ForcefieldConsts.HEALTH_UPDATE_REMOTE_NAME)
		local STARTING_HEALTH = ForcefieldConsts.STARTING_HEALTH
		forcefield.maid:GiveTask(healthUpdateRemote.OnClientEvent:Connect(function(player, fid, health)
			if fid == forcefieldId then
				if Players.LocalPlayer == player or forcefield.Local then
					DisplayDamage.draw(fid, forcefield.PartShell, STARTING_HEALTH - health, {
						isVehicleDamage = true,
						didPopVehicleTires = health <= 0
					})
				end
				STARTING_HEALTH = health
				if health <= 0 then
					local currentTime = workspace:GetServerTimeNow()
					if currentTime - spawnTime >= ForcefieldLauncher.MinShieldDuration then
						forcefield:Shrink()
						return
					end
					forcefield.maid.shrinkTask = task.delay(ForcefieldLauncher.MinShieldDuration - (currentTime - spawnTime), function()
						forcefield:Shrink()
					end)
					health = 0
				end
				local transparency = 0.7 + 0.20000000000000007 * (1 - health / ForcefieldConsts.STARTING_HEALTH)
				local transparencyTween = TweenService:Create(forcefield.PartShell, TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.In, 0, true), {
					Transparency = transparency - 0.3
				})
				forcefield.maid.transparencyHitFlicker = transparencyTween
				forcefield.PartShell.Transparency = transparency
				transparencyTween:Play()
				forcefield.maid.afterTween = task.delay(0.1, function()
					forcefield.PartShell.Transparency = transparency
				end)
			end
		end))
		forcefield.maid:GiveTask(task.delay(ForcefieldLauncher.MaxShieldDuration, function()
			forcefield:Shrink()
		end))
		Audio.ObjectLocal(forcefield.PartShell, 4058366615)
		Audio.ObjectLocal(forcefield.PartShell, 9058693376, {
			Looped = true,
			MaxDistance = 128,
			Volume = 0.2
		})
	else
		forcefield:Destroy()
	end
end
function ForcefieldInstance.Shrink(forcefield)
	if not forcefield.isShrinking then
		forcefield.isShrinking = true
		local startTime = os.clock()
		forcefield.maid:GiveTask(RunService.Heartbeat:Connect(function(deltaTime)
			local elapsedTime = (os.clock() - startTime) * 2
			forcefield:SetSize(1 - elapsedTime)
			if elapsedTime > 1 then
				forcefield:Destroy()
			end
		end))
		assert(ForcefieldService.removeById(forcefield.ForcefieldId))
		forcefield.ForcefieldId = nil
	end
end
function ForcefieldInstance.Destroy(forcefield)
	forcefield.PartShell:Destroy()
	forcefield.PartShell = nil
	forcefield.MeshPartForcefield:Destroy()
	forcefield.MeshPartForcefield = nil
	forcefield.maid:Destroy()
end
local ForcefieldLauncherClass = {
	__ClassName = "ForcefieldLauncher"
}
ForcefieldLauncherClass.__index = ForcefieldLauncherClass
setmetatable(ForcefieldLauncherClass, Item)
function ForcefieldLauncherClass.Init(itemConfig)
	eventSignal = itemConfig.Event
	function itemConfig.em.oy0cfqfm(self, position, forcefieldId, spawnTime)
		assert(self)
		assert(position)
		ForcefieldInstance.new():Grow(position, forcefieldId, spawnTime)
	end
end
function ForcefieldLauncherClass.new(parent, inventoryValue, humanoid)
	local itemInstance = Item.new(parent, humanoid)
	setmetatable(itemInstance, ForcefieldLauncherClass)
	itemInstance.Config = ForcefieldLauncher
	itemInstance.inventoryItemValue = inventoryValue
	if not InventoryItemUtils.getAttr(itemInstance.inventoryItemValue, "LastShoot") then
		InventoryItemUtils.setAttr(itemInstance.inventoryItemValue, "LastShoot", 0)
	end
	if itemInstance.Local then
		itemInstance.SpringCamera = Spring.new(Vector3.new(), Vector3.new(), 0.6, 70)
	end
	itemInstance.IK = R15IKv2.BuildPacketArms(itemInstance.Character)
	itemInstance:SetupModel()
	itemInstance:AttachModelToPlayer()
	itemInstance.Maid:GiveTask(RunService.Stepped:Connect(function()
		itemInstance:Stepped()
	end))
	itemInstance.Maid:GiveTask(RunService.RenderStepped:Connect(function()
		itemInstance:RenderStepped()
	end))
	if itemInstance.Local then
		local nextShootTime = InventoryItemUtils.getAttr(itemInstance.inventoryItemValue, "NextShootPossible") or 0
		local currentTime = os.clock()
		if currentTime < nextShootTime then
			itemInstance:StartReloadProgressCircle(itemInstance.Config.Reload + itemInstance.Config.MaxShieldDuration, os.clock() - (itemInstance.Config.Reload + itemInstance.Config.MaxShieldDuration - (nextShootTime - currentTime)))
		end
		local isReloading = currentTime < nextShootTime
		itemInstance.Maid:GiveTask(Interval.every(0.5):Connect(function()
			local canShoot = (InventoryItemUtils.getAttr(itemInstance.inventoryItemValue, "NextShootPossible") or 0) > os.clock()
			if canShoot ~= isReloading then
				isReloading = canShoot
				if not canShoot then
					Audio.ObjectLocal(itemInstance.Center, 16663715207)
				end
			end
		end))
	end
	return itemInstance
end
function ForcefieldLauncherClass.SetupModel(self)
	local modelName = InventoryItemUtils.getName(self.inventoryItemValue)
	local modelResource = ReplicatedStorage.Resource.ItemSystem.Models:FindFirstChild(modelName)
	if modelResource == nil then
		error(("Could not find model for item `%s`"):format(modelName))
	end
	local modelClone = modelResource:Clone()
	self.Model = modelClone
	local Center = modelClone.Skeleton.Center
	self.Center = Center
	Joint.WeldAllTo(modelClone, Center)
	self.Maid:GiveTask(function()
		self.Model:Destroy()
		self.Model = nil
	end)
end
function ForcefieldLauncherClass.AttachModelToPlayer(self)
	local UpperTorso = self.UpperTorso
	self.Center.CFrame = UpperTorso.CFrame
	local motorJoint = Joint.BlankMotor(self.Center, UpperTorso)
	self.Model.Parent = workspace.Items
	self.Motor = motorJoint
	self.Motor.C1 = CFrame.new(1.2, 0, -1.5)
	self.Maid:GiveTask(function()
		self.Motor:Destroy()
		self.Motor = nil
	end)
end
function ForcefieldLauncherClass.RenderStepped(self)
	if self.Local then
		CurrentCamera.CFrame = CFrame.new(CurrentCamera.CFrame.p, CurrentCamera.CFrame * Vector3.new(0, 0, -2) + self.SpringCamera:Update())
	end
end
function ForcefieldLauncherClass.Stepped(self)
	local IK = self.IK
	IK.RightArm = self.Center.CFrame * Vector3.new(0, 0, 0.2)
	R15IKv2.Arms(IK)
	IK.LeftWrist.Transform = CFrame.new()
	IK.RightWrist.Transform = CFrame.new()
end
function ForcefieldLauncherClass.GetMouseLocation(self)
	if InputUtils.isTouch() then
		local ViewportSize = CurrentCamera.ViewportSize
		return Vector3.new(ViewportSize.X * 0.5, ViewportSize.Y * (self.Config.MobileMouseHeightScalar or 0.5), 0)
	else
		return UserInputService:GetMouseLocation()
	end
end
function ForcefieldLauncherClass.ShootBegin(self)
	local mouseLocation = self:GetMouseLocation()
	local viewportRay = CurrentCamera:ViewportPointToRay(mouseLocation.x, mouseLocation.y)
	local _, hitPart = workspace:FindPartOnRayWithIgnoreList(Ray.new(viewportRay.Origin, viewportRay.Direction * 200), { self.Character, self.Model })
	local currentTime = os.clock()
	if currentTime < (InventoryItemUtils.getAttr(self.inventoryItemValue, "NextShootPossible") or 0) then
		Audio.ObjectLocal(self.Center, 4058365633)
	else
		local Tip = self.Model.Skeleton.Tip
		Audio.ObjectLocal(Tip, 16652902101)
		local randomRecoilX = math.random() * 2 - 1
		local randomRecoilY = math.random() * 2 - 1
		self.SpringCamera:Accelerate(Vector3.new(randomRecoilX, randomRecoilY, math.random() * 2 - 1).Unit * 30)
		local launchSucceeded = ForcefieldInstance.new(self.Local):AttemptLaunch(Tip.Position, hitPart)
		local nextShootTime = currentTime + self.Config.Reload
		if launchSucceeded then
			nextShootTime = nextShootTime + self.Config.MaxShieldDuration
		end
		self:StartReloadProgressCircle(self.Config.Reload + self.Config.MaxShieldDuration, os.clock())
		InventoryItemUtils.setAttr(self.inventoryItemValue, "NextShootPossible", nextShootTime)
	end
end
function ForcefieldLauncherClass.InputBegan(self, input, gameProcessed)
	if if input.UserInputType == Enum.UserInputType.MouseButton1 then true elseif input.UserInputType == Enum.UserInputType.Gamepad1 then input.KeyCode == Enum.KeyCode.ButtonR2 else false then
		self:ShootBegin()
	end
	Item.InputBegan(self, input, gameProcessed)
end
function ForcefieldLauncherClass.InputEnded(self)  end
return ForcefieldLauncherClass
