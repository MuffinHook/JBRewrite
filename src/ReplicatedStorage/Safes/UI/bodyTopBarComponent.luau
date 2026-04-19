-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- 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

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:45:46
-- Luau version 6, Types version 3
-- Time taken: 0.003068 seconds

local createElement_upvr = require(game:GetService("ReplicatedStorage").Roact).createElement
return function(arg1) -- Line 5
    --[[ Upvalues[1]:
        [1]: createElement_upvr (readonly)
    ]]
    return createElement_upvr("Frame", {
        Size = UDim2.new(1, 0, 0.1, 0);
        BackgroundTransparency = 1;
        ZIndex = 3;
    }, {
        UICorner = createElement_upvr("UICorner", {
            CornerRadius = UDim.new(0, 4);
        });
        Title = createElement_upvr("Frame", {
            BorderSizePixel = 0;
            BackgroundTransparency = 1;
            BackgroundColor3 = Color3.new(1, 0, 0);
            Size = UDim2.new(1 - 2 / arg1.verticalPaddingRatio / arg1.aspectRatio, 0, 0.8 - 2 / arg1.verticalPaddingRatio / 0.1, 0);
            Position = UDim2.new(1 / arg1.verticalPaddingRatio / arg1.aspectRatio, 0, 0.1 + 1 / arg1.verticalPaddingRatio / 0.1, 0);
        }, {
            Text = createElement_upvr("TextLabel", {
                BackgroundTransparency = 1;
                Size = UDim2.new(1, 0, 1.25, 0);
                Position = UDim2.new(0.5, 0, 0.5, 0);
                AnchorPoint = Vector2.new(0.5, 0.5);
                Text = "Win one of these items:";
                TextXAlignment = Enum.TextXAlignment.Left;
                Font = Enum.Font.Bangers;
                LineHeight = 1;
                TextScaled = true;
                TextColor3 = Color3.new(1, 1, 1);
            });
        });
        Line = createElement_upvr("Frame", {
            Size = UDim2.new(1, 0, 0, 1);
            Position = UDim2.new(0, 0, 1, -1);
            BackgroundColor3 = Color3.new(0.1, 0.1, 0.1);
            BorderSizePixel = 0;
        });
    })
end