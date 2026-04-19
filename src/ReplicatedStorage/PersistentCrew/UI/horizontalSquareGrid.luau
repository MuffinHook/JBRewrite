-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- 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

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:44:42
-- Luau version 6, Types version 3
-- Time taken: 0.004176 seconds

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local createElement_upvr = require(ReplicatedStorage.Roact).createElement
local PaddedContainer_upvr = require(ReplicatedStorage.EzUi.PaddedContainer)
local function horizontalSquareGridItem_upvr(arg1) -- Line 7, Named "horizontalSquareGridItem"
    --[[ Upvalues[2]:
        [1]: createElement_upvr (readonly)
        [2]: PaddedContainer_upvr (readonly)
    ]]
    local var4 = 1 / (1 / arg1.aspectRatio + 1 / arg1.verticalPaddingRatio / arg1.aspectRatio)
    return createElement_upvr(PaddedContainer_upvr, {
        component = arg1.component;
        props = arg1.props;
        aspectRatio = var4;
        verticalPaddingRatio = arg1.verticalPaddingRatio;
        size = UDim2.fromScale(1 / var4, 1);
        position = UDim2.fromScale(0.5 + (arg1.index - 1 - arg1.numItems / 2) / var4, 0);
        paddingTop = 0;
        paddingBottom = 0;
        paddingRight = 0.5;
        paddingLeft = 0.5;
    })
end
local Dictionary_upvr = require(ReplicatedStorage.Std.Dictionary)
return function(arg1) -- Line 23, Named "horizontalSquareGrid"
    --[[ Upvalues[4]:
        [1]: createElement_upvr (readonly)
        [2]: horizontalSquareGridItem_upvr (readonly)
        [3]: Dictionary_upvr (readonly)
        [4]: PaddedContainer_upvr (readonly)
    ]]
    -- KONSTANTWARNING: Variable analysis failed. Output will have some incorrect variable assignments
    local module = {}
    local numItems = arg1.numItems
    if not numItems then
        numItems = #arg1.items
    end
    for i = 1, numItems do
        module[i] = createElement_upvr(horizontalSquareGridItem_upvr, {
            exposePaddedContainerProps = true;
            index = i;
            numItems = numItems;
            component = arg1.component;
            props = Dictionary_upvr.merge(arg1.items[i], arg1.itemMetadata);
        })
    end
    return createElement_upvr(PaddedContainer_upvr, {
        backgroundTransparency = 1;
        backgroundColor = Color3.new(0, 0, 0);
        aspectRatio = arg1.aspectRatio;
        verticalPaddingRatio = arg1.verticalPaddingRatio;
        size = UDim2.fromScale(1, 1);
        paddingLeft = 0;
        paddingRight = 0;
    }, module)
end