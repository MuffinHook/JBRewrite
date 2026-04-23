return {
	new = function() --[[ Name: new | Line: 30 ]]
		local t = {}
		local v1 = Instance.new("BindableEvent")
		local v2 = nil
		local v3 = nil
		function t.fire(p1, ...) --[[ Line: 38 | Upvalues: v2 (ref), v3 (ref), v1 (ref) ]]
			v2 = { ... }
			v3 = select("#", ...)
			v1:Fire()
		end
		function t.connect(p1, p2) --[[ Line: 44 | Upvalues: v1 (ref), v2 (ref), v3 (ref) ]]
			if not p2 then
				error("connect(nil)", 2)
			end
			return v1.Event:connect(function() --[[ Line: 48 | Upvalues: p2 (copy), v2 (ref), v3 (ref) ]]
				p2(unpack(v2, 1, v3))
			end)
		end
		function t.wait(p1) --[[ Line: 53 | Upvalues: v1 (ref), v2 (ref), v3 (ref) ]]
			v1.Event:wait()
			assert(v2, "Missing arg data, likely due to :TweenSize/Position corrupting threadrefs.")
			return unpack(v2, 1, v3)
		end
		function t.Destroy(p1) --[[ Line: 59 | Upvalues: v1 (ref), v2 (ref), v3 (ref) ]]
			v1:Destroy()
			v2 = nil
			v3 = nil
			v1 = nil
		end
		return t
	end
}