-- Reviewed by Claude
return function()
	local Component = require(script.Parent.Component)
	local ElementKind = require(script.Parent.ElementKind)
	local GlobalConfig = require(script.Parent.GlobalConfig)
	local Logging = require(script.Parent.Logging)
	local Type = require(script.Parent.Type)
	local Portal = require(script.Parent.Portal)
	local Children = require(script.Parent.PropMarkers.Children)
	local createElement = require(script.Parent.createElement)
	it("should create new primitive elements", function()
 local v1 = createElement("Frame")
 expect(v1).to.be.ok()
 expect(Type.of(v1)).to.equal(Type.Element)
 expect(ElementKind.of(v1)).to.equal(ElementKind.Host)
	end)
	it("should create new functional elements", function()
 local v1 = createElement(function() end)
 expect(v1).to.be.ok()
 expect(Type.of(v1)).to.equal(Type.Element)
 expect(ElementKind.of(v1)).to.equal(ElementKind.Function)
	end)
	it("should create new stateful components", function()
 local v1 = createElement((Component:extend("Foo")))
 expect(v1).to.be.ok()
 expect(Type.of(v1)).to.equal(Type.Element)
 expect(ElementKind.of(v1)).to.equal(ElementKind.Stateful)
	end)
	it("should create new portal elements", function()
 local v1 = createElement(Portal)
 expect(v1).to.be.ok()
 expect(Type.of(v1)).to.equal(Type.Element)
 expect(ElementKind.of(v1)).to.equal(ElementKind.Portal)
	end)
	it("should accept props", function()
 local v1 = createElement("StringValue", {
 Value = "Foo"
 })
 expect(v1).to.be.ok()
 expect(v1.props.Value).to.equal("Foo")
	end)
	it("should accept props and children", function()
 local v1 = createElement("IntValue")
 local v2 = createElement("StringValue", {
 Value = "Foo"
 }, {
 Child = v1
 })
 expect(v2).to.be.ok()
 expect(v2.props.Value).to.equal("Foo")
 expect(v2.props[Children]).to.be.ok()
 expect(v2.props[Children].Child).to.equal(v1)
	end)
	it("should accept children with without props", function()
 local v1 = createElement("IntValue")
 local v2 = createElement("StringValue", nil, {
 Child = v1
 })
 expect(v2).to.be.ok()
 expect(v2.props[Children]).to.be.ok()
 expect(v2.props[Children].Child).to.equal(v1)
	end)
	it("should warn once if children is specified in two different ways", function()
 local v1 = Logging.capture(function()
 for i = 1, 2 do
 createElement("Frame", {
 [Children] = {}
 }, {})
 end
 end)
 expect(#v1.warnings).to.equal(1)
 expect(v1.warnings[1]:find("createElement")).to.be.ok()
 expect(v1.warnings[1]:find("Children")).to.be.ok()
	end)
	it("should have a `source` member if elementTracing is set", function()
 GlobalConfig.scoped({
 elementTracing = true
 }, function()
 expect(createElement("StringValue").source).to.be.a("string")
 end)
	end)
end