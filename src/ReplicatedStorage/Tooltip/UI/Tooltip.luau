-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- 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

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:47:04
-- Luau version 6, Types version 3
-- Time taken: 0.003202 seconds

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Roact = require(ReplicatedStorage.Roact)
local any_extend_result1 = Roact.PureComponent:extend("Tooltip")
any_extend_result1.defaultProps = {
    size = UDim2.fromScale(0.75, 0.05);
    anchorPoint = Vector2.new(0.5, 0);
    position = UDim2.fromScale(0.5, 0);
}
local Maid_upvr = require(ReplicatedStorage.Std.Maid)
function any_extend_result1.init(arg1) -- Line 13
    --[[ Upvalues[1]:
        [1]: Maid_upvr (readonly)
    ]]
    arg1.maid = Maid_upvr.new()
end
local createElement_upvr = Roact.createElement
function any_extend_result1.render(arg1) -- Line 16
    --[[ Upvalues[1]:
        [1]: createElement_upvr (readonly)
    ]]
    if not arg1.props.visible then return end
    return createElement_upvr("Frame", {
        BackgroundColor3 = Color3.new(0, 0, 0);
        BackgroundTransparency = 1;
        Size = arg1.props.size;
        AnchorPoint = arg1.props.anchorPoint;
        Position = arg1.props.position;
    }, {
        Text = createElement_upvr("TextLabel", {
            BackgroundTransparency = 1;
            Size = UDim2.fromScale(1, 1);
            Position = UDim2.fromScale(0.5, 0.5);
            AnchorPoint = Vector2.new(0.5, 0.5);
            Font = Enum.Font.FredokaOne;
            Text = arg1.props.text;
            TextColor3 = Color3.new(0.95, 0.95, 0.95);
            TextScaled = true;
        }, {
            Stroke = createElement_upvr("UIStroke", {
                Thickness = 1;
                Color = Color3.new(0.4, 0.4, 0.4);
                Transparency = 0.2;
            });
        });
    })
end
function any_extend_result1.willUnmount(arg1) -- Line 45
    arg1.maid:DoCleaning()
end
return any_extend_result1