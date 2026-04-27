local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
require(ReplicatedStorage.Std.Audio)
require(ReplicatedStorage.Module.R15IKv2)
local Spring = require(ReplicatedStorage.Std.Spring)
local RxInstanceUtils = require(ReplicatedStorage.Std.RxInstanceUtils)
require(ReplicatedStorage.Inventory.InventoryItemUtils)
local TableUtils = require(ReplicatedStorage.Std.TableUtils)
local CurrentCamera = workspace.CurrentCamera
local Gun = require(script.Parent.Gun)
local function RandomVector()
	local randomX = math.random() * 2 - 1
	local randomY = math.random() * 2 - 1
	return Vector3.new(randomX, randomY, math.random() * 2 - 1).Unit
end
local CarTurret = {
	__ClassName = "CarTurret"
}
CarTurret.__index = CarTurret
setmetatable(CarTurret, Gun)
function CarTurret.new(gunInstance, vehicleModel, p3)
	local turretInstance = Gun.new(gunInstance, vehicleModel)
	setmetatable(turretInstance, CarTurret)
	turretInstance.Maid:GiveTask(RxInstanceUtils.observeOneChildNamed(vehicleModel, "VehicleModel", function(modelChild, maid)
		if modelChild then
			maid:GiveTask(RxInstanceUtils.observeProperty(modelChild, "Value", function(model, maid)
				turretInstance.Model = model
				if model then
					turretInstance:_getTips()
					if turretInstance.Local then
						maid:GiveTask(RxInstanceUtils.observeOneChildNamed(model, "UpdateHeatRemote", function(remote)
							turretInstance._updateHeatRemote = remote
						end))
					end
				end
			end))
		end
	end))
	turretInstance.ShootActionButtonConfig = {
		primary = false,
		saturateTo = 100,
		priority = 500,
		keyCodes = { Enum.KeyCode.DPadDown }
	}
	turretInstance:Setup()
	turretInstance:DefaultDisableCamLock()
	return turretInstance
end
function CarTurret._getTips(self)
	if self.Model then
		local Model = self.Model:FindFirstChild("Model")
		if Model then
			local TurretTips = Model:FindFirstChild("TurretTips")
			if TurretTips then
				self.Tips = TableUtils.filter(TurretTips:GetChildren(), function(attachment)
					return attachment:IsA("Attachment")
				end)
			end
		end
	end
end
function CarTurret._updateIgnoreList(self)
	self.IgnoreList = { self.Character, self.Model, workspace.Items }
	if self.BulletEmitter then
		self.BulletEmitter.IgnoreList = self.IgnoreList
	end
end
function CarTurret.Setup(self)
	self:_updateIgnoreList()
	self.LastShoot = 0
	self.LastPlayerImpact = 0
	self.SpringThirdMousePosition = Spring.new(Vector3.new(), Vector3.new(), 0.9, 30)
	if self.Local then
		self.SpringCamera = Spring.new(Vector3.new(), Vector3.new(), 0.6, 300)
	end
	self.SpringSpin = Spring.new(0, 0, 0.6, 7)
	self.SpinTotal = 0
	self.MouseDown = false
	if not self.Tips then
		self.Tips = {}
	end
	self.TipIndex = 1
	self:SetupBulletEmitter()
	self:SetupShoot()
	self:UpdateMousePosition()
	self.Maid:GiveTask(RunService.RenderStepped:Connect(function()
		self:RenderStepped()
	end))
	self.Maid:GiveTask(RunService.Stepped:Connect(function()
		self:Stepped()
	end))
end
function CarTurret.BulletEmitterOnLocalHitPlayer(self, ...)
	local currentTime = tick()
	if currentTime - self.LastPlayerImpact > 0.1 then
		self.LastPlayerImpact = currentTime
		Gun.BulletEmitterOnLocalHitPlayer(self, ...)
	end
end
CarTurret.Reload = false
function CarTurret.TransformLocalMousePosition(self, targetPosition)
	return self.SpringThirdMousePosition:SetTarget(targetPosition)
end
function CarTurret.UpdateArmJoints(self) end
function CarTurret.UpdateCamera(self)
	local springOffset = self.SpringCamera:Update()
	local camera = CurrentCamera
	camera.CFrame = camera.CFrame * CFrame.new(springOffset.x * 4, springOffset.y * 4, 0)
end
function CarTurret.RenderStepped(self)
	self:UpdateMousePosition()
	if self.Local then
		self:UpdateCamera()
	end
end
function CarTurret.Shoot(self)
	self:_updateIgnoreList()
	local currentTip = self.Tips[self.TipIndex]
	if currentTip then
		self.Tip = currentTip
		self.BulletEmitter:Emit(currentTip.WorldPosition, currentTip.WorldCFrame.LookVector, self.Config.BulletSpeed)
		self.TipIndex = self.TipIndex % #self.Tips + 1
		if self.Local then
			local recoilStrength = math.clamp(20 / (self.Model.PrimaryPart.Position - CurrentCamera.CFrame.p).Magnitude, 0.1, 1)
			self.SpringCamera:Accelerate(Vector3.new(math.random() * 2 - 1, math.random() * 2 - 1, math.random() * 2 - 1).Unit * recoilStrength * 50)
		end
	else
		self:_getTips()
	end
end
function CarTurret.ShootCheckConditions(self)
	return true
end
function CarTurret.AnimateBarrel(self, deltaTime, throttle)
	if self.Model then
		local currentTime = tick()
		if self.Sound then
			self.Sound.Volume = throttle * 0.5
		end
		local MaxHeat = self.Config.MaxHeat
		local heat = self.Model:GetAttribute("Heat")
		if throttle >= 0.6 and heat < MaxHeat then
			if 1 / (10 + 30 * throttle) < currentTime - self.LastShoot then
				heat = heat + deltaTime
				if MaxHeat <= heat then
					self:InputEnded({
						UserInputType = Enum.UserInputType.MouseButton1
					})
					heat = heat + 3
				end
				self.LastShoot = currentTime
				if self.Local then
					self:_attemptShoot()
				end
			end
		else
			if heat > 0 then
				heat = heat - deltaTime
			end
			if heat < 0 then
				heat = 0
			end
		end
		local heatPercent = math.clamp(heat, 0, MaxHeat) / MaxHeat
		if self.Model:FindFirstChild("Model") and self.Model.Model:FindFirstChild("Turret") then
			self.Model.Model.Turret.Color = self.Config.ColorNormal:Lerp(self.Config.ColorHeat, heatPercent)
		end
		self.Model:SetAttribute("Heat", heat)
	end
end
function CarTurret.Stepped(self)
	if self.Model then
		local currentTime = tick()
		local deltaTime = currentTime - (self.LastUpdate or currentTime)
		self.LastUpdate = currentTime
		local spinVelocity = self.SpringSpin:Update()
		local newSpinTotal = self.SpinTotal + deltaTime * spinVelocity
		if newSpinTotal > 6.283185307179586 then
			newSpinTotal = newSpinTotal - 6.283185307179586
		end
		self.SpinTotal = newSpinTotal
		self:AnimateBarrel(deltaTime, spinVelocity)
	end
end
CarTurret.ApplySkin = false
CarTurret.ScopeBegin = false
function CarTurret.Heartbeat(self) end
function CarTurret.InputBegan(self, inputObject, gameProcessed)
	if gameProcessed then
		return false
	end
	if inputObject.UserInputType == Enum.UserInputType.MouseButton1 then
		if self.Model:GetAttribute("Heat") < self.Config.MaxHeat then
			self.SpringSpin:SetTarget(1)
			self.MouseDown = true
			if not self.Sound then
				local Sound = Instance.new("Sound")
				Sound.SoundId = "rbxassetid://2198390391"
				Sound.Volume = 0
				Sound.Looped = true
				Sound.Parent = self.Model.PrimaryPart
				Sound:Play()
				self.Sound = Sound
			end
		end
		if self.Local then
			self:BroadcastInputBegan(inputObject)
		end
	end
end
function CarTurret.InputEnded(self, inputObject, gameProcessed)
	if gameProcessed then
		return false
	end
	if inputObject.UserInputType == Enum.UserInputType.MouseButton1 then
		self.SpringSpin:SetTarget(0)
		self.MouseDown = false
		delay(0.5, function()
			if self.Sound and not self.MouseDown then
				self.Sound:Destroy()
				self.Sound = nil
			end
		end)
		if self.Local then
			self:BroadcastInputEnded(inputObject)
		end
	end
end
function CarTurret.Unequip(self)
	if self.Local and self._updateHeatRemote then
		self._updateHeatRemote:FireServer(self.Model:GetAttribute("Heat"))
	end
	if self.Model:FindFirstChild("Model") and self.Model.Model:FindFirstChild("Turret") then
		self.Model.Model.Turret.Color = self.Config.ColorNormal
	end
	if self.Sound then
		self.Sound:Destroy()
		self.Sound = nil
	end
end
return CarTurret
