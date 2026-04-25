-- Reviewed by Claude
-- variables reassigned
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Binder = require(ReplicatedStorage.Std.Binder)
local Maid = require(ReplicatedStorage.Std.Maid)
local RxInstanceUtils = require(ReplicatedStorage.Std.RxInstanceUtils)
return {
	init = function()
		local baseCFrame = CFrame.new(0.292251587, -68.3681335, 4.94998169, 1, 0, 0, 0, 1, 0, 0, 0, 1)
		Binder.new("Turbine", function(p1)
			local turbineMaid = Maid.new()
			turbineMaid:GiveTask(RxInstanceUtils.observeProperty(p1, "PrimaryPart", function(p1, p2)
				if p1 then
					p2:GiveTask(RxInstanceUtils.observeOneChildNamed(p1, "Blade->Base", function(p1, p2)
						local randomRotationOffset = math.random() * math.pi * 2
						local startTime = os.clock()
						p2:GiveTask(RunService.Heartbeat:Connect(function()
							local elapsedTime = os.clock() - startTime
							p1.C1 = baseCFrame:Inverse() * CFrame.Angles(0, 0, -0.3 * elapsedTime + randomRotationOffset) * baseCFrame
						end))
					end))
				end
			end))
			return turbineMaid
		end):Start()
	end
}
