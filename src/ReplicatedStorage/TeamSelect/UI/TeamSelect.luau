local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Roact_upvr = require(ReplicatedStorage.Roact)
local tbl_7_upvr = {
    Police = "rbxassetid://116966056798634";
    Criminal = "rbxassetid://115514483147983";
    Prison = "rbxassetid://92321803810937";
}
local any_extend_result1 = Roact_upvr.PureComponent:extend("TeamSelect")
any_extend_result1.defaultProps = {
    aspectRatio = 1.75;
    verticalPaddingRatio = 64;
    size = UDim2.fromScale(1, 1);
    position = UDim2.fromScale(0.5, 0.5);
    anchorPoint = Vector2.new(0.5, 0.5);
}
local Maid_upvr = require(ReplicatedStorage.Std.Maid)
function any_extend_result1.init(arg1) -- Line 32
    arg1.maid = Maid_upvr.new()
end
local createElement_upvr = Roact_upvr.createElement
local Countdown_upvr = require(ReplicatedStorage.EzUi.Countdown)
local TeamSelectConsts_upvr = require(ReplicatedStorage.TeamSelect.TeamSelectConsts)
local AllUpdateText_upvr = require(ReplicatedStorage.TeamSelect.AllUpdateText)
local TeamSelectImageAssets_upvr = require(ReplicatedStorage.TeamSelect.TeamSelectImageAssets)
local PaddedContainer_upvr = require(ReplicatedStorage.EzUi.PaddedContainer)
local paddedScrollingGrid_upvr = require(ReplicatedStorage.EzUi.paddedScrollingGrid)
local Settings_upvr = require(ReplicatedStorage.Resource.Settings)
local ColorUtils_upvr = require(ReplicatedStorage.Std.ColorUtils)
local Localization_upvr = require(ReplicatedStorage.Module.Localization)
function any_extend_result1.render(arg1) -- Line 36
    -- Decomp Logic Error: Konstant variable analysis failed; temporary assignments in this block were preserved for review.
    local tbl_5 = {}
    local tbl_6 = {}
    local tbl_4 = {}
    local any_split_result1 = AllUpdateText_upvr:split('\n')
    local var50
    for i, v in any_split_result1, var50 do
        v = v:gsub("^%s+", "")
        local var51
        if v:sub(1, 9) == "[version:" or i == #any_split_result1 then
            if var51 ~= nil then
                table.insert(tbl_6, var51..'\n')
            end
            var51 = ""
        elseif not false then
            table.insert(tbl_4, v)
        else
            var51 = var51..'\n'..v
        end
    end
    if #tbl_6 ~= #tbl_4 then
        var50 = false
    else
        var50 = true
    end
    assert(var50)
    var50 = {}
    for i_2 = #tbl_6, 1, -1 do
        table.insert({}, tbl_6[i_2])
        table.insert(var50, tbl_4[i_2])
        local var53
    end
    for i_3, _ in var53 do
        table.insert(tbl_5, createElement_upvr("TextLabel", {
            BackgroundTransparency = 1;
            BorderSizePixel = 0;
            Size = UDim2.new(0.9, 0, 0.15, 0);
            Text = var50[i_3];
            LayoutOrder = i_3 * 3;
            Font = Enum.Font.SourceSansBold;
            TextXAlignment = Enum.TextXAlignment.Left;
            TextColor3 = Color3.new(1, 1, 1);
            TextScaled = true;
        }, {
            Stroke = createElement_upvr("UIStroke", {
                Thickness = 1;
                Color = Color3.new(0.4, 0.2, 0.2);
                ApplyStrokeMode = Enum.ApplyStrokeMode.Contextual;
            });
        }))
        table.insert(tbl_5, createElement_upvr("TextLabel", {
            BackgroundTransparency = 1;
            BorderSizePixel = 0;
            Size = UDim2.new(1, 0, 0.7, 0);
            RichText = true;
            Text = var53[i_3];
            LayoutOrder = i_3 * 3 + 1;
            Font = Enum.Font.SourceSansBold;
            TextYAlignment = Enum.TextYAlignment.Top;
            TextXAlignment = Enum.TextXAlignment.Left;
            TextColor3 = Color3.new(1, 1, 1);
            TextScaled = true;
        }))
        table.insert(tbl_5, createElement_upvr("Frame", {
            Size = UDim2.new(1, 0, 0, 1);
            BackgroundColor3 = Color3.new(1, 1, 1);
            BorderSizePixel = 0;
            LayoutOrder = i_3 * 3 + 2;
        }))
        local _
    end
    tbl_5.ListLayout = createElement_upvr("UIListLayout", {
        HorizontalAlignment = Enum.HorizontalAlignment.Left;
        VerticalAlignment = Enum.VerticalAlignment.Top;
        SortOrder = Enum.SortOrder.LayoutOrder;
        FillDirection = Enum.FillDirection.Vertical;
        Padding = UDim.new(0, 0);
    })
    local Color3_fromHex_result1_upvr_2 = Color3.fromHex("6687ce")
    local Color3_fromHex_result1_upvr = Color3.fromHex("de4833")
    local function getText_upvr(arg1_4, arg2) -- Line 193, Named "getText"
        local module_5 = {
            Size = UDim2.fromScale(1, 0.2);
            Position = UDim2.fromScale(0, 0.9);
            AnchorPoint = Vector2.new(0, 1);
            BackgroundTransparency = 1;
        }
        module_5.Text = arg1_4
        module_5.Font = Enum.Font.Bangers
        module_5.TextScaled = true
        module_5.TextColor3 = Color3.fromRGB(255, 255, 255)
        local module = {}
        local tbl_2 = {
            Thickness = 2;
        }
        tbl_2.Color = arg2
        module.UIStroke = createElement_upvr("UIStroke", tbl_2)
        return createElement_upvr("TextLabel", module_5, module)
    end
    local function getNumPlayers_upvr(arg1_5, arg2) -- Line 210, Named "getNumPlayers"
        local module_3 = {}
        local tbl_10 = {
            Thickness = 2;
        }
        tbl_10.Color = arg2
        module_3.UIStroke = createElement_upvr("UIStroke", tbl_10)
        return createElement_upvr("TextLabel", {
            Size = UDim2.fromScale(0.4, 0.09);
            Position = UDim2.fromScale(0.5, 0.9);
            AnchorPoint = Vector2.new(0.5, 0);
            BackgroundTransparency = 1;
            Text = `{arg1_5 or 0} PLAYERS`;
            Font = Enum.Font.Bangers;
            TextScaled = true;
            TextColor3 = Color3.fromRGB(255, 255, 255);
        }, module_3)
    end
    local any_createBinding_result1, any_createBinding_result2_upvr = Roact_upvr.createBinding(Color3_fromHex_result1_upvr_2)
    local _, _ = Roact_upvr.createBinding(Color3_fromHex_result1_upvr)
    local module_6 = {
        BadimoLogo = createElement_upvr("ImageLabel", {
            Size = UDim2.fromScale(0.05, 0.05);
            Position = UDim2.new(0, 5, 1, -5);
            AnchorPoint = Vector2.new(0, 1);
            BackgroundTransparency = 1;
            Image = TeamSelectImageAssets_upvr.BadimoLogo;
        }, {
            UIAspectRatioConstraint = createElement_upvr("UIAspectRatioConstraint", {
                AspectRatio = 2;
            });
        });
        RightContainer = createElement_upvr("Frame", {
            Position = UDim2.fromScale(1, 1);
            AnchorPoint = Vector2.new(1, 1);
            Size = UDim2.fromScale(0.25, 1);
            BackgroundTransparency = 1;
        }, {
            UIAspectRatioConstraint = createElement_upvr("UIAspectRatioConstraint", {
                AspectRatio = 0.5;
            });
            Inner = createElement_upvr(PaddedContainer_upvr, {
                verticalPaddingRatio = 64;
                aspectRatio = 0.5;
                paddingNone = true;
                backgroundTransparency = 1;
            }, {
                UpdateContainer = createElement_upvr(PaddedContainer_upvr, {
                    verticalPaddingRatio = 0;
                    aspectRatio = 1;
                    position = UDim2.fromScale(0, 0.55);
                    size = UDim2.fromScale(1, 0.25);
                    backgroundColor = Color3.new(0.2, 0.2, 0.2);
                    backgroundTransparency = 0.5;
                    paddingLeft = 0;
                    paddingRight = 1;
                    paddingBottom = 0;
                    paddingTop = 0;
                }, {
                    UICorner = createElement_upvr("UICorner", {
                        CornerRadius = UDim.new(0, 8);
                    });
                    UIStroke = createElement_upvr("UIStroke", {
                        Thickness = 2;
                        Transparency = 0.5;
                        Color = Color3.new(0.1, 0.1, 0.1);
                    });
                    ScrollingFrame = createElement_upvr(PaddedContainer_upvr, {
                        backgroundTransparency = 1;
                        paddingLeft = 0.5;
                        paddingTop = 0.5;
                        paddingRight = 0.5;
                        paddingBottom = 0.5;
                    }, {
                        ScrollingFrame = createElement_upvr("ScrollingFrame", {
                            BackgroundTransparency = 1;
                            BackgroundColor3 = Color3.new(1, 1, 1);
                            BorderSizePixel = 0;
                            ScrollBarThickness = 10;
                            ScrollBarImageColor3 = Color3.new(1, 1, 1);
                            Size = UDim2.fromScale(1, 1);
                            CanvasSize = UDim2.new(0, 0, 0, 0);
                            AutomaticCanvasSize = Enum.AutomaticSize.Y;
                            ElasticBehavior = Enum.ElasticBehavior.Always;
                            VerticalScrollBarPosition = Enum.VerticalScrollBarPosition.Right;
                            VerticalScrollBarInset = Enum.ScrollBarInset.None;
                        }, tbl_5);
                    });
                });
                Buttons = createElement_upvr(PaddedContainer_upvr, {
                    size = UDim2.fromScale(1, 0.2);
                    position = UDim2.fromScale(0, 0.8);
                    paddingBottom = 1;
                    paddingRight = 1;
                    paddingTop = 1;
                    paddingLeft = 0;
                    backgroundTransparency = 1;
                }, {
                    Inner = createElement_upvr(PaddedContainer_upvr, {
                        paddingLeft = -1;
                        paddingTop = -1;
                        paddingBottom = -1;
                        paddingRight = -1;
                        backgroundTransparency = 1;
                    }, {
                        ServerButtons = createElement_upvr(paddedScrollingGrid_upvr, {
                            exposePaddedContainerProps = true;
                            rowsPerPage = 3;
                            colsPerRow = 1;
                            component = function(arg1_2) -- Line 41, Named "buttonComponent"
                                local module_4 = {
                                    Size = arg1_2.size;
                                    Position = arg1_2.position;
                                    AnchorPoint = arg1_2.anchorPoint;
                                    BackgroundTransparency = 0.15;
                                    BackgroundColor3 = Color3.fromRGB(0, 0, 0);
                                    Text = ' '..arg1_2.text;
                                }
                                local textColor = arg1_2.textColor
                                if not textColor then
                                    textColor = Color3.fromRGB(255, 255, 255)
                                end
                                module_4.TextColor3 = textColor
                                module_4.TextScaled = true
                                module_4.Font = Enum.Font.Bangers
                                module_4.Selectable = true
                                module_4.TextXAlignment = Enum.TextXAlignment.Left
                                module_4[Roact_upvr.Event.Activated] = arg1_2.onClicked
                                local module_8 = {
                                    UIStroke = createElement_upvr("UIStroke", {
                                        Thickness = 2;
                                        Color = Color3.new(1, 1, 1);
                                        ApplyStrokeMode = Enum.ApplyStrokeMode.Border;
                                    });
                                    UICorner = createElement_upvr("UICorner", {
                                        CornerRadius = UDim.new(0, 8);
                                    });
                                }
                                local var42 = false
                                if arg1_2.text == "OG JAILBREAK" then
                                    var42 = createElement_upvr
                                    var42 = var42(Countdown_upvr, {
                                        injectPaddedContainerProps = true;
                                        endTime = TeamSelectConsts_upvr.OG_JB_END_TIME;
                                        size = UDim2.fromScale(0.4, 0.4);
                                        position = UDim2.fromScale(0.98, 0.8);
                                        anchorPoint = Vector2.new(1, 1);
                                        paddingNone = true;
                                        textXAlignment = Enum.TextXAlignment.Right;
                                        fontFace = Font.fromEnum(Enum.Font.Bangers);
                                        timeFormatFunc = function(arg1_3) -- Line 74, Named "timeFormatFunc"
                                            local var44 = arg1_3 % 86400
                                            return `{math.floor(arg1_3 / 86400)}D {math.floor(var44 / 3600)}H {math.floor(var44 % 3600 / 60)}M`
                                        end;
                                    })
                                end
                                module_8.Countdown = var42
                                return createElement_upvr("TextButton", module_4, module_8)
                            end;
                            items = arg1.props.serverButtons;
                        });
                    });
                });
            });
        });
    }
    local tbl_9 = {}
    local tbl = {}
    local tbl_3 = {
        JailbreakLogo = createElement_upvr("ImageLabel", {
            Size = UDim2.fromScale(0.9, 0.5);
            Position = UDim2.fromScale(0.5, 0);
            AnchorPoint = Vector2.new(0.5, 1);
            BackgroundTransparency = 1;
            Image = TeamSelectImageAssets_upvr.JailbreakLogo;
        }, {
            UIAspectRatioConstraint = createElement_upvr("UIAspectRatioConstraint", {
                AspectRatio = 2.2;
            });
        });
        Text = createElement_upvr("TextLabel", {
            Size = UDim2.fromScale(0.75, 0.1);
            Position = UDim2.fromScale(0.5, 0);
            AnchorPoint = Vector2.new(0.5, 0);
            BackgroundTransparency = 1;
            Text = "CHOOSE YOUR SIDE!";
            Font = Enum.Font.Bangers;
            TextScaled = true;
            TextColor3 = Color3.fromRGB(255, 255, 255);
        }, {
            UIStroke = createElement_upvr("UIStroke", {
                Thickness = 1;
                Color = Color3.fromRGB(0, 0, 0);
            });
        });
    }
    local tbl_8 = {
        PoliceTeam = createElement_upvr("ImageButton", {
            Size = UDim2.fromScale(0.45, 1);
            AnchorPoint = Vector2.new(1, 0);
            Position = UDim2.fromScale(0.48, 0);
            BackgroundTransparency = 0;
            BackgroundColor3 = any_createBinding_result1;
            Image = tbl_7_upvr.Police;
            [Roact_upvr.Event.Activated] = function() -- Line 408
                arg1.props.onTeamSelected(Settings_upvr.EnumTeam.Police)
            end;
            [Roact_upvr.Event.MouseEnter] = function() -- Line 411
                any_createBinding_result2_upvr(ColorUtils_upvr.brightenBy(Color3_fromHex_result1_upvr_2, -0.5))
            end;
            [Roact_upvr.Event.MouseLeave] = function() -- Line 414
                any_createBinding_result2_upvr(Color3_fromHex_result1_upvr_2)
            end;
            Selectable = true;
        }, {
            UIAspectRatioConstraint = createElement_upvr("UIAspectRatioConstraint", {
                AspectRatio = 1;
            });
            UICorner = createElement_upvr("UICorner", {
                CornerRadius = UDim.new(1);
            });
            UIStroke = createElement_upvr("UIStroke", {
                Thickness = 3;
                Color = any_createBinding_result1;
            });
            Text = getText_upvr(Localization_upvr:FormatByKey("Teams.TeamPolice"), Color3_fromHex_result1_upvr_2);
            NumPlayers = getNumPlayers_upvr(arg1.props.numPolice, Color3_fromHex_result1_upvr_2);
        });
    }
    local Color3_fromRGB_result1_upvw = Color3.fromRGB(253, 123, 49)
    tbl_8.NonPoliceTeam = (function() -- Line 433
        -- Decomp Logic Error: Konstant variable analysis failed; temporary assignments in this block were preserved for review.
        local var119
        if arg1.props.allowCriminal ~= true then
            var119 = false
        else
            var119 = true
        end
        local var120_upvw
        if var119 then
            var120_upvw = Settings_upvr.EnumTeam.Criminal
            local _ = Color3_fromHex_result1_upvr
        else
            var120_upvw = Settings_upvr.EnumTeam.Prisoner
        end
        local any_createBinding_result1_2, any_createBinding_result2_upvr_2 = Roact_upvr.createBinding(Color3_fromRGB_result1_upvw)
        local module_2 = {
            Size = UDim2.fromScale(0.45, 1);
            AnchorPoint = Vector2.new(0, 0);
            Position = UDim2.fromScale(0.52, 0);
            BackgroundTransparency = 0;
            BackgroundColor3 = any_createBinding_result1_2;
        }
        if not var119 or not tbl_7_upvr.Criminal then
        end
        module_2.Image = tbl_7_upvr.Prison
        module_2[Roact_upvr.Ref] = arg1.props.criminalButtonRef
        module_2[Roact_upvr.Event.Activated] = function() -- Line 460
            arg1.props.onTeamSelected(var120_upvw)
        end
        module_2[Roact_upvr.Event.MouseEnter] = function() -- Line 463
            any_createBinding_result2_upvr_2(ColorUtils_upvr.brightenBy(Color3_fromRGB_result1_upvw, -0.5))
        end
        module_2[Roact_upvr.Event.MouseLeave] = function() -- Line 466
            any_createBinding_result2_upvr_2(Color3_fromRGB_result1_upvw)
        end
        module_2.Selectable = true
        local module_7 = {
            UIAspectRatioConstraint = createElement_upvr("UIAspectRatioConstraint", {
                AspectRatio = 1;
            });
            UICorner = createElement_upvr("UICorner", {
                CornerRadius = UDim.new(1);
            });
            UIStroke = createElement_upvr("UIStroke", {
                Thickness = 3;
                Color = any_createBinding_result1_2;
            });
        }
        -- Decomp Logic Error: Konstant reused an expression here; surrounding logic was preserved for review.
        module_7.Text = getText_upvr(Localization_upvr:FormatByKey("Teams.TeamPrisoner"), Color3_fromRGB_result1_upvw)
        -- Decomp Logic Error: Konstant reused an expression here; surrounding logic was preserved for review.
        module_7.NumPlayers = getNumPlayers_upvr(arg1.props.numCriminals, Color3_fromRGB_result1_upvw)
        return createElement_upvr("ImageButton", module_2, module_7)
    end)()
    tbl_3.ImagesContainer = createElement_upvr(PaddedContainer_upvr, {
        verticalPaddingRatio = 0;
        anchorPoint = Vector2.new(0, 0);
        position = UDim2.fromScale(0, 0.1);
        size = UDim2.fromScale(1, 0.9);
        paddingLeft = 0;
        paddingRight = 0;
        paddingTop = 2;
        paddingBottom = 0;
        backgroundTransparency = 1;
    }, tbl_8)
    tbl.TeamsContainer = createElement_upvr(PaddedContainer_upvr, {
        verticalPaddingRatio = 0;
        aspectRatio = 1;
        anchorPoint = Vector2.new(0.5, 0.5);
        position = UDim2.fromScale(0.5, 0.55);
        size = UDim2.fromScale(1, 0.5);
        paddingNone = true;
        backgroundTransparency = 1;
    }, tbl_3)
    tbl_9.MiddleContainer = createElement_upvr(PaddedContainer_upvr, {
        verticalPaddingRatio = arg1.props.verticalPaddingRatio;
        aspectRatio = arg1.props.aspectRatio;
        anchorPoint = Vector2.new(0.5, 0.5);
        position = UDim2.fromScale(0.5, 0.45);
        size = UDim2.fromScale(0.5, 0.5);
        paddingNone = true;
        backgroundTransparency = 1;
    }, tbl)
    module_6.Frame = createElement_upvr("Frame", {
        Size = arg1.props.size;
        Position = arg1.props.position;
        AnchorPoint = arg1.props.anchorPoint;
        BackgroundTransparency = 1;
    }, tbl_9)
    return createElement_upvr("Frame", {
        Size = UDim2.fromScale(1, 1);
        Position = UDim2.fromScale(0.5, 0.5);
        AnchorPoint = Vector2.new(0.5, 0.5);
        BackgroundTransparency = 1;
        BackgroundColor3 = Color3.fromRGB(0, 0, 0);
    }, module_6)
end
function any_extend_result1.willUnmount(arg1) -- Line 491
    arg1.maid:Destroy()
end
return any_extend_result1