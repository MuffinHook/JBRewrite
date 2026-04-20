local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Roact = require(ReplicatedStorage.Roact)
local GameSettingsService_upvr = require(script.Parent.Parent.GameSettingsService)
local any_extend_result1 = Roact.PureComponent:extend("GameSettings")
local Maid_upvr = require(ReplicatedStorage.Std.Maid)
function any_extend_result1.init(arg1) -- Line 13
    arg1.maid = Maid_upvr.new()
    arg1:setState({
        updateCounter = 0;
    })
    arg1.maid:GiveTask(GameSettingsService_upvr.onUpdate:Connect(function() -- Line 18
        arg1:_forceUpdate()
    end))
end
function any_extend_result1._forceUpdate(arg1) -- Line 22
    arg1:setState({
        updateCounter = arg1.state.updateCounter + 1;
    })
end
local gameSettingType_upvr = require(script.Parent.Parent.gameSettingType)
local createElement_upvr = Roact.createElement
local Checkbox_upvr = require(ReplicatedStorage.EzUi.Checkbox)
local Slider_upvr = require(ReplicatedStorage.EzUi.Slider)
local Dictionary_upvr = require(ReplicatedStorage.EzUi.Dictionary)
function any_extend_result1.render(arg1) -- Line 27
    local module = {}
    for _, v_upvr in ipairs(GameSettingsService_upvr.getAll()) do
        local var22
        if v_upvr.type == gameSettingType_upvr.Checkbox then
            local tbl_2 = {
                AspectRatio = createElement_upvr("UIAspectRatioConstraint", {
                    AspectRatio = 30;
                });
                ListLayout = createElement_upvr("UIListLayout", {
                    HorizontalAlignment = Enum.HorizontalAlignment.Left;
                    VerticalAlignment = Enum.VerticalAlignment.Center;
                    SortOrder = Enum.SortOrder.LayoutOrder;
                    FillDirection = Enum.FillDirection.Horizontal;
                    Padding = UDim.new(0.02, 0);
                });
                Value = createElement_upvr(Checkbox_upvr, {
                    size = UDim2.new(1, 0, 1, 0);
                    value = v_upvr._value;
                    onChecked = function(arg1_2) -- Line 52, Named "onChecked"
                        v_upvr._value = arg1_2
                        arg1:_forceUpdate()
                        v_upvr.onChanged:Fire(arg1_2)
                    end;
                    layoutOrder = 1;
                    checkColor = arg1.props.color;
                });
            }
            local tbl_4 = {
                BackgroundTransparency = 1;
                Size = UDim2.new(0.85, 0, 0.8, 0);
                Position = UDim2.new(0, 0, 0, 0);
            }
            local title = v_upvr.title
            if not title then
                title = v_upvr.name
            end
            tbl_4.Text = title
            tbl_4.Font = Enum.Font.LuckiestGuy
            tbl_4.LineHeight = 0.7
            tbl_4.TextXAlignment = Enum.TextXAlignment.Left
            tbl_4.TextScaled = true
            tbl_4.TextColor3 = Color3.new(1, 1, 1)
            tbl_4.LayoutOrder = 2
            tbl_2.Title = createElement_upvr("TextLabel", tbl_4)
            var22 = createElement_upvr("Frame", {
                BackgroundTransparency = 1;
                Size = UDim2.new(1, 0, 1, 0);
                LayoutOrder = v_upvr.order;
            }, tbl_2)
        elseif v_upvr.type == gameSettingType_upvr.Slider then
            local tbl_3 = {
                AspectRatio = createElement_upvr("UIAspectRatioConstraint", {
                    AspectRatio = 30;
                });
                ListLayout = createElement_upvr("UIListLayout", {
                    HorizontalAlignment = Enum.HorizontalAlignment.Left;
                    VerticalAlignment = Enum.VerticalAlignment.Center;
                    SortOrder = Enum.SortOrder.LayoutOrder;
                    FillDirection = Enum.FillDirection.Horizontal;
                    Padding = UDim.new(0.02, 0);
                });
                Value = createElement_upvr(Slider_upvr, {
                    backgroundColor = Color3.new(0, 0, 0);
                    handleColor = Color3.new(1, 1, 1);
                    size = UDim2.new(0.48, 0, 1, 0);
                    min = v_upvr.min;
                    max = v_upvr.max;
                    step = v_upvr.step;
                    value = v_upvr._value;
                    updateValue = function(arg1_3) -- Line 97, Named "updateValue"
                        v_upvr._updateValue(arg1_3)
                        v_upvr.onChanged:Fire(arg1_3)
                    end;
                    layoutOrder = 1;
                    text = v_upvr._value:map(v_upvr.textMap);
                });
            }
            local tbl = {
                BackgroundTransparency = 1;
                Size = UDim2.new(0.5, 0, 0.8, 0);
                Position = UDim2.new(0, 0, 0, 0);
            }
            local title_2 = v_upvr.title
            if not title_2 then
                title_2 = v_upvr.name
            end
            tbl.Text = title_2
            tbl.Font = Enum.Font.LuckiestGuy
            tbl.LineHeight = 0.7
            tbl.TextXAlignment = Enum.TextXAlignment.Left
            tbl.TextScaled = true
            tbl.TextColor3 = Color3.new(1, 1, 1)
            tbl.LayoutOrder = 2
            tbl_3.Title = createElement_upvr("TextLabel", tbl)
            var22 = createElement_upvr("Frame", {
                BackgroundTransparency = 1;
                Size = UDim2.new(1, 0, 1, 0);
                LayoutOrder = v_upvr.order;
            }, tbl_3)
        end
        module[v_upvr.name] = var22
    end
    return createElement_upvr("ScrollingFrame", {
        BackgroundTransparency = 1;
        BorderSizePixel = 0;
        Size = arg1.props.size;
        Position = arg1.props.position;
        AnchorPoint = arg1.props.anchorPoint;
        Selectable = false;
        ScrollBarThickness = 6;
        ScrollingDirection = Enum.ScrollingDirection.Y;
    }, Dictionary_upvr.merge({
        Padding = createElement_upvr("UIPadding", {
            PaddingLeft = UDim.new(0, 4);
            PaddingRight = UDim.new(0, 4);
            PaddingTop = UDim.new(0, 4);
            PaddingBottom = UDim.new(0, 4);
        });
        ListLayout = createElement_upvr("UIListLayout", {
            HorizontalAlignment = Enum.HorizontalAlignment.Center;
            VerticalAlignment = Enum.VerticalAlignment.Top;
            SortOrder = Enum.SortOrder.LayoutOrder;
            FillDirection = Enum.FillDirection.Vertical;
            Padding = UDim.new(0.02, 0);
        });
    }, module))
end
function any_extend_result1.willUnmount(arg1) -- Line 150
    arg1.maid:DoCleaning()
end
return any_extend_result1