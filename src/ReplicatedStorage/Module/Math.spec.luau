-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMNBUlzTmFOBmV4cGVjdAJ0bwVlcXVhbAJpdBdzaG91bGQgaWRlbnRpZnkgbnVtYmVycxtzaG91bGQgaWRlbnRpZnkgbm9uLW51bWJlcnMHcmVxdWlyZQZzY3JpcHQGcGFyZW50BE1hdGgIZGVzY3JpYmUFaXNOYU4ABQMAAQAAABD7AAAATQAAFgAAAACMAQEAnwACAqQBAgAAABBAUgIAAJ8BAgJNAQGSAwAAAE0BAXsEAAAAqQIAAJ8BAgGCAAEABQMBAwIEAAAQQAMDAwQABQABGAAAAAAAAQAAAAAAAAAAAAEGAAAAAAMAAQAAABD7AAAATQAAFgAAAABvAQEAnwACAqQBAwAAACBAUgIAAJ8BAgJNAQGSBAAAAE0BAXsFAAAAqQIBAJ8BAgGCAAEABgMBAgAAAAAAAPj/AwIEAAAgQAMDAwQACQABGAAAAAAAAQAAAAAAAAAAAAEKAAAAAAMAAQAAAA2kAAEAAAAAQG8BAgDZAgAAEgIAAJ8AAwGkAAEAAAAAQG8BAwDZAgEAEgIAAJ8AAwGCAAEABAMFBAAAAEADBgMHAgABBAABGAAAAAAAAAQAAAAAAAQFAAAAAAQAAAAAABCkAAEAAAAAQKQBAwAAACBATQEBxAQAAABNAQGMBQAAAJ8AAgKkAQcAAABgQG8CCADZAwAAEgAAAJ8BAwGCAAEACQMIBAAAAEADCQQAACBAAwoDCwMMBAAAYEADDQECAQABGAAAAAAAAAAAAAIAAAAAAAoCAAAAAAEAAAECAAOjAAAAwAAAAIIAAgABBgMBAwEAARgAAAABAAAAAARDZFxYlGlJCdgPm6emhkeBM3xLLHGgNlk=

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:39:33
-- Luau version 6, Types version 3
-- Time taken: 0.001108 seconds

return function() -- Line 1
    local Math_upvr = require(script.parent.Math)
    describe("isNaN", function() -- Line 4
        --[[ Upvalues[1]:
            [1]: Math_upvr (readonly)
        ]]
        it("should identify numbers", function() -- Line 5
            --[[ Upvalues[1]:
                [1]: Math_upvr (copied, readonly)
            ]]
            expect(Math_upvr.IsNaN(1)).to.equal(false)
        end)
        it("should identify non-numbers", function() -- Line 9
            --[[ Upvalues[1]:
                [1]: Math_upvr (copied, readonly)
            ]]
            expect(Math_upvr.IsNaN(tonumber("nan"))).to.equal(true)
        end)
    end)
end