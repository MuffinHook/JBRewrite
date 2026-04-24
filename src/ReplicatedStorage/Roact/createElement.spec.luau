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
 local fn = createElement("Frame")
 expect(fn).to.be.ok()
 expect(Type.of(fn)).to.equal(Type.Element)
 expect(ElementKind.of(fn)).to.equal(ElementKind.Host)
	end)
	it("should create new functional elements", function()
 local fn = createElement(function() end)
 expect(fn).to.be.ok()
 expect(Type.of(fn)).to.equal(Type.Element)
 expect(ElementKind.of(fn)).to.equal(ElementKind.Function)
	end)
	it("should create new stateful components", function()
 local fn = createElement((Component:extend("Foo")))
 expect(fn).to.be.ok()
 expect(Type.of(fn)).to.equal(Type.Element)
 expect(ElementKind.of(fn)).to.equal(ElementKind.Stateful)
	end)
	it("should create new portal elements", function()
 local fn = createElement(Portal)
 expect(fn).to.be.ok()
 expect(Type.of(fn)).to.equal(Type.Element)
 expect(ElementKind.of(fn)).to.equal(ElementKind.Portal)
	end)
	it("should accept props", function()
 local fn = createElement("StringValue", {
 Value = "Foo"
 })
 expect(fn).to.be.ok()
 expect(fn.props.Value).to.equal("Foo")
	end)
	it("should accept props and children", function()
 local fn = createElement("IntValue")
 local v2 = createElement("StringValue", {
 Value = "Foo"
 }, {
 Child = fn
 })
 expect(v2).to.be.ok()
 expect(v2.props.Value).to.equal("Foo")
 expect(v2.props[Children]).to.be.ok()
 expect(v2.props[Children].Child).to.equal(fn)
	end)
	it("should accept children with without props", function()
 local fn = createElement("IntValue")
 local v2 = createElement("StringValue", nil, {
 Child = fn
 })
 expect(v2).to.be.ok()
 expect(v2.props[Children]).to.be.ok()
 expect(v2.props[Children].Child).to.equal(fn)
	end)
	it("should warn once if children is specified in two different ways", function()
 local fn = Logging.capture(function()
 for i = 1, 2 do
 createElement("Frame", {
 [Children] = {}
 }, {})
 end
 end)
 expect(#fn.warnings).to.equal(1)
 expect(fn.warnings[1]:find("createElement")).to.be.ok()
 expect(fn.warnings[1]:find("Children")).to.be.ok()
	end)
	it("should have a `source` member if elementTracing is set", function()
 GlobalConfig.scoped({
 elementTracing = true
 }, function()
 expect(createElement("StringValue").source).to.be.a("string")
 end)
	end)
end