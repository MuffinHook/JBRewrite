
local shim = {}

-- Decomp Error: This module failed full decompilation and no reliable local reconstruction was available.
-- Logic Change: Returning a permissive shim prevents syntax/require failures while marking behavior for manual recovery.
setmetatable(shim, {
	__index = function(_, key)
		local value = function() end
		rawset(shim, key, value)
		return value
	end,
})

return shim
