local ReplicatedStorage = game:GetService("ReplicatedStorage")
local PaddedContainer_upvr = require(ReplicatedStorage.EzUi.PaddedContainer)
local Roact_upvr = require(ReplicatedStorage.Roact)
local createElement_upvr = Roact_upvr.createElement
local any_extend_result1_upvr = Roact_upvr.PureComponent:extend("PlacerButton")
local function init(arg1) -- Line 8
    arg1:setState({
        hovered = false;
        pressed = false;
    })
    function arg1.onMouseEnter() -- Line 13
        arg1:setState({
            hovered = true;
        })
    end
    function arg1.onMouseLeave() -- Line 18
        arg1:setState({
            hovered = false;
        })
    end
    function arg1.onMouseDown() -- Line 23
        arg1:setState({
            pressed = true;
        })
        if arg1.props.onMouseDown then
            arg1.props.onMouseDown()
        end
    end
    function arg1.onMouseUp() -- Line 31
        arg1:setState({
            pressed = false;
        })
        if arg1.props.onMouseUp then
            arg1.props.onMouseUp()
        end
    end
end
any_extend_result1_upvr.init = init
local ColorUtils_upvr = require(ReplicatedStorage.Std.ColorUtils)
local function render(arg1) -- Line 40
    local state = arg1.state
    local bgColor = arg1.props.bgColor
    if state.pressed then
        bgColor = ColorUtils_upvr.brightenBy(bgColor, -0.2)
    elseif state.hovered then
        bgColor = ColorUtils_upvr.brightenBy(bgColor, -0.1)
    end
    local module = {}
    local icon = arg1.props.icon
    if icon then
        icon = createElement_upvr
        icon = icon("ImageButton", {
            BackgroundTransparency = 1;
            Image = arg1.props.icon;
            Size = UDim2.fromScale(1, 1);
            ImageColor3 = ColorUtils_upvr.brightenBy(bgColor, -0.7);
            Selectable = true;
            [Roact_upvr.Event.Activated] = arg1.props.onClick;
            [Roact_upvr.Event.MouseEnter] = arg1.onMouseEnter;
            [Roact_upvr.Event.MouseLeave] = arg1.onMouseLeave;
            [Roact_upvr.Event.SelectionGained] = arg1.onMouseEnter;
            [Roact_upvr.Event.SelectionLost] = arg1.onMouseLeave;
            [Roact_upvr.Event.MouseButton1Down] = arg1.onMouseDown;
            [Roact_upvr.Event.MouseButton1Up] = arg1.onMouseUp;
        })
    end
    module.Icon = icon
    local text = arg1.props.text
    if text then
        text = createElement_upvr
        text = text("TextButton", {
            BackgroundTransparency = 1;
            Text = "";
            Size = UDim2.fromScale(1, 1);
            Selectable = true;
            [Roact_upvr.Event.Activated] = arg1.props.onClick;
            [Roact_upvr.Event.MouseEnter] = arg1.onMouseEnter;
            [Roact_upvr.Event.MouseLeave] = arg1.onMouseLeave;
            [Roact_upvr.Event.SelectionGained] = arg1.onMouseEnter;
            [Roact_upvr.Event.SelectionLost] = arg1.onMouseLeave;
            [Roact_upvr.Event.MouseButton1Down] = arg1.onMouseDown;
            [Roact_upvr.Event.MouseButton1Up] = arg1.onMouseUp;
        }, {
            Title = createElement_upvr("TextLabel", {
                BackgroundTransparency = 1;
                Text = arg1.props.text;
                Size = UDim2.fromScale(0.8, 0.8);
                Position = UDim2.fromScale(0.5, 0.5);
                AnchorPoint = Vector2.new(0.5, 0.5);
                Font = Enum.Font.LuckiestGuy;
                LineHeight = 0.7;
                TextScaled = true;
                TextColor3 = ColorUtils_upvr.brightenBy(arg1.props.bgColor, -0.7);
            });
        })
    end
    module.Button = text
    module.UICorner = createElement_upvr("UICorner", {
        CornerRadius = UDim.new(0, 4);
    })
    local keyCode = arg1.props.keyCode
    if keyCode then
        keyCode = createElement_upvr
        keyCode = keyCode("TextLabel", {
            BackgroundTransparency = 1;
            Text = tostring(arg1.props.keyCode);
            Font = Enum.Font.SourceSansBold;
            TextColor3 = ColorUtils_upvr.brightenBy(arg1.props.bgColor, -0.5);
            TextScaled = true;
            Size = UDim2.fromScale(0.4, 0.4);
            Position = UDim2.fromScale(1, 1);
            AnchorPoint = Vector2.new(1, 1);
            ZIndex = 3;
        }, {
            AspectRatio = createElement_upvr("UIAspectRatioConstraint", {
                AspectRatio = 1;
            });
        })
    end
    module.KeyCodeContext = keyCode
    return createElement_upvr(PaddedContainer_upvr, {
        aspectRatio = arg1.props.aspectRatio;
        verticalPaddingRatio = arg1.props.verticalPaddingRatio;
        backgroundColor = bgColor;
        size = arg1.props.size;
        position = arg1.props.position;
        paddingTop = 0.5;
        paddingBottom = 0.5;
        paddingLeft = 0.5;
        paddingRight = 0.5;
    }, module)
end
any_extend_result1_upvr.render = render
local function buttons_upvr(arg1) -- Line 119, Named "buttons"
    local module_2 = {
        Left = createElement_upvr(any_extend_result1_upvr, {
            exposePaddedContainerProps = true;
            bgColor = arg1.bgColor;
            icon = "rbxassetid://6535451691";
            onMouseDown = arg1.onDownLeft;
            onMouseUp = arg1.onUpLeft;
            keyCode = 'Q';
            size = UDim2.fromScale(1 / arg1.aspectRatio, 1);
            position = UDim2.fromScale(0, 0);
        });
        Right = createElement_upvr(any_extend_result1_upvr, {
            exposePaddedContainerProps = true;
            bgColor = arg1.bgColor;
            icon = "rbxassetid://6535451364";
            onMouseDown = arg1.onDownRight;
            onMouseUp = arg1.onUpRight;
            keyCode = 'E';
            size = UDim2.fromScale(1 / arg1.aspectRatio, 1);
            position = UDim2.fromScale(1 - 1 / arg1.aspectRatio, 0);
        });
    }
    local tbl = {
        exposePaddedContainerProps = true;
        bgColor = arg1.bgColor;
        text = "Delete";
    }
    local onClickDelete = arg1.onClickDelete
    tbl.onClick = onClickDelete
    if arg1.showPlace then
        onClickDelete = UDim2.fromScale(0.5 - 1 / arg1.aspectRatio, 1)
    else
        onClickDelete = UDim2.fromScale(1 - 2 / arg1.aspectRatio, 1)
    end
    tbl.size = onClickDelete
    tbl.position = UDim2.fromScale(1 / arg1.aspectRatio, 0)
    module_2.Delete = createElement_upvr(any_extend_result1_upvr, tbl)
    local showPlace = arg1.showPlace
    if showPlace then
        showPlace = createElement_upvr
        showPlace = showPlace(any_extend_result1_upvr, {
            exposePaddedContainerProps = true;
            bgColor = arg1.bgColor;
            text = "Place";
            onClick = arg1.onClickPlace;
            size = UDim2.fromScale(0.5 - 1 / arg1.aspectRatio, 1);
            position = UDim2.fromScale(0.5, 0);
        })
    end
    module_2.Place = showPlace
    return createElement_upvr(PaddedContainer_upvr, {
        backgroundTransparency = 1;
        aspectRatio = arg1.aspectRatio;
        verticalPaddingRatio = arg1.verticalPaddingRatio;
        paddingTop = 0;
        paddingBottom = 0;
        paddingLeft = 0;
        paddingRight = 0;
    }, module_2)
end
local any_extend_result1 = Roact_upvr.PureComponent:extend("PlacerApp")
function any_extend_result1.init(arg1) -- Line 171
end
function any_extend_result1.render(arg1) -- Line 172
    return createElement_upvr(PaddedContainer_upvr, {
        backgroundTransparency = 0.8;
        backgroundColor = Color3.new(0, 0, 0);
        aspectRatio = arg1.props.aspectRatio;
        verticalPaddingRatio = arg1.props.verticalPaddingRatio;
        paddingTop = 0;
        paddingBottom = 0;
        paddingLeft = 0;
        paddingRight = 0;
    }, {
        UIAspectRatioConstraint = createElement_upvr("UIAspectRatioConstraint", {
            AspectRatio = arg1.props.aspectRatio;
        });
        UICorner = createElement_upvr("UICorner", {
            CornerRadius = UDim.new(0, 4);
        });
        Buttons = createElement_upvr(PaddedContainer_upvr, {
            backgroundTransparency = 1;
            paddingTop = 0.5;
            paddingBottom = 0.5;
            paddingLeft = 0.5;
            paddingRight = 0.5;
        }, {
            Buttons = createElement_upvr(buttons_upvr, {
                exposePaddedContainerProps = true;
                bgColor = Color3.fromRGB(255, 202, 11);
                onDownLeft = arg1.props.onDownLeft;
                onUpLeft = arg1.props.onUpLeft;
                onDownRight = arg1.props.onDownRight;
                onUpRight = arg1.props.onUpRight;
                onClickDelete = arg1.props.onClickDelete;
                onClickPlace = arg1.props.onClickPlace;
                showPlace = arg1.props.showPlace;
            });
        });
    })
end
return any_extend_result1