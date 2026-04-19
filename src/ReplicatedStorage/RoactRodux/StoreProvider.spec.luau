-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- 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

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:31:37
-- Luau version 6, Types version 3
-- Time taken: 0.003079 seconds

return function() -- Line 1
    local StoreProvider_upvr = require(script.Parent.StoreProvider)
    local Roact_upvr = require(script.Parent.Parent.Roact)
    local Rodux_upvr = require(script.Parent.Parent.Rodux)
    it("should be instantiable as a component", function() -- Line 7
        --[[ Upvalues[3]:
            [1]: Rodux_upvr (readonly)
            [2]: Roact_upvr (readonly)
            [3]: StoreProvider_upvr (readonly)
        ]]
        local any_new_result1_2 = Rodux_upvr.Store.new(function() -- Line 8
            return 0
        end)
        local any_createElement_result1_2 = Roact_upvr.createElement(StoreProvider_upvr, {
            store = any_new_result1_2;
        })
        expect(any_createElement_result1_2).to.be.ok()
        Roact_upvr.unmount(Roact_upvr.mount(any_createElement_result1_2, nil, "StoreProvider-test"))
        any_new_result1_2:destruct()
    end)
    it("should expect a 'store' prop", function() -- Line 23
        --[[ Upvalues[2]:
            [1]: Roact_upvr (readonly)
            [2]: StoreProvider_upvr (readonly)
        ]]
        local any_createElement_result1_3_upvr = Roact_upvr.createElement(StoreProvider_upvr)
        expect(function() -- Line 26
            --[[ Upvalues[2]:
                [1]: Roact_upvr (copied, readonly)
                [2]: any_createElement_result1_3_upvr (readonly)
            ]]
            Roact_upvr.mount(any_createElement_result1_3_upvr)
        end).to.throw()
    end)
    it("should accept a single child", function() -- Line 31
        --[[ Upvalues[3]:
            [1]: Rodux_upvr (readonly)
            [2]: Roact_upvr (readonly)
            [3]: StoreProvider_upvr (readonly)
        ]]
        local any_new_result1 = Rodux_upvr.Store.new(function() -- Line 32
            return 0
        end)
        local Folder = Instance.new("Folder")
        local any_createElement_result1 = Roact_upvr.createElement(StoreProvider_upvr, {
            store = any_new_result1;
        }, {
            test1 = Roact_upvr.createElement("Frame");
        })
        expect(any_createElement_result1).to.be.ok()
        local StoreProvider_test = Folder:FindFirstChild("StoreProvider-test", true)
        expect(StoreProvider_test).to.be.ok()
        expect(StoreProvider_test:IsA("Frame")).to.equal(true)
        Roact_upvr.unmount(Roact_upvr.mount(any_createElement_result1, Folder, "StoreProvider-test"))
        any_new_result1:destruct()
    end)
end