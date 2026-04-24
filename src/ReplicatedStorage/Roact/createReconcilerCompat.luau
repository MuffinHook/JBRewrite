-- Reviewed by Claude
local Logging = require(script.Parent.Logging)
return function(self)
	return {
 reify = function(...)
 Logging.warnOnce("Roact.reify has been renamed to Roact.mount and will be removed in a future release.\nCheck the call to Roact.reify at:\n")
 return self.mountVirtualTree(...)
 end,
 teardown = function(...)
 Logging.warnOnce("Roact.teardown has been renamed to Roact.unmount and will be removed in a future release.\nCheck the call to Roact.teardown at:\n")
 return self.unmountVirtualTree(...)
 end,
 reconcile = function(...)
 Logging.warnOnce("Roact.reconcile has been renamed to Roact.update and will be removed in a future release.\nCheck the call to Roact.reconcile at:\n")
 return self.updateVirtualTree(...)
 end
	}
end
