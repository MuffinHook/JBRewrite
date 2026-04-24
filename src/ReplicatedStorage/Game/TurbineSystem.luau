-- Reviewed by Claude
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Binder = require(ReplicatedStorage.Std.Binder)
local Maid = require(ReplicatedStorage.Std.Maid)
local RxInstanceUtils = require(ReplicatedStorage.Std.RxInstanceUtils)
return {
	init = function()
		local v1 = CFrame.new(0.292251587, -68.3681335, 4.94998169, 1, 0, 0, 0, 1, 0, 0, 0, 1)
		Binder.new("Turbine", function(p1)
			local v12 = Maid.new()
			v12:GiveTask(RxInstanceUtils.observeProperty(p1, "PrimaryPart", function(p1, p2)
				if p1 then
					p2:GiveTask(RxInstanceUtils.observeOneChildNamed(p1, "Blade->Base", function(p1, p2)
						local v12 = math.random() * math.pi * 2
						local v2 = os.clock()
						p2:GiveTask(RunService.Heartbeat:Connect(function()
							local v13 = os.clock() - v2
							p1.C1 = v1:Inverse() * CFrame.Angles(0, 0, -0.3 * v13 + v12) * v1
						end))
					end))
				end
			end))
			return v12
		end):Start()
	end
}
