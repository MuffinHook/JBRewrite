local CollectionService_upvr = game:GetService("CollectionService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Maid_upvr = require(ReplicatedStorage.Std.Maid)
local Roact_upvr = require(ReplicatedStorage.Roact)
local any_extend_result1 = Roact_upvr.PureComponent:extend("Viewer")
function any_extend_result1.init(arg1) -- Line 17
    arg1._maid = Maid_upvr.new()
    arg1:setState({
        index = 1;
    })
    arg1:_updateCameraParts()
    local any_createBinding_result1, any_createBinding_result2 = Roact_upvr.createBinding(1)
    arg1.flash = any_createBinding_result1
    arg1.updateFlash = any_createBinding_result2
end
local RunService_upvr = game:GetService("RunService")
function any_extend_result1._flash(arg1) -- Line 25
    local os_clock_result1_upvr = os.clock()
    arg1._maid.flash = RunService_upvr.Heartbeat:Connect(function() -- Line 28
        local var12 = (os.clock() - os_clock_result1_upvr) / 0.25
        if 1 < var12 then
            var12 = 1
            arg1._maid.flash = nil
        end
        arg1.updateFlash(1 - math.sin(math.pi * (var12 + 0.25) / 1.25))
    end)
end
function any_extend_result1._updateCameraParts(arg1) -- Line 39
    local any_GetTagged_result1 = CollectionService_upvr:GetTagged(arg1.props.cameraTag)
    arg1:setState({
        cameraParts = any_GetTagged_result1;
    })
    local any_new_result1 = Maid_upvr.new()
    arg1._maid.cameraPartMaid = any_new_result1
    for _, v in ipairs(any_GetTagged_result1) do
        any_new_result1:GiveTask(v:GetAttributeChangedSignal("CCTVDisabled"):Connect(function() -- Line 47
            arg1:_updateCameraParts()
        end))
    end
end
local createElement_upvr = Roact_upvr.createElement
local CCTV_upvr = require(script.Parent.CCTV)
local CameraBinder_upvr = require(script.Parent.Parent.CameraBinder)
local Dictionary_upvr = require(ReplicatedStorage.EzUi.Dictionary)
function any_extend_result1.render(arg1) -- Line 52
    -- Decomp Logic Error: Konstant variable analysis failed; temporary assignments in this block were preserved for review.
    if not arg1.state.cameraParts or #arg1.state.cameraParts == 0 then return end
    local tbl_5 = {}
    local tbl_4 = {}
    for i_2 = 1, #arg1.state.cameraParts do
        local var38 = arg1.state.cameraParts[i_2]
        tbl_5[i_2] = var38.CFrame * CFrame.new(0, 0, -var38.Size.Z * 0.5)
        local CCTVName = var38:GetAttribute("CCTVName")
        ;({})[i_2] = CCTVName
        if var38:GetAttribute("CCTVDisabled") ~= true then
            CCTVName = false
        else
            CCTVName = true
        end
        tbl_4[i_2] = CCTVName
    end
    local tbl_3 = {}
    for i_3 = 1, 3 do
        local var41 = (arg1.state.index + i_3 - 1) % #tbl_5 + 1
        tbl_3[var41] = createElement_upvr(CCTV_upvr, {
            active = false;
            size = UDim2.new(1, 0, 1, 0);
            position = UDim2.new(0.5, 0, 0.5, 0);
            distance = arg1.props.distance;
            aspectRatio = arg1.props.aspectRatio;
            cameraCFrame = tbl_5[var41];
            fieldOfView = arg1.props.fieldOfView;
            layoutOrder = i_3;
            disabled = tbl_4[var41];
        })
        local var43_upvr
    end
    local module = {
        Padding = createElement_upvr("UIPadding", {
            PaddingLeft = UDim.new(0.015625, 0);
            PaddingRight = UDim.new(0.015625, 0);
            PaddingTop = UDim.new(0.03359375, 0);
            PaddingBottom = UDim.new(0.03359375, 0);
        });
        UICorner = createElement_upvr("UICorner", {
            CornerRadius = UDim.new(0.015625, 0);
        });
        AspectRatio = createElement_upvr("UIAspectRatioConstraint", {
            AspectRatio = 2.15;
        });
        Close = createElement_upvr("ImageButton", {
            BackgroundTransparency = 1;
            Image = "rbxassetid://4933143781";
            AnchorPoint = Vector2.new(0.6, 0.6);
            ZIndex = 3;
            Position = UDim2.new(0, 0, 0);
            Size = UDim2.new(0.1, 0, 0.1, 0);
            Selectable = true;
            [Roact_upvr.Event.MouseButton1Down] = arg1.props.onClickClose;
        }, {
            AspectRatio = createElement_upvr("UIAspectRatioConstraint", {
                AspectRatio = 1;
            });
        });
    }
    local tbl_2 = {
        Padding = createElement_upvr("UIPadding", {
            PaddingRight = UDim.new(0.015625, 0);
        });
        Camera = createElement_upvr(CCTV_upvr, {
            size = UDim2.new(1, 0, 1, 0);
            position = UDim2.new(0.5, 0, 0.5, 0);
            distance = arg1.props.distance;
            aspectRatio = arg1.props.aspectRatio;
            cameraCFrame = var43_upvr[arg1.state.index];
            fieldOfView = arg1.props.fieldOfView;
            disabled = tbl_4[arg1.state.index];
            flash = arg1.flash;
            onCharacterEnter = function(arg1_2) -- Line 133, Named "onCharacterEnter"
                CameraBinder_upvr:Get(arg1.state.cameraParts[arg1.state.index]):Spot(arg1_2)
                arg1:_flash()
            end;
        });
        Number = createElement_upvr("Frame", {
            BorderSizePixel = 0;
            BackgroundColor3 = Color3.new(0, 0, 0);
            BackgroundTransparency = 1;
            Size = UDim2.new(0.2, 0, 1, 0);
            AnchorPoint = Vector2.new(1, 1);
            Position = UDim2.new(0.98, 0, 0.98, 0);
            ZIndex = 3;
        }, {
            AspectRatio = createElement_upvr("UIAspectRatioConstraint", {
                AspectRatio = 3;
            });
            Title = createElement_upvr("TextLabel", {
                BackgroundTransparency = 1;
                Size = UDim2.new(1, 0, 1, 0);
                AnchorPoint = Vector2.new(0.5, 0.5);
                Position = UDim2.new(0.5, 0, 0.6, 0);
                TextColor3 = Color3.new(1, 1, 1);
                TextScaled = true;
                Text = "%02d/%02d":format(arg1.state.index, #var43_upvr);
                Font = Enum.Font.LuckiestGuy;
            });
        });
    }
    local tbl_6 = {
        AspectRatio = createElement_upvr("UIAspectRatioConstraint", {
            AspectRatio = 8;
        });
    }
    local tbl = {
        BackgroundTransparency = 1;
        Size = UDim2.new(1, 0, 1, 0);
        AnchorPoint = Vector2.new(0.5, 0.5);
        Position = UDim2.new(0.5, 0, 0.6, 0);
        TextColor3 = Color3.new(1, 1, 1);
        TextScaled = true;
    }
    -- Decomp Logic Error: Konstant reused an expression here; surrounding logic was preserved for review.
    tbl.Text = ({})[arg1.state.index]
    tbl.Font = Enum.Font.LuckiestGuy
    tbl.TextXAlignment = Enum.TextXAlignment.Left
    tbl_6.Title = createElement_upvr("TextLabel", tbl)
    tbl_2.Title = createElement_upvr("Frame", {
        BorderSizePixel = 0;
        BackgroundColor3 = Color3.new(0, 0, 0);
        BackgroundTransparency = 1;
        Size = UDim2.new(0.5, 0, 1, 0);
        AnchorPoint = Vector2.new(0, 0);
        Position = UDim2.new(0.02, 0, 0.02, 0);
        ZIndex = 3;
    }, tbl_6)
    module.Main = createElement_upvr("Frame", {
        BackgroundTransparency = 1;
        Size = UDim2.new(0.8, 0, 1, 0);
    }, tbl_2)
    module.Side = createElement_upvr("Frame", {
        BackgroundTransparency = 1;
        Size = UDim2.new(0.2, 0, 1, 0);
        Position = UDim2.new(0.8, 0, 0, 0);
    }, Dictionary_upvr.merge({
        ListLayout = createElement_upvr("UIListLayout", {
            HorizontalAlignment = Enum.HorizontalAlignment.Center;
            VerticalAlignment = Enum.VerticalAlignment.Center;
            SortOrder = Enum.SortOrder.LayoutOrder;
            FillDirection = Enum.FillDirection.Vertical;
            Padding = UDim.new(0.0215, 0);
        });
        Next = createElement_upvr("TextButton", {
            BackgroundTransparency = 0;
            BorderSizePixel = 0;
            BackgroundColor3 = Color3.new(0.3, 0.3, 0.3);
            Size = UDim2.new(1, 0, 1, 0);
            LayoutOrder = 100;
            Text = "";
            [Roact_upvr.Event.MouseButton1Down] = function() -- Line 209
                arg1:setState({
                    index = (arg1.state.index + 1 - 1) % #var43_upvr + 1;
                })
            end;
        }, {
            AspectRatio = createElement_upvr("UIAspectRatioConstraint", {
                AspectRatio = 6;
            });
            Title = createElement_upvr("TextLabel", {
                BackgroundTransparency = 1;
                Size = UDim2.new(1, 0, 1, 0);
                AnchorPoint = Vector2.new(0.5, 0.5);
                Position = UDim2.new(0.5, 0, 0.65, 0);
                TextColor3 = Color3.new(1, 1, 1);
                TextScaled = true;
                Text = "Next";
                Font = Enum.Font.LuckiestGuy;
            });
        });
        Prev = createElement_upvr("TextButton", {
            BackgroundTransparency = 0;
            BorderSizePixel = 0;
            BackgroundColor3 = Color3.new(0.3, 0.3, 0.3);
            Size = UDim2.new(1, 0, 1, 0);
            LayoutOrder = 101;
            Text = "";
            [Roact_upvr.Event.MouseButton1Down] = function() -- Line 236
                arg1:setState({
                    index = (arg1.state.index - 1 - 1) % #var43_upvr + 1;
                })
            end;
        }, {
            AspectRatio = createElement_upvr("UIAspectRatioConstraint", {
                AspectRatio = 6;
            });
            Title = createElement_upvr("TextLabel", {
                BackgroundTransparency = 1;
                Size = UDim2.new(1, 0, 1, 0);
                AnchorPoint = Vector2.new(0.5, 0.5);
                Position = UDim2.new(0.5, 0, 0.65, 0);
                TextColor3 = Color3.new(1, 1, 1);
                TextScaled = true;
                Text = "Prev";
                Font = Enum.Font.LuckiestGuy;
            });
        });
    }, tbl_3))
    return createElement_upvr("Frame", {
        BackgroundTransparency = 0;
        BorderSizePixel = 0;
        BackgroundColor3 = Color3.new(0.1, 0.1, 0.1);
        Size = arg1.props.size;
        Position = arg1.props.position;
        LayoutOrder = arg1.props.layoutOrder;
        AnchorPoint = Vector2.new(0.5, 0.5);
    }, module)
end
local Players_upvr = game:GetService("Players")
local Audio_upvr = require(ReplicatedStorage.Std.Audio)
local CharacterUtils_upvr = require(ReplicatedStorage.Std.CharacterUtils)
local Interval_upvr = require(ReplicatedStorage.Std.Interval)
function any_extend_result1.didMount(arg1) -- Line 260
    arg1.updateFlash(1)
    arg1._maid:GiveTask(CollectionService_upvr:GetInstanceAddedSignal(arg1.props.cameraTag):Connect(function() -- Line 263
        arg1:_updateCameraParts()
    end))
    arg1._maid:GiveTask(CollectionService_upvr:GetInstanceRemovedSignal(arg1.props.cameraTag):Connect(function() -- Line 266
        arg1:_updateCameraParts()
    end))
    if Players_upvr.LocalPlayer then
        arg1._maid:GiveTask(Audio_upvr.ObjectLocal(Players_upvr.LocalPlayer.PlayerGui, 9058379519, {
            Volume = 0.6;
            Looped = true;
        }))
    end
    if arg1.props.expireDistance then
        local any_getRootPart_result1_upvw = CharacterUtils_upvr.getRootPart(Players_upvr.LocalPlayer.Character)
        if any_getRootPart_result1_upvw then
            local Position_upvr = any_getRootPart_result1_upvw.Position
            arg1._maid:GiveTask(Interval_upvr.every(1):Connect(function() -- Line 279
                -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
                any_getRootPart_result1_upvw = CharacterUtils_upvr.getRootPart(Players_upvr.LocalPlayer.Character)
                -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
                -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
                arg1.props.onClickClose()
                do
                    return
                end
                -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
                -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
                arg1.props.onClickClose()
                -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
            end))
        end
    end
end
function any_extend_result1.willUnmount(arg1) -- Line 293
    arg1._maid:DoCleaning()
end
return any_extend_result1