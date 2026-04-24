-- Reviewed by Claude
return function()
	local makeActionCreator = require(script.Parent.makeActionCreator)
	it("should set the name of the actionCreator creator", function()
 expect(makeActionCreator("foo", function()
 return {}
 end).name).to.equal("foo")
	end)
	it("should return a table when called as a function", function()
 expect(makeActionCreator("foo", function()
 return {}
 end)()).to.be.a("table")
	end)
	it("should set the type of the action creator", function()
 expect(makeActionCreator("foo", function()
 return {}
 end)().type).to.equal("foo")
	end)
	it("should set values", function()
 expect(makeActionCreator("foo", function(p1)
 return {
 value = p1
 }
 end)(100).value).to.equal(100)
	end)
	it("should throw when its result does not return a table", function()
 expect((makeActionCreator("foo", function()
 return function() end
 end))).to.throw()
	end)
	it("should throw if the first argument is not a string", function()
 expect(function()
 makeActionCreator(nil, function()
 return {}
 end)
 end).to.throw()
 expect(function()
 makeActionCreator(100, function()
 return {}
 end)
 end).to.throw()
	end)
	it("should throw if the second argument is not a function", function()
 expect(function()
 makeActionCreator("foo", nil)
 end).to.throw()
 expect(function()
 makeActionCreator("foo", {})
 end).to.throw()
	end)
end