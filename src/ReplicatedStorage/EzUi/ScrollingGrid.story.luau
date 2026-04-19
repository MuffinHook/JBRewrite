-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- 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

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:41:47
-- Luau version 6, Types version 3
-- Time taken: 0.003285 seconds

local Roact_upvr = require(script:FindFirstAncestor("EzUi").Parent.Roact)
local createElement_upvr = Roact_upvr.createElement
local function testComponent_upvr(arg1) -- Line 6, Named "testComponent"
    --[[ Upvalues[1]:
        [1]: createElement_upvr (readonly)
    ]]
    return createElement_upvr("TextLabel", {
        BackgroundTransparency = 0.5;
        BackgroundColor3 = arg1.color;
        Size = arg1.size;
        Position = arg1.position;
        Text = arg1.title;
    })
end
return function(arg1) -- Line 16
    --[[ Upvalues[3]:
        [1]: Roact_upvr (readonly)
        [2]: createElement_upvr (readonly)
        [3]: testComponent_upvr (readonly)
    ]]
    local tbl = {}
    for i = 1, 31 do
        table.insert(tbl, {
            title = tostring(i);
            color = Color3.fromHSV(math.random(), 1, 1);
        })
    end
    local any_mount_result1_upvr = Roact_upvr.mount(createElement_upvr("Frame", {
        BackgroundTransparency = 0.5;
        Size = UDim2.new(0.9, 0, 0.9, 0);
        Position = UDim2.new(0.05, 0, 0.05, 0);
    }, {
        AspectRatio = createElement_upvr("UIAspectRatioConstraint", {
            AspectRatio = 1.5;
        });
        Grid = Roact_upvr.createElement(require(script.Parent.ScrollingGrid), {
            aspectRatio = 1.5;
            paddingRatio = 128;
            rowsPerPage = 3;
            colsPerRow = 3;
            component = testComponent_upvr;
            items = tbl;
        });
    }), arg1)
    return function() -- Line 46
        --[[ Upvalues[2]:
            [1]: Roact_upvr (copied, readonly)
            [2]: any_mount_result1_upvr (readonly)
        ]]
        Roact_upvr.unmount(any_mount_result1_upvr)
    end
end