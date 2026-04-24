-- Reviewed by Claude
-- variables reassigned
local createSignal = require(script.Parent.createSignal)
local Symbol = require(script.Parent.Symbol)
local Type = require(script.Parent.Type)
local config = require(script.Parent.GlobalConfig).get()
local typeSymbol = Symbol.named("BindingImpl")
local tableObj = {}
local tbl3 = {
	__index = {
		getValue = function(self)
			return tableObj.getValue(self)
		end,
		map = function(self, callback)
			return tableObj.map(self, callback)
		end
	},
	__tostring = function(self)
		return string.format("RoactBinding(%s)", (tostring(self:getValue())))
	end
}
function tableObj.update(self, callback)
	return self[typeSymbol].update(callback)
end
function tableObj.subscribe(self, callback)
	return self[typeSymbol].subscribe(callback)
end
function tableObj.getValue(self)
	return self[typeSymbol].getValue()
end
function tableObj.create(self)
	local tableObj = {
		value = self,
		changeSignal = createSignal()
	}
	function tableObj.subscribe(self)
		return tableObj.changeSignal:subscribe(self)
	end
	function tableObj.update(self)
		tableObj.value = self
		tableObj.changeSignal:fire(self)
	end
	function tableObj.getValue()
		return tableObj.value
	end
	return setmetatable({
		[Type] = Type.Binding,
		[typeSymbol] = tableObj
	}, tbl3), tableObj.update
end
function tableObj.map(self, callback)
	if config.typeChecks then
		local isBinding = Type.of(self) == Type.Binding
		assert(isBinding, "Expected arg #1 to be a binding")
		assert(typeof(callback) == "function", "Expected arg #1 to be a function")
	end
	return setmetatable({
		[Type] = Type.Binding,
		[typeSymbol] = {
			subscribe = function(param12)
				return tableObj.subscribe(self, function(self)
					param12(callback(self))
				end)
			end,
			update = function(self)
				error("Bindings created by Binding:map(fn) cannot be updated directly", 2)
			end,
			getValue = function()
				return callback(self:getValue())
			end
		}
	}, tbl3)
end
function tableObj.join(self)
	if config.typeChecks then
		assert(typeof(self) == "table", "Expected arg #1 to be of type table")
		for k, v in pairs(self) do
			if Type.of(v) ~= Type.Binding then
				error(("Expected arg #1 to contain only bindings, but key %q had a non-binding value"):format((tostring(k))), 2)
			end
		end
	end
	local tbl2 = {}
	local function getValue()
		local tableObj = {}
		for k, v in pairs(self) do
			tableObj[k] = v:getValue()
		end
		return tableObj
	end
	function tbl2.subscribe(param12)
		local tbl3 = {}
		for k, v in pairs(self) do
			tbl3[k] = tableObj.subscribe(v, function(self)
				param12((getValue()))
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
	function tbl2.update(self)
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
return tableObj
