local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Roact_upvr = require(ReplicatedStorage.Roact)
local any_extend_result1 = Roact_upvr.PureComponent:extend("BattleCrewInfo")
any_extend_result1.defaultProps = {
    backgroundColor = Color3.new(0, 0, 0);
    size = UDim2.fromScale(0.5, 0.5);
    anchorPoint = Vector2.new(0.5, 0.5);
    position = UDim2.fromScale(0.5, 0.5);
    attacking = false;
}
local ColorUtils_upvr = require(ReplicatedStorage.Std.ColorUtils)
local createElement_upvr = Roact_upvr.createElement
local BattleRobberyStatus_upvr = require(script.Parent.BattleRobberyStatus)
local Dictionary_upvr = require(ReplicatedStorage.Std.Dictionary)
local Elapsed_upvr = require(script.Parent.Elapsed)
local PersistentCrewBattleConsts_upvr = require(ReplicatedStorage.PersistentCrewBattle.PersistentCrewBattleConsts)
function any_extend_result1.render(arg1) -- Line 19
    local tbl = {}
    local var16
    for i, v in arg1.props.robberiesCompleted do
        if v.robberyCompleted then
            var16 += 1
        end
        tbl["Robbery_"..tostring(v.robberyType)] = createElement_upvr(BattleRobberyStatus_upvr, {
            rowIndex = i;
            robberyType = v.robberyType;
            robberyCompleted = v.robberyCompleted;
            backgroundColor = ColorUtils_upvr.saturateBy(arg1.props.backgroundColor, -0.9);
        })
    end
    local module = {
        UICorners = createElement_upvr("UICorner", {
            CornerRadius = UDim.new(0, 4);
        });
        TitleContainer = createElement_upvr("Frame", {
            BackgroundTransparency = 1;
            Size = UDim2.new(1, 0, 1, 0);
        }, {
            Text = createElement_upvr("TextLabel", {
                BackgroundTransparency = 1;
                Size = UDim2.new(1, 0, 1, 0);
                Position = UDim2.new(0.5, 0, 0.5, 0);
                AnchorPoint = Vector2.new(0.5, 0.5);
                Font = Enum.Font.Bangers;
                Text = arg1.props.clanName;
                LineHeight = 1;
                TextScaled = true;
                TextColor3 = ColorUtils_upvr.brightenBy(arg1.props.backgroundColor, -0.5);
            });
        });
    }
    local attacking_2 = arg1.props.attacking
    if attacking_2 then
        attacking_2 = createElement_upvr
        attacking_2 = attacking_2("Frame", {
            BorderSizePixel = 0;
            BackgroundColor3 = arg1.props.backgroundColor;
            Size = UDim2.new(0.5, -2, 0.8, 0);
            AnchorPoint = Vector2.new(0, 0);
            Position = UDim2.new(0, 0, 1, 4);
        }, {
            UICorners = createElement_upvr("UICorner", {
                CornerRadius = UDim.new(0, 4);
            });
            ElapsedContainer = createElement_upvr(Elapsed_upvr, {
                font = Enum.Font.FredokaOne;
                textColor = ColorUtils_upvr.brightenBy(arg1.props.backgroundColor, -0.5);
                createdAt = arg1.props.createdAt;
                elapsed = arg1.props.elapsed;
                disabled = arg1.props.disabled;
                prefix = "Time Taken: ";
            });
        })
    end
    module.TakenContainer = attacking_2
    local attacking = arg1.props.attacking
    if attacking then
        attacking = createElement_upvr
        attacking = attacking("Frame", {
            BorderSizePixel = 0;
            BackgroundColor3 = arg1.props.backgroundColor;
            Size = UDim2.new(0.5, -2, 0.8, 0);
            AnchorPoint = Vector2.new(0, 0);
            Position = UDim2.new(0.5, 2, 1, 4);
        }, Dictionary_upvr.merge({
            UICorners = createElement_upvr("UICorner", {
                CornerRadius = UDim.new(0, 4);
            });
            TitleContainer = createElement_upvr("Frame", {
                BackgroundTransparency = 1;
                Size = UDim2.new(1, 0, 1, 0);
            }, {
                Text = createElement_upvr("TextLabel", {
                    BackgroundTransparency = 1;
                    Size = UDim2.new(0.9, 0, 0.8, 0);
                    Position = UDim2.new(0.5, 0, 0.5, 0);
                    AnchorPoint = Vector2.new(0.5, 0.5);
                    Font = Enum.Font.FredokaOne;
                    Text = "Checklist (%d/%d)":format(var16, PersistentCrewBattleConsts_upvr.NUM_ROBBERIES_TO_FINISH_ROUND);
                    LineHeight = 1;
                    TextScaled = true;
                    TextColor3 = ColorUtils_upvr.brightenBy(arg1.props.backgroundColor, -0.5);
                });
            });
        }, tbl))
    end
    module.RobberyList = attacking
    attacking = not arg1.props.attacking
    local var36 = attacking
    if var36 then
        var36 = createElement_upvr
        var36 = var36("Frame", {
            BorderSizePixel = 0;
            BackgroundColor3 = arg1.props.backgroundColor;
            Size = UDim2.new(0.5, -2, 0.8, 0);
            AnchorPoint = Vector2.new(0, 0);
            Position = UDim2.new(0, 0, 1, 4);
        }, {
            UICorners = createElement_upvr("UICorner", {
                CornerRadius = UDim.new(0, 4);
            });
            ElapsedContainer = createElement_upvr(Elapsed_upvr, {
                font = Enum.Font.FredokaOne;
                textColor = ColorUtils_upvr.brightenBy(arg1.props.backgroundColor, -0.5);
                createdAt = arg1.props.createdAt;
                elapsed = arg1.props.elapsed;
                disabled = arg1.props.disabled;
                prefix = "Time Taken: ";
            });
        })
    end
    module.BeatContainer = var36
    var36 = not arg1.props.attacking
    local var41 = var36
    if var41 then
        var41 = createElement_upvr
        var41 = var41("Frame", {
            BorderSizePixel = 0;
            BackgroundColor3 = arg1.props.backgroundColor;
            Size = UDim2.new(0.5, -2, 0.8, 0);
            AnchorPoint = Vector2.new(0, 0);
            Position = UDim2.new(0.5, 2, 1, 4);
        }, {
            UICorners = createElement_upvr("UICorner", {
                CornerRadius = UDim.new(0, 4);
            });
            TitleContainer = createElement_upvr("Frame", {
                BackgroundTransparency = 1;
                Size = UDim2.new(1, 0, 1, 0);
            }, {
                Text = createElement_upvr("TextLabel", {
                    BackgroundTransparency = 1;
                    Size = UDim2.new(0.9, 0, 0.8, 0);
                    Position = UDim2.new(0.5, 0, 0.5, 0);
                    AnchorPoint = Vector2.new(0.5, 0.5);
                    Font = Enum.Font.FredokaOne;
                    Text = "Beat their time!";
                    LineHeight = 1;
                    TextScaled = true;
                    TextColor3 = ColorUtils_upvr.brightenBy(arg1.props.backgroundColor, -0.5);
                });
            });
        })
    end
    module.Help = var41
    return createElement_upvr("Frame", {
        BorderSizePixel = 0;
        BackgroundColor3 = arg1.props.backgroundColor;
        Size = arg1.props.size;
        AnchorPoint = arg1.props.anchorPoint;
        Position = arg1.props.position;
    }, Dictionary_upvr.merge(arg1.props[Roact_upvr.Children], module))
end
return any_extend_result1