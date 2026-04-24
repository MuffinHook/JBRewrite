-- Reviewed by Claude
-- variables reassigned
local Symbol = require(script.Parent.Symbol)
local createFragment = require(script.Parent.createFragment)
local createSignal = require(script.Parent.createSignal)
local Children = require(script.Parent.PropMarkers.Children)
local Component = require(script.Parent.Component)
local function createContextEntry(self)
	return {
 value = self,
 onUpdate = createSignal()
	}
end
local function createProvider(self)
	local v1 = Component:extend("Provider")
	function v1.init(param12, callback)
 param12.contextEntry = {
 value = callback.value,
 onUpdate = createSignal()
 }
 param12:__addContext(self.key, param12.contextEntry)
	end
	function v1.willUpdate(self, callback)
 if callback.value ~= self.props.value then
 self.contextEntry.value = callback.value
 end
	end
	function v1.didUpdate(self, callback)
 if callback.value ~= self.props.value then
 self.contextEntry.onUpdate:fire(self.props.value)
 end
	end
	function v1.render(self)
 return createFragment(self.props[Children])
	end
	return v1
end
local function createConsumer(self)
	local v1 = Component:extend("Consumer")
	function v1.validateProps(self)
 if type(self.render) == "function" then
 return true
 else
 return false, "Consumer expects a `render` function"
 end
	end
	function v1.init(param12, callback)
 param12.contextEntry = param12:__getContext(self.key)
	end
	function v1.render(param12)
 return param12.props.render(if param12.contextEntry == nil then self.defaultValue else param12.contextEntry.value)
	end
	function v1.didUpdate(self)
 if self.contextEntry ~= nil then
 self.lastValue = self.contextEntry.value
 end
	end
	function v1.didMount(self)
 if self.contextEntry ~= nil then
 self.disconnect = self.contextEntry.onUpdate:subscribe(function(param12)
 if param12 ~= self.lastValue then
 self:setState({})
 end
 end)
 end
	end
	function v1.willUnmount(self)
 if self.disconnect ~= nil then
 self.disconnect()
 self.disconnect = nil
 end
	end
	return v1
end
local tableObj = {}
tableObj.__index = tableObj
function tableObj.new(self)
	return setmetatable({
 defaultValue = self,
 key = Symbol.named("ContextKey")
	}, tableObj)
end
function tableObj.__tostring(self)
	return "RoactContext"
end
return function(self)
	local v1 = tableObj.new(self)
	return {
 Provider = createProvider(v1),
 Consumer = createConsumer(v1)
	}
end
