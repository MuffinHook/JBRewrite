-- Reviewed by Claude
local createSignal = require(script.Parent.createSignal)
local Symbol = require(script.Parent.Symbol)
local Type = require(script.Parent.Type)
local v1 = require(script.Parent.GlobalConfig).get()
local typeSymbol = Symbol.named("BindingImpl")
local tbl = {}
local tbl3 = {
	__index = {
		getValue = function(p1)
			return tbl.getValue(p1)
		end,
		map = function(p1, p2)
			return tbl.map(p1, p2)
		end
	},
	__tostring = function(p1)
		return string.format("RoactBinding(%s)", (tostring(p1:getValue())))
	end
}
function tbl.update(p1, p2)
	return p1[typeSymbol].update(p2)
end
function tbl.subscribe(p1, p2)
	return p1[typeSymbol].subscribe(p2)
end
function tbl.getValue(p1)
	return p1[typeSymbol].getValue()
end
function tbl.create(p1)
	local tbl = {
		value = p1,
		changeSignal = createSignal()
	}
	function tbl.subscribe(p1)
		return tbl.changeSignal:subscribe(p1)
	end
	function tbl.update(p1)
		tbl.value = p1
		tbl.changeSignal:fire(p1)
	end
	function tbl.getValue()
		return tbl.value
	end
	return setmetatable({
		[Type] = Type.Binding,
		[typeSymbol] = tbl
	}, tbl3), tbl.update
end
function tbl.map(p1, p2)
	if v1.typeChecks then
		local isBinding = Type.of(p1) == Type.Binding
		assert(isBinding, "Expected arg #1 to be a binding")
		assert(typeof(p2) == "function", "Expected arg #1 to be a function")
	end
	return setmetatable({
		[Type] = Type.Binding,
		[typeSymbol] = {
			subscribe = function(p12)
				return tbl.subscribe(p1, function(p1)
					p12(p2(p1))
				end)
			end,
			update = function(p1)
				error("Bindings created by Binding:map(fn) cannot be updated directly", 2)
			end,
			getValue = function()
				return p2(p1:getValue())
			end
		}
	}, tbl3)
end
function tbl.join(p1)
	if v1.typeChecks then
		assert(typeof(p1) == "table", "Expected arg #1 to be of type table")
		for k, v in pairs(p1) do
			if Type.of(v) ~= Type.Binding then
				error(("Expected arg #1 to contain only bindings, but key %q had a non-binding value"):format((tostring(k))), 2)
			end
		end
	end
	local tbl2 = {}
	local function getValue()
		local tbl = {}
		for k, v in pairs(p1) do
			tbl[k] = v:getValue()
		end
		return tbl
	end
	function tbl2.subscribe(p12)
		local tbl3 = {}
		for k, v in pairs(p1) do
			tbl3[k] = tbl.subscribe(v, function(p1)
				p12((getValue()))
			end)
		end
		return function()
			if tbl3 ~= nil then
				for k, v in pairs(tbl3) do
					v()
				end
				tbl3 = nil
			end
		end
	end
	function tbl2.update(p1)
		error("Bindings created by joinBindings(...) cannot be updated directly", 2)
	end
	function tbl2.getValue()
		return getValue()
	end
	return setmetatable({
		[Type] = Type.Binding,
		[typeSymbol] = tbl2
	}, tbl3)
end
return tbl
