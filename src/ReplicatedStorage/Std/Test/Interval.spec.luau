-- Reviewed by Claude
local Interval = require(script.Parent.Parent.Interval)
local function getErr(p1)
	local v1 = 0
	for i = 1, p1 do
		local v2 = math.random()
		local v3 = false
		local v4 = Interval.every(v2):Connect(function(p1)
			print(i, p1)
			v3 = true
			local v22 = math.abs(p1 - v2)
			if v22 > 0.04 then
				error("invalid elapsed")
			end
			v1 = v1 + v22
		end)
		local v5 = math.random()
		task.delay(2, function()
			if not v3 and v2 * 2 < v5 then
				error("did not fire once: " .. tostring(i) .. (" (%.2f, %.2f)"):format(v5, v2))
			end
		end)
		task.delay(v5, function()
			v4:Disconnect()
		end)
	end
	task.wait(3)
	return v1 / p1
end
return function()
	describe("Interval", function()
		it("should all fire and elapsed minimized", function()
			task.wait(5)
			expect(getErr(100) < 0.1).to.equal(true)
		end)
	end)
end
