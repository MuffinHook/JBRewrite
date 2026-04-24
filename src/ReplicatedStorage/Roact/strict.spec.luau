-- Reviewed by Claude
return function()
	local strict = require(script.Parent.strict)
	it("should error when getting a nonexistent key", function()
 local v1 = strict({
 a = 1,
 b = 2
 })
 expect(function()
 return v1.c
 end).to.throw()
	end)
	it("should error when setting a nonexistent key", function()
 local v1 = strict({
 a = 1,
 b = 2
 })
 expect(function()
 v1.c = 3
 end).to.throw()
	end)
end