return function() -- Line 1
    local Symbol_upvr = require(script.Parent.Symbol)
    describe("named", function() -- Line 4
        it("should give an opaque object", function() -- Line 5
            expect(Symbol_upvr.named("foo")).to.be.a("userdata")
        end)
        it("should coerce to the given name", function() -- Line 11
            expect(tostring(Symbol_upvr.named("foo")):find("foo")).to.be.ok()
        end)
        it("should be unique when constructed", function() -- Line 17
            expect(Symbol_upvr.named("abc")).never.to.equal(Symbol_upvr.named("abc"))
        end)
    end)
    describe("unnamed", function() -- Line 25
        it("should give an opaque object", function() -- Line 26
            expect(Symbol_upvr.unnamed()).to.be.a("userdata")
        end)
        it("should coerce to some string", function() -- Line 32
            expect(tostring(Symbol_upvr.unnamed())).to.be.a("string")
        end)
        it("should be unique when constructed", function() -- Line 38
            expect(Symbol_upvr.unnamed()).never.to.equal(Symbol_upvr.unnamed())
        end)
    end)
end