local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Roact_upvr = require(ReplicatedStorage.Roact)
local any_extend_result1 = Roact_upvr.PureComponent:extend("ReportCrew")
any_extend_result1.defaultProps = {
    position = UDim2.fromScale(0.5, 0.5);
    size = UDim2.fromScale(0.9, 0.9);
}
local PersistentCrewBattleConsts_upvr = require(ReplicatedStorage.PersistentCrewBattle.PersistentCrewBattleConsts)
function any_extend_result1.init(arg1) -- Line 13
    arg1.explainBoxRef = Roact_upvr.createRef()
    arg1.reportButtons = PersistentCrewBattleConsts_upvr.CLAN_REPORT_OPTIONS
    arg1:setState({
        selectedButton = Roact_upvr.None;
    })
    function arg1.close() -- Line 19
        arg1.explainBoxRef:getValue().Text = ""
        arg1:setState({
            selectedButton = Roact_upvr.None;
        })
        arg1.props.onClose()
    end
    function arg1.attemptSubmit() -- Line 27
        if arg1.state.selectedButton == nil then
        else
            arg1.props.onSubmit(arg1.state.selectedButton.name, arg1.explainBoxRef:getValue().Text)
            arg1.close()
        end
    end
end
local createElement_upvr = Roact_upvr.createElement
local PaddedContainer_upvr = require(ReplicatedStorage.EzUi.PaddedContainer)
function any_extend_result1.render(arg1) -- Line 37
    -- Decomp Logic Error: Konstant variable analysis failed; temporary assignments in this block were preserved for review.
    local Color3_new_result1 = Color3.new(0.2, 0.2, 0.2)
    local function button(arg1_2) -- Line 47
        return createElement_upvr(PaddedContainer_upvr, {
            size = arg1_2.size;
            position = arg1_2.position;
            backgroundTransparency = 1;
            paddingTop = 0.5;
            paddingBottom = 0.5;
            paddingLeft = 0.5;
            paddingRight = 0.5;
        }, {
            Button = createElement_upvr("TextButton", {
                AutoButtonColor = not arg1_2.disabled;
                BackgroundColor3 = arg1_2.bgColor;
                BackgroundTransparency = 0;
                Size = UDim2.fromScale(1, 1);
                Position = UDim2.fromScale(0, 0.5);
                AnchorPoint = Vector2.new(0, 0.5);
                Text = "";
                TextScaled = true;
                TextColor3 = Color3.fromRGB(255, 255, 255);
                TextXAlignment = Enum.TextXAlignment.Left;
                Selectable = true;
                [Roact_upvr.Event.Activated] = arg1_2.onClicked;
            }, {
                Stroke = createElement_upvr("UIStroke", {
                    ApplyStrokeMode = Enum.ApplyStrokeMode.Border;
                    Thickness = 1.5;
                    Color = Color3.new(0.1, 0.1, 0.1);
                });
                Corner = createElement_upvr("UICorner", {
                    CornerRadius = UDim.new(0, 8);
                });
                Inner = createElement_upvr(PaddedContainer_upvr, {
                    backgroundTransparency = 1;
                    paddingTop = 1;
                    paddingBottom = 1;
                    paddingLeft = 2;
                    paddingRight = 2;
                }, {
                    Title = createElement_upvr("TextLabel", {
                        BackgroundTransparency = 1;
                        Size = UDim2.fromScale(1, 0.9);
                        Position = UDim2.fromScale(0, 0.5);
                        AnchorPoint = Vector2.new(0, 0.5);
                        Text = arg1_2.text;
                        LineHeight = arg1_2.lineHeight;
                        Font = arg1_2.font;
                        TextScaled = true;
                        TextColor3 = Color3.fromRGB(255, 255, 255);
                    });
                });
            });
        })
    end
    local tbl_11 = {}
    local var31
    for i, v_upvr in arg1.reportButtons do
        local var32
        if arg1.state.selectedButton ~= v_upvr then
            var32 = false
        else
            var32 = true
        end
        local tbl_4 = {
            size = UDim2.fromScale(1, 1 / #arg1.reportButtons);
            position = UDim2.fromScale(0, 1 / #arg1.reportButtons * (i - 1));
            text = v_upvr.title;
            font = Enum.Font.FredokaOne;
        }
        if var32 then
            local Color3_fromRGB_result1 = Color3.fromRGB(251, 121, 121)
        else
        end
        tbl_4.bgColor = Color3.fromRGB(88, 172, 246)
        function tbl_4.onClicked() -- Line 115
            arg1:setState({
                selectedButton = v_upvr;
            })
        end
        table.insert(tbl_11, button(tbl_4))
    end
    local module = {
        AspectRatio = createElement_upvr("UIAspectRatioConstraint", {
            AspectRatio = 0.75;
        });
    }
    local tbl_8 = {}
    local tbl_7 = {
        Corner = createElement_upvr("UICorner", {
            CornerRadius = UDim.new(0, 4);
        });
    }
    local tbl_12 = {}
    var31 = {}
    var31.BackgroundTransparency = 1
    var31.Size = UDim2.fromScale(1, 0.9)
    var31.Position = UDim2.fromScale(0, 0.5)
    var31.AnchorPoint = Vector2.new(0, 0.5)
    var31.Text = "Report Crew?"
    var31.LineHeight = 0.7
    var31.Font = Enum.Font.LuckiestGuy
    var31.TextScaled = true
    var31.TextColor3 = Color3.fromRGB(255, 255, 255)
    var31.TextXAlignment = Enum.TextXAlignment.Left
    tbl_12.Title = createElement_upvr("TextLabel", var31)
    tbl_7.Inner = createElement_upvr(PaddedContainer_upvr, {
        backgroundTransparency = 1;
        paddingTop = 2;
        paddingBottom = 2;
        paddingLeft = 2;
        paddingRight = 2;
    }, tbl_12)
    tbl_8.Header = createElement_upvr(PaddedContainer_upvr, {
        backgroundColor = Color3_new_result1;
        size = UDim2.fromScale(1, 0.15);
        paddingBottom = 0.5;
    }, tbl_7)
    local tbl_10 = {
        Corner = createElement_upvr("UICorner", {
            CornerRadius = UDim.new(0, 4);
        });
    }
    local tbl_6 = {}
    var31 = {}
    var31.backgroundTransparency = 1
    var31.size = UDim2.fromScale(1, 0.75)
    var31.paddingBottom = 0.25
    var31.paddingTop = 0.5
    var31.paddingRight = 0.5
    var31.paddingLeft = 0.5
    tbl_6.Buttons = createElement_upvr(PaddedContainer_upvr, var31, tbl_11)
    var31 = {}
    var31.backgroundTransparency = 0
    var31.backgroundColor = Color3.fromRGB(150, 150, 150)
    var31.size = UDim2.fromScale(1, 0.25)
    var31.position = UDim2.fromScale(0, 0.75)
    var31.paddingTop = 0.5
    tbl_6.Explain = createElement_upvr(PaddedContainer_upvr, var31, {
        Corner = createElement_upvr("UICorner", {
            CornerRadius = UDim.new(0, 4);
        });
        Inner = createElement_upvr(PaddedContainer_upvr, {
            backgroundTransparency = 1;
            paddingTop = 2;
            paddingBottom = 2;
            paddingLeft = 2;
            paddingRight = 2;
        }, {
            Box = createElement_upvr("TextBox", {
                BackgroundTransparency = 1;
                BorderSizePixel = 0;
                Size = UDim2.fromScale(1, 1);
                Font = Enum.Font.FredokaOne;
                TextScaled = true;
                ClearTextOnFocus = false;
                Text = "";
                TextWrapped = true;
                PlaceholderText = "Tell us more...";
                TextXAlignment = Enum.TextXAlignment.Left;
                TextYAlignment = Enum.TextYAlignment.Top;
                TextColor3 = Color3.fromRGB(255, 255, 255);
                [Roact_upvr.Ref] = arg1.explainBoxRef;
            }, {
                TextSizeConstraint = createElement_upvr("UITextSizeConstraint", {
                    MinTextSize = 1;
                    MaxTextSize = 20;
                });
            });
        });
    })
    tbl_10.Inner = createElement_upvr(PaddedContainer_upvr, {
        backgroundTransparency = 1;
        paddingTop = 2;
        paddingBottom = 2;
        paddingLeft = 2;
        paddingRight = 2;
    }, tbl_6)
    tbl_8.Body = createElement_upvr(PaddedContainer_upvr, {
        backgroundColor = Color3_new_result1;
        size = UDim2.fromScale(1, 0.7);
        position = UDim2.fromScale(0, 0.15);
        paddingTop = 0.5;
        paddingBottom = 0.5;
    }, tbl_10)
    local tbl_3 = {
        Corner = createElement_upvr("UICorner", {
            CornerRadius = UDim.new(0, 4);
        });
    }
    local tbl = {}
    local tbl_2 = {}
    var31 = "Nevermind"
    tbl_2.text = var31
    var31 = UDim2.fromScale(0.6, 1)
    tbl_2.size = var31
    var31 = Enum.Font.LuckiestGuy
    tbl_2.font = var31
    var31 = 0.7
    tbl_2.lineHeight = var31
    var31 = Color3.fromRGB(88, 172, 246)
    tbl_2.bgColor = var31
    var31 = arg1.close
    tbl_2.onClicked = var31
    tbl.NevermindButton = button(tbl_2)
    local tbl_9 = {}
    var31 = "Submit"
    tbl_9.text = var31
    var31 = UDim2.fromScale(0.4, 1)
    tbl_9.size = var31
    var31 = UDim2.fromScale(0.6, 0)
    tbl_9.position = var31
    var31 = Enum.Font.LuckiestGuy
    tbl_9.font = var31
    var31 = 0.7
    tbl_9.lineHeight = var31
    if arg1.state.selectedButton ~= nil then
        var31 = false
    else
        var31 = true
    end
    tbl_9.disabled = var31
    if arg1.state.selectedButton ~= nil then
    else
    end
    tbl_9.bgColor = Color3.new(0.5, 0.5, 0.5)
    tbl_9.onClicked = arg1.attemptSubmit
    tbl.SubmitButton = button(tbl_9)
    tbl_3.Buttons = createElement_upvr(PaddedContainer_upvr, {
        backgroundTransparency = 1;
        size = UDim2.fromScale(1, 0.7);
        paddingTop = 0.5;
        paddingBottom = 0.5;
        paddingLeft = 0.5;
        paddingRight = 0.5;
    }, tbl)
    local tbl_5 = {}
    ;({}).backgroundTransparency = 1
    -- Decomp Logic Error: Konstant reused an expression here; surrounding logic was preserved for review.
    ;({}).paddingNone = true
    -- Decomp Logic Error: Konstant reused an expression here; surrounding logic was preserved for review.
    tbl_5.Inner = createElement_upvr(PaddedContainer_upvr, {}, {
        Title = createElement_upvr("TextLabel", {
            BackgroundTransparency = 1;
            Size = UDim2.fromScale(0.8, 1.6);
            Position = UDim2.fromScale(0.5, 0.3);
            AnchorPoint = Vector2.new(0.5, 0.5);
            Text = "All reports must be honest. If you are caught abusing this system, you may be banned from the game.";
            Font = Enum.Font.FredokaOne;
            TextScaled = true;
            TextColor3 = Color3.fromRGB(255, 255, 255);
            TextXAlignment = Enum.TextXAlignment.Center;
        });
    })
    tbl_3.Help = createElement_upvr(PaddedContainer_upvr, {
        backgroundTransparency = 1;
        size = UDim2.fromScale(1, 0.3);
        position = UDim2.fromScale(0, 0.7);
        paddingNone = true;
    }, tbl_5)
    tbl_8.Footer = createElement_upvr(PaddedContainer_upvr, {
        backgroundColor = Color3_new_result1;
        size = UDim2.fromScale(1, 0.15);
        position = UDim2.fromScale(0, 0.85);
        paddingTop = 0.5;
    }, tbl_3)
    module.Container = createElement_upvr(PaddedContainer_upvr, {
        backgroundTransparency = 1;
        aspectRatio = 0.75;
        verticalPaddingRatio = 85.33333333333333;
        paddingNone = true;
    }, tbl_8)
    return createElement_upvr("Frame", {
        BackgroundTransparency = 1;
        Size = arg1.props.size;
        Position = arg1.props.position;
        AnchorPoint = Vector2.new(0.5, 0.5);
    }, module)
end
return any_extend_result1