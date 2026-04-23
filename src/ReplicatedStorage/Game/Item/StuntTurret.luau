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
local function RandomVector() --[[ Line: 14 ]]
	local v1 = math.random() * 2 - 1
	local v2 = math.random() * 2 - 1
	return Vector3.new(v1, v2, math.random() * 2 - 1).Unit
end
local t = {
	__ClassName = "StuntTurret"
}
t.__index = t
setmetatable(t, Gun)
function t.new(p1, p2, p3) --[[ Line: 22 | Upvalues: Gun (copy), t (copy), RxInstanceUtils (copy) ]]
	local v1 = Gun.new(p1, p2)
	setmetatable(v1, t)
	v1.Maid:GiveTask(RxInstanceUtils.observeOneChildNamed(p2, "PlaneModel", function(p1, p2) --[[ Line: 31 | Upvalues: RxInstanceUtils (ref), v1 (copy) ]]
		if p1 then
			p2:GiveTask(RxInstanceUtils.observeProperty(p1, "Value", function(p1, p2) --[[ Line: 36 | Upvalues: v1 (ref), RxInstanceUtils (ref) ]]
				v1.Model = p1
				if p1 then
					v1:_getTips()
					if v1.Local then
						p2:GiveTask(RxInstanceUtils.observeOneChildNamed(p1, "UpdateHeatRemote", function(p1) --[[ Line: 47 | Upvalues: v1 (ref) ]]
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
		priority = 500
	}
	v1:Setup()
	v1:DefaultDisableCamLock()
	return v1
end
function t._getTips(p1) --[[ Line: 70 | Upvalues: TableUtils (copy) ]]
	if p1.Model then
		local Model = p1.Model:FindFirstChild("Model")
		if Model then
			local BlackChrome = Model:FindFirstChild("BlackChrome")
			if BlackChrome then
				p1.Tips = TableUtils.filter(BlackChrome:GetChildren(), function(p1) --[[ Line: 82 ]]
					return p1.Name == "MachineGun"
				end)
			end
		end
	end
end
function t._updateIgnoreList(p1) --[[ Line: 86 ]]
	p1.IgnoreList = { p1.Character, p1.Model, workspace.Items }
	if p1.BulletEmitter then
		p1.BulletEmitter.IgnoreList = p1.IgnoreList
	end
end
function t.Setup(p1) --[[ Line: 92 | Upvalues: Spring (copy), RunService (copy) ]]
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
	p1.Maid:GiveTask(RunService.RenderStepped:Connect(function() --[[ Line: 119 | Upvalues: p1 (copy) ]]
		p1:RenderStepped()
	end))
	p1.Maid:GiveTask(RunService.Stepped:Connect(function() --[[ Line: 122 | Upvalues: p1 (copy) ]]
		p1:Stepped()
	end))
end
function t.BulletEmitterOnLocalHitPlayer(p1, ...) --[[ Line: 126 | Upvalues: Gun (copy) ]]
	local v1 = tick()
	if v1 - p1.LastPlayerImpact > 0.1 then
		p1.LastPlayerImpact = v1
		Gun.BulletEmitterOnLocalHitPlayer(p1, ...)
	end
end
t.Reload = false
function t.TransformLocalMousePosition(p1, p2) --[[ Line: 136 ]]
	return p1.SpringThirdMousePosition:SetTarget(p2)
end
function t.UpdateArmJoints(p1) --[[ Line: 139 ]] end
function t.UpdateCamera(p1) --[[ Line: 140 | Upvalues: CurrentCamera (copy) ]]
	local v1 = p1.SpringCamera:Update()
	local v2 = CurrentCamera
	v2.CFrame = v2.CFrame * CFrame.new(v1.x * 1, v1.y * 1, 0)
end
function t.RenderStepped(p1) --[[ Line: 144 ]]
	p1:UpdateMousePosition()
	if p1.Local then
		p1:UpdateCamera()
	end
end
function t.Shoot(p1) --[[ Line: 150 | Upvalues: CurrentCamera (copy) ]]
	p1:_updateIgnoreList()
	local v1 = p1.Tips[p1.TipIndex]
	if v1 then
		p1.Tip = v1
		p1.BulletEmitter:Emit(v1.WorldPosition, v1.WorldCFrame.LookVector, p1.Config.BulletSpeed)
		p1.TipIndex = p1.TipIndex % #p1.Tips + 1
		if p1.Local then
			local v3 = math.clamp(20 / (p1.Model.PrimaryPart.Position - CurrentCamera.CFrame.p).Magnitude, 0.1, 1)
			p1.SpringCamera:Accelerate(Vector3.new(math.random() * 2 - 1, math.random() * 2 - 1, math.random() * 2 - 1).Unit * v3 * 5)
		end
	else
		p1:_getTips()
	end
end
function t.ShootCheckConditions(p1) --[[ Line: 169 ]]
	return true
end
function t.AnimateBarrel(p1, p2, p3) --[[ Line: 172 ]]
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
		local _ = math.clamp(sum, 0, MaxHeat) / MaxHeat
		p1.Model:SetAttribute("Heat", sum)
	end
end
function t.Stepped(p1) --[[ Line: 213 ]]
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
function t.Heartbeat(p1) --[[ Line: 234 ]] end
function t.InputBegan(p1, p2, p3) --[[ Line: 235 ]]
	if p3 then
		return false
	end
	if if p2.UserInputType == Enum.UserInputType.MouseButton1 then true elseif p2.UserInputType == Enum.UserInputType.Gamepad1 then p2.KeyCode == Enum.KeyCode.ButtonX else false then
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
function t.InputEnded(p1, p2, p3) --[[ Line: 263 ]]
	if p3 then
		return false
	end
	if if p2.UserInputType == Enum.UserInputType.MouseButton1 then true elseif p2.UserInputType == Enum.UserInputType.Gamepad1 then p2.KeyCode == Enum.KeyCode.ButtonX else false then
		p1.SpringSpin:SetTarget(0)
		p1.MouseDown = false
		delay(0.5, function() --[[ Line: 274 | Upvalues: p1 (copy) ]]
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
function t.Unequip(p1) --[[ Line: 285 ]]
	if p1.Local and p1._updateHeatRemote then
		p1._updateHeatRemote:FireServer(p1.Model:GetAttribute("Heat"))
	end
	if p1.Sound then
		p1.Sound:Destroy()
		p1.Sound = nil
	end
end
return t