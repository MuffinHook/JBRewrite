local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local Turret = require(script.Parent.Turret)
local TurretConsts = require(script.Parent.TurretConsts)
local Binder = require(ReplicatedStorage.Std.Binder)
return {
	init = function()
		local instance = Binder.new("Turret2", Turret)
		instance:GetClassAddedSignal():Connect(function(turret)
			local targetPointerModel = turret.Model:FindFirstChild(TurretConsts.TARGET_PTR_NAME)
			turret.Maid:GiveTask(RunService.Heartbeat:Connect(function()
				if targetPointerModel.Value then
					local targetPart = targetPointerModel.Value
					assert(targetPart:IsA("BasePart"))
					turret:PointAt(targetPart.Position)
				else
					turret:PointAt()
				end
				turret:Update()
			end))
			turret.Maid:GiveTask(turret.onLocalPlayerHit:Connect(function()
				local reportHitRemote = turret.Model:FindFirstChild(TurretConsts.REPORT_HIT_REMOTE_NAME)
				assert(reportHitRemote)
				reportHitRemote:FireServer()
			end))
		end)
		instance:Start()
	end
}
