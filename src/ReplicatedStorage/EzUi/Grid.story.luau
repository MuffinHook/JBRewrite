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
    local any_mount_result1_upvr = Roact_upvr.mount(createElement_upvr("Frame", {
        BackgroundTransparency = 0.5;
        Size = UDim2.new(0.9, 0, 0.9, 0);
        Position = UDim2.new(0.05, 0, 0.05, 0);
    }, Roact_upvr.createElement(require(script.Parent.Grid), {
        aspectRatio = 1;
        paddingRatio = 100;
        rowsPerPage = 3;
        colsPerRow = 3;
        component = testComponent_upvr;
        items = {{
            color = Color3.new(1, 0, 0);
            title = '1';
        }, {
            color = Color3.new(0, 1, 0);
            title = '2';
        }, {
            color = Color3.new(0, 0, 1);
            title = '3';
        }};
    })), arg1)
    return function() -- Line 50
        Roact_upvr.unmount(any_mount_result1_upvr)
    end
end