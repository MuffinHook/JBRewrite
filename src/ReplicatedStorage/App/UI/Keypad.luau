local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Roact_upvr = require(ReplicatedStorage.Roact)
local createElement_upvr = Roact_upvr.createElement
local function button_upvr(arg1) -- Line 6, Named "button"
    local module = {
        BorderSizePixel = 1;
        BorderColor3 = Color3.new(0.3, 0.3, 0.3);
        BackgroundTransparency = 0;
    }
    local color = arg1.color
    if not color then
        color = Color3.new(0.1, 0.1, 0.1)
    end
    module.BackgroundColor3 = color
    module.Size = arg1.size
    module.Position = arg1.position
    module.Text = ""
    module.Selectable = true
    module[Roact_upvr.Event.Activated] = arg1.onClicked
    return createElement_upvr("TextButton", module, {
        Title = createElement_upvr("TextLabel", {
            BackgroundTransparency = 1;
            BorderSizePixel = 0;
            Size = UDim2.new(0.9, 0, 1, 0);
            Position = UDim2.new(0.5, 0, 0.5, 0);
            AnchorPoint = Vector2.new(0.5, 0.5);
            Text = arg1.title;
            Font = Enum.Font.LuckiestGuy;
            LineHeight = 0.7;
            TextScaled = true;
            TextXAlignment = Enum.TextXAlignment.Center;
            TextYAlignment = Enum.TextYAlignment.Center;
            TextColor3 = Color3.fromRGB(255, 255, 255);
            ZIndex = 10;
        });
    })
end
local any_extend_result1 = Roact_upvr.PureComponent:extend("Keypad")
any_extend_result1.defaultProps = {
    anchorPoint = Vector2.new(0.5, 0.5);
    position = UDim2.new(0.5, 0, 0.5, 0);
    title = "Keypad";
}
function any_extend_result1.init(arg1) -- Line 42
    arg1:setState({
        code = "";
    })
end
local Grid_upvr = require(ReplicatedStorage.EzUi.Grid)
function any_extend_result1.render(arg1) -- Line 47
    local tbl = {}
    for i_upvr = 1, 9 do
        local tbl_3 = {
            title = tostring(i_upvr);
        }
        local function onClicked() -- Line 52
            if arg1.props.onClicked then
                arg1.props.onClicked(i_upvr)
            end
            arg1:setState({
                code = arg1.state.code..tostring(i_upvr);
            })
        end
        tbl_3.onClicked = onClicked
        table.insert(tbl, tbl_3)
    end
    local tbl_2 = {
        title = "Clear";
        color = Color3.fromRGB(235, 60, 0);
    }
    local function onClicked() -- Line 65
        if arg1.props.onClicked then
            arg1.props.onClicked(-2)
        end
        arg1:setState({
            code = "";
        })
    end
    tbl_2.onClicked = onClicked
    table.insert(tbl, tbl_2)
    local tbl_4 = {
        title = tostring(0);
    }
    local function onClicked() -- Line 76
        if arg1.props.onClicked then
            arg1.props.onClicked(0)
        end
        arg1:setState({
            code = arg1.state.code..tostring(0);
        })
    end
    tbl_4.onClicked = onClicked
    table.insert(tbl, tbl_4)
    table.insert(tbl, {
        title = "Enter";
        color = Color3.fromRGB(25, 200, 53);
        onClicked = function() -- Line 88, Named "onClicked"
            if arg1.props.onClicked then
                arg1.props.onClicked(-1)
            end
            if arg1.props.onSubmit then
                arg1.props.onSubmit(arg1.state.code)
            end
            arg1:setState({
                code = "";
            })
        end;
    })
    return createElement_upvr("Frame", {
        BackgroundTransparency = 0;
        BackgroundColor3 = Color3.new(0.2, 0.2, 0.2);
        BorderSizePixel = 0;
        Size = arg1.props.size;
        Position = arg1.props.position;
        AnchorPoint = arg1.props.anchorPoint;
    }, {
        AspectRatio = createElement_upvr("UIAspectRatioConstraint", {
            AspectRatio = 0.8333333333333333;
        });
        Close = createElement_upvr("ImageButton", {
            BackgroundTransparency = 1;
            Image = "rbxassetid://4933143781";
            AnchorPoint = Vector2.new(0.5, 0.5);
            ZIndex = 3;
            Position = UDim2.new(0, 0, 0);
            Size = UDim2.new(0.05, 0, 0.05, 0);
            Selectable = true;
            [Roact_upvr.Event.MouseButton1Down] = arg1.props.onClickClose;
        }, {
            AspectRatio = createElement_upvr("UIAspectRatioConstraint", {
                AspectRatio = 1;
            });
        });
        Code = createElement_upvr("Frame", {
            BackgroundTransparency = 1;
            Size = UDim2.new(1, 0, 0.08333333333333333, 0);
            Position = UDim2.new(0, 0, 0.9166666666666666, 0);
        }, {
            Title = createElement_upvr("TextLabel", {
                BackgroundTransparency = 1;
                BorderSizePixel = 0;
                Size = UDim2.new(0.9, 0, 0.7, 0);
                Position = UDim2.new(0.5, 0, 0.5, 0);
                AnchorPoint = Vector2.new(0.5, 0.5);
                Text = arg1.state.code;
                Font = Enum.Font.LuckiestGuy;
                LineHeight = 0.7;
                TextScaled = true;
                TextXAlignment = Enum.TextXAlignment.Center;
                TextYAlignment = Enum.TextYAlignment.Center;
                TextColor3 = Color3.fromRGB(255, 255, 255);
                ZIndex = 10;
            });
        });
        Title = createElement_upvr("Frame", {
            BackgroundTransparency = 1;
            Size = UDim2.new(1, 0, 1, 0);
            Position = UDim2.new(0, 0, 0, 0);
        }, {
            AspectRatio = createElement_upvr("UIAspectRatioConstraint", {
                AspectRatio = 10;
            });
            Title = createElement_upvr("TextLabel", {
                BackgroundTransparency = 1;
                BorderSizePixel = 0;
                Size = UDim2.new(0.9, 0, 0.7, 0);
                Position = UDim2.new(0.5, 0, 0.5, 0);
                AnchorPoint = Vector2.new(0.5, 0.5);
                Text = arg1.props.title or "";
                Font = Enum.Font.LuckiestGuy;
                LineHeight = 0.7;
                TextScaled = true;
                TextXAlignment = Enum.TextXAlignment.Center;
                TextYAlignment = Enum.TextYAlignment.Center;
                TextColor3 = Color3.fromRGB(255, 255, 255);
                ZIndex = 10;
            }, {
                UIStroke = createElement_upvr("UIStroke", {
                    Color = Color3.new(0.1, 0.1, 0.1);
                    Thickness = 2;
                    Enabled = arg1.props.active;
                });
            });
        });
        Buttons = createElement_upvr("Frame", {
            BackgroundTransparency = 1;
            Size = UDim2.new(1, 0, 0.8333333333333333, 0);
            Position = UDim2.new(0, 0, 0.08333333333333333, 0);
        }, {
            Grid = Roact_upvr.createElement(Grid_upvr, {
                aspectRatio = 1;
                paddingRatio = 100;
                rowsPerPage = 4;
                colsPerRow = 3;
                component = button_upvr;
                items = tbl;
            });
        });
    })
end
function any_extend_result1.didMount(arg1) -- Line 195
    arg1:setState({
        code = "";
    })
end
return any_extend_result1