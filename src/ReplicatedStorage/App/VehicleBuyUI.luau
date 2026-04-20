local Players_upvr = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Audio_upvr = require(ReplicatedStorage.Std.Audio)
local function _() -- Line 10, Named "PlayButtonClick"
    task.spawn(Audio_upvr.ObjectLocal, Players_upvr.LocalPlayer, 6105461542, {
        Volume = 0.15;
    })
end
local function _() -- Line 13, Named "PlayUIOpen"
    task.spawn(Audio_upvr.ObjectLocal, Players_upvr.LocalPlayer, 131184732929614, {
        Volume = 0.15;
    })
end
local Signal_upvr = require(ReplicatedStorage.Std.Signal)
local Maid_upvr = require(ReplicatedStorage.Std.Maid)
local Settings_upvr = require(ReplicatedStorage.Resource.Settings)
local Format_upvr = require(ReplicatedStorage.Module.Format)
return function() -- Line 17
    local Frame_upvr = Instance.new("Frame")
    Frame_upvr.Name = "NewBuyVehicle"
    Frame_upvr.BackgroundColor3 = Color3.fromRGB(68, 194, 93)
    Frame_upvr.Position = UDim2.new(0.5, -125, 0.5, -75)
    Frame_upvr.Size = UDim2.fromOffset(250, 110)
    Frame_upvr.ZIndex = 5
    Frame_upvr.Visible = false
    local ImageButton_upvr = Instance.new("ImageButton")
    ImageButton_upvr.Name = "BuyCash"
    ImageButton_upvr.BackgroundTransparency = 1
    ImageButton_upvr.Image = "rbxassetid://723277512"
    ImageButton_upvr.Position = UDim2.fromOffset(-24, -24)
    ImageButton_upvr.Size = UDim2.fromOffset(64, 64)
    ImageButton_upvr.ZIndex = 6
    ImageButton_upvr.Parent = Frame_upvr
    local TextLabel_2_upvr = Instance.new("TextLabel")
    TextLabel_2_upvr.Name = "TextLabel"
    TextLabel_2_upvr.BackgroundTransparency = 1
    TextLabel_2_upvr.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
    TextLabel_2_upvr.Position = UDim2.fromOffset(30, 15)
    TextLabel_2_upvr.Size = UDim2.new(1, -60, 1, -40)
    TextLabel_2_upvr.TextColor3 = Color3.fromRGB(20, 59, 26)
    TextLabel_2_upvr.TextScaled = true
    TextLabel_2_upvr.TextYAlignment = Enum.TextYAlignment.Top
    TextLabel_2_upvr.ZIndex = 6
    TextLabel_2_upvr.Parent = Frame_upvr
    local TextLabel_upvr = Instance.new("TextLabel")
    TextLabel_upvr.Name = "Money"
    TextLabel_upvr.BackgroundTransparency = 1
    TextLabel_upvr.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
    TextLabel_upvr.Position = UDim2.new(0.48, -80, -0.007, -40)
    TextLabel_upvr.Size = UDim2.fromOffset(173, 37)
    TextLabel_upvr.TextColor3 = Color3.new(1, 1, 1)
    TextLabel_upvr.TextScaled = true
    TextLabel_upvr.TextStrokeTransparency = 0.4
    TextLabel_upvr.TextXAlignment = Enum.TextXAlignment.Right
    TextLabel_upvr.ZIndex = 6
    TextLabel_upvr.Parent = Frame_upvr
    local TextLabel = Instance.new("TextLabel")
    TextLabel.Name = "OneTime"
    TextLabel.BackgroundTransparency = 1
    TextLabel.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
    TextLabel.Position = UDim2.new(0, 30, 1, -30)
    TextLabel.Size = UDim2.new(1, -60, 0, 20)
    TextLabel.Text = "* one time purchase"
    TextLabel.TextColor3 = Color3.fromRGB(26, 76, 32)
    TextLabel.TextScaled = true
    TextLabel.TextTransparency = 0.6
    TextLabel.TextYAlignment = Enum.TextYAlignment.Top
    TextLabel.ZIndex = 6
    TextLabel.Parent = Frame_upvr
    local UICorner_2 = Instance.new("UICorner")
    UICorner_2.Name = "UICorner"
    UICorner_2.CornerRadius = UDim.new(0.2, 0)
    UICorner_2.Parent = Frame_upvr
    local UIStroke_2 = Instance.new("UIStroke")
    UIStroke_2.Name = "UIStroke"
    UIStroke_2.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    UIStroke_2.BorderStrokePosition = Enum.BorderStrokePosition.Center
    UIStroke_2.Color = Color3.fromRGB(57, 163, 76)
    UIStroke_2.StrokeSizingMode = Enum.StrokeSizingMode.ScaledSize
    UIStroke_2.Thickness = 0.03
    UIStroke_2.Parent = Frame_upvr
    local TextButton_upvr_4 = Instance.new("TextButton")
    TextButton_upvr_4.Name = "Buy"
    TextButton_upvr_4.BackgroundColor3 = Color3.fromRGB(74, 211, 99)
    TextButton_upvr_4.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
    TextButton_upvr_4.Position = UDim2.new(0, 10, 1.03636, 5)
    TextButton_upvr_4.Size = UDim2.new(0.5, -15, 0, 40)
    TextButton_upvr_4.Text = "Buy"
    TextButton_upvr_4.TextColor3 = Color3.fromRGB(20, 59, 26)
    TextButton_upvr_4.TextSize = 28
    TextButton_upvr_4.ZIndex = 6
    local UICorner_5 = Instance.new("UICorner")
    UICorner_5.Name = "UICorner"
    UICorner_5.CornerRadius = UDim.new(1, 0)
    UICorner_5.Parent = TextButton_upvr_4
    local UIStroke_4 = Instance.new("UIStroke")
    UIStroke_4.Name = "UIStroke"
    UIStroke_4.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    UIStroke_4.Color = Color3.fromRGB(57, 163, 76)
    UIStroke_4.StrokeSizingMode = Enum.StrokeSizingMode.ScaledSize
    UIStroke_4.Thickness = 0.08
    UIStroke_4.Parent = TextButton_upvr_4
    TextButton_upvr_4.Parent = Frame_upvr
    local TextButton_upvr = Instance.new("TextButton")
    TextButton_upvr.Name = "Cancel"
    TextButton_upvr.BackgroundColor3 = Color3.fromRGB(68, 194, 93)
    TextButton_upvr.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
    TextButton_upvr.Position = UDim2.new(0.5, 5, 1.03636, 5)
    TextButton_upvr.Size = UDim2.new(0.5, -15, 0, 40)
    TextButton_upvr.Text = "Cancel"
    TextButton_upvr.TextColor3 = Color3.fromRGB(20, 59, 26)
    TextButton_upvr.TextSize = 28
    TextButton_upvr.ZIndex = 6
    local UICorner_3 = Instance.new("UICorner")
    UICorner_3.Name = "UICorner"
    UICorner_3.CornerRadius = UDim.new(1, 0)
    UICorner_3.Parent = TextButton_upvr
    local UIStroke_3 = Instance.new("UIStroke")
    UIStroke_3.Name = "UIStroke"
    UIStroke_3.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    UIStroke_3.Color = Color3.fromRGB(57, 163, 76)
    UIStroke_3.StrokeSizingMode = Enum.StrokeSizingMode.ScaledSize
    UIStroke_3.Thickness = 0.08
    UIStroke_3.Parent = TextButton_upvr
    TextButton_upvr.Parent = Frame_upvr
    local TextButton_upvr_2 = Instance.new("TextButton")
    TextButton_upvr_2.Name = "BuyCash2"
    TextButton_upvr_2.AnchorPoint = Vector2.new(0, 0.5)
    TextButton_upvr_2.BackgroundColor3 = Color3.fromRGB(74, 211, 99)
    TextButton_upvr_2.Position = UDim2.fromScale(0.89, -0.203)
    TextButton_upvr_2.RichText = true
    TextButton_upvr_2.Size = UDim2.fromScale(0.108, 0.259481)
    TextButton_upvr_2.Text = '+'
    TextButton_upvr_2.TextScaled = true
    local UICorner_4 = Instance.new("UICorner")
    UICorner_4.Name = "UICorner"
    UICorner_4.CornerRadius = UDim.new(1, 0)
    UICorner_4.Parent = TextButton_upvr_2
    local UIStroke = Instance.new("UIStroke")
    UIStroke.Name = "UIStroke"
    UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    UIStroke.BorderStrokePosition = Enum.BorderStrokePosition.Center
    UIStroke.Color = Color3.fromRGB(57, 163, 76)
    UIStroke.StrokeSizingMode = Enum.StrokeSizingMode.ScaledSize
    UIStroke.Thickness = 0.05
    UIStroke.ZIndex = 0
    UIStroke.Parent = TextButton_upvr_2
    local UIAspectRatioConstraint = Instance.new("UIAspectRatioConstraint")
    UIAspectRatioConstraint.Name = "UIAspectRatioConstraint"
    UIAspectRatioConstraint.DominantAxis = Enum.DominantAxis.Height
    UIAspectRatioConstraint.Parent = TextButton_upvr_2
    TextButton_upvr_2.Parent = Frame_upvr
    local TextButton_upvr_3 = Instance.new("TextButton")
    TextButton_upvr_3.Name = "Rent"
    TextButton_upvr_3.BackgroundColor3 = Color3.fromRGB(68, 194, 93)
    TextButton_upvr_3.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
    TextButton_upvr_3.Position = UDim2.new(0.02, 5, 1.52727, 5)
    TextButton_upvr_3.Size = UDim2.new(0.98, -15, -0.145455, 40)
    TextButton_upvr_3.Text = "Rent for 24 hours for ???"
    TextButton_upvr_3.TextColor3 = Color3.fromRGB(20, 59, 26)
    TextButton_upvr_3.TextScaled = true
    TextButton_upvr_3.ZIndex = 6
    local UICorner = Instance.new("UICorner")
    UICorner.Name = "UICorner"
    UICorner.CornerRadius = UDim.new(1, 0)
    UICorner.Parent = TextButton_upvr_3
    local UIStroke_5 = Instance.new("UIStroke")
    UIStroke_5.Name = "UIStroke"
    UIStroke_5.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    UIStroke_5.Color = Color3.fromRGB(57, 163, 76)
    UIStroke_5.StrokeSizingMode = Enum.StrokeSizingMode.ScaledSize
    UIStroke_5.Thickness = 0.08
    UIStroke_5.Parent = TextButton_upvr_3
    local UIPadding = Instance.new("UIPadding")
    UIPadding.Name = "UIPadding"
    UIPadding.PaddingLeft = UDim.new(0, 8)
    UIPadding.PaddingRight = UDim.new(0, 8)
    UIPadding.Parent = TextButton_upvr_3
    TextButton_upvr_3.Parent = Frame_upvr
    local any_new_result1_upvr_2 = Signal_upvr.new()
    local any_new_result1_upvr = Maid_upvr.new()
    local var34_upvw = 0
    local function _(arg1, arg2) -- Line 212, Named "bindButtonTo"
        any_new_result1_upvr:GiveTask(arg1.MouseButton1Click:Connect(function() -- Line 213
            any_new_result1_upvr_2:Fire(arg2)
        end))
    end
    task.spawn(function() -- Line 218
        if not Settings_upvr.FetchedMarketplace then
            Settings_upvr.OnProductsFetched:Wait()
        end
        TextButton_upvr_3.Text = "Rent for 24 hours for "..utf8.char(57346)..Settings_upvr.getFirstProductByType("Rent").Robux
    end)
    return {
        Frame = Frame_upvr;
        BuyButton = TextButton_upvr_4;
        onAction = any_new_result1_upvr_2;
        setEnabled = function(arg1) -- Line 230, Named "setEnabled"
            Frame_upvr.Visible = arg1
            any_new_result1_upvr:DoCleaning()
            if arg1 then
                local var39_upvr = "Cash"
                any_new_result1_upvr:GiveTask(ImageButton_upvr.MouseButton1Click:Connect(function() -- Line 213
                    any_new_result1_upvr_2:Fire(var39_upvr)
                end))
                var39_upvr = "Cash"
                any_new_result1_upvr:GiveTask(TextButton_upvr_2.MouseButton1Click:Connect(function() -- Line 213
                    any_new_result1_upvr_2:Fire(var39_upvr)
                end))
                var39_upvr = "Buy"
                any_new_result1_upvr:GiveTask(TextButton_upvr_4.MouseButton1Click:Connect(function() -- Line 213
                    any_new_result1_upvr_2:Fire(var39_upvr)
                end))
                var39_upvr = "Cancel"
                any_new_result1_upvr:GiveTask(TextButton_upvr.MouseButton1Click:Connect(function() -- Line 213
                    any_new_result1_upvr_2:Fire(var39_upvr)
                end))
                var39_upvr = "Rent"
                any_new_result1_upvr:GiveTask(TextButton_upvr_3.MouseButton1Click:Connect(function() -- Line 213
                    any_new_result1_upvr_2:Fire(var39_upvr)
                end))
                task.spawn(Audio_upvr.ObjectLocal, Players_upvr.LocalPlayer, 131184732929614, {
                    Volume = 0.15;
                })
            end
        end;
        setCash = function(arg1) -- Line 242, Named "setCash"
            var34_upvw = arg1
            TextLabel_upvr.Text = Format_upvr.Currency(arg1)
        end;
        setVehicle = function(arg1, arg2, arg3) -- Line 246, Named "setVehicle"
            local var45 = arg1
            TextLabel_2_upvr.Text = "Buy %s for %s?":format(var45, Format_upvr.Currency(arg2))
            TextButton_upvr_3.Visible = arg3
            if arg2 <= var34_upvw then
                var45 = Color3.new(1, 1, 1)
            else
                var45 = Color3.new(1, 0.262745, 0.262745)
            end
            TextLabel_upvr.TextColor3 = var45
        end;
    }
end