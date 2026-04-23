local Interval = require(script.Parent.Parent.Interval)
local function getErr(p1) --[[ Line: 4 | Upvalues: Interval (copy) ]]
	local v1 = 0
	for i = 1, p1 do
		local v2 = math.random()
		local v3 = false
		local v4 = Interval.every(v2):Connect(function(p1) --[[ Line: 10 | Upvalues: i (copy), v3 (ref), v2 (copy), v1 (ref) ]]
			print(i, p1)
			v3 = true
			local v22 = math.abs(p1 - v2)
			if v22 > 0.04 then
				error("invalid elapsed")
			end
			v1 = v1 + v22
		end)
		local v5 = math.random()
		task.delay(2, function() --[[ Line: 20 | Upvalues: v3 (ref), v5 (copy), v2 (copy), i (copy) ]]
			if not v3 and v2 * 2 < v5 then
				error("did not fire once: " .. tostring(i) .. (" (%.2f, %.2f)"):format(v5, v2))
			end
		end)
		task.delay(v5, function() --[[ Line: 25 | Upvalues: v4 (ref) ]]
			v4:Disconnect()
		end)
	end
	task.wait(3)
	return v1 / p1
end
return function() --[[ Line: 33 | Upvalues: getErr (copy) ]]
	describe("Interval", function() --[[ Line: 34 | Upvalues: getErr (ref) ]]
		it("should all fire and elapsed minimized", function() --[[ Line: 35 | Upvalues: getErr (ref) ]]
			task.wait(5)
			expect(getErr(100) < 0.1).to.equal(true)
		end)
	end)
end