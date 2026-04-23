return function() --[[ Line: 1 ]]
	local connect = require(script.Parent.connect)
	local StoreProvider = require(script.Parent.StoreProvider)
	local Roact = require(script.Parent.Parent.Roact)
	local Rodux = require(script.Parent.Parent.Rodux)
	local function noop() --[[ Line: 9 ]]
		return nil
	end
	local function NoopComponent() --[[ Line: 13 ]]
		return nil
	end
	local function countReducer(p1, p2) --[[ Line: 17 ]]
		local v1 = p1 or 0
		if p2.type == "increment" then
			return v1 + 1
		else
			return v1
		end
	end
	local v1 = Rodux.combineReducers({
		count = countReducer
	})
	describe("Argument validation", function() --[[ Line: 31 | Upvalues: connect (copy), noop (copy) ]]
		it("should accept no arguments", function() --[[ Line: 32 | Upvalues: connect (ref) ]]
			connect()
		end)
		it("should accept one function", function() --[[ Line: 36 | Upvalues: connect (ref), noop (ref) ]]
			connect(noop)
		end)
		it("should accept two functions", function() --[[ Line: 40 | Upvalues: connect (ref), noop (ref) ]]
			connect(noop, noop)
		end)
		it("should accept only the second function", function() --[[ Line: 44 | Upvalues: connect (ref) ]]
			connect(nil, function() --[[ Line: 45 ]] end)
		end)
		it("should accept one table of action creators", function() --[[ Line: 48 | Upvalues: connect (ref) ]]
			connect(nil, {
				foo = function() --[[ Name: foo | Line: 50 ]] end
			})
		end)
		it("should throw if not passed a component", function() --[[ Line: 54 | Upvalues: connect (ref) ]]
			local function f1(p1) --[[ Line: 55 ]]
				return {}
			end
			expect(function() --[[ Line: 59 | Upvalues: connect (ref), f1 (copy) ]]
				connect(f1)(nil)
			end).to.throw()
		end)
	end)
	it("should throw if not mounted under a StoreProvider", function() --[[ Line: 65 | Upvalues: connect (copy), NoopComponent (copy), Roact (copy) ]]
		local v1 = connect()(NoopComponent)
		expect(function() --[[ Line: 68 | Upvalues: Roact (ref), v1 (copy) ]]
			Roact.mount(Roact.createElement(v1))
		end).to.throw()
	end)
	it("should accept a higher-order function mapStateToProps", function() --[[ Line: 73 | Upvalues: connect (copy), NoopComponent (copy), Rodux (copy), v1 (copy), Roact (copy), StoreProvider (copy) ]]
		local v12 = connect(function() --[[ Name: mapStateToProps | Line: 74 ]]
			return function(p1) --[[ Line: 75 ]]
				return {
					count = p1.count
				}
			end
		end)(NoopComponent)
		Roact.unmount((Roact.mount((Roact.createElement(StoreProvider, {
			store = Rodux.Store.new(v1)
		}, {
			someComponent = Roact.createElement(v12)
		})))))
	end)
	it("should not accept a higher-order mapStateToProps that returns a non-table value", function() --[[ Line: 96 | Upvalues: connect (copy), NoopComponent (copy), Rodux (copy), v1 (copy), Roact (copy), StoreProvider (copy) ]]
		local v12 = connect(function() --[[ Name: mapStateToProps | Line: 97 ]]
			return function(p1) --[[ Line: 98 ]]
				return "nope"
			end
		end)(NoopComponent)
		local v3 = Roact.createElement(StoreProvider, {
			store = Rodux.Store.new(v1)
		}, {
			someComponent = Roact.createElement(v12)
		})
		expect(function() --[[ Line: 112 | Upvalues: Roact (ref), v3 (copy) ]]
			Roact.mount(v3)
		end).to.throw()
	end)
	it("should not accept a mapStateToProps that returns a non-table value", function() --[[ Line: 117 | Upvalues: connect (copy), NoopComponent (copy), Rodux (copy), v1 (copy), Roact (copy), StoreProvider (copy) ]]
		local v12 = connect(function() --[[ Name: mapStateToProps | Line: 118 ]]
			return "nah"
		end)(NoopComponent)
		local v3 = Roact.createElement(StoreProvider, {
			store = Rodux.Store.new(v1)
		}, {
			someComponent = Roact.createElement(v12)
		})
		expect(function() --[[ Line: 131 | Upvalues: Roact (ref), v3 (copy) ]]
			Roact.mount(v3)
		end).to.throw()
	end)
	it("should abort renders when mapStateToProps returns the same data", function() --[[ Line: 136 | Upvalues: connect (copy), Rodux (copy), v1 (copy), Roact (copy), StoreProvider (copy) ]]
		local function mapStateToProps(p1) --[[ Line: 137 ]]
			return {
				count = p1.count
			}
		end
		local v12 = 0
		local function SomeComponent(p1) --[[ Line: 144 | Upvalues: v12 (ref) ]]
			v12 = v12 + 1
		end
		local v2 = connect(mapStateToProps)(SomeComponent)
		local v3 = Rodux.Store.new(v1)
		local v5 = Roact.mount((Roact.createElement(StoreProvider, {
			store = v3
		}, {
			someComponent = Roact.createElement(v2)
		})))
		expect(v12).to.equal(1)
		v3:dispatch({
			type = "an unknown action"
		})
		v3:flush()
		expect(v12).to.equal(1)
		v3:dispatch({
			type = "increment"
		})
		v3:flush()
		expect(v12).to.equal(2)
		Roact.unmount(v5)
	end)
	it("should only call mapDispatchToProps once and never re-render if no mapStateToProps was passed", function() --[[ Line: 174 | Upvalues: connect (copy), Rodux (copy), v1 (copy), Roact (copy), StoreProvider (copy) ]]
		local v12 = 0
		local function f2(p1) --[[ Line: 176 | Upvalues: v12 (ref) ]]
			v12 = v12 + 1
			return {
				increment = function() --[[ Name: increment | Line: 180 | Upvalues: p1 (copy) ]]
					return p1({
						type = "increment"
					})
				end
			}
		end
		local v3 = 0
		local function SomeComponent(p1) --[[ Line: 187 | Upvalues: v3 (ref) ]]
			v3 = v3 + 1
		end
		local v4 = connect(nil, f2)(SomeComponent)
		local v5 = Rodux.Store.new(v1)
		local v7 = Roact.mount((Roact.createElement(StoreProvider, {
			store = v5
		}, {
			someComponent = Roact.createElement(v4)
		})))
		expect(v12).to.equal(1)
		expect(v3).to.equal(1)
		v5:dispatch({
			type = "an unknown action"
		})
		v5:flush()
		expect(v12).to.equal(1)
		expect(v3).to.equal(1)
		v5:dispatch({
			type = "increment"
		})
		v5:flush()
		expect(v12).to.equal(1)
		expect(v3).to.equal(1)
		Roact.unmount(v7)
	end)
	it("should dispatch the action using a table of action creators", function() --[[ Line: 220 | Upvalues: connect (copy), Rodux (copy), v1 (copy), Roact (copy), StoreProvider (copy) ]]
		local t = {
			increment = function() --[[ Name: increment | Line: 222 ]]
				return {
					type = "increment"
				}
			end
		}
		local function SomeComponent(p1) --[[ Line: 229 ]]
			p1.increment()
		end
		local v12 = connect(nil, t)(SomeComponent)
		local v2 = Rodux.Store.new(v1)
		local v4 = Roact.mount((Roact.createElement(StoreProvider, {
			store = v2
		}, {
			someComponent = Roact.createElement(v12)
		})))
		v2.changed:connect(function(p1) --[[ Line: 244 ]]
			expect(p1.count).to.equal(1)
		end)
		Roact.unmount(v4)
	end)
	it("should return result values from the dispatch passed to mapDispatchToProps", function() --[[ Line: 251 | Upvalues: connect (copy), Rodux (copy), Roact (copy), StoreProvider (copy) ]]
		local function reducer() --[[ Line: 252 ]]
			return 0
		end
		local function fiveThunk() --[[ Line: 256 ]]
			return 5
		end
		local v1 = nil
		local function SomeComponent(p1) --[[ Line: 261 | Upvalues: v1 (ref) ]]
			v1 = p1.dispatch
		end
		local v2 = connect(nil, function(p1) --[[ Name: mapDispatchToProps | Line: 265 ]]
			return {
				dispatch = p1
			}
		end)(SomeComponent)
		local v5 = Roact.mount((Roact.createElement(StoreProvider, {
			store = Rodux.Store.new(reducer, nil, { Rodux.thunkMiddleware })
		}, {
			someComponent = Roact.createElement(v2)
		})))
		expect(v1).to.be.a("function")
		expect(v1(fiveThunk)).to.equal(5)
		Roact.unmount(v5)
	end)
	it("should allow fields to be assigned on connected components", function() --[[ Line: 289 | Upvalues: connect (copy), NoopComponent (copy) ]]
		local v1 = connect(function(p1) --[[ Name: mapStateToProps | Line: 290 ]]
			return {
				count = p1.count
			}
		end)(NoopComponent)
		expect(function() --[[ Line: 298 | Upvalues: v1 (copy) ]]
			v1.SomeEnum = {
				Value = 1
			}
		end).never.to.throw()
		expect(v1.SomeEnum).to.be.ok()
		expect(v1.SomeEnum.Value).to.equal(1)
	end)
	it("should never pass the store and innerProps to `mapStateToProps`", function() --[[ Line: 309 | Upvalues: connect (copy), NoopComponent (copy), Rodux (copy), v1 (copy), Roact (copy), StoreProvider (copy) ]]
		local t = {}
		local v12 = nil
		local v2 = connect(function(p1, p2) --[[ Name: mapStateToProps | Line: 312 | Upvalues: v12 (ref), t (copy) ]]
			v12 = p2
			expect(p2.store).to.equal(nil)
			expect(p2.innerProps).to.equal(nil)
			expect(p2.somePropName).to.equal(t)
			return {
				count = p1.count
			}
		end)(NoopComponent)
		local v3 = Rodux.Store.new(v1)
		local v5 = Roact.mount((Roact.createElement(StoreProvider, {
			store = v3
		}, {
			parent = Roact.createElement(v2, {
				somePropName = t
			})
		})))
		v3:dispatch({
			type = "increment"
		})
		v3:flush()
		expect(v12.store).to.equal(nil)
		expect(v12.innerProps).to.equal(nil)
		expect(v12.somePropName).to.equal(t)
		Roact.unmount(v5)
	end)
end