-- Reviewed by Claude
-- variables reassigned
return function()
	local Config = require(script.Parent.Config)
	it("should accept valid configuration", function()
		local state1 = Config.new()
		local state2 = state1.get()
		expect(state2.elementTracing).to.equal(false)
		state1.set({
			elementTracing = true
		})
		expect(state2.elementTracing).to.equal(true)
	end)
	it("should reject invalid configuration keys", function()
		local state1 = Config.new()
		local state2, newState = pcall(function()
			state1.set({
				garblegoop = true
			})
		end)
		expect(state2).to.equal(false)
		expect(newState:find("garblegoop")).to.be.ok()
	end)
	it("should reject invalid configuration values", function()
		local state1 = Config.new()
		local state2, newState = pcall(function()
			state1.set({
				elementTracing = "Hello there!"
			})
		end)
		expect(state2).to.equal(false)
		expect(newState:find("elementTracing")).to.be.ok()
		expect(newState:find("Hello there!")).to.be.ok()
	end)
end
