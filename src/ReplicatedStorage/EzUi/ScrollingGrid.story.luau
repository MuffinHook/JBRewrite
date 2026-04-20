local Roact_upvr = require(script:FindFirstAncestor("EzUi").Parent.Roact)
local createElement_upvr = Roact_upvr.createElement
local function testComponent_upvr(arg1) -- Line 6, Named "testComponent"
    return createElement_upvr("TextLabel", {
        BackgroundTransparency = 0.5;
        BackgroundColor3 = arg1.color;
        Size = arg1.size;
        Position = arg1.position;
        Text = arg1.title;
    })
end
return function(arg1) -- Line 16
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
        Roact_upvr.unmount(any_mount_result1_upvr)
    end
end