local v1 = nil
return {
	init = function() --[[ Name: init | Line: 4 | Upvalues: v1 (ref) ]]
		v1 = require(script.Parent.OwnedPartBinder)
		v1:Start()
	end
}