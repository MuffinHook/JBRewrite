-- Reviewed by Claude
return function()
	local createElement = require(script.Parent.createElement)
	local oneChild = require(script.Parent.oneChild)
	it("should get zero children from a table", function()
 expect(oneChild({})).to.equal(nil)
	end)
	it("should get exactly one child", function()
 local v1 = createElement("Frame")
 expect(oneChild({
 foo = v1
 })).to.equal(v1)
	end)
	it("should error with more than one child", function()
 local t = {
 a = createElement("Frame"),
 b = createElement("Frame")
 }
 expect(function()
 oneChild(t)
 end).to.throw()
	end)
	it("should handle being passed nil", function()
 expect(oneChild(nil)).to.equal(nil)
	end)
end