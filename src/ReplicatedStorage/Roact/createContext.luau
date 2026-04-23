local Symbol = require(script.Parent.Symbol)
local createFragment = require(script.Parent.createFragment)
local createSignal = require(script.Parent.createSignal)
local Children = require(script.Parent.PropMarkers.Children)
local Component = require(script.Parent.Component)
local function createContextEntry(p1) --[[ Line: 10 | Upvalues: createSignal (copy) ]]
	return {
		value = p1,
		onUpdate = createSignal()
	}
end
local function createProvider(p1) --[[ Line: 17 | Upvalues: Component (copy), createSignal (copy), createFragment (copy), Children (copy) ]]
	local v1 = Component:extend("Provider")
	function v1.init(p12, p2) --[[ Line: 20 | Upvalues: createSignal (ref), p1 (copy) ]]
		p12.contextEntry = {
			value = p2.value,
			onUpdate = createSignal()
		}
		p12:__addContext(p1.key, p12.contextEntry)
	end
	function v1.willUpdate(p1, p2) --[[ Line: 25 ]]
		if p2.value ~= p1.props.value then
			p1.contextEntry.value = p2.value
		end
	end
	function v1.didUpdate(p1, p2) --[[ Line: 36 ]]
		if p2.value ~= p1.props.value then
			p1.contextEntry.onUpdate:fire(p1.props.value)
		end
	end
	function v1.render(p1) --[[ Line: 51 | Upvalues: createFragment (ref), Children (ref) ]]
		return createFragment(p1.props[Children])
	end
	return v1
end
local function createConsumer(p1) --[[ Line: 58 | Upvalues: Component (copy) ]]
	local v1 = Component:extend("Consumer")
	function v1.validateProps(p1) --[[ Line: 61 ]]
		if type(p1.render) == "function" then
			return true
		else
			return false, "Consumer expects a `render` function"
		end
	end
	function v1.init(p12, p2) --[[ Line: 69 | Upvalues: p1 (copy) ]]
		p12.contextEntry = p12:__getContext(p1.key)
	end
	function v1.render(p12) --[[ Line: 75 | Upvalues: p1 (copy) ]]
		return p12.props.render(if p12.contextEntry == nil then p1.defaultValue else p12.contextEntry.value)
	end
	function v1.didUpdate(p1) --[[ Line: 90 ]]
		if p1.contextEntry ~= nil then
			p1.lastValue = p1.contextEntry.value
		end
	end
	function v1.didMount(p1) --[[ Line: 99 ]]
		if p1.contextEntry ~= nil then
			p1.disconnect = p1.contextEntry.onUpdate:subscribe(function(p12) --[[ Line: 110 | Upvalues: p1 (copy) ]]
				if p12 ~= p1.lastValue then
					p1:setState({})
				end
			end)
		end
	end
	function v1.willUnmount(p1) --[[ Line: 119 ]]
		if p1.disconnect ~= nil then
			p1.disconnect()
			p1.disconnect = nil
		end
	end
	return v1
end
local t = {}
t.__index = t
function t.new(p1) --[[ Line: 132 | Upvalues: Symbol (copy), t (copy) ]]
	return setmetatable({
		defaultValue = p1,
		key = Symbol.named("ContextKey")
	}, t)
end
function t.__tostring(p1) --[[ Line: 139 ]]
	return "RoactContext"
end
return function(p1) --[[ Name: createContext | Line: 143 | Upvalues: t (copy), createProvider (copy), createConsumer (copy) ]]
	local v1 = t.new(p1)
	return {
		Provider = createProvider(v1),
		Consumer = createConsumer(v1)
	}
end