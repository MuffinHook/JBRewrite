return function() --[[ Name: createSignal | Line: 15 ]]
	local t = {}
	local t2 = {}
	local v1 = false
	return {
		subscribe = function(p1, p2) --[[ Name: subscribe | Line: 20 | Upvalues: v1 (ref), t (copy), t2 (copy) ]]
			assert(typeof(p2) == "function", "Can only subscribe to signals with a function.")
			local t3 = {
				callback = p2,
				disconnected = false
			}
			if v1 and not t[p2] then
				t2[p2] = t3
			end
			t[p2] = t3
			return function() --[[ Name: disconnect | Line: 36 | Upvalues: t3 (copy), t (ref), p2 (copy), t2 (ref) ]]
				assert(not t3.disconnected, "Listeners can only be disconnected once.")
				t3.disconnected = true
				t[p2] = nil
				t2[p2] = nil
			end
		end,
		fire = function(p1, ...) --[[ Name: fire | Line: 47 | Upvalues: v1 (ref), t (copy), t2 (copy) ]]
			v1 = true
			for k, v in pairs(t) do
				if not (v.disconnected or t2[k]) then
					k(...)
				end
			end
			v1 = false
			for k, v in pairs(t2) do
				t2[k] = nil
			end
		end
	}
end