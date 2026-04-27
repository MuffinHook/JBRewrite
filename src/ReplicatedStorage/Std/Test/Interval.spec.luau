local Interval = require(script.Parent.Parent.Interval)
local function getErr(iterationCount)
	local totalElapsedError = 0
	for i = 1, iterationCount do
		local randomDelay = math.random()
		local hasConnected = false
		local connection = Interval.every(randomDelay):Connect(function(elapsedTime)
			print(i, elapsedTime)
			hasConnected = true
			local elapsedDifference = math.abs(elapsedTime - randomDelay)
			if elapsedDifference > 0.04 then
				error("invalid elapsed")
			end
			totalElapsedError = totalElapsedError + elapsedDifference
		end)
		local disconnectDelay = math.random()
		task.delay(2, function()
			if not hasConnected and randomDelay * 2 < disconnectDelay then
				error("did not fire once: " .. tostring(i) .. (" (%.2f, %.2f)"):format(disconnectDelay, randomDelay))
			end
		end)
		task.delay(disconnectDelay, function()
			connection:Disconnect()
		end)
	end
	task.wait(3)
	return totalElapsedError / iterationCount
end
return function()
	describe("Interval", function()
		it("should all fire and elapsed minimized", function()
			task.wait(5)
			expect(getErr(100) < 0.1).to.equal(true)
		end)
	end)
end
