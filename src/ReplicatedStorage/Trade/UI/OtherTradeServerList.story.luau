-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- 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

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:47:32
-- Luau version 6, Types version 3
-- Time taken: 0.002957 seconds

local ReplicatedStorage_upvr = game:GetService("ReplicatedStorage")
local Roact_upvr = require(ReplicatedStorage_upvr.Roact)
local RoactRodux_upvr = require(ReplicatedStorage_upvr.RoactRodux)
return function(arg1) -- Line 6
    --[[ Upvalues[3]:
        [1]: Roact_upvr (readonly)
        [2]: ReplicatedStorage_upvr (readonly)
        [3]: RoactRodux_upvr (readonly)
    ]]
    local any_extend_result1 = Roact_upvr.Component:extend("App")
    local OtherTradeServerUIData_upvr = require(ReplicatedStorage_upvr.Trade.Test.OtherTradeServerUIData)
    function any_extend_result1.init(arg1_2) -- Line 11
        --[[ Upvalues[1]:
            [1]: OtherTradeServerUIData_upvr (readonly)
        ]]
        arg1_2.aspectRatio = 1.5
        arg1_2.otherTradeServerInfo = OtherTradeServerUIData_upvr.otherTradeServerInfo
    end
    local persistentCrewStore_upvr = require(ReplicatedStorage_upvr.PersistentCrew.persistentCrewStore)
    local OtherTradeServerList_upvr = require(script.Parent.OtherTradeServerList)
    function any_extend_result1.render(arg1_3) -- Line 16
        --[[ Upvalues[4]:
            [1]: Roact_upvr (copied, readonly)
            [2]: RoactRodux_upvr (copied, readonly)
            [3]: persistentCrewStore_upvr (readonly)
            [4]: OtherTradeServerList_upvr (readonly)
        ]]
        return Roact_upvr.createElement(RoactRodux_upvr.StoreProvider, {
            store = persistentCrewStore_upvr;
        }, {Roact_upvr.createElement("Frame", {
            Size = UDim2.fromScale(1, 1);
        }, {
            x = Roact_upvr.createElement(OtherTradeServerList_upvr, {
                otherTradeServerInfo = arg1_3.otherTradeServerInfo;
                onJoinOtherTradeServer = function(arg1_4) -- Line 25, Named "onJoinOtherTradeServer"
                    print("CLICK.. join server id", arg1_4)
                end;
                aspectRatio = arg1_3.aspectRatio;
                visible = true;
                size = UDim2.fromScale(1, 1);
                position = UDim2.fromScale(0.5, 0.5);
            });
            Aspect = Roact_upvr.createElement("UIAspectRatioConstraint", {
                AspectRatio = arg1_3.aspectRatio;
            });
        })})
    end
    local any_mount_result1_upvr = Roact_upvr.mount(Roact_upvr.createElement(any_extend_result1), arg1)
    return function() -- Line 41
        --[[ Upvalues[2]:
            [1]: Roact_upvr (copied, readonly)
            [2]: any_mount_result1_upvr (readonly)
        ]]
        Roact_upvr.unmount(any_mount_result1_upvr)
    end
end