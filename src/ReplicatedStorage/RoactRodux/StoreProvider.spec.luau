-- Reviewed by Claude
return function()
	local StoreProvider = require(script.Parent.StoreProvider)
	local Roact = require(script.Parent.Parent.Roact)
	local Rodux = require(script.Parent.Parent.Rodux)
	it("should be instantiable as a component", function()
 local fn = Rodux.Store.new(function()
 return 0
 end)
 local v2 = Roact.createElement(StoreProvider, {
 store = fn
 })
 expect(v2).to.be.ok()
 Roact.unmount((Roact.mount(v2, nil, "StoreProvider-test")))
 fn:destruct()
	end)
	it("should expect a \'store\' prop", function()
 local fn = Roact.createElement(StoreProvider)
 expect(function()
 Roact.mount(fn)
 end).to.throw()
	end)
	it("should accept a single child", function()
 local fn = Rodux.Store.new(function()
 return 0
 end)
 local v2 = Instance.new("Folder")
 local v3 = Roact.createElement(StoreProvider, {
 store = fn
 }, {
 test1 = Roact.createElement("Frame")
 })
 expect(v3).to.be.ok()
 local v4 = Roact.mount(v3, v2, "StoreProvider-test")
 local v5 = v2:FindFirstChild("StoreProvider-test", true)
 expect(v5).to.be.ok()
 expect(v5:IsA("Frame")).to.equal(true)
 Roact.unmount(v4)
 fn:destruct()
	end)
end