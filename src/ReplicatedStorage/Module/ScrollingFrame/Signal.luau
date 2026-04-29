return {
	new = function()
		local signal = {}
		local instance = Instance.new("BindableEvent")
		local args = nil
		local argCount = nil
		function signal.fire(self, ...)
			args = { ... }
			argCount = select("#", ...)
			instance:Fire()
		end
		function signal.connect(self, callback)
			if not callback then
				error("connect(nil)", 2)
			end
			return instance.Event:connect(function()
				callback(unpack(args, 1, argCount))
			end)
		end
		function signal.wait(self)
			instance.Event:Wait()
			assert(args, "Missing arg data, likely due to :TweenSize/Position corrupting threadrefs.")
			return unpack(args, 1, argCount)
		end
		function signal.Destroy(self)
			instance:Destroy()
			args = nil
			argCount = nil
			instance = nil
		end
		return signal
	end
}
