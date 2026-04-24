-- Reviewed by Claude
-- variables reassigned
return function()
	local config = require(script.Parent)
	it("should load with all public APIs", function()
 local tableObj = {
 createElement = "function",
 createFragment = "function",
 createRef = "function",
 forwardRef = "function",
 createBinding = "function",
 joinBindings = "function",
 mount = "function",
 unmount = "function",
 update = "function",
 oneChild = "function",
 setGlobalConfig = "function",
 createContext = "function",
 reify = "function",
 teardown = "function",
 reconcile = "function",
 Component = true,
 PureComponent = true,
 Portal = true,
 Children = true,
 Event = true,
 Change = true,
 Ref = true,
 None = true,
 UNSTABLE = true
 }
 expect(config).to.be.ok()
 for k, v in pairs(tableObj) do
 local internalData, v2
 internalData = if typeof(v) == "string" then typeof(config[k]) == v else config[k] ~= nil
 if not internalData then
 v2 = if typeof(v) == "boolean" then "present" else "of type " .. tostring(v)
 error((("Expected public API member %q to be %s, but instead it was of type %s"):format(tostring(k), v2, (typeof(config[k])))))
 end
 end
 for k in pairs(config) do
 if tableObj[k] == nil then
 error((("Found unknown public API key %q!"):format((tostring(k)))))
 end
 end
	end)
end
