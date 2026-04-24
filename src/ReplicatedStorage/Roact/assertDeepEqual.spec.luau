-- Reviewed by Claude
-- variables reassigned
return function()
	local assertDeepEqual = require(script.Parent.assertDeepEqual)
	it("should fail with a message when args are not equal", function()
 local v1, v2 = pcall(assertDeepEqual, 1, 2)
 expect(v1).to.equal(false)
 expect(v2:find("first ~= second")).to.be.ok()
 local newState, currentState = pcall(assertDeepEqual, {
 foo = 1
 }, {
 foo = 2
 })
 expect(newState).to.equal(false)
 expect(currentState:find("first%[foo%] ~= second%[foo%]")).to.be.ok()
	end)
	it("should compare non-table values using standard \'==\' equality", function()
 assertDeepEqual(1, 1)
 assertDeepEqual("hello", "hello")
 assertDeepEqual(nil, nil)
 local function f1() end
 assertDeepEqual(f1, f1)
 assertDeepEqual({
 foo = f1
 }, {
 foo = f1
 })
	end)
	it("should fail when types differ", function()
 local v1, v2 = pcall(assertDeepEqual, 1, "1")
 expect(v1).to.equal(false)
 expect(v2:find("first is of type number, but second is of type string")).to.be.ok()
	end)
	it("should compare (and report about) nested tables", function()
 local t = {
 foo = "bar",
 nested = {
 foo = 1,
 bar = 2
 }
 }
 assertDeepEqual(t, {
 foo = "bar",
 nested = {
 foo = 1,
 bar = 2
 }
 })
 local v1, v2 = pcall(assertDeepEqual, t, {
 foo = "bar",
 nested = {
 foo = 1,
 bar = 3
 }
 })
 expect(v1).to.equal(false)
 expect(v2:find("first%[nested%]%[bar%] ~= second%[nested%]%[bar%]")).to.be.ok()
	end)
	it("should be commutative", function()
 local t = {
 foo = "bar",
 hello = "world"
 }
 local tbl2 = {
 foo = "bar",
 hello = "world"
 }
 assertDeepEqual(t, tbl2)
 assertDeepEqual(tbl2, t)
 local metadata = {
 foo = "bar"
 }
 expect(function()
 assertDeepEqual(t, metadata)
 end).to.throw()
 expect(function()
 assertDeepEqual(metadata, t)
 end).to.throw()
	end)
end
