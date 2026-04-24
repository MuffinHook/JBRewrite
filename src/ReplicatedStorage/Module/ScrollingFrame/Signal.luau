-- Reviewed by Claude
return {
	new = function()
		local t = {}
		local instance = Instance.new("BindableEvent")
		local v2 = nil
		local var3 = nil
		function t.fire(p1, ...)
			v2 = { ... }
			var3 = select("#", ...)
			instance:Fire()
		end
		function t.connect(p1, p2)
			if not p2 then
				error("connect(nil)", 2)
			end
			return instance.Event:connect(function()
				p2(unpack(v2, 1, var3))
			end)
		end
		function t.wait(p1)
			instance.Event:wait()
			assert(v2, "Missing arg data, likely due to :TweenSize/Position corrupting threadrefs.")
			return unpack(v2, 1, var3)
		end
		function t.Destroy(p1)
			instance:Destroy()
			v2 = nil
			var3 = nil
			instance = nil
		end
		return t
	end
}
