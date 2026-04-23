return function() --[[ Line: 1 ]]
	local Type = require(script.Parent.Parent.Type)
	local v1 = require(script.Parent.Event)
	it("should yield event objects when indexed", function() --[[ Line: 6 | Upvalues: Type (copy), v1 (copy) ]]
		expect(Type.of(v1.MouseButton1Click)).to.equal(Type.HostEvent)
		expect(Type.of(v1.Touched)).to.equal(Type.HostEvent)
	end)
	it("should yield the same object when indexed again", function() --[[ Line: 11 | Upvalues: v1 (copy) ]]
		local MouseButton1Click = v1.MouseButton1Click
		expect(MouseButton1Click).to.equal(v1.MouseButton1Click)
		expect(MouseButton1Click).never.to.equal(v1.Touched)
	end)
end