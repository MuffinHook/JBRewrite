local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Roact = require(ReplicatedStorage.Roact)
local RewardSpinnerConsts_upvr = require(ReplicatedStorage.RewardSpinner.RewardSpinnerConsts)
local any_extend_result1 = Roact.PureComponent:extend("BriefcaseDisplay")
local Maid_upvr = require(ReplicatedStorage.Std.Maid)
function any_extend_result1.init(arg1) -- Line 10
    arg1.maid = Maid_upvr.new()
    arg1:setState({
        probs = {};
    })
end
local createElement_upvr = Roact.createElement
local ColorUtils_upvr = require(ReplicatedStorage.Std.ColorUtils)
function any_extend_result1.render(arg1) -- Line 16
    -- Decomp Logic Error: Konstant variable analysis failed; temporary assignments in this block were preserved for review.
    local var13
    if not var13 then
        var13 = arg1.state
        var13 = var13.probs
    end
    local module = {}
    local len = #RewardSpinnerConsts_upvr.RARITIES
    for i = 1, len do
        local var16 = RewardSpinnerConsts_upvr.RARITIES[i]
        local var17 = (var13[var16.id] or 0) / 100
        module[i] = createElement_upvr("Frame", {
            BackgroundTransparency = 1;
            BorderSizePixel = 0;
            Size = UDim2.new(1, 0, 1 / len, 0);
            Position = UDim2.new(0, 0, (i - 1) / len, 0);
        }, {
            Progress = createElement_upvr("Frame", {
                BorderSizePixel = 0;
                BackgroundColor3 = var16.color;
                Size = UDim2.new(var17, 0, 1, 0);
            });
            Title = createElement_upvr("Frame", {
                BackgroundTransparency = 1;
                BackgroundColor3 = Color3.new(1, 0, 0);
                Size = UDim2.new(1, 0, 1, 0);
                Position = UDim2.new(0, 0, 0, 0);
            }, {
                Text = createElement_upvr("TextLabel", {
                    BackgroundTransparency = 1;
                    Size = UDim2.new(0.9, 0, 1, 0);
                    Position = UDim2.new(0.5, 0, 0.5, 0);
                    AnchorPoint = Vector2.new(0.5, 0.5);
                    Text = "%s: %d%%":format(var16.name, var17 * 100 or 0);
                    TextXAlignment = Enum.TextXAlignment.Left;
                    Font = Enum.Font.Bangers;
                    LineHeight = 1;
                    TextScaled = true;
                    TextColor3 = ColorUtils_upvr.brightenBy(var16.color, -0.9);
                });
            });
        })
        local _
    end
    return createElement_upvr("Frame", {
        Size = UDim2.new(1, 0, 1, 0);
        BackgroundTransparency = 1;
    }, module)
end
local RxInstanceUtils_upvr = require(ReplicatedStorage.Std.RxInstanceUtils)
function any_extend_result1.didMount(arg1) -- Line 66
    if arg1.props.probsFolder then
        local function f_upvr() -- Line 68, Named "f"
            for i_2 = 1, #RewardSpinnerConsts_upvr.RARITIES do
                local SOME = arg1.props.probsFolder:FindFirstChild(tostring(i_2))
                if SOME then
                    ({})[i_2] = SOME.Value
                end
            end
            local tbl = {}
            -- Decomp Logic Error: Konstant reused an expression here; surrounding logic was preserved for review.
            tbl.probs = {}
            arg1:setState(tbl)
        end
        arg1.maid:GiveTask(RxInstanceUtils_upvr.observeChildren(arg1.props.probsFolder, function(arg1_2, arg2) -- Line 82
            f_upvr()
            arg2:GiveTask(arg1_2.Changed:Connect(f_upvr))
        end))
    end
end
function any_extend_result1.willUnmount(arg1) -- Line 89
    arg1.maid:DoCleaning()
end
return any_extend_result1