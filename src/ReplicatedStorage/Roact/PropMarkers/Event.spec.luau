-- Reviewed by Claude
-- variables reassigned
return function()
	local Type = require(script.Parent.Parent.Type)
	local module1 = require(script.Parent.Event)
	it("should yield event objects when indexed", function()
 expect(Type.of(module1.MouseButton1Click)).to.equal(Type.HostEvent)
 expect(Type.of(module1.Touched)).to.equal(Type.HostEvent)
	end)
	it("should yield the same object when indexed again", function()
 local MouseButton1Click = module1.MouseButton1Click
 expect(MouseButton1Click).to.equal(module1.MouseButton1Click)
 expect(MouseButton1Click).never.to.equal(module1.Touched)
	end)
end