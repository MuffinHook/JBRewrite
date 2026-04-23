local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local Binder = require(ReplicatedStorage.Std.Binder)
local Maid = require(ReplicatedStorage.Std.Maid)
local CurrentCamera = workspace.CurrentCamera
return {
	Init = function() --[[ Name: Init | Line: 10 | Upvalues: Binder (copy), Maid (copy), RunService (copy), CurrentCamera (copy) ]]
		Binder.new("LighthouseLight", function(p1) --[[ Line: 12 | Upvalues: Maid (ref), RunService (ref), CurrentCamera (ref) ]]
			local v1 = Maid.new()
			assert(p1.PrimaryPart.Name == "Center", "LighthouseLight must have Center as PrimaryPart")
			v1:GiveTask(RunService.Heartbeat:Connect(function(p12) --[[ Line: 20 | Upvalues: p1 (copy), CurrentCamera (ref) ]]
				local v1 = p1:GetPivot()
				local Magnitude = (CurrentCamera.CFrame.Position - v1.Position).Magnitude
				if not (Magnitude * Magnitude > 1048576) then
					debug.profilebegin("Lighthouse")
					p1:PivotTo(v1 * CFrame.Angles(0, 0.5 * p12, 0))
					debug.profileend()
				end
			end))
			return v1
		end):Start()
	end
}