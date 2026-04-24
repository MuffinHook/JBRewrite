-- Reviewed by Claude
return function()
	local createReducer = require(script.Parent.createReducer)
	it("should handle actions", function()
 local v1 = createReducer({
 a = 0,
 b = 0
 }, {
 a = function(p1, p2)
 return {
 a = p1.a + 1,
 b = p1.b
 }
 end,
 b = function(p1, p2)
 return {
 a = p1.a,
 b = p1.b + 2
 }
 end
 })
 local v2 = v1({
 a = 0,
 b = 0
 }, {
 type = "a"
 })
 expect(v2.a).to.equal(1)
 expect(v1(v2, {
 type = "b"
 }).b).to.equal(2)
	end)
	it("should return the initial state if the state is nil", function()
 local v1 = createReducer({
 a = 0,
 b = 0
 }, {})(nil, {})
 expect(v1).to.be.ok()
 expect(v1.a).to.equal(0)
 expect(v1.b).to.equal(0)
	end)
	it("should still run action handlers if the state is nil", function()
 local v1 = 0
 local v2 = createReducer(0, {
 foo = function(p1, p2)
 v1 = v1 + 1
 return nil
 end
 })
 expect(v1).to.equal(0)
 local v3 = v2(nil, {
 type = "foo"
 })
 expect(v1).to.equal(1)
 expect(v3).to.equal(nil)
 local v4 = v2(v3, {
 type = "foo"
 })
 expect(v1).to.equal(2)
 expect(v4).to.equal(nil)
	end)
	it("should return the same state if the action is not handled", function()
 local t = {
 a = 0,
 b = 0
 }
 expect((createReducer(t, {
 a = function(p1, p2)
 return {
 a = p1.a + 1,
 b = p1.b
 }
 end,
 b = function(p1, p2)
 return {
 a = p1.a,
 b = p1.b + 2
 }
 end
 })(t, {
 type = "c"
 }))).to.equal(t)
	end)
end