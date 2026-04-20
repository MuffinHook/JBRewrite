local Roact_upvr = require(game:GetService("ReplicatedStorage").Roact)
local any_extend_result1 = Roact_upvr.PureComponent:extend("LicensePlate")
any_extend_result1.defaultProps = {
    text = "JAILBRK";
}
function any_extend_result1.init(arg1) -- Line 9
    arg1.boxRef = Roact_upvr.createRef()
end
local createElement_upvr = Roact_upvr.createElement
function any_extend_result1.render(arg1) -- Line 12
    return createElement_upvr("Frame", {
        BackgroundTransparency = 0.6666666666666666;
        BackgroundColor3 = Color3.new(0.2, 0.2, 0.2);
        AnchorPoint = Vector2.new(0.5, 0.5);
        Size = arg1.props.size;
        Position = arg1.props.position;
    }, {
        AspectRatio = createElement_upvr("UIAspectRatioConstraint", {
            AspectRatio = 3;
        });
        UICorner = createElement_upvr("UICorner", {
            CornerRadius = UDim.new(0.125, 0);
        });
        UIStroke = createElement_upvr("UIStroke", {
            Color = Color3.new(1, 1, 1);
            Thickness = 3;
        });
        Close = createElement_upvr("ImageButton", {
            BackgroundTransparency = 1;
            Image = "rbxassetid://4933143781";
            AnchorPoint = Vector2.new(0.4, 0.4);
            ZIndex = 3;
            Position = UDim2.new(0, 0, 0);
            Size = UDim2.new(0.2, 0, 0.2, 0);
            Selectable = true;
            [Roact_upvr.Event.MouseButton1Down] = arg1.props.onClickClose;
        }, {
            AspectRatio = createElement_upvr("UIAspectRatioConstraint", {
                AspectRatio = 1;
            });
        });
        Input = createElement_upvr("Frame", {
            BackgroundTransparency = 0.6666666666666666;
            BackgroundColor3 = Color3.new(0.1, 0.1, 0.1);
            Size = UDim2.new(0.8, 0, 0.3333333333333333, 0);
            Position = UDim2.new(0.5, 0, 0.3333333333333333, 0);
            AnchorPoint = Vector2.new(0.5, 0.5);
        }, {
            UICorner = createElement_upvr("UICorner", {
                CornerRadius = UDim.new(0.125, 0);
            });
            UIStroke = createElement_upvr("UIStroke", {
                Color = Color3.new(1, 1, 1);
                Thickness = 3;
            });
            Box = createElement_upvr("TextBox", {
                Size = UDim2.new(0.9, 0, 0.8, 0);
                AnchorPoint = Vector2.new(0.5, 0.5);
                Position = UDim2.new(0.5, 0, 0.6, 0);
                BackgroundTransparency = 1;
                TextScaled = true;
                Font = Enum.Font.LuckiestGuy;
                TextColor3 = Color3.new(1, 1, 1);
                PlaceholderText = arg1.props.text.."...";
                Text = "";
                [Roact_upvr.Ref] = arg1.boxRef;
                [Roact_upvr.Change.Text] = function(arg1_2) -- Line 69
                    arg1_2.Text = arg1_2.Text:upper():gsub("[^%w%s]", ""):sub(1, 7)
                end;
            });
        });
        Apply = createElement_upvr("TextButton", {
            BackgroundTransparency = 0.3333333333333333;
            BackgroundColor3 = Color3.new(0.1, 0.1, 0.1);
            Size = UDim2.new(0.4, 0, 0.2333333333333333, 0);
            Position = UDim2.new(0.5, 0, 0.7666666666666666, 0);
            AnchorPoint = Vector2.new(0.5, 0.5);
            Text = "";
            [Roact_upvr.Event.MouseButton1Down] = function() -- Line 85
                if arg1.props.onClickApply then
                    arg1.props.onClickApply(arg1.boxRef:getValue().Text)
                end
            end;
        }, {
            UICorner = createElement_upvr("UICorner", {
                CornerRadius = UDim.new(0.125, 0);
            });
            UIStroke = createElement_upvr("UIStroke", {
                Color = Color3.new(1, 1, 1);
                Thickness = 3;
                ApplyStrokeMode = Enum.ApplyStrokeMode.Border;
            });
            Title = createElement_upvr("TextLabel", {
                BackgroundTransparency = 1;
                Size = UDim2.new(0.9, 0, 0.8, 0);
                AnchorPoint = Vector2.new(0.5, 0.5);
                Position = UDim2.new(0.5, 0, 0.6, 0);
                TextScaled = true;
                Font = Enum.Font.LuckiestGuy;
                TextColor3 = Color3.new(1, 1, 1);
                Text = "Apply";
            });
        });
    })
end
return any_extend_result1