local Roact_upvr = require(script:FindFirstAncestor("EzUi").Parent.Roact)
local createElement_upvr = Roact_upvr.createElement
return function(arg1) -- Line 6
    local PaddedContainer = require(script.Parent.PaddedContainer)
    local any_mount_result1_upvr = Roact_upvr.mount(createElement_upvr("Frame", {
        BackgroundTransparency = 0.9;
        BackgroundColor3 = Color3.new(1, 0, 0);
        Size = UDim2.new(1, 0, 1, 0);
    }, {
        AspectRatio = createElement_upvr("UIAspectRatioConstraint", {
            AspectRatio = 2;
        });
        Container1 = createElement_upvr(PaddedContainer, {
            aspectRatio = 2;
            verticalPaddingRatio = 32;
        }, {
            Frame1 = createElement_upvr("Frame", {
                BorderSizePixel = 0;
                Size = UDim2.new(0.75, 0, 1, 0);
            }, {
                Container2 = createElement_upvr(PaddedContainer, {
                    paddingRight = 0.5;
                    size = UDim2.new(0.5, 0, 1, 0);
                }, {
                    Container3 = createElement_upvr(PaddedContainer, {}, {});
                });
                Container3 = createElement_upvr(PaddedContainer, {
                    paddingLeft = 0.5;
                    paddingRight = 0.5;
                    size = UDim2.new(0.5, 0, 1, 0);
                    position = UDim2.new(0.5, 0, 0, 0);
                }, {
                    Container3 = createElement_upvr(PaddedContainer, {}, {});
                });
            });
            Frame2 = createElement_upvr("Frame", {
                BorderSizePixel = 0;
                BackgroundColor3 = Color3.new(0, 1, 0);
                BackgroundTransparency = 0.7;
                Size = UDim2.new(0.25, 0, 1, 0);
                Position = UDim2.new(0.75, 0, 0, 0);
                ZIndex = 3;
            }, {
                Container2 = createElement_upvr(PaddedContainer, {
                    paddingLeft = 0.5;
                }, {});
            });
        });
    }), arg1)
    return function() -- Line 78
        Roact_upvr.unmount(any_mount_result1_upvr)
    end
end