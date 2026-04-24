-- Reviewed by Claude
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local Turret = require(script.Parent.Turret)
local TurretConsts = require(script.Parent.TurretConsts)
local Binder = require(ReplicatedStorage.Std.Binder)
return {
	init = function()
		local instance = Binder.new("Turret2", Turret)
		instance:GetClassAddedSignal():Connect(function(p1)
			local instance = p1.Model:FindFirstChild(TurretConsts.TARGET_PTR_NAME)
			p1.Maid:GiveTask(RunService.Heartbeat:Connect(function()
				if instance.Value then
					local var12 = instance.Value
					assert(var12:IsA("BasePart"))
					p1:PointAt(var12.Position)
				else
					p1:PointAt()
				end
				p1:Update()
			end))
			p1.Maid:GiveTask(p1.onLocalPlayerHit:Connect(function()
				local instance = p1.Model:FindFirstChild(TurretConsts.REPORT_HIT_REMOTE_NAME)
				assert(instance)
				instance:FireServer()
			end))
		end)
		instance:Start()
	end
}
