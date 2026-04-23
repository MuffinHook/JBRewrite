local Promise = require(script.Parent.Promise)
local Maid = require(script.Parent.Maid)
return function(p1, p2, p3) --[[ Name: waitForChild | Line: 5 | Upvalues: Promise (copy), Maid (copy) ]]
	local v1 = p1:FindFirstChild(p2)
	if v1 then
		return Promise.resolve(v1)
	else
		local v2 = Maid.new()
		local v3 = Promise.new(function(p12, p22) --[[ Line: 14 | Upvalues: v2 (copy), p1 (copy), p2 (copy), p3 (copy), Promise (ref) ]]
			v2:GiveTask(p1.ChildAdded:Connect(function(p1) --[[ Line: 15 | Upvalues: p2 (ref), p12 (copy) ]]
				if p1.Name == tostring(p2) then
					p12(p1)
				end
			end))
			if p3 then
				v2:GivePromise(Promise.delay(p3):andThen(function() --[[ Line: 21 | Upvalues: p22 (copy), p1 (ref), p2 (ref) ]]
					p22(("[waitForChild] Timeout: no child of `%s` with name `%s`"):format(p1.Name, p2))
				end))
			end
		end)
		v3:finally(function() --[[ Line: 26 | Upvalues: v2 (copy) ]]
			v2:Destroy()
		end)
		return v3
	end
end