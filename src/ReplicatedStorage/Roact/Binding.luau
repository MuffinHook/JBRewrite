local createSignal = require(script.Parent.createSignal)
local Symbol = require(script.Parent.Symbol)
local Type = require(script.Parent.Type)
local v1 = require(script.Parent.GlobalConfig).get()
local v2 = Symbol.named("BindingImpl")
local t = {}
local t2 = {
	__index = {
		getValue = function(p1) --[[ Name: getValue | Line: 13 | Upvalues: t (copy) ]]
			return t.getValue(p1)
		end,
		map = function(p1, p2) --[[ Name: map | Line: 17 | Upvalues: t (copy) ]]
			return t.map(p1, p2)
		end
	},
	__tostring = function(p1) --[[ Name: __tostring | Line: 23 ]]
		return string.format("RoactBinding(%s)", (tostring(p1:getValue())))
	end
}
function t.update(p1, p2) --[[ Line: 28 | Upvalues: v2 (copy) ]]
	return p1[v2].update(p2)
end
function t.subscribe(p1, p2) --[[ Line: 32 | Upvalues: v2 (copy) ]]
	return p1[v2].subscribe(p2)
end
function t.getValue(p1) --[[ Line: 36 | Upvalues: v2 (copy) ]]
	return p1[v2].getValue()
end
function t.create(p1) --[[ Line: 40 | Upvalues: createSignal (copy), Type (copy), v2 (copy), t2 (copy) ]]
	local t = {
		value = p1,
		changeSignal = createSignal()
	}
	function t.subscribe(p1) --[[ Line: 46 | Upvalues: t (copy) ]]
		return t.changeSignal:subscribe(p1)
	end
	function t.update(p1) --[[ Line: 50 | Upvalues: t (copy) ]]
		t.value = p1
		t.changeSignal:fire(p1)
	end
	function t.getValue() --[[ Line: 55 | Upvalues: t (copy) ]]
		return t.value
	end
	return setmetatable({
		[Type] = Type.Binding,
		[v2] = t
	}, t2), t.update
end
function t.map(p1, p2) --[[ Line: 65 | Upvalues: v1 (copy), Type (copy), t (copy), v2 (copy), t2 (copy) ]]
	if v1.typeChecks then
		local isBinding = Type.of(p1) == Type.Binding
		assert(isBinding, "Expected arg #1 to be a binding")
		assert(typeof(p2) == "function", "Expected arg #1 to be a function")
	end
	return setmetatable({
		[Type] = Type.Binding,
		[v2] = {
			subscribe = function(p12) --[[ Name: subscribe | Line: 73 | Upvalues: t (ref), p1 (copy), p2 (copy) ]]
				return t.subscribe(p1, function(p1) --[[ Line: 74 | Upvalues: p12 (copy), p2 (ref) ]]
					p12(p2(p1))
				end)
			end,
			update = function(p1) --[[ Name: update | Line: 79 ]]
				error("Bindings created by Binding:map(fn) cannot be updated directly", 2)
			end,
			getValue = function() --[[ Name: getValue | Line: 83 | Upvalues: p2 (copy), p1 (copy) ]]
				return p2(p1:getValue())
			end
		}
	}, t2)
end
function t.join(p1) --[[ Line: 93 | Upvalues: v1 (copy), Type (copy), t (copy), v2 (copy), t2 (copy) ]]
	if v1.typeChecks then
		assert(typeof(p1) == "table", "Expected arg #1 to be of type table")
		for k, v in pairs(p1) do
			if Type.of(v) ~= Type.Binding then
				error(("Expected arg #1 to contain only bindings, but key %q had a non-binding value"):format((tostring(k))), 2)
			end
		end
	end
	local t3 = {}
	local function getValue() --[[ Line: 109 | Upvalues: p1 (copy) ]]
		local t = {}
		for k, v in pairs(p1) do
			t[k] = v:getValue()
		end
		return t
	end
	function t3.subscribe(p12) --[[ Line: 119 | Upvalues: p1 (copy), t (ref), getValue (copy) ]]
		local t2 = {}
		for k, v in pairs(p1) do
			t2[k] = t.subscribe(v, function(p1) --[[ Line: 123 | Upvalues: p12 (copy), getValue (ref) ]]
				p12((getValue()))
			end)
		end
		return function() --[[ Line: 128 | Upvalues: t2 (ref) ]]
			if t2 ~= nil then
				for k, v in pairs(t2) do
					v()
				end
				t2 = nil
			end
		end
	end
	function t3.update(p1) --[[ Line: 141 ]]
		error("Bindings created by joinBindings(...) cannot be updated directly", 2)
	end
	function t3.getValue() --[[ Line: 145 | Upvalues: getValue (copy) ]]
		return getValue()
	end
	return setmetatable({
		[Type] = Type.Binding,
		[v2] = t3
	}, t2)
end
return t