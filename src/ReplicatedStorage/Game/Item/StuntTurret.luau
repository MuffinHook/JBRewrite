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
local StuntTurretClass = {
	__ClassName = "StuntTurret"
}
StuntTurretClass.__index = StuntTurretClass
setmetatable(StuntTurretClass, Gun)
function StuntTurretClass.new(baseGun, modelParent, p3)
	local newInstance = Gun.new(baseGun, modelParent)
	setmetatable(newInstance, StuntTurretClass)
	newInstance.Maid:GiveTask(RxInstanceUtils.observeOneChildNamed(modelParent, "PlaneModel", function(planeModel, observerMaid)
		if planeModel then
			observerMaid:GiveTask(RxInstanceUtils.observeProperty(planeModel, "Value", function(modelValue, valueMaid)
				newInstance.Model = modelValue
				if modelValue then
					newInstance:_getTips()
					if newInstance.Local then
						valueMaid:GiveTask(RxInstanceUtils.observeOneChildNamed(modelValue, "UpdateHeatRemote", function(heatRemote)
							newInstance._updateHeatRemote = heatRemote
						end))
					end
				end
			end))
		end
	end))
	newInstance.ShootActionButtonConfig = {
		primary = false,
		saturateTo = 100,
		priority = 500
	}
	newInstance:Setup()
	newInstance:DefaultDisableCamLock()
	return newInstance
end
function StuntTurretClass._getTips(self)
	if self.Model then
		local Model = self.Model:FindFirstChild("Model")
		if Model then
			local BlackChrome = Model:FindFirstChild("BlackChrome")
			if BlackChrome then
				self.Tips = TableUtils.filter(BlackChrome:GetChildren(), function(child)
					return child.Name == "MachineGun"
				end)
			end
		end
	end
end
function StuntTurretClass._updateIgnoreList(self)
	self.IgnoreList = { self.Character, self.Model, workspace.Items }
	if self.BulletEmitter then
		self.BulletEmitter.IgnoreList = self.IgnoreList
	end
end
function StuntTurretClass.Setup(self)
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
function StuntTurretClass.BulletEmitterOnLocalHitPlayer(self, ...)
	local currentTime = tick()
	if currentTime - self.LastPlayerImpact > 0.1 then
		self.LastPlayerImpact = currentTime
		Gun.BulletEmitterOnLocalHitPlayer(self, ...)
	end
end
StuntTurretClass.Reload = false
function StuntTurretClass.TransformLocalMousePosition(self, targetPosition)
	return self.SpringThirdMousePosition:SetTarget(targetPosition)
end
function StuntTurretClass.UpdateArmJoints(self)  end
function StuntTurretClass.UpdateCamera(self)
	local cameraOffset = self.SpringCamera:Update()
	local currentCam = CurrentCamera
	currentCam.CFrame = currentCam.CFrame * CFrame.new(cameraOffset.x * 1, cameraOffset.y * 1, 0)
end
function StuntTurretClass.RenderStepped(self)
	self:UpdateMousePosition()
	if self.Local then
		self:UpdateCamera()
	end
end
function StuntTurretClass.Shoot(self)
	self:_updateIgnoreList()
	local currentTip = self.Tips[self.TipIndex]
	if currentTip then
		self.Tip = currentTip
		self.BulletEmitter:Emit(currentTip.WorldPosition, currentTip.WorldCFrame.LookVector, self.Config.BulletSpeed)
		self.TipIndex = self.TipIndex % #self.Tips + 1
		if self.Local then
			local recoilMagnitude = math.clamp(20 / (self.Model.PrimaryPart.Position - CurrentCamera.CFrame.p).Magnitude, 0.1, 1)
			self.SpringCamera:Accelerate(Vector3.new(math.random() * 2 - 1, math.random() * 2 - 1, math.random() * 2 - 1).Unit * recoilMagnitude * 5)
		end
	else
		self:_getTips()
	end
end
function StuntTurretClass.ShootCheckConditions(self)
	return true
end
function StuntTurretClass.AnimateBarrel(self, heatIncrement, spinSpeed)
	if self.Model then
		local currentTime = tick()
		if self.Sound then
			self.Sound.Volume = spinSpeed * 0.5
		end
		local MaxHeat = self.Config.MaxHeat
		local sum = self.Model:GetAttribute("Heat")
		if spinSpeed >= 0.6 and sum < MaxHeat then
			if 1 / (10 + 30 * spinSpeed) < currentTime - self.LastShoot then
				sum = sum + heatIncrement
				if MaxHeat <= sum then
					self:InputEnded({
						UserInputType = Enum.UserInputType.MouseButton1
					})
					sum = sum + 3
				end
				self.LastShoot = currentTime
				if self.Local then
					self:_attemptShoot()
				end
			end
		else
			if sum > 0 then
				sum = sum - heatIncrement
			end
			if sum < 0 then
				sum = 0
			end
		end
		local _ = math.clamp(sum, 0, MaxHeat) / MaxHeat
		self.Model:SetAttribute("Heat", sum)
	end
end
function StuntTurretClass.Stepped(self)
	if self.Model then
		local currentTime = tick()
		local deltaTime = currentTime - (self.LastUpdate or currentTime)
		self.LastUpdate = currentTime
		local spinSpeed = self.SpringSpin:Update()
		local sum = self.SpinTotal + deltaTime * spinSpeed
		if sum > 6.283185307179586 then
			sum = sum - 6.283185307179586
		end
		self.SpinTotal = sum
		self:AnimateBarrel(deltaTime, spinSpeed)
	end
end
StuntTurretClass.ApplySkin = false
StuntTurretClass.ScopeBegin = false
function StuntTurretClass.Heartbeat(self)  end
function StuntTurretClass.InputBegan(self, inputObject, isGameProcessed)
	if isGameProcessed then
		return false
	end
	if if inputObject.UserInputType == Enum.UserInputType.MouseButton1 then true elseif inputObject.UserInputType == Enum.UserInputType.Gamepad1 then inputObject.KeyCode == Enum.KeyCode.ButtonX else false then
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
function StuntTurretClass.InputEnded(self, inputObject, isGameProcessed)
	if isGameProcessed then
		return false
	end
	if if inputObject.UserInputType == Enum.UserInputType.MouseButton1 then true elseif inputObject.UserInputType == Enum.UserInputType.Gamepad1 then inputObject.KeyCode == Enum.KeyCode.ButtonX else false then
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
function StuntTurretClass.Unequip(self)
	if self.Local and self._updateHeatRemote then
		self._updateHeatRemote:FireServer(self.Model:GetAttribute("Heat"))
	end
	if self.Sound then
		self.Sound:Destroy()
		self.Sound = nil
	end
end
return StuntTurretClass
