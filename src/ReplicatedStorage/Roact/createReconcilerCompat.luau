local Logging = require(script.Parent.Logging)
return function(p1) --[[ Name: createReconcilerCompat | Line: 23 | Upvalues: Logging (copy) ]]
	return {
		reify = function(...) --[[ Name: reify | Line: 26 | Upvalues: Logging (ref), p1 (copy) ]]
			Logging.warnOnce("Roact.reify has been renamed to Roact.mount and will be removed in a future release.\nCheck the call to Roact.reify at:\n")
			return p1.mountVirtualTree(...)
		end,
		teardown = function(...) --[[ Name: teardown | Line: 32 | Upvalues: Logging (ref), p1 (copy) ]]
			Logging.warnOnce("Roact.teardown has been renamed to Roact.unmount and will be removed in a future release.\nCheck the call to Roact.teardown at:\n")
			return p1.unmountVirtualTree(...)
		end,
		reconcile = function(...) --[[ Name: reconcile | Line: 38 | Upvalues: Logging (ref), p1 (copy) ]]
			Logging.warnOnce("Roact.reconcile has been renamed to Roact.update and will be removed in a future release.\nCheck the call to Roact.reconcile at:\n")
			return p1.updateVirtualTree(...)
		end
	}
end