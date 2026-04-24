-- Reviewed by Claude
return {
	new = function()
		local t = {}
		local v1 = Instance.new("BindableEvent")
		local v2 = nil
		local v3 = nil
		function t.fire(p1, ...)
			v2 = { ... }
			v3 = select("#", ...)
			v1:Fire()
		end
		function t.connect(p1, p2)
			if not p2 then
				error("connect(nil)", 2)
			end
			return v1.Event:connect(function()
				p2(unpack(v2, 1, v3))
			end)
		end
		function t.wait(p1)
			v1.Event:wait()
			assert(v2, "Missing arg data, likely due to :TweenSize/Position corrupting threadrefs.")
			return unpack(v2, 1, v3)
		end
		function t.Destroy(p1)
			v1:Destroy()
			v2 = nil
			v3 = nil
			v1 = nil
		end
		return t
	end
}
