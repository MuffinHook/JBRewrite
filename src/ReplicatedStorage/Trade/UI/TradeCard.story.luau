-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- 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

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:47:37
-- Luau version 6, Types version 3
-- Time taken: 0.003322 seconds

local Roact_upvr = require(game:GetService("ReplicatedStorage").Roact)
local createElement_upvr = Roact_upvr.createElement
return function(arg1) -- Line 5
    --[[ Upvalues[2]:
        [1]: Roact_upvr (readonly)
        [2]: createElement_upvr (readonly)
    ]]
    local any_extend_result1 = Roact_upvr.Component:extend("App")
    function any_extend_result1.init(arg1_2) -- Line 8
    end
    local TradeCard_upvr = require(script.Parent.TradeCard)
    function any_extend_result1.render(arg1_3) -- Line 9
        --[[ Upvalues[3]:
            [1]: Roact_upvr (copied, readonly)
            [2]: createElement_upvr (copied, readonly)
            [3]: TradeCard_upvr (readonly)
        ]]
        local module = {}
        local tbl = {
            aspectRatio = 0.8;
            season = 3;
            level = 5;
            itemType = "VehicleCustomization";
            title = "winter camo";
            categoryTitle = "Texture";
            info = {{
                title = "Original Owner";
                value = "badcc";
            }, {
                title = "Times Traded";
                value = "15";
            }, {
                title = "Created At";
                value = DateTime.now():FormatLocalTime("ll", "en-us");
            }};
        }
        function tbl.onCardFlipped() -- Line 37
            print("flipped!")
        end
        module.Card = createElement_upvr(TradeCard_upvr, tbl)
        module.AspectRatio = createElement_upvr("UIAspectRatioConstraint", {
            AspectRatio = 0.8;
        })
        return Roact_upvr.createElement("Frame", {
            BackgroundTransparency = 1;
            Size = UDim2.new(1, 0, 1, 0);
        }, module)
    end
    function any_extend_result1.willUnmount(arg1_4) -- Line 46
    end
    local any_mount_result1_upvr = Roact_upvr.mount(Roact_upvr.createElement(any_extend_result1), arg1)
    return function() -- Line 49
        --[[ Upvalues[2]:
            [1]: Roact_upvr (copied, readonly)
            [2]: any_mount_result1_upvr (readonly)
        ]]
        Roact_upvr.unmount(any_mount_result1_upvr)
    end
end