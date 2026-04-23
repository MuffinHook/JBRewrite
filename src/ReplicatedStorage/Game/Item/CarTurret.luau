-- Reviewed by Claude
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
	local v1 = math.random() * 2 - 1
	local v2 = math.random() * 2 - 1
	return Vector3.new(v1, v2, math.random() * 2 - 1).Unit
end
local t = {
	__ClassName = "CarTurret"
}
t.__index = t
setmetatable(t, Gun)
function t.new(p1, p2, p3)
	local v1 = Gun.new(p1, p2)
	setmetatable(v1, t)
	v1.Maid:GiveTask(RxInstanceUtils.observeOneChildNamed(p2, "VehicleModel", function(p1, p2)
		if p1 then
			p2:GiveTask(RxInstanceUtils.observeProperty(p1, "Value", function(p1, p2)
				v1.Model = p1
				if p1 then
					v1:_getTips()
					if v1.Local then
						p2:GiveTask(RxInstanceUtils.observeOneChildNamed(p1, "UpdateHeatRemote", function(p1)
							v1._updateHeatRemote = p1
						end))
					end
				end
			end))
		end
	end))
	v1.ShootActionButtonConfig = {
		primary = false,
		saturateTo = 100,
		priority = 500,
		keyCodes = { Enum.KeyCode.DPadDown }
	}
	v1:Setup()
	v1:DefaultDisableCamLock()
	return v1
end
function t._getTips(p1)
	if p1.Model then
		local Model = p1.Model:FindFirstChild("Model")
		if Model then
			local TurretTips = Model:FindFirstChild("TurretTips")
			if TurretTips then
				p1.Tips = TableUtils.filter(TurretTips:GetChildren(), function(p1)
					return p1:IsA("Attachment")
				end)
			end
		end
	end
end
function t._updateIgnoreList(p1)
	p1.IgnoreList = { p1.Character, p1.Model, workspace.Items }
	if p1.BulletEmitter then
		p1.BulletEmitter.IgnoreList = p1.IgnoreList
	end
end
function t.Setup(p1)
	p1:_updateIgnoreList()
	p1.LastShoot = 0
	p1.LastPlayerImpact = 0
	p1.SpringThirdMousePosition = Spring.new(Vector3.new(), Vector3.new(), 0.9, 30)
	if p1.Local then
		p1.SpringCamera = Spring.new(Vector3.new(), Vector3.new(), 0.6, 300)
	end
	p1.SpringSpin = Spring.new(0, 0, 0.6, 7)
	p1.SpinTotal = 0
	p1.MouseDown = false
	if not p1.Tips then
		p1.Tips = {}
	end
	p1.TipIndex = 1
	p1:SetupBulletEmitter()
	p1:SetupShoot()
	p1:UpdateMousePosition()
	p1.Maid:GiveTask(RunService.RenderStepped:Connect(function()
		p1:RenderStepped()
	end))
	p1.Maid:GiveTask(RunService.Stepped:Connect(function()
		p1:Stepped()
	end))
end
function t.BulletEmitterOnLocalHitPlayer(p1, ...)
	local v1 = tick()
	if v1 - p1.LastPlayerImpact > 0.1 then
		p1.LastPlayerImpact = v1
		Gun.BulletEmitterOnLocalHitPlayer(p1, ...)
	end
end
t.Reload = false
function t.TransformLocalMousePosition(p1, p2)
	return p1.SpringThirdMousePosition:SetTarget(p2)
end
function t.UpdateArmJoints(p1) end
function t.UpdateCamera(p1)
	local v1 = p1.SpringCamera:Update()
	local v2 = CurrentCamera
	v2.CFrame = v2.CFrame * CFrame.new(v1.x * 4, v1.y * 4, 0)
end
function t.RenderStepped(p1)
	p1:UpdateMousePosition()
	if p1.Local then
		p1:UpdateCamera()
	end
end
function t.Shoot(p1)
	p1:_updateIgnoreList()
	local v1 = p1.Tips[p1.TipIndex]
	if v1 then
		p1.Tip = v1
		p1.BulletEmitter:Emit(v1.WorldPosition, v1.WorldCFrame.LookVector, p1.Config.BulletSpeed)
		p1.TipIndex = p1.TipIndex % #p1.Tips + 1
		if p1.Local then
			local v3 = math.clamp(20 / (p1.Model.PrimaryPart.Position - CurrentCamera.CFrame.p).Magnitude, 0.1, 1)
			p1.SpringCamera:Accelerate(Vector3.new(math.random() * 2 - 1, math.random() * 2 - 1, math.random() * 2 - 1).Unit * v3 * 50)
		end
	else
		p1:_getTips()
	end
end
function t.ShootCheckConditions(p1)
	return true
end
function t.AnimateBarrel(p1, p2, p3)
	if p1.Model then
		local v1 = tick()
		if p1.Sound then
			p1.Sound.Volume = p3 * 0.5
		end
		local MaxHeat = p1.Config.MaxHeat
		local sum = p1.Model:GetAttribute("Heat")
		if p3 >= 0.6 and sum < MaxHeat then
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
			if sum > 0 then
				sum = sum - p2
			end
			if sum < 0 then
				sum = 0
			end
		end
		local v2 = math.clamp(sum, 0, MaxHeat) / MaxHeat
		if p1.Model:FindFirstChild("Model") and p1.Model.Model:FindFirstChild("Turret") then
			p1.Model.Model.Turret.Color = p1.Config.ColorNormal:Lerp(p1.Config.ColorHeat, v2)
		end
		p1.Model:SetAttribute("Heat", sum)
	end
end
function t.Stepped(p1)
	if p1.Model then
		local v1 = tick()
		local v2 = v1 - (p1.LastUpdate or v1)
		p1.LastUpdate = v1
		local v3 = p1.SpringSpin:Update()
		local sum = p1.SpinTotal + v2 * v3
		if sum > 6.283185307179586 then
			sum = sum - 6.283185307179586
		end
		p1.SpinTotal = sum
		p1:AnimateBarrel(v2, v3)
	end
end
t.ApplySkin = false
t.ScopeBegin = false
function t.Heartbeat(p1) end
function t.InputBegan(p1, p2, p3)
	if p3 then
		return false
	end
	if p2.UserInputType == Enum.UserInputType.MouseButton1 then
		if p1.Model:GetAttribute("Heat") < p1.Config.MaxHeat then
			p1.SpringSpin:SetTarget(1)
			p1.MouseDown = true
			if not p1.Sound then
				local Sound = Instance.new("Sound")
				Sound.SoundId = "rbxassetid://2198390391"
				Sound.Volume = 0
				Sound.Looped = true
				Sound.Parent = p1.Model.PrimaryPart
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
	if p3 then
		return false
	end
	if p2.UserInputType == Enum.UserInputType.MouseButton1 then
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
	if p1.Local and p1._updateHeatRemote then
		p1._updateHeatRemote:FireServer(p1.Model:GetAttribute("Heat"))
	end
	if p1.Model:FindFirstChild("Model") and p1.Model.Model:FindFirstChild("Turret") then
		p1.Model.Model.Turret.Color = p1.Config.ColorNormal
	end
	if p1.Sound then
		p1.Sound:Destroy()
		p1.Sound = nil
	end
end
return t