local Roact_upvr = require(game:GetService("ReplicatedStorage").Roact)
local createElement_upvr = Roact_upvr.createElement
return function(arg1) -- Line 5
    local any_extend_result1 = Roact_upvr.Component:extend("App")
    function any_extend_result1.init(arg1_2) -- Line 8
    end
    local TradeCard_upvr = require(script.Parent.TradeCard)
    function any_extend_result1.render(arg1_3) -- Line 9
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
        Roact_upvr.unmount(any_mount_result1_upvr)
    end
end