local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local Turret = require(script.Parent.Turret)
local TurretConsts = require(script.Parent.TurretConsts)
local Binder = require(ReplicatedStorage.Std.Binder)
return {
	init = function() --[[ Name: init | Line: 7 | Upvalues: Binder (copy), Turret (copy), TurretConsts (copy), RunService (copy) ]]
		local v1 = Binder.new("Turret2", Turret)
		v1:GetClassAddedSignal():Connect(function(p1) --[[ Line: 9 | Upvalues: TurretConsts (ref), RunService (ref) ]]
			local v1 = p1.Model:FindFirstChild(TurretConsts.TARGET_PTR_NAME)
			p1.Maid:GiveTask(RunService.Heartbeat:Connect(function() --[[ Line: 11 | Upvalues: v1 (copy), p1 (copy) ]]
				if v1.Value then
					local v12 = v1.Value
					assert(v12:IsA("BasePart"))
					p1:PointAt(v12.Position)
				else
					p1:PointAt()
				end
				p1:Update()
			end))
			p1.Maid:GiveTask(p1.onLocalPlayerHit:Connect(function() --[[ Line: 21 | Upvalues: p1 (copy), TurretConsts (ref) ]]
				local v1 = p1.Model:FindFirstChild(TurretConsts.REPORT_HIT_REMOTE_NAME)
				assert(v1)
				v1:FireServer()
			end))
		end)
		v1:Start()
	end
}