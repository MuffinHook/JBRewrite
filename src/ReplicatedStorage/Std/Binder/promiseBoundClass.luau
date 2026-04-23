local Promise = require(script.Parent.Parent.Promise)
local Maid = require(script.Parent.Parent.Maid)
return function(p1, p2) --[[ Line: 5 | Upvalues: Promise (copy), Maid (copy) ]]
	local v1 = debug.traceback()
	local v2 = p1:Get(p2)
	if v2 then
		return Promise.resolve(v2)
	else
		local v3 = Maid.new()
		local v4 = Promise.defer(function(p12) --[[ Line: 13 | Upvalues: p1 (copy), p2 (copy), v3 (copy) ]]
			local v1 = p1:Get(p2)
			if v1 then
				p12(v1)
			else
				v3:GiveTask(p1:ObserveInstance(p2, function(p1) --[[ Line: 18 | Upvalues: p12 (copy) ]]
					p12(p1)
				end))
			end
		end)
		v4:finally(function() --[[ Line: 23 | Upvalues: v3 (copy) ]]
			v3:Destroy()
		end)
		task.delay(5, function() --[[ Line: 26 | Upvalues: v4 (copy), Promise (ref), p2 (copy), p1 (copy), v1 (copy) ]]
			if v4:getStatus() == Promise.Status.Started then
				warn(("[promiseBoundClass] - Infinite yield possible on %q for binder %q\n"):format(p2:GetFullName(), p1:GetTag()))
				warn(v1)
			end
		end)
		return v4
	end
end