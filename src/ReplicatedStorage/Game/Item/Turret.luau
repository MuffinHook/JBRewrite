-- Reviewed by Claude
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
	local v1 = math.random() * 2 - 1
	local v2 = math.random() * 2 - 1
	return Vector3.new(v1, v2, math.random() * 2 - 1).Unit
end
local t = {
	__ClassName = "Turret"
}
t.__index = t
setmetatable(t, Gun)
function t.new(p1, p2, p3)
	local v1 = Gun.new(p1, p2)
	setmetatable(v1, t)
	v1.Maid:GiveTask(RxInstanceUtils.observeOneChildNamed(p2, "TurretValue", function(p1, p2)
		p2:GiveTask(RxInstanceUtils.observeProperty(p1, "Value", function(p1, p2)
			v1.Model = p1
			p2:GiveTask(RxInstanceUtils.observeOneChildNamed(p1, "BarrelMotor", function(p1)
				v1.BarrelMotor = p1
			end))
			p2:GiveTask(RxInstanceUtils.observeOneChildNamed(p1, "VerticalMotor", function(p1)
				v1.VerticalMotor = p1
			end))
			p2:GiveTask(RxInstanceUtils.observeOneChildNamed(p1, "HorizontalMotor", function(p1)
				v1.HorizontalMotor = p1
			end))
			p2:GiveTask(RxInstanceUtils.observeOneChildNamed(p1, "Flare", function(p1, p2)
				p2:GiveTask(RxInstanceUtils.observeOneChildNamed(p1, "ParticleEmitter", function(p1)
					v1.FlareEmitter = p1
				end))
			end))
			p2:GiveTask(RxInstanceUtils.observeOneChildNamed(p1, "Tips", function(p1, p2)
				p2:GiveTask(RxInstanceUtils.observeChildren(p1, function()
					v1.Tips = p1:GetChildren()
				end))
			end))
			if v1.Local then
				v1.Maid:GiveTask(RxInstanceUtils.observeOneChildNamed(p1, "UpdateHeatRemote", function(p1)
					v1._updateHeatRemote = p1
				end))
			end
		end))
	end))
	v1:Setup()
	v1:DefaultDisableCamLock()
	return v1
end
function t.Setup(p1)
	p1.IgnoreList = { p1.Character, p1.Model, workspace.Items }
	p1.LastShoot = 0
	p1.LastPlayerImpact = 0
	p1.SpringThirdMousePosition = Spring.new(Vector3.new(), Vector3.new(), 0.9, 30)
	if p1.Local then
		p1.SpringCamera = Spring.new(Vector3.new(), Vector3.new(), 0.6, 75)
	end
	p1.SpringSpin = Spring.new(0, 0, 0.6, 7)
	p1.SpinTotal = 0
	p1.MouseDown = false
	if not p1.Tips then
		p1.Tips = {}
	end
	p1.TipIndex = 1
	p1:SetupBulletEmitter()
	if p1.Local then
		p1:SetupCrossHair()
	end
	p1:SetupShoot()
	p1.IK = R15IKv2.BuildPacketArms(p1.Character)
	p1:UpdateMousePosition()
	p1.Maid:GiveTask(RunService.RenderStepped:Connect(function(p12)
		p1:RenderStepped(p12)
	end))
	p1.Maid:GiveTask(RunService.Stepped:Connect(function()
		p1:Stepped()
	end))
end
t.ApplySkin = false
t.Reload = false
function t.BulletEmitterOnLocalHitPlayer(p1, ...)
	local v1 = tick()
	if v1 - p1.LastPlayerImpact > 0.1 then
		p1.LastPlayerImpact = v1
		Gun.BulletEmitterOnLocalHitPlayer(p1, ...)
	end
end
function t.TransformLocalMousePosition(p1, p2)
	return p1.SpringThirdMousePosition:SetTarget(p2)
end
function t.UpdateArmJoints(p1)
	local IK = p1.IK
	local Model = p1.Model
	IK.RightArm = Model.RightArm.Position
	IK.LeftArm = Model.LeftArm.Position
	R15IKv2.Arms(IK)
end
function t.UpdateCamera(p1)
	local v1 = os.clock()
	local v2 = v1 - (p1._lastCameraUpdate or v1)
	p1._lastCameraUpdate = v1
	local v3 = p1.SpringCamera:Update()
	local v4 = CurrentCamera
	v4.CFrame = v4.CFrame * (CFrame.Angles(0, v3.X * v2 * 60, 0) * CFrame.Angles(v3.Y * v2 * 60, 0, 0))
end
function t.RenderStepped(p1, p2)
	p1:UpdateMousePosition()
	if p1.Local then
		p1:UpdateCrossHair()
		p1:UpdateCamera()
	end
end
function t.Shoot(p1)
	local v1 = p1.Tips[p1.TipIndex]
	p1.Tip = v1
	p1.BulletEmitter:Emit(v1.Position, v1.CFrame.lookVector, p1.Config.BulletSpeed)
	p1.TipIndex = p1.TipIndex % #p1.Tips + 1
	if p1.Local then
		p1.CrossHair.Spring:Accelerate(200)
		local v3 = math.clamp(20 / (p1.Model.Back.Position - CurrentCamera.CFrame.p).Magnitude, 0.1, 1)
		p1.SpringCamera:Accelerate(Vector3.new(math.random() * 2 - 1, math.random() * 2 - 1, math.random() * 2 - 1).Unit * v3 * 0.15 * 15)
	end
end
function t.ShootCheckConditions(p1)
	return true
end
function t.AnimateBarrel(p1, p2, p3)
	if p1.Model then
		local v1 = tick()
		if p1.Sound then
			p1.Sound.Volume = p3
		end
		local MaxHeat = p1.Config.MaxHeat
		local sum = p1.Model:GetAttribute("Heat")
		if p3 >= 0.6 and sum < MaxHeat then
			if not p1.FlareEmitter.Enabled then
				p1.FlareEmitter.Enabled = true
			end
			if 1 / (10 + 30 * p3) < v1 - p1.LastShoot then
				sum = sum + p2
				if MaxHeat <= sum then
					p1:InputEnded({
						UserInputType = Enum.UserInputType.MouseButton1
					})
					sum = sum + 3
				end
				p1.LastShoot = v1
				if p1.Local then
					p1:_attemptShoot()
				end
			end
		else
			if p1.FlareEmitter.Enabled then
				p1.FlareEmitter.Enabled = false
			end
			if sum > 0 then
				sum = sum - p2
			end
			if sum < 0 then
				sum = 0
			end
		end
		p1.Model.Barrel.Color = p1.Config.ColorNormal:Lerp(p1.Config.ColorHeat, math.clamp(sum, 0, MaxHeat) / MaxHeat)
		p1.Model:SetAttribute("Heat", sum)
	end
end
function t.Stepped(p1)
	if p1.Model and (p1.HorizontalMotor and p1.BarrelMotor) then
		if p1.VerticalMotor then
			local v1 = tick()
			local v2 = v1 - (p1.LastUpdate or v1)
			p1.LastUpdate = v1
			local v3 = p1.Model.Root.CFrame:PointToObjectSpace(p1.MousePosition)
			local x = v3.x
			local z = v3.z
			local v4 = z < 0 and math.atan(x / z) or math.pi - math.atan(-x / z)
			local v5 = z * math.cos(v4) + x * math.sin(v4)
			local v6 = v3.y - p1.Model.AxisV.Position.Y + p1.Model.Root.Position.Y
			local v9 = math.clamp(v5 < 0 and math.atan(-v6 / v5) or math.atan(v6 / v5), -0.47123889803846897, 0.6283185307179586)
			local v10 = math.clamp(v9, -0.25132741228718347, 0.3141592653589793)
			p1.JointWaist.Transform = CFrame.Angles(-v10 * 0.1, 0, 0)
			p1.JointNeck.Transform = CFrame.Angles(v10, 0, 0)
			local v11 = p1.SpringSpin:Update()
			local sum = p1.SpinTotal + v2 * v11
			if sum > 6.283185307179586 then
				sum = sum - 6.283185307179586
			end
			p1.SpinTotal = sum
			p1.BarrelMotor.C1 = CFrame.Angles(0, 0, -16 * sum)
			p1.VerticalMotor.C1 = CFrame.Angles(v9, 0, 0)
			p1.HorizontalMotor.C1 = CFrame.Angles(0, (v4 + math.pi) % 6.283185307179586 - math.pi, 0)
			p1:UpdateArmJoints()
			p1:AnimateBarrel(v2, v11)
		end
	end
end
function t.Heartbeat(p1)  end
function t.InputBegan(p1, p2, p3)
	if if p2.UserInputType == Enum.UserInputType.MouseButton1 then true elseif p2.UserInputType == Enum.UserInputType.Gamepad1 then p2.KeyCode == Enum.KeyCode.ButtonR2 else false then
		if p1.Model:GetAttribute("Heat") < p1.Config.MaxHeat then
			p1.SpringSpin:SetTarget(1)
			p1.MouseDown = true
			if not p1.Sound then
				local Sound = Instance.new("Sound")
				Sound.SoundId = "rbxassetid://2198390391"
				Sound.Volume = 0
				Sound.Looped = true
				Sound.Parent = p1.Model.Barrel
				Sound:Play()
				p1.Sound = Sound
			end
		end
		if p1.Local then
			p1:BroadcastInputBegan(p2)
		end
	end
end
function t.InputEnded(p1, p2, p3)
	if if p2.UserInputType == Enum.UserInputType.MouseButton1 then true elseif p2.UserInputType == Enum.UserInputType.Gamepad1 then p2.KeyCode == Enum.KeyCode.ButtonR2 else false then
		p1.SpringSpin:SetTarget(0)
		p1.MouseDown = false
		delay(0.5, function()
			if p1.Sound and not p1.MouseDown then
				p1.Sound:Destroy()
				p1.Sound = nil
			end
		end)
		if p1.Local then
			p1:BroadcastInputEnded(p2)
		end
	end
end
function t.Unequip(p1)
	if p1.FlareEmitter then
		p1.FlareEmitter.Enabled = false
	end
	if p1.Model and p1.Model:FindFirstChild("Barrel") then
		p1.Model.Barrel.Color = p1.Config.ColorNormal
	end
	if p1.HorizontalMotor then
		p1.HorizontalMotor.C1 = CFrame.new()
	end
	if p1.VerticalMotor then
		p1.VerticalMotor.C1 = CFrame.new()
	end
	if p1.BarrelMotor then
		p1.BarrelMotor.C1 = CFrame.new()
	end
	p1.SpinTotal = 0
	if p1.Local and p1._updateHeatRemote then
		p1._updateHeatRemote:FireServer(p1.Model:GetAttribute("Heat"))
	end
	if p1.Sound then
		p1.Sound:Destroy()
		p1.Sound = nil
	end
end
return t
