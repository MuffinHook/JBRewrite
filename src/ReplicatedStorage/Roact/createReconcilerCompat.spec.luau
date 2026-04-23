return function() --[[ Line: 1 ]]
	local createElement = require(script.Parent.createElement)
	local createReconciler = require(script.Parent.createReconciler)
	local Logging = require(script.Parent.Logging)
	local NoopRenderer = require(script.Parent.NoopRenderer)
	local createReconcilerCompat = require(script.Parent.createReconcilerCompat)
	local v1 = createReconciler(NoopRenderer)
	local v2 = createReconcilerCompat(v1)
	it("reify should only warn once per call site", function() --[[ Line: 12 | Upvalues: Logging (copy), v2 (copy), createElement (copy), v1 (copy) ]]
		local v12 = Logging.capture(function() --[[ Line: 13 | Upvalues: v2 (ref), createElement (ref), v1 (ref) ]]
			v1.unmountVirtualTree((v2.reify(createElement("StringValue"))))
			v1.unmountVirtualTree((v2.reify(createElement("StringValue"))))
		end)
		expect(#v12.warnings).to.equal(1)
		expect(v12.warnings[1]:find("reify")).to.be.ok()
		local v22 = Logging.capture(function() --[[ Line: 25 | Upvalues: v2 (ref), createElement (ref), v1 (ref) ]]
			v1.unmountVirtualTree((v2.reify(createElement("StringValue"))))
		end)
		expect(#v22.warnings).to.equal(1)
		expect(v22.warnings[1]:find("reify")).to.be.ok()
	end)
	it("teardown should only warn once per call site", function() --[[ Line: 35 | Upvalues: Logging (copy), v1 (copy), createElement (copy), v2 (copy) ]]
		local v12 = Logging.capture(function() --[[ Line: 36 | Upvalues: v1 (ref), createElement (ref), v2 (ref) ]]
			v2.teardown((v1.mountVirtualTree(createElement("StringValue"))))
			v2.teardown((v1.mountVirtualTree(createElement("StringValue"))))
		end)
		expect(#v12.warnings).to.equal(1)
		expect(v12.warnings[1]:find("teardown")).to.be.ok()
		local v22 = Logging.capture(function() --[[ Line: 48 | Upvalues: v1 (ref), createElement (ref), v2 (ref) ]]
			v2.teardown((v1.mountVirtualTree(createElement("StringValue"))))
		end)
		expect(#v22.warnings).to.equal(1)
		expect(v22.warnings[1]:find("teardown")).to.be.ok()
	end)
	it("update should only warn once per call site", function() --[[ Line: 58 | Upvalues: Logging (copy), v1 (copy), createElement (copy), v2 (copy) ]]
		local v12 = Logging.capture(function() --[[ Line: 59 | Upvalues: v1 (ref), createElement (ref), v2 (ref) ]]
			for i = 1, 2 do
				local v12 = v1.mountVirtualTree(createElement("StringValue"))
				v2.reconcile(v12, createElement("StringValue"))
				v1.unmountVirtualTree(v12)
			end
		end)
		expect(#v12.warnings).to.equal(1)
		expect(v12.warnings[1]:find("reconcile")).to.be.ok()
		local v22 = Logging.capture(function() --[[ Line: 72 | Upvalues: v1 (ref), createElement (ref), v2 (ref) ]]
			local v12 = v1.mountVirtualTree(createElement("StringValue"))
			v2.reconcile(v12, createElement("StringValue"))
			v1.unmountVirtualTree(v12)
		end)
		expect(#v22.warnings).to.equal(1)
		expect(v22.warnings[1]:find("reconcile")).to.be.ok()
	end)
end