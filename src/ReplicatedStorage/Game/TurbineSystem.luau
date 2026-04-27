local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Binder = require(ReplicatedStorage.Std.Binder)
local Maid = require(ReplicatedStorage.Std.Maid)
local RxInstanceUtils = require(ReplicatedStorage.Std.RxInstanceUtils)
return {
	init = function()
		local baseCFrame = CFrame.new(0.292251587, -68.3681335, 4.94998169, 1, 0, 0, 0, 1, 0, 0, 0, 1)
		Binder.new("Turbine", function(turbineInstance)
			local turbineMaid = Maid.new()
			turbineMaid:GiveTask(RxInstanceUtils.observeProperty(turbineInstance, "PrimaryPart", function(primaryPart, observerMaid)
				if primaryPart then
					observerMaid:GiveTask(RxInstanceUtils.observeOneChildNamed(primaryPart, "Blade->Base", function(bladeBase, bladeMaid)
						local randomRotationOffset = math.random() * math.pi * 2
						local startTime = os.clock()
						bladeMaid:GiveTask(RunService.Heartbeat:Connect(function()
							local elapsedTime = os.clock() - startTime
							bladeBase.C1 = baseCFrame:Inverse() * CFrame.Angles(0, 0, -0.3 * elapsedTime + randomRotationOffset) * baseCFrame
						end))
					end))
				end
			end))
			return turbineMaid
		end):Start()
	end
}
