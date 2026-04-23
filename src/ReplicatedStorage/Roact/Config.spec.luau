return function() --[[ Line: 1 ]]
	local Config = require(script.Parent.Config)
	it("should accept valid configuration", function() --[[ Line: 4 | Upvalues: Config (copy) ]]
		local v1 = Config.new()
		local v2 = v1.get()
		expect(v2.elementTracing).to.equal(false)
		v1.set({
			elementTracing = true
		})
		expect(v2.elementTracing).to.equal(true)
	end)
	it("should reject invalid configuration keys", function() --[[ Line: 17 | Upvalues: Config (copy) ]]
		local v1 = Config.new()
		local v2, v3 = pcall(function() --[[ Line: 22 | Upvalues: v1 (copy) ]]
			v1.set({
				garblegoop = true
			})
		end)
		expect(v2).to.equal(false)
		expect(v3:find("garblegoop")).to.be.ok()
	end)
	it("should reject invalid configuration values", function() --[[ Line: 34 | Upvalues: Config (copy) ]]
		local v1 = Config.new()
		local v2, v3 = pcall(function() --[[ Line: 40 | Upvalues: v1 (copy) ]]
			v1.set({
				elementTracing = "Hello there!"
			})
		end)
		expect(v2).to.equal(false)
		expect(v3:find("elementTracing")).to.be.ok()
		expect(v3:find("Hello there!")).to.be.ok()
	end)
end