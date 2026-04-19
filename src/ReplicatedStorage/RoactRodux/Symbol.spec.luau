-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- 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

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:31:39
-- Luau version 6, Types version 3
-- Time taken: 0.002323 seconds

return function() -- Line 1
    local Symbol_upvr = require(script.Parent.Symbol)
    describe("named", function() -- Line 4
        --[[ Upvalues[1]:
            [1]: Symbol_upvr (readonly)
        ]]
        it("should give an opaque object", function() -- Line 5
            --[[ Upvalues[1]:
                [1]: Symbol_upvr (copied, readonly)
            ]]
            expect(Symbol_upvr.named("foo")).to.be.a("userdata")
        end)
        it("should coerce to the given name", function() -- Line 11
            --[[ Upvalues[1]:
                [1]: Symbol_upvr (copied, readonly)
            ]]
            expect(tostring(Symbol_upvr.named("foo")):find("foo")).to.be.ok()
        end)
        it("should be unique when constructed", function() -- Line 17
            --[[ Upvalues[1]:
                [1]: Symbol_upvr (copied, readonly)
            ]]
            expect(Symbol_upvr.named("abc")).never.to.equal(Symbol_upvr.named("abc"))
        end)
    end)
    describe("unnamed", function() -- Line 25
        --[[ Upvalues[1]:
            [1]: Symbol_upvr (readonly)
        ]]
        it("should give an opaque object", function() -- Line 26
            --[[ Upvalues[1]:
                [1]: Symbol_upvr (copied, readonly)
            ]]
            expect(Symbol_upvr.unnamed()).to.be.a("userdata")
        end)
        it("should coerce to some string", function() -- Line 32
            --[[ Upvalues[1]:
                [1]: Symbol_upvr (copied, readonly)
            ]]
            expect(tostring(Symbol_upvr.unnamed())).to.be.a("string")
        end)
        it("should be unique when constructed", function() -- Line 38
            --[[ Upvalues[1]:
                [1]: Symbol_upvr (copied, readonly)
            ]]
            expect(Symbol_upvr.unnamed()).never.to.equal(Symbol_upvr.unnamed())
        end)
    end)
end