return function() --[[ Line: 1 ]]
	local assertDeepEqual = require(script.Parent.assertDeepEqual)
	local createSpy = require(script.Parent.createSpy)
	local Logging = require(script.Parent.Logging)
	local SingleEventManager = require(script.Parent.SingleEventManager)
	describe("new", function() --[[ Line: 8 | Upvalues: SingleEventManager (copy) ]]
		it("should create a SingleEventManager", function() --[[ Line: 9 | Upvalues: SingleEventManager (ref) ]]
			expect((SingleEventManager.new())).to.be.ok()
		end)
	end)
	describe("connectEvent", function() --[[ Line: 16 | Upvalues: SingleEventManager (copy), createSpy (copy), assertDeepEqual (copy), Logging (copy) ]]
		it("should connect to events", function() --[[ Line: 17 | Upvalues: SingleEventManager (ref), createSpy (ref) ]]
			local v1 = Instance.new("BindableEvent")
			local v2 = SingleEventManager.new(v1)
			local v3 = createSpy()
			v2:connectEvent("Event", v3.value)
			v2:resume()
			v1:Fire("foo")
			expect(v3.callCount).to.equal(1)
			v3:assertCalledWith(v1, "foo")
			v1:Fire("bar")
			expect(v3.callCount).to.equal(2)
			v3:assertCalledWith(v1, "bar")
			v2:connectEvent("Event", nil)
			v1:Fire("baz")
			expect(v3.callCount).to.equal(2)
		end)
		it("should drop events until resumed initially", function() --[[ Line: 39 | Upvalues: SingleEventManager (ref), createSpy (ref) ]]
			local v1 = Instance.new("BindableEvent")
			local v2 = SingleEventManager.new(v1)
			local v3 = createSpy()
			v2:connectEvent("Event", v3.value)
			v1:Fire("foo")
			expect(v3.callCount).to.equal(0)
			v2:resume()
			v1:Fire("bar")
			expect(v3.callCount).to.equal(1)
			v3:assertCalledWith(v1, "bar")
		end)
		it("should invoke suspended events when resumed", function() --[[ Line: 56 | Upvalues: SingleEventManager (ref), createSpy (ref) ]]
			local v1 = Instance.new("BindableEvent")
			local v2 = SingleEventManager.new(v1)
			local v3 = createSpy()
			v2:connectEvent("Event", v3.value)
			v2:resume()
			v1:Fire("foo")
			expect(v3.callCount).to.equal(1)
			v3:assertCalledWith(v1, "foo")
			v2:suspend()
			v1:Fire("bar")
			expect(v3.callCount).to.equal(1)
			v2:resume()
			expect(v3.callCount).to.equal(2)
			v3:assertCalledWith(v1, "bar")
		end)
		it("should invoke events triggered during resumption in the correct order", function() --[[ Line: 78 | Upvalues: SingleEventManager (ref), createSpy (ref), assertDeepEqual (ref) ]]
			local v1 = Instance.new("BindableEvent")
			local v2 = SingleEventManager.new(v1)
			local t = {}
			local v3 = createSpy(function(p1, p2) --[[ Line: 83 | Upvalues: t (copy), v1 (copy) ]]
				table.insert(t, p2)
				if p2 == 2 then
					v1:Fire(3)
				elseif p2 == 3 then
					v1:Fire(4)
				end
			end)
			v2:connectEvent("Event", v3.value)
			v2:suspend()
			v1:Fire(1)
			v1:Fire(2)
			v2:resume()
			expect(v3.callCount).to.equal(4)
			assertDeepEqual(t, { 1, 2, 3, 4 })
		end)
		it("should not invoke events fired during suspension but disconnected before resumption", function() --[[ Line: 104 | Upvalues: SingleEventManager (ref), createSpy (ref) ]]
			local v1 = Instance.new("BindableEvent")
			local v2 = SingleEventManager.new(v1)
			local v3 = createSpy()
			v2:connectEvent("Event", v3.value)
			v2:suspend()
			v1:Fire(1)
			v2:connectEvent("Event", nil)
			v2:resume()
			expect(v3.callCount).to.equal(0)
		end)
		it("should not yield events through the SingleEventManager when resuming", function() --[[ Line: 120 | Upvalues: SingleEventManager (ref) ]]
			local v1 = Instance.new("BindableEvent")
			local v2 = SingleEventManager.new(v1)
			v2:connectEvent("Event", function() --[[ Line: 124 ]]
				coroutine.yield()
			end)
			v2:resume()
			local v3 = coroutine.create(function() --[[ Line: 130 | Upvalues: v1 (copy) ]]
				v1:Fire(5)
			end)
			assert(coroutine.resume(v3))
			expect(coroutine.status(v3)).to.equal("dead")
			v2:suspend()
			v1:Fire(5)
			local v4 = coroutine.create(function() --[[ Line: 140 | Upvalues: v2 (copy) ]]
				v2:resume()
			end)
			assert(coroutine.resume(v4))
			expect(coroutine.status(v4)).to.equal("dead")
		end)
		it("should not throw errors through SingleEventManager when resuming", function() --[[ Line: 148 | Upvalues: SingleEventManager (ref), Logging (ref) ]]
			local v1 = Instance.new("BindableEvent")
			local v2 = SingleEventManager.new(v1)
			v2:connectEvent("Event", function() --[[ Line: 154 ]]
				error("Error from SingleEventManager test")
			end)
			v2:resume()
			v2:suspend()
			v1:Fire(5)
			local v3 = Logging.capture(function() --[[ Line: 167 | Upvalues: v2 (copy) ]]
				v2:resume()
			end)
			expect(#v3.errors).to.equal(0)
			expect(#v3.warnings).to.equal(1)
			expect(#v3.infos).to.equal(0)
			expect(v3.warnings[1]:find("Error from SingleEventManager test")).to.be.ok()
		end)
		it("should not overflow with events if manager:resume() is invoked when resuming a suspended event", function() --[[ Line: 178 | Upvalues: SingleEventManager (ref), createSpy (ref) ]]
			local v1 = Instance.new("BindableEvent")
			local v2 = SingleEventManager.new(v1)
			local v3 = createSpy(function(p1, p2) --[[ Line: 186 | Upvalues: v2 (copy), v1 (copy) ]]
				if p2 == 1 then
					v2:suspend()
					v1:Fire(2)
					v2:resume()
				end
			end)
			v2:connectEvent("Event", v3.value)
			v2:suspend()
			v1:Fire(1)
			v2:resume()
			expect(v3.callCount).to.equal(2)
		end)
	end)
	describe("connectPropertyChange", function() --[[ Line: 204 | Upvalues: SingleEventManager (copy), createSpy (copy) ]]
		it("should connect to property changes", function() --[[ Line: 208 | Upvalues: SingleEventManager (ref), createSpy (ref) ]]
			local baz = Instance.new("Folder")
			local v1 = SingleEventManager.new(baz)
			local v2 = createSpy()
			v1:connectPropertyChange("Name", v2.value)
			v1:resume()
			baz.Name = "foo"
			expect(v2.callCount).to.equal(1)
			v2:assertCalledWith(baz)
			baz.Name = "bar"
			expect(v2.callCount).to.equal(2)
			v2:assertCalledWith(baz)
			v1:connectPropertyChange("Name")
			baz.Name = "baz"
			expect(v2.callCount).to.equal(2)
		end)
		it("should throw an error if the property is invalid", function() --[[ Line: 230 | Upvalues: SingleEventManager (ref) ]]
			local v2 = SingleEventManager.new((Instance.new("Folder")))
			expect(function() --[[ Line: 234 | Upvalues: v2 (copy) ]]
				v2:connectPropertyChange("foo", function() --[[ Line: 235 ]] end)
			end).to.throw()
		end)
	end)
end