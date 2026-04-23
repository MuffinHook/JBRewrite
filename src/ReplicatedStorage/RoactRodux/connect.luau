local Roact = require(script.Parent.Parent.Roact)
local shallowEqual = require(script.Parent.shallowEqual)
local join = require(script.Parent.join)
local StoreContext = require(script.Parent.StoreContext)
local function formatMessage(p1, p2) --[[ Line: 9 ]]
	return table.concat(p1, "\n"):format(unpack(p2 or {}))
end
local function noop() --[[ Line: 13 ]]
	return nil
end
local function makeStateUpdater(p1) --[[ Line: 26 | Upvalues: join (copy) ]]
	return function(p12, p2, p3) --[[ Line: 27 | Upvalues: p1 (copy), join (ref) ]]
		if p3 == nil then
			p3 = p2.mapStateToProps(p1:getState(), p12)
		end
		return {
			mappedStoreState = p3,
			propsForChild = join(p12, p3, p2.mappedStoreDispatch)
		}
	end
end
return function(p1, p2) --[[ Name: connect | Line: 50 | Upvalues: noop (copy), Roact (copy), join (copy), shallowEqual (copy), StoreContext (copy) ]]
	local v1 = debug.traceback()
	if p1 == nil then
		p1 = noop
	else
		assert(typeof(p1) == "function", "mapStateToProps must be a function or nil!")
	end
	local v3 = typeof(p2)
	if p2 == nil then
		p2 = noop
	else
		assert(v3 == "function" or v3 == "table", "mapDispatchToProps must be a function, table, or nil!")
	end
	return function(p12) --[[ Line: 69 | Upvalues: v1 (copy), Roact (ref), p1 (ref), v3 (copy), p2 (ref), join (ref), shallowEqual (ref), StoreContext (ref) ]]
		if p12 == nil then
			error(table.concat({ "connect returns a function that must be passed a component.", "Check the connection at:", "%s" }, "\n"):format(unpack({ v1 } or {})), 2)
		end
		local v4 = ("RoduxConnection(%s)"):format((tostring(p12)))
		local v5 = Roact.Component:extend(v4)
		function v5.getDerivedStateFromProps(p1, p2) --[[ Line: 86 ]]
			if p2.stateUpdater ~= nil then
				return p2.stateUpdater(p1.innerProps, p2)
			end
		end
		function v5.init(p13, p22) --[[ Line: 92 | Upvalues: p12 (copy), p1 (ref), v3 (ref), p2 (ref), join (ref) ]]
			p13.store = p22.store
			if p13.store == nil then
				local t = {}
				t[1] = tostring(p12)
				error((table.concat({ "Cannot initialize Roact-Rodux connection without being a descendent of StoreProvider!", "Tried to wrap component %q", "Make sure there is a StoreProvider above this component in the tree." }, "\n"):format(unpack(t or {}))))
			end
			local v5 = p13.store:getState()
			local v6 = p1
			local v7 = v6(v5, p13.props.innerProps)
			if typeof(v7) == "function" then
				v7, v6 = v7(v5, p13.props.innerProps), v7
			end
			if v7 ~= nil and typeof(v7) ~= "table" then
				local t = { tostring(v7), (typeof(v7)) }
				error((table.concat({ "mapStateToProps must either return a table, or return another function that returns a table.", "Instead, it returned %q, which is of type %s." }, "\n"):format(unpack(t or {}))))
			end
			local function dispatch(...) --[[ Line: 133 | Upvalues: p13 (copy) ]]
				return p13.store:dispatch(...)
			end
			local v12 = nil
			if v3 == "table" then
				v12 = {}
				for k, v in pairs(p2) do
					local v13
					v13 = typeof(v) == "function"
					assert(v13, "mapDispatchToProps must contain function values")
					v12[k] = function(...) --[[ Line: 144 | Upvalues: dispatch (copy), v (copy) ]]
						dispatch(v(...))
					end
				end
			elseif v3 == "function" then
				v12 = p2(dispatch)
			end
			local store = p13.store
			local function f15(p1, p2, p3) --[[ Line: 27 | Upvalues: store (copy), join (ref) ]]
				if p3 == nil then
					p3 = p2.mapStateToProps(store:getState(), p1)
				end
				return {
					mappedStoreState = p3,
					propsForChild = join(p1, p3, p2.mappedStoreDispatch)
				}
			end
			p13.state = {
				stateUpdater = f15,
				mapStateToProps = v6,
				mappedStoreDispatch = v12,
				propsForChild = nil
			}
			for k, v in pairs((f15(p13.props.innerProps, p13.state, v7))) do
				p13.state[k] = v
			end
		end
		function v5.didMount(p1) --[[ Line: 179 | Upvalues: shallowEqual (ref) ]]
			local function f1(p12) --[[ Line: 180 | Upvalues: p1 (copy), shallowEqual (ref) ]]
				p1:setState(function(p1, p2) --[[ Line: 181 | Upvalues: p12 (copy), shallowEqual (ref) ]]
					local v1 = p1.mapStateToProps(p12, p2.innerProps)
					if shallowEqual(v1, p1.mappedStoreState) then
						return nil
					else
						return p1.stateUpdater(p2.innerProps, p1, v1)
					end
				end)
			end
			local v2 = p1.store:getState()
			p1:setState(function(p1, p2) --[[ Line: 181 | Upvalues: v2 (copy), shallowEqual (ref) ]]
				local v1 = p1.mapStateToProps(v2, p2.innerProps)
				if shallowEqual(v1, p1.mappedStoreState) then
					return nil
				else
					return p1.stateUpdater(p2.innerProps, p1, v1)
				end
			end)
			p1.storeChangedConnection = p1.store.changed:connect(f1)
		end
		function v5.willUnmount(p1) --[[ Line: 203 ]]
			if p1.storeChangedConnection then
				p1.storeChangedConnection:disconnect()
				p1.storeChangedConnection = nil
			end
		end
		function v5.render(p1) --[[ Line: 210 | Upvalues: Roact (ref), p12 (copy) ]]
			return Roact.createElement(p12, p1.state.propsForChild)
		end
		local v6 = Roact.Component:extend(v4)
		function v6.render(p1) --[[ Line: 216 | Upvalues: Roact (ref), StoreContext (ref), v5 (copy) ]]
			return Roact.createElement(StoreContext.Consumer, {
				render = function(p12) --[[ Name: render | Line: 218 | Upvalues: Roact (ref), v5 (ref), p1 (copy) ]]
					return Roact.createElement(v5, {
						innerProps = p1.props,
						store = p12
					})
				end
			})
		end
		return v6
	end
end