local RunService = game:GetService("RunService")
local Maid = require(script.Parent.Maid)
return {
	linear = function(p1, p2, p3, p4) --[[ Name: linear | Line: 5 | Upvalues: Maid (copy), RunService (copy) ]]
		local v1 = Maid.new()
		local v2 = os.clock()
		local v3 = p1[p2]
		v1:GiveTask(RunService.Heartbeat:Connect(function() --[[ Line: 9 | Upvalues: v2 (copy), p4 (copy), p1 (copy), p2 (copy), v3 (copy), p3 (copy), v1 (copy) ]]
			local v12 = (os.clock() - v2) / p4
			if v12 >= 1 then
				v12 = 1
			end
			p1[p2] = v3 * (1 - v12) + p3 * v12
			if v12 == 1 then
				p1[p2] = p3
				v1:DoCleaning()
			end
		end))
		return v1
	end
}