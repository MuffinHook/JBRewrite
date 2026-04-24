-- Reviewed by Claude
return function()
	local Config = require(script.Parent.Config)
	it("should accept valid configuration", function()
		local v1 = Config.new()
		local v2 = v1.get()
		expect(v2.elementTracing).to.equal(false)
		v1.set({
			elementTracing = true
		})
		expect(v2.elementTracing).to.equal(true)
	end)
	it("should reject invalid configuration keys", function()
		local v1 = Config.new()
		local v2, v3 = pcall(function()
			v1.set({
				garblegoop = true
			})
		end)
		expect(v2).to.equal(false)
		expect(v3:find("garblegoop")).to.be.ok()
	end)
	it("should reject invalid configuration values", function()
		local v1 = Config.new()
		local v2, v3 = pcall(function()
			v1.set({
				elementTracing = "Hello there!"
			})
		end)
		expect(v2).to.equal(false)
		expect(v3:find("elementTracing")).to.be.ok()
		expect(v3:find("Hello there!")).to.be.ok()
	end)
end
