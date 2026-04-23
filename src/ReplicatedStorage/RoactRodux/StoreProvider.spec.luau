return function() --[[ Line: 1 ]]
	local StoreProvider = require(script.Parent.StoreProvider)
	local Roact = require(script.Parent.Parent.Roact)
	local Rodux = require(script.Parent.Parent.Rodux)
	it("should be instantiable as a component", function() --[[ Line: 7 | Upvalues: Rodux (copy), Roact (copy), StoreProvider (copy) ]]
		local v1 = Rodux.Store.new(function() --[[ Line: 8 ]]
			return 0
		end)
		local v2 = Roact.createElement(StoreProvider, {
			store = v1
		})
		expect(v2).to.be.ok()
		Roact.unmount((Roact.mount(v2, nil, "StoreProvider-test")))
		v1:destruct()
	end)
	it("should expect a \'store\' prop", function() --[[ Line: 23 | Upvalues: Roact (copy), StoreProvider (copy) ]]
		local v1 = Roact.createElement(StoreProvider)
		expect(function() --[[ Line: 26 | Upvalues: Roact (ref), v1 (copy) ]]
			Roact.mount(v1)
		end).to.throw()
	end)
	it("should accept a single child", function() --[[ Line: 31 | Upvalues: Rodux (copy), Roact (copy), StoreProvider (copy) ]]
		local v1 = Rodux.Store.new(function() --[[ Line: 32 ]]
			return 0
		end)
		local v2 = Instance.new("Folder")
		local v3 = Roact.createElement(StoreProvider, {
			store = v1
		}, {
			test1 = Roact.createElement("Frame")
		})
		expect(v3).to.be.ok()
		local v4 = Roact.mount(v3, v2, "StoreProvider-test")
		local v5 = v2:FindFirstChild("StoreProvider-test", true)
		expect(v5).to.be.ok()
		expect(v5:IsA("Frame")).to.equal(true)
		Roact.unmount(v4)
		v1:destruct()
	end)
end