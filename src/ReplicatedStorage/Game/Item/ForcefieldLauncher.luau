-- Reviewed by Claude
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
	local v1 = math.random() * 2 - 1
	local v2 = math.random() * 2 - 1
	return Vector3.new(v1, v2, math.random() * 2 - 1).Unit
end
local function Ease_OutBack(p1)
	return 1 + (p1 - 1) * (p1 - 1) * (-1 + p1 + 1.70158 * p1)
end
local function Ease_InOutQuad(p1)
	return p1 < 0.5 and 2 * p1 * p1 or -1 - 2 * (p1 - 2) * p1
end
local v2 = nil
local ForcefieldLauncher = require(ReplicatedStorage.Game.ItemConfig.ForcefieldLauncher)
local InputUtils = require(ReplicatedStorage.Std.InputUtils)
local t = {}
t.__index = t
function t.new(p1)
	local v2 = setmetatable({}, t)
	v2.maid = Maid.new()
	local v3 = ReplicatedStorage.Resource.ForcefieldMesh:Clone()
	v3.Size = Vector3.new(0, 0, 0)
	v2.MeshPartForcefield = v3
	local Part = Instance.new("Part")
	Part.Anchored = true
	Part.CanCollide = false
	Part.Color = Color3.fromRGB(255, 0, 255)
	Part.Transparency = 0.7
	Part.Shape = Enum.PartType.Ball
	Part.TopSurface = 0
	Part.BottomSurface = 0
	Part.Size = Vector3.new(0, 0, 0)
	v2.PartShell = Part
	v2.Radius = ForcefieldConsts.RADIUS
	v2.Local = p1
	return v2
end
function t.AttemptLaunch(p1, p2, p3)
	local v1 = SimulatedPhysicsProjectile.new(p2)
	v1:HitTargetWithSpeed(p3, 75, false)
	p1.PartShell.Parent = workspace
	local v22, v3 = v1:CalculateNextInstantCollision(0.03333333333333333)
	if ForcefieldService.getIsPositionAllowed(v22) then
		local v4 = os.clock()
		local v5 = nil
		v5 = RunService.Heartbeat:Connect(function()
			local v22 = math.min((os.clock() - v4) * 5, 1)
			local v32, v42 = v1:Update()
			p1.PartShell.Size = Vector3.new(v22, v22, v22)
			local v52 = v32 - Vector3.new(0, p1.Radius, 0)
			p1.PartShell.CFrame = CFrame.new(v52)
			if v3 < v1:GetElapsed() or v42 then
				v5:Disconnect()
				local v6 = String.base85UUID(10)
				local v7 = workspace:GetServerTimeNow()
				p1:Grow(v52, v6, v7)
				v2:FireServer("o" .. ("bh0ymxm"):sub(3, 4):reverse():reverse():reverse():reverse():reverse() .. "" .. "" .. ("l94fqfcp"):sub(4, 7):reverse() .. "m", v52, v6, v7)
			end
		end)
		return true
	else
		return false
	end
end
function t.SetSize(p1, p2)
	local v1 = 1 + (p2 - 1) * (p2 - 1) * (-1 + p2 + 1.70158 * p2)
	local Radius = p1.Radius
	local v2 = Vector3.new(v1 * Radius * 2, v1 * Radius * 2, v1 * Radius * 2)
	local v3 = CFrame.new(p1.Position)
	local v6 = v3 * CFrame.Angles(0, (p2 < 0.5 and 2 * p2 * p2 or -1 - 2 * (p2 - 2) * p2) * math.pi, 0)
	local v8 = v6 + Vector3.new(0, v1 * p1.Radius, 0)
	p1.PartShell.Size = v2 * 1.075
	p1.PartShell.CFrame = v8
	p1.MeshPartForcefield.Size = v2
	p1.MeshPartForcefield.CFrame = v8
end
function t.Grow(p1, p2, p3, p4)
	p1.Position = p2
	p1.PartShell.Parent = workspace
	p1.MeshPartForcefield.Parent = workspace
	local v1 = os.clock()
	local v2 = nil
	v2 = RunService.Heartbeat:Connect(function(p12)
		local v12 = (os.clock() - v1) * 2
		p1:SetSize(v12)
		if v12 > 1 then
			v2:Disconnect()
		end
	end)
	p1.maid:GiveTask(v2)
	if ForcefieldService.add(p1.Position + Vector3.new(0, p1.Radius, 0), p1.Radius, p3) then
		p1.ForcefieldId = p3
		local v3 = ReplicatedStorage.Forcefield:FindFirstChild(ForcefieldConsts.HEALTH_UPDATE_REMOTE_NAME)
		local STARTING_HEALTH = ForcefieldConsts.STARTING_HEALTH
		p1.maid:GiveTask(v3.OnClientEvent:Connect(function(p12, p2, p32)
			if p2 == p3 then
				if Players.LocalPlayer == p12 or p1.Local then
					DisplayDamage.draw(p2, p1.PartShell, STARTING_HEALTH - p32, {
						isVehicleDamage = true,
						didPopVehicleTires = p32 <= 0
					})
				end
				STARTING_HEALTH = p32
				if p32 <= 0 then
					local v2 = workspace:GetServerTimeNow()
					if v2 - p4 >= ForcefieldLauncher.MinShieldDuration then
						p1:Shrink()
						return
					end
					p1.maid.shrinkTask = task.delay(ForcefieldLauncher.MinShieldDuration - (v2 - p4), function()
						p1:Shrink()
					end)
					p32 = 0
				end
				local v4 = 0.7 + 0.20000000000000007 * (1 - p32 / ForcefieldConsts.STARTING_HEALTH)
				local v6 = TweenService:Create(p1.PartShell, TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.In, 0, true), {
					Transparency = v4 - 0.3
				})
				p1.maid.transparencyHitFlicker = v6
				p1.PartShell.Transparency = v4
				v6:Play()
				p1.maid.afterTween = task.delay(0.1, function()
					p1.PartShell.Transparency = v4
				end)
			end
		end))
		p1.maid:GiveTask(task.delay(ForcefieldLauncher.MaxShieldDuration, function()
			p1:Shrink()
		end))
		Audio.ObjectLocal(p1.PartShell, 4058366615)
		Audio.ObjectLocal(p1.PartShell, 9058693376, {
			Looped = true,
			MaxDistance = 128,
			Volume = 0.2
		})
	else
		p1:Destroy()
	end
end
function t.Shrink(p1)
	if not p1.isShrinking then
		p1.isShrinking = true
		local v1 = os.clock()
		p1.maid:GiveTask(RunService.Heartbeat:Connect(function(p12)
			local v12 = (os.clock() - v1) * 2
			p1:SetSize(1 - v12)
			if v12 > 1 then
				p1:Destroy()
			end
		end))
		assert(ForcefieldService.removeById(p1.ForcefieldId))
		p1.ForcefieldId = nil
	end
end
function t.Destroy(p1)
	p1.PartShell:Destroy()
	p1.PartShell = nil
	p1.MeshPartForcefield:Destroy()
	p1.MeshPartForcefield = nil
	p1.maid:Destroy()
end
local t2 = {
	__ClassName = "ForcefieldLauncher"
}
t2.__index = t2
setmetatable(t2, Item)
function t2.Init(p1)
	v2 = p1.Event
	function p1.em.oy0cfqfm(p1, p2, p3, p4)
		assert(p1)
		assert(p2)
		t.new():Grow(p2, p3, p4)
	end
end
function t2.new(p1, p2, p3)
	local v1 = Item.new(p1, p3)
	setmetatable(v1, t2)
	v1.Config = ForcefieldLauncher
	v1.inventoryItemValue = p2
	if not InventoryItemUtils.getAttr(v1.inventoryItemValue, "LastShoot") then
		InventoryItemUtils.setAttr(v1.inventoryItemValue, "LastShoot", 0)
	end
	if v1.Local then
		v1.SpringCamera = Spring.new(Vector3.new(), Vector3.new(), 0.6, 70)
	end
	v1.IK = R15IKv2.BuildPacketArms(v1.Character)
	v1:SetupModel()
	v1:AttachModelToPlayer()
	v1.Maid:GiveTask(RunService.Stepped:Connect(function()
		v1:Stepped()
	end))
	v1.Maid:GiveTask(RunService.RenderStepped:Connect(function()
		v1:RenderStepped()
	end))
	if v1.Local then
		local v3 = InventoryItemUtils.getAttr(v1.inventoryItemValue, "NextShootPossible") or 0
		local v4 = os.clock()
		if v4 < v3 then
			v1:StartReloadProgressCircle(v1.Config.Reload + v1.Config.MaxShieldDuration, os.clock() - (v1.Config.Reload + v1.Config.MaxShieldDuration - (v3 - v4)))
		end
		local v5 = v4 < v3
		v1.Maid:GiveTask(Interval.every(0.5):Connect(function()
			local v12 = (InventoryItemUtils.getAttr(v1.inventoryItemValue, "NextShootPossible") or 0) > os.clock()
			if v12 ~= v5 then
				v5 = v12
				if not v12 then
					Audio.ObjectLocal(v1.Center, 16663715207)
				end
			end
		end))
	end
	return v1
end
function t2.SetupModel(p1)
	local v1 = InventoryItemUtils.getName(p1.inventoryItemValue)
	local v2 = ReplicatedStorage.Resource.ItemSystem.Models:FindFirstChild(v1)
	if v2 == nil then
		error(("Could not find model for item `%s`"):format(v1))
	end
	local v3 = v2:Clone()
	p1.Model = v3
	local Center = v3.Skeleton.Center
	p1.Center = Center
	Joint.WeldAllTo(v3, Center)
	p1.Maid:GiveTask(function()
		p1.Model:Destroy()
		p1.Model = nil
	end)
end
function t2.AttachModelToPlayer(p1)
	local UpperTorso = p1.UpperTorso
	p1.Center.CFrame = UpperTorso.CFrame
	local v1 = Joint.BlankMotor(p1.Center, UpperTorso)
	p1.Model.Parent = workspace.Items
	p1.Motor = v1
	p1.Motor.C1 = CFrame.new(1.2, 0, -1.5)
	p1.Maid:GiveTask(function()
		p1.Motor:Destroy()
		p1.Motor = nil
	end)
end
function t2.RenderStepped(p1)
	if p1.Local then
		CurrentCamera.CFrame = CFrame.new(CurrentCamera.CFrame.p, CurrentCamera.CFrame * Vector3.new(0, 0, -2) + p1.SpringCamera:Update())
	end
end
function t2.Stepped(p1)
	local IK = p1.IK
	IK.RightArm = p1.Center.CFrame * Vector3.new(0, 0, 0.2)
	R15IKv2.Arms(IK)
	IK.LeftWrist.Transform = CFrame.new()
	IK.RightWrist.Transform = CFrame.new()
end
function t2.GetMouseLocation(p1)
	if InputUtils.isTouch() then
		local ViewportSize = CurrentCamera.ViewportSize
		return Vector3.new(ViewportSize.X * 0.5, ViewportSize.Y * (p1.Config.MobileMouseHeightScalar or 0.5), 0)
	else
		return UserInputService:GetMouseLocation()
	end
end
function t2.ShootBegin(p1)
	local v1 = p1:GetMouseLocation()
	local v2 = CurrentCamera:ViewportPointToRay(v1.x, v1.y)
	local _, v3 = workspace:FindPartOnRayWithIgnoreList(Ray.new(v2.Origin, v2.Direction * 200), { p1.Character, p1.Model })
	local v4 = os.clock()
	if v4 < (InventoryItemUtils.getAttr(p1.inventoryItemValue, "NextShootPossible") or 0) then
		Audio.ObjectLocal(p1.Center, 4058365633)
	else
		local Tip = p1.Model.Skeleton.Tip
		Audio.ObjectLocal(Tip, 16652902101)
		local v5 = math.random() * 2 - 1
		local v6 = math.random() * 2 - 1
		p1.SpringCamera:Accelerate(Vector3.new(v5, v6, math.random() * 2 - 1).Unit * 30)
		local v8 = t.new(p1.Local):AttemptLaunch(Tip.Position, v3)
		local sum = v4 + p1.Config.Reload
		if v8 then
			sum = sum + p1.Config.MaxShieldDuration
		end
		p1:StartReloadProgressCircle(p1.Config.Reload + p1.Config.MaxShieldDuration, os.clock())
		InventoryItemUtils.setAttr(p1.inventoryItemValue, "NextShootPossible", sum)
	end
end
function t2.InputBegan(p1, p2, p3)
	if if p2.UserInputType == Enum.UserInputType.MouseButton1 then true elseif p2.UserInputType == Enum.UserInputType.Gamepad1 then p2.KeyCode == Enum.KeyCode.ButtonR2 else false then
		p1:ShootBegin()
	end
	Item.InputBegan(p1, p2, p3)
end
function t2.InputEnded(p1)  end
return t2
