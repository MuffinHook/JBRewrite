-- Reviewed by Claude
-- variables reassigned
local RunService = game:GetService("RunService")
local Maid = require(script.Parent.Maid)
return {
	linear = function(obj, property, targetValue, duration)
		local cleanup = Maid.new()
		local startTime = os.clock()
		local startValue = obj[property]
		cleanup:GiveTask(RunService.Heartbeat:Connect(function()
			local progress = (os.clock() - startTime) / duration
			if progress >= 1 then
				progress = 1
			end
			obj[property] = startValue * (1 - progress) + targetValue * progress
			if progress == 1 then
				obj[property] = targetValue
				cleanup:DoCleaning()
			end
		end))
		return cleanup
	end
}
