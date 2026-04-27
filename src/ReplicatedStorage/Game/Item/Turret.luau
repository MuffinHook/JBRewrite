local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
require(ReplicatedStorage.Std.Audio)
local R15IKv2 = require(ReplicatedStorage.Module.R15IKv2)
local Spring = require(ReplicatedStorage.Std.Spring)
local RxInstanceUtils = require(ReplicatedStorage.Std.RxInstanceUtils)
require(ReplicatedStorage.Inventory.InventoryItemUtils)
local CurrentCamera = workspace.CurrentCamera
local Gun = require(script.Parent.Gun)
local function RandomVector()
	local randomX = math.random() * 2 - 1
	local randomY = math.random() * 2 - 1
	return Vector3.new(randomX, randomY, math.random() * 2 - 1).Unit
end
local TurretClass = {
	__ClassName = "Turret"
}
TurretClass.__index = TurretClass
setmetatable(TurretClass, Gun)
function TurretClass.new(baseGun, parentContainer, p3)
	local turret = Gun.new(baseGun, parentContainer)
	setmetatable(turret, TurretClass)
	turret.Maid:GiveTask(RxInstanceUtils.observeOneChildNamed(parentContainer, "TurretValue", function(turretValueInstance, maid)
		maid:GiveTask(RxInstanceUtils.observeProperty(turretValueInstance, "Value", function(modelInstance, maid)
			turret.Model = modelInstance
			maid:GiveTask(RxInstanceUtils.observeOneChildNamed(modelInstance, "BarrelMotor", function(barrelMotor)
				turret.BarrelMotor = barrelMotor
			end))
			maid:GiveTask(RxInstanceUtils.observeOneChildNamed(modelInstance, "VerticalMotor", function(verticalMotor)
				turret.VerticalMotor = verticalMotor
			end))
			maid:GiveTask(RxInstanceUtils.observeOneChildNamed(modelInstance, "HorizontalMotor", function(horizontalMotor)
				turret.HorizontalMotor = horizontalMotor
			end))
			maid:GiveTask(RxInstanceUtils.observeOneChildNamed(modelInstance, "Flare", function(flareInstance, maid)
				maid:GiveTask(RxInstanceUtils.observeOneChildNamed(flareInstance, "ParticleEmitter", function(emitter)
					turret.FlareEmitter = emitter
				end))
			end))
			maid:GiveTask(RxInstanceUtils.observeOneChildNamed(modelInstance, "Tips", function(tipsContainer, maid)
				maid:GiveTask(RxInstanceUtils.observeChildren(tipsContainer, function()
					turret.Tips = tipsContainer:GetChildren()
				end))
			end))
			if turret.Local then
				turret.Maid:GiveTask(RxInstanceUtils.observeOneChildNamed(modelInstance, "UpdateHeatRemote", function(heatRemote)
					turret._updateHeatRemote = heatRemote
				end))
			end
		end))
	end))
	turret:Setup()
	turret:DefaultDisableCamLock()
	return turret
end
function TurretClass.Setup(turret)
	turret.IgnoreList = { turret.Character, turret.Model, workspace.Items }
	turret.LastShoot = 0
	turret.LastPlayerImpact = 0
	turret.SpringThirdMousePosition = Spring.new(Vector3.new(), Vector3.new(), 0.9, 30)
	if turret.Local then
		turret.SpringCamera = Spring.new(Vector3.new(), Vector3.new(), 0.6, 75)
	end
	turret.SpringSpin = Spring.new(0, 0, 0.6, 7)
	turret.SpinTotal = 0
	turret.MouseDown = false
	if not turret.Tips then
		turret.Tips = {}
	end
	turret.TipIndex = 1
	turret:SetupBulletEmitter()
	if turret.Local then
		turret:SetupCrossHair()
	end
	turret:SetupShoot()
	turret.IK = R15IKv2.BuildPacketArms(turret.Character)
	turret:UpdateMousePosition()
	turret.Maid:GiveTask(RunService.RenderStepped:Connect(function(deltaTime)
		turret:RenderStepped(deltaTime)
	end))
	turret.Maid:GiveTask(RunService.Stepped:Connect(function()
		turret:Stepped()
	end))
end
TurretClass.ApplySkin = false
TurretClass.Reload = false
function TurretClass.BulletEmitterOnLocalHitPlayer(turret, ...)
	local currentTime = tick()
	if currentTime - turret.LastPlayerImpact > 0.1 then
		turret.LastPlayerImpact = currentTime
		Gun.BulletEmitterOnLocalHitPlayer(turret, ...)
	end
end
function TurretClass.TransformLocalMousePosition(turret, targetPosition)
	return turret.SpringThirdMousePosition:SetTarget(targetPosition)
end
function TurretClass.UpdateArmJoints(turret)
	local IK = turret.IK
	local Model = turret.Model
	IK.RightArm = Model.RightArm.Position
	IK.LeftArm = Model.LeftArm.Position
	R15IKv2.Arms(IK)
end
function TurretClass.UpdateCamera(turret)
	local currentTime = os.clock()
	local deltaTime = currentTime - (turret._lastCameraUpdate or currentTime)
	turret._lastCameraUpdate = currentTime
	local cameraSpringUpdate = turret.SpringCamera:Update()
	local camera = CurrentCamera
	camera.CFrame = camera.CFrame * (CFrame.Angles(0, cameraSpringUpdate.X * deltaTime * 60, 0) * CFrame.Angles(cameraSpringUpdate.Y * deltaTime * 60, 0, 0))
end
function TurretClass.RenderStepped(turret, deltaTime)
	turret:UpdateMousePosition()
	if turret.Local then
		turret:UpdateCrossHair()
		turret:UpdateCamera()
	end
end
function TurretClass.Shoot(turret)
	local currentTip = turret.Tips[turret.TipIndex]
	turret.Tip = currentTip
	turret.BulletEmitter:Emit(currentTip.Position, currentTip.CFrame.lookVector, turret.Config.BulletSpeed)
	turret.TipIndex = turret.TipIndex % #turret.Tips + 1
	if turret.Local then
		turret.CrossHair.Spring:Accelerate(200)
		local recoilDampening = math.clamp(20 / (turret.Model.Back.Position - CurrentCamera.CFrame.p).Magnitude, 0.1, 1)
		turret.SpringCamera:Accelerate(Vector3.new(math.random() * 2 - 1, math.random() * 2 - 1, math.random() * 2 - 1).Unit * recoilDampening * 0.15 * 15)
	end
end
function TurretClass.ShootCheckConditions(turret)
	return true
end
function TurretClass.AnimateBarrel(turret, heatIncrement, volumeMultiplier)
	if turret.Model then
		local currentTime = tick()
		if turret.Sound then
			turret.Sound.Volume = volumeMultiplier
		end
		local MaxHeat = turret.Config.MaxHeat
		local currentHeat = turret.Model:GetAttribute("Heat")
		if volumeMultiplier >= 0.6 and currentHeat < MaxHeat then
			if not turret.FlareEmitter.Enabled then
				turret.FlareEmitter.Enabled = true
			end
			if 1 / (10 + 30 * volumeMultiplier) < currentTime - turret.LastShoot then
				currentHeat = currentHeat + heatIncrement
				if MaxHeat <= currentHeat then
					turret:InputEnded({
						UserInputType = Enum.UserInputType.MouseButton1
					})
					currentHeat = currentHeat + 3
				end
				turret.LastShoot = currentTime
				if turret.Local then
					turret:_attemptShoot()
				end
			end
		else
			if turret.FlareEmitter.Enabled then
				turret.FlareEmitter.Enabled = false
			end
			if currentHeat > 0 then
				currentHeat = currentHeat - heatIncrement
			end
			if currentHeat < 0 then
				currentHeat = 0
			end
		end
		turret.Model.Barrel.Color = turret.Config.ColorNormal:Lerp(turret.Config.ColorHeat, math.clamp(currentHeat, 0, MaxHeat) / MaxHeat)
		turret.Model:SetAttribute("Heat", currentHeat)
	end
end
function TurretClass.Stepped(turret)
	if turret.Model and (turret.HorizontalMotor and turret.BarrelMotor) then
		if turret.VerticalMotor then
			local currentTime = tick()
			local deltaTime = currentTime - (turret.LastUpdate or currentTime)
			turret.LastUpdate = currentTime
			local relativeMousePosition = turret.Model.Root.CFrame:PointToObjectSpace(turret.MousePosition)
			local x = relativeMousePosition.x
			local z = relativeMousePosition.z
			local horizontalAngle = z < 0 and math.atan(x / z) or math.pi - math.atan(-x / z)
			local horizontalDistance = z * math.cos(horizontalAngle) + x * math.sin(horizontalAngle)
			local verticalOffset = relativeMousePosition.y - turret.Model.AxisV.Position.Y + turret.Model.Root.Position.Y
			local verticalAngleRaw = math.clamp(horizontalDistance < 0 and math.atan(-verticalOffset / horizontalDistance) or math.atan(verticalOffset / horizontalDistance), -0.47123889803846897, 0.6283185307179586)
			local verticalAngleClamped = math.clamp(verticalAngleRaw, -0.25132741228718347, 0.3141592653589793)
			turret.JointWaist.Transform = CFrame.Angles(-verticalAngleClamped * 0.1, 0, 0)
			turret.JointNeck.Transform = CFrame.Angles(verticalAngleRaw, 0, 0)
			local spinSpeed = turret.SpringSpin:Update()
			local totalSpin = turret.SpinTotal + deltaTime * spinSpeed
			if totalSpin > math.tau then
				totalSpin = totalSpin - math.tau
			end
			turret.SpinTotal = totalSpin
			turret.BarrelMotor.C1 = CFrame.Angles(0, 0, -16 * totalSpin)
			turret.VerticalMotor.C1 = CFrame.Angles(verticalAngleRaw, 0, 0)
			turret.HorizontalMotor.C1 = CFrame.Angles(0, (horizontalAngle + math.pi) % math.tau - math.pi, 0)
			turret:UpdateArmJoints()
			turret:AnimateBarrel(deltaTime, spinSpeed)
		end
	end
end
function TurretClass.Heartbeat(turret)  end
function TurretClass.InputBegan(turret, inputData, p3)
	if if inputData.UserInputType == Enum.UserInputType.MouseButton1 then true elseif inputData.UserInputType == Enum.UserInputType.Gamepad1 then inputData.KeyCode == Enum.KeyCode.ButtonR2 else false then
		if turret.Model:GetAttribute("Heat") < turret.Config.MaxHeat then
			turret.SpringSpin:SetTarget(1)
			turret.MouseDown = true
			if not turret.Sound then
				local Sound = Instance.new("Sound")
				Sound.SoundId = "rbxassetid://2198390391"
				Sound.Volume = 0
				Sound.Looped = true
				Sound.Parent = turret.Model.Barrel
				Sound:Play()
				turret.Sound = Sound
			end
		end
		if turret.Local then
			turret:BroadcastInputBegan(inputData)
		end
	end
end
function TurretClass.InputEnded(turret, inputData, p3)
	if if inputData.UserInputType == Enum.UserInputType.MouseButton1 then true elseif inputData.UserInputType == Enum.UserInputType.Gamepad1 then inputData.KeyCode == Enum.KeyCode.ButtonR2 else false then
		turret.SpringSpin:SetTarget(0)
		turret.MouseDown = false
		delay(0.5, function()
			if turret.Sound and not turret.MouseDown then
				turret.Sound:Destroy()
				turret.Sound = nil
			end
		end)
		if turret.Local then
			turret:BroadcastInputEnded(inputData)
		end
	end
end
function TurretClass.Unequip(turret)
	if turret.FlareEmitter then
		turret.FlareEmitter.Enabled = false
	end
	if turret.Model and turret.Model:FindFirstChild("Barrel") then
		turret.Model.Barrel.Color = turret.Config.ColorNormal
	end
	if turret.HorizontalMotor then
		turret.HorizontalMotor.C1 = CFrame.new()
	end
	if turret.VerticalMotor then
		turret.VerticalMotor.C1 = CFrame.new()
	end
	if turret.BarrelMotor then
		turret.BarrelMotor.C1 = CFrame.new()
	end
	turret.SpinTotal = 0
	if turret.Local and turret._updateHeatRemote then
		turret._updateHeatRemote:FireServer(turret.Model:GetAttribute("Heat"))
	end
	if turret.Sound then
		turret.Sound:Destroy()
		turret.Sound = nil
	end
end
return TurretClass
