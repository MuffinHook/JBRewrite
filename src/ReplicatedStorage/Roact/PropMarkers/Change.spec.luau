return function() --[[ Line: 1 ]]
	local Type = require(script.Parent.Parent.Type)
	local Change = require(script.Parent.Change)
	it("should yield change listener objects when indexed", function() --[[ Line: 6 | Upvalues: Type (copy), Change (copy) ]]
		expect(Type.of(Change.Text)).to.equal(Type.HostChangeEvent)
		expect(Type.of(Change.Selected)).to.equal(Type.HostChangeEvent)
	end)
	it("should yield the same object when indexed again", function() --[[ Line: 11 | Upvalues: Change (copy) ]]
		local Text = Change.Text
		expect(Text).to.equal(Change.Text)
		expect(Text).never.to.equal(Change.Selected)
	end)
end