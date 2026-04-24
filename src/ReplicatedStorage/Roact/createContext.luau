-- Reviewed by Claude
local Symbol = require(script.Parent.Symbol)
local createFragment = require(script.Parent.createFragment)
local createSignal = require(script.Parent.createSignal)
local Children = require(script.Parent.PropMarkers.Children)
local Component = require(script.Parent.Component)
local function createContextEntry(p1)
	return {
 value = p1,
 onUpdate = createSignal()
	}
end
local function createProvider(p1)
	local v1 = Component:extend("Provider")
	function v1.init(p12, p2)
 p12.contextEntry = {
 value = p2.value,
 onUpdate = createSignal()
 }
 p12:__addContext(p1.key, p12.contextEntry)
	end
	function v1.willUpdate(p1, p2)
 if p2.value ~= p1.props.value then
 p1.contextEntry.value = p2.value
 end
	end
	function v1.didUpdate(p1, p2)
 if p2.value ~= p1.props.value then
 p1.contextEntry.onUpdate:fire(p1.props.value)
 end
	end
	function v1.render(p1)
 return createFragment(p1.props[Children])
	end
	return v1
end
local function createConsumer(p1)
	local v1 = Component:extend("Consumer")
	function v1.validateProps(p1)
 if type(p1.render) == "function" then
 return true
 else
 return false, "Consumer expects a `render` function"
 end
	end
	function v1.init(p12, p2)
 p12.contextEntry = p12:__getContext(p1.key)
	end
	function v1.render(p12)
 return p12.props.render(if p12.contextEntry == nil then p1.defaultValue else p12.contextEntry.value)
	end
	function v1.didUpdate(p1)
 if p1.contextEntry ~= nil then
 p1.lastValue = p1.contextEntry.value
 end
	end
	function v1.didMount(p1)
 if p1.contextEntry ~= nil then
 p1.disconnect = p1.contextEntry.onUpdate:subscribe(function(p12)
 if p12 ~= p1.lastValue then
 p1:setState({})
 end
 end)
 end
	end
	function v1.willUnmount(p1)
 if p1.disconnect ~= nil then
 p1.disconnect()
 p1.disconnect = nil
 end
	end
	return v1
end
local t = {}
t.__index = t
function t.new(p1)
	return setmetatable({
 defaultValue = p1,
 key = Symbol.named("ContextKey")
	}, t)
end
function t.__tostring(p1)
	return "RoactContext"
end
return function(p1)
	local v1 = t.new(p1)
	return {
 Provider = createProvider(v1),
 Consumer = createConsumer(v1)
	}
end