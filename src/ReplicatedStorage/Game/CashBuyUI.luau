local MarketplaceService_upvr = game:GetService("MarketplaceService")
local Players_upvr = game:GetService("Players")
local LocalPlayer_upvr = Players_upvr.LocalPlayer
local ReplicatedStorage_upvr = game:GetService("ReplicatedStorage")
local SubscriptionConsts_upvr = require(ReplicatedStorage_upvr.Gamepass.SubscriptionConsts)
local Format_upvr = require(ReplicatedStorage_upvr.Module.Format)
local Maid_upvr = require(ReplicatedStorage_upvr.Std.Maid)
local Settings_upvr = require(ReplicatedStorage_upvr.Resource.Settings)
local GamepassUtils_upvr = require(ReplicatedStorage_upvr.Gamepass.GamepassUtils)
local GamepassData_upvr = require(ReplicatedStorage_upvr.Gamepass.GamepassData)
local Audio_upvr = require(ReplicatedStorage_upvr.Std.Audio)
local var12_upvw
local var13_upvw
local Color3_fromRGB_result1_upvr = Color3.fromRGB(87, 87, 87)
local Color3_fromRGB_result1_upvr_2 = Color3.fromRGB(138, 138, 138)
local function _() -- Line 26, Named "PlayButtonClick"
    task.spawn(Audio_upvr.ObjectLocal, LocalPlayer_upvr.PlayerGui, 6105461542, {
        Volume = 0.15;
    })
end
local module_upvr = {
    IsOpen = nil;
    Loaded = false;
    OnLoaded = require(ReplicatedStorage_upvr.Std.Signal).new();
}
local var18_upvw
local Localization_upvr = require(ReplicatedStorage_upvr.Module.Localization)
function module_upvr.Init(arg1) -- Line 36
    var12_upvw = arg1.Event
    var13_upvw = arg1.em
    local CashGui_upvr = ReplicatedStorage_upvr.StarterGui:FindFirstChild("CashGui")
    CashGui_upvr.Parent = LocalPlayer_upvr.PlayerGui
    module_upvr.Gui = CashGui_upvr
    module_upvr.IsOpen = CashGui_upvr.Enabled
    CashGui_upvr.Container.Content.ContainerCash.ContainerDonate.Drop.TextLabel.Text = Localization_upvr:FormatByKey("Cash.DropCash")
    module_upvr.Maid = Maid_upvr.new()
    Settings_upvr.OnProductsFetched:Connect(function() -- Line 50
        module_upvr.UpdatePrices()
        module_upvr.Loaded = true
        module_upvr.OnLoaded:Fire()
    end)
    CashGui_upvr.Container.Close.MouseButton1Down:Connect(module_upvr.Close)
    CashGui_upvr.Container.Content.ContainerTop.ContainerLeft.Cash.MouseButton1Down:Connect(module_upvr.OpenTabCash)
    CashGui_upvr.Container.Content.ContainerTop.ContainerLeft.Passes.MouseButton1Down:Connect(module_upvr.OpenTabPasses)
    CashGui_upvr.Container.Content.ContainerTop.ContainerLeft.GiftPasses.MouseButton1Down:Connect(function() -- Line 60
        if not Settings_upvr.FetchedMarketplace then
        else
            if CashGui_upvr.Container.Content.ContainerGiftPasses.Visible then return end
            module_upvr.OpenTabGiftPasses()
        end
    end)
    module_upvr.SetupCashDrop()
    task.spawn(function() -- Line 73
        local pcall_result1, pcall_result2 = pcall(function() -- Line 74
            return MarketplaceService_upvr:GetSubscriptionProductInfoAsync(SubscriptionConsts_upvr.VIP.SUBSCRIPTION_ID)
        end)
        if pcall_result1 and pcall_result2 then
            var18_upvw = pcall_result2.PriceInRobux or 100
        end
    end)
end
function module_upvr.OpenTabCash() -- Line 83
    local Gui_7 = module_upvr.Gui
    Gui_7.Container.Content.ContainerCash.Visible = true
    Gui_7.Container.Content.ContainerPasses.Visible = false
    Gui_7.Container.Content.ContainerTop.ContainerRight.ContainerCash.Visible = true
    Gui_7.Container.Content.ContainerTop.ContainerLeft.Cash.BackgroundColor3 = Color3_fromRGB_result1_upvr_2
    Gui_7.Container.Content.ContainerTop.ContainerLeft.Passes.BackgroundColor3 = Color3_fromRGB_result1_upvr
    module_upvr.Maid.Gifting = nil
    task.spawn(Audio_upvr.ObjectLocal, LocalPlayer_upvr.PlayerGui, 6105461542, {
        Volume = 0.15;
    })
end
function module_upvr.OpenTabPasses() -- Line 94
    local Gui_6 = module_upvr.Gui
    Gui_6.Container.Content.ContainerCash.Visible = false
    Gui_6.Container.Content.ContainerPasses.Visible = true
    Gui_6.Container.Content.ContainerTop.ContainerRight.ContainerCash.Visible = false
    Gui_6.Container.Content.ContainerTop.ContainerLeft.Cash.BackgroundColor3 = Color3_fromRGB_result1_upvr
    Gui_6.Container.Content.ContainerTop.ContainerLeft.Passes.BackgroundColor3 = Color3_fromRGB_result1_upvr_2
    module_upvr.Maid.Gifting = nil
    task.spawn(Audio_upvr.ObjectLocal, LocalPlayer_upvr.PlayerGui, 6105461542, {
        Volume = 0.15;
    })
end
function module_upvr.OpenTabGiftPasses() -- Line 105
    local Gui_5 = module_upvr.Gui
    Gui_5.Container.Content.ContainerCash.Visible = false
    Gui_5.Container.Content.ContainerPasses.Visible = false
    Gui_5.Container.Content.ContainerTop.ContainerLeft.Cash.BackgroundColor3 = Color3_fromRGB_result1_upvr
    Gui_5.Container.Content.ContainerTop.ContainerLeft.Passes.BackgroundColor3 = Color3_fromRGB_result1_upvr
    task.spawn(Audio_upvr.ObjectLocal, LocalPlayer_upvr.PlayerGui, 6105461542, {
        Volume = 0.15;
    })
    module_upvr.SetupGiftingUI()
end
function module_upvr.SetCash(arg1) -- Line 114
    module_upvr.Gui.Container.Content.ContainerTop.ContainerRight.ContainerCash.TextLabel.Text = Format_upvr.Currency(arg1)
end
local UI_upvr = require(ReplicatedStorage_upvr.Module.UI)
local CollectionService_upvr = game:GetService("CollectionService")
function module_upvr.SetupCashDrop() -- Line 119
    function var13_upvw.h5alw1i3(arg1) -- Line 122
        local var39
        if arg1.NotEnoughMoney then
            var39 = "You don't have that much money."
        elseif arg1.InvalidWorld then
            var39 = "Cannot drop cash in current world."
        elseif arg1.TooLittleQuantity then
            var39 = ("Drop more than %s."):format(Format_upvr.Currency(arg1.TooLittleQuantity))
        elseif arg1.TooMuchQuantity then
            var39 = ("Drop less than %s."):format(Format_upvr.Currency(arg1.TooMuchQuantity))
        elseif arg1.Debounce then
            var39 = ("Wait %d seconds."):format(arg1.Debounce)
        elseif arg1.Daily then
            var39 = ("Can only donate %s per day."):format(Format_upvr.Currency(arg1.Quantity))
        elseif arg1.SmallVIP then
            var39 = "Donations disabled in small private servers."
        end
        if var39 then
            var13_upvw.ropj1fju({
                Title = "Donation";
                Text = var39;
            })
        end
    end
    local ContainerDonate = module_upvr.Gui.Container.Content.ContainerCash.ContainerDonate
    local Amount_upvr = ContainerDonate.ContainerAmount.Amount
    Amount_upvr:GetPropertyChangedSignal("Text"):Connect(function() -- Line 145
        Amount_upvr.Text = Amount_upvr.Text:gsub("[^%d]+", "")
    end)
    local function AddedFun() -- Line 150
        task.spawn(Audio_upvr.ObjectLocal, LocalPlayer_upvr.PlayerGui, 6105461542, {
            Volume = 0.15;
        })
        local tonumber_result1 = tonumber(Amount_upvr.Text)
        if not tonumber_result1 then
        else
            var12_upvw:FireServer('w'..("jonkomw"):sub(3, 3):reverse():reverse():reverse():reverse():reverse().."".."atlk3l", tonumber_result1)
        end
    end
    ContainerDonate.Drop.MouseButton1Down:connect(AddedFun)
    local CircleAction_upvr = UI_upvr.CircleAction
    local function Action_upvr(arg1, arg2) -- Line 161, Named "Action"
        if arg2 then
            var12_upvw:FireServer('g'..("h1xfm"):sub(2, 2):reverse().."".."zm6gm0", arg1.Part.Parent)
            return true
        end
    end
    function AddedFun(arg1) -- Line 168
        local tbl = {
            Part = arg1.PrimaryPart;
        }
        tbl.ValidRoot = arg1
        tbl.Name = ("Collect %s from %s"):format(Format_upvr.Currency(arg1:WaitForChild("Amount", 2).Value), arg1:WaitForChild("PlayerName", 2).Value)
        tbl.Timed = true
        tbl.Duration = 1
        tbl.Dist = 10
        tbl.Callback = Action_upvr
        CircleAction_upvr.Add(tbl, arg1)
    end
    local var48 = AddedFun
    for _, v in ipairs(CollectionService_upvr:GetTagged("CashDrop")) do
        var48(v)
    end
    CollectionService_upvr:GetInstanceAddedSignal("CashDrop"):Connect(var48)
    CollectionService_upvr:GetInstanceRemovedSignal("CashDrop"):Connect(function(arg1) -- Line 182, Named "RemovedFun"
        CircleAction_upvr.Remove(arg1)
    end)
end
local function _(arg1) -- Line 191, Named "TransformPassIntoOwned"
    arg1.Product.ContainerCost.Amount.Text = "OWNED"
    arg1.Product.ContainerImage.Thumbnail.ImageTransparency = 0.75
end
local function ClickVIPSubscription_upvr() -- Line 196, Named "ClickVIPSubscription"
    module_upvr.Maid.Subscription = nil
    local any_new_result1_upvr = Maid_upvr.new()
    module_upvr.Maid.Subscription = any_new_result1_upvr
    local Gui = module_upvr.Gui
    local VIPSubscription_upvr = Gui.VIPSubscription
    local Container_upvr = Gui.Container
    Container_upvr.Visible = false
    VIPSubscription_upvr.Visible = true
    any_new_result1_upvr:GiveTask(function() -- Line 207
        VIPSubscription_upvr.Visible = false
        Container_upvr.Visible = true
    end)
    local VIP_upvr = GamepassUtils_upvr.EnumGamepass.VIP
    local var59_upvw = false
    local var60_upvw = false
    any_new_result1_upvr:GiveTask(VIPSubscription_upvr.Close.MouseButton1Down:Connect(function() -- Line 219
        task.spawn(Audio_upvr.ObjectLocal, LocalPlayer_upvr.PlayerGui, 6105461542, {
            Volume = 0.15;
        })
        any_new_result1_upvr:DoCleaning()
    end))
    any_new_result1_upvr:GiveTask(VIPSubscription_upvr.Container.Gamepass.MouseButton1Down:Connect(function() -- Line 224
        if var59_upvw then
        else
            task.spawn(Audio_upvr.ObjectLocal, LocalPlayer_upvr.PlayerGui, 6105461542, {
                Volume = 0.15;
            })
            GamepassUtils_upvr.PromptGamepass(VIP_upvr)
        end
    end))
    any_new_result1_upvr:GiveTask(VIPSubscription_upvr.Container.Subscription.MouseButton1Down:Connect(function() -- Line 232
        if var59_upvw or var60_upvw then
        else
            task.spawn(Audio_upvr.ObjectLocal, LocalPlayer_upvr.PlayerGui, 6105461542, {
                Volume = 0.15;
            })
            MarketplaceService_upvr:PromptSubscriptionPurchase(LocalPlayer_upvr, SubscriptionConsts_upvr.VIP.SUBSCRIPTION_ID)
        end
    end))
    local any_GetGamepassFromEnum_result1_upvr = GamepassUtils_upvr.GetGamepassFromEnum(VIP_upvr)
    local function updateOwned() -- Line 241
        var59_upvw = LocalPlayer_upvr:GetAttribute(SubscriptionConsts_upvr.VIP.LIFETIME_ATTR_NAME)
        local SUBSCRIPTION_ATTR_NAME = SubscriptionConsts_upvr.VIP.SUBSCRIPTION_ATTR_NAME
        var60_upvw = LocalPlayer_upvr:GetAttribute(SUBSCRIPTION_ATTR_NAME)
        if var18_upvw then
            SUBSCRIPTION_ATTR_NAME = Format_upvr
            SUBSCRIPTION_ATTR_NAME = SUBSCRIPTION_ATTR_NAME.Comma(var18_upvw)
        else
            SUBSCRIPTION_ATTR_NAME = "N/A"
        end
        local var69 = utf8.char(57346)..Format_upvr.Comma(any_GetGamepassFromEnum_result1_upvr.PriceInRobux)
        if var59_upvw then
            VIPSubscription_upvr.Container.Gamepass.Text = "OWNED"
            VIPSubscription_upvr.Container.Gamepass.AutoButtonColor = false
            VIPSubscription_upvr.Container.Subscription.Text = "N/A"
            VIPSubscription_upvr.Container.Subscription.AutoButtonColor = false
        else
            if var60_upvw then
                VIPSubscription_upvr.Container.Gamepass.Text = var69
                VIPSubscription_upvr.Container.Gamepass.AutoButtonColor = true
                VIPSubscription_upvr.Container.Subscription.Text = "ACTIVE"
                VIPSubscription_upvr.Container.Subscription.AutoButtonColor = false
                return
            end
            VIPSubscription_upvr.Container.Gamepass.Text = var69
            VIPSubscription_upvr.Container.Gamepass.AutoButtonColor = true
            VIPSubscription_upvr.Container.Subscription.Text = utf8.char(57346)..SUBSCRIPTION_ATTR_NAME
            VIPSubscription_upvr.Container.Subscription.AutoButtonColor = true
        end
    end
    updateOwned()
    any_new_result1_upvr:GiveTask(LocalPlayer_upvr:GetAttributeChangedSignal(SubscriptionConsts_upvr.VIP.SUBSCRIPTION_ATTR_NAME):Connect(updateOwned))
    any_new_result1_upvr:GiveTask(LocalPlayer_upvr:GetAttributeChangedSignal(SubscriptionConsts_upvr.VIP.LIFETIME_ATTR_NAME):Connect(updateOwned))
end
local GamepassSystem_upvr = require(ReplicatedStorage_upvr.Gamepass.GamepassSystem)
function module_upvr.UpdatePrices() -- Line 272
    -- Decomp Logic Error: Konstant variable analysis failed; temporary assignments in this block were preserved for review.
    local Gui_4 = module_upvr.Gui
    local tbl_3 = {}
    local _
    for i_2, v_2 in ipairs(Settings_upvr.DevProduct) do
        if v_2.Type == "Cash" then
            tbl_3[v_2.Index] = v_2
        end
    end
    for i_3 = 1, 5 do
        i_2 = tbl_3[i_3]
        if i_2 == nil then
            i_2 = error
            v_2 = ("Missing product frame: %d"):format(i_3)
            i_2(v_2)
        end
    end
    for i_4 = 1, 5 do
        local SOME = Gui_4.Container.Content.ContainerCash.ContainerProducts:FindFirstChild(("ContainerProduct%d"):format(i_4))
        local var172_upvr = tbl_3[i_4]
        SOME.Product.ContainerAmount.Amount.Text = Format_upvr.Currency(var172_upvr.Cash)
        SOME.Product.ContainerCost.Amount.Text = utf8.char(57346)..Format_upvr.Comma(var172_upvr.Robux)
        if var172_upvr.ImageId then
            SOME.Product.ContainerCash.Cash.Image = ("rbxassetid://%d"):format(var172_upvr.ImageId)
        end
        -- Decomp Logic Error: Konstant reused an expression here; surrounding logic was preserved for review.
        module_upvr.Maid[("ContainerProduct%d"):format(i_4)] = SOME.Product.MouseButton1Down:Connect(function() -- Line 299
            task.spawn(Audio_upvr.ObjectLocal, LocalPlayer_upvr.PlayerGui, 6105461542, {
                Volume = 0.15;
            })
            MarketplaceService_upvr:PromptProductPurchase(LocalPlayer_upvr, var172_upvr.Id)
        end)
    end
    local ContainerProducts = Gui_4.Container.Content.ContainerPasses.ContainerProducts
    for _, v_3 in ipairs(ContainerProducts:GetChildren()) do
        if v_3:IsA("Frame") and v_3.Name ~= "ContainerPreset" then
            v_3:Destroy()
        end
    end
    local ContainerPreset = ContainerProducts.ContainerPreset
    for i_6, v_4_upvr in ipairs(GamepassData_upvr) do
        if v_4_upvr.PriceInRobux then
            local HideFromUI_upvr = v_4_upvr.HideFromUI
            if not HideFromUI_upvr then
                if v_4_upvr.Title ~= "VIP" then
                    HideFromUI_upvr = false
                else
                    HideFromUI_upvr = true
                end
                local formatted = ("ContainerProduct%d_%s"):format(i_6, v_4_upvr.Title)
                local clone_upvr_3 = ContainerPreset:Clone()
                if HideFromUI_upvr then
                else
                end
                clone_upvr_3.LayoutOrder = i_6
                clone_upvr_3.Name = formatted
                if not v_4_upvr.DisplayName then
                end
                clone_upvr_3.Product.ContainerTitle.Title.Text = v_4_upvr.Title
                GamepassSystem_upvr.promiseImageId(v_4_upvr.PassId):andThen(function(arg1) -- Line 321
                    clone_upvr_3.Product.ContainerImage.Thumbnail.Image = ("rbxassetid://%d"):format(arg1)
                end)
                if HideFromUI_upvr then
                else
                end
                clone_upvr_3.Product.ContainerCost.Amount.Text = utf8.char(57346)..Format_upvr.Comma(v_4_upvr.PriceInRobux)
                if HideFromUI_upvr then
                    local UIScale = Instance.new("UIScale")
                    UIScale.Scale = 1.1
                    UIScale.Parent = clone_upvr_3
                    clone_upvr_3.Product.ContainerImage.ImageTransparency = 1
                    clone_upvr_3.Product.ContainerCost.ImageColor3 = Color3.fromRGB(255, 255, 255)
                    local ImageLabel_2 = Instance.new("ImageLabel")
                    ImageLabel_2.BackgroundTransparency = 1
                    ImageLabel_2.Image = "rbxassetid://10046133665"
                    ImageLabel_2.ImageColor3 = Color3.fromRGB(255, 206, 29)
                    ImageLabel_2.AnchorPoint = Vector2.new(0.5, 0.5)
                    ImageLabel_2.Size = UDim2.fromScale(1.3, 1.3)
                    ImageLabel_2.Position = UDim2.fromScale(0.5, 0.5)
                    ImageLabel_2.ZIndex = 0
                    Instance.new("UIAspectRatioConstraint").Parent = ImageLabel_2
                    ImageLabel_2.Parent = clone_upvr_3
                end
                clone_upvr_3.Visible = true
                clone_upvr_3.Parent = ContainerPreset.Parent
                module_upvr.Maid[formatted] = clone_upvr_3.Product.MouseButton1Down:Connect(function() -- Line 350
                    if clone_upvr_3.Product.ContainerCost.Amount.Text == "OWNED" then
                    else
                        task.spawn(Audio_upvr.ObjectLocal, LocalPlayer_upvr.PlayerGui, 6105461542, {
                            Volume = 0.15;
                        })
                        if HideFromUI_upvr then
                            ClickVIPSubscription_upvr()
                            return
                        end
                        GamepassUtils_upvr.PromptPurchase(v_4_upvr)
                    end
                end)
                if not HideFromUI_upvr and GamepassSystem_upvr.DoesPlayerOwn(GamepassUtils_upvr.EnumGamepass[v_4_upvr.Title]) then
                    clone_upvr_3.Product.ContainerCost.Amount.Text = "OWNED"
                    clone_upvr_3.Product.ContainerImage.Thumbnail.ImageTransparency = 0.75
                end
                if not HideFromUI_upvr then
                    -- Decomp Logic Error: Konstant reused an expression here; surrounding logic was preserved for review.
                    module_upvr.Maid[formatted.."Owned"] = GamepassSystem_upvr.GetGamepassOwnedSignal(GamepassUtils_upvr.EnumGamepass[v_4_upvr.Title]):Connect(function() -- Line 367
                        local var192 = clone_upvr_3
                        var192.Product.ContainerCost.Amount.Text = "OWNED"
                        var192.Product.ContainerImage.Thumbnail.ImageTransparency = 0.75
                    end)
                end
                if v_4_upvr.Title == "DuffelBag" then
                    if LocalPlayer_upvr:GetAttribute("EffectivelyDuffelBag") then
                        clone_upvr_3.Product.ContainerCost.Amount.Text = "OWNED"
                        clone_upvr_3.Product.ContainerImage.Thumbnail.ImageTransparency = 0.75
                    else
                        LocalPlayer_upvr:GetAttributeChangedSignal("EffectivelyDuffelBag"):Connect(function(...) -- Line 375
                            if LocalPlayer_upvr:GetAttribute("EffectivelyDuffelBag") then
                                local var194 = clone_upvr_3
                                var194.Product.ContainerCost.Amount.Text = "OWNED"
                                var194.Product.ContainerImage.Thumbnail.ImageTransparency = 0.75
                            end
                        end)
                    end
                end
            end
        end
    end
    ContainerProducts.UIGridLayout.CellSize = UDim2.new(1 / (0 + 1) - 0.0001, 0, 1, 0)
end
local GetGiftProductInfoFromGamepass_upvr = GamepassUtils_upvr.GetGiftProductInfoFromGamepass
function module_upvr.SetupGiftingUI() -- Line 389
    module_upvr.Maid.Gifting = nil
    module_upvr.Maid.Gifting = Maid_upvr.new()
    local Gui_2_upvr = module_upvr.Gui
    local ContainerGiftPasses_upvr = Gui_2_upvr.Container.Content.ContainerGiftPasses
    local GiftContainer_upvr = ContainerGiftPasses_upvr.GiftContainer
    ContainerGiftPasses_upvr.Visible = true
    local function _() -- Line 399, Named "clearInputs"
        GiftContainer_upvr.ContainerIcon.Icon.Image = ""
        GiftContainer_upvr.ContainerPlayerName.Text = ""
    end
    Gui_2_upvr.Container.Content.ContainerTop.ContainerLeft.GiftPasses.BackgroundColor3 = Color3.fromRGB(242, 187, 56)
    module_upvr.Maid.Gifting:GiveTask(function() -- Line 406
        ContainerGiftPasses_upvr.Visible = false
        GiftContainer_upvr.Visible = false
        Gui_2_upvr.Container.Content.ContainerTop.ContainerLeft.GiftPasses.BackgroundColor3 = Color3.fromRGB(179, 138, 41)
        GiftContainer_upvr.ContainerIcon.Icon.Image = ""
        GiftContainer_upvr.ContainerPlayerName.Text = ""
    end)
    local var204_upvw
    local ContainerPreset_2 = ContainerGiftPasses_upvr.ContainerProducts.ContainerPreset
    for i_7, v_5_upvr in ipairs(GamepassData_upvr) do
        local GetGiftProductInfoFromGamepass_upvr_result1 = GetGiftProductInfoFromGamepass_upvr(v_5_upvr.Title)
        if v_5_upvr.PriceInRobux and not v_5_upvr.HideFromUI and GetGiftProductInfoFromGamepass_upvr_result1 and GetGiftProductInfoFromGamepass_upvr_result1.Robux then
            local formatted_2 = ("ContainerProduct%d_%s"):format(i_7, v_5_upvr.Title)
            local clone_upvr_2 = ContainerPreset_2:Clone()
            clone_upvr_2.LayoutOrder = i_7
            clone_upvr_2.Name = formatted_2
            local DisplayName = v_5_upvr.DisplayName
            if not DisplayName then
                DisplayName = v_5_upvr.Title
            end
            clone_upvr_2.Product.ContainerTitle.Title.Text = DisplayName
            clone_upvr_2.Product.ContainerImage.Thumbnail.Image = ("rbxassetid://%d"):format(GetGiftProductInfoFromGamepass_upvr_result1.ImageId or 0)
            clone_upvr_2.Product.ContainerCost.Amount.Text = utf8.char(57346)..Format_upvr.Comma(GetGiftProductInfoFromGamepass_upvr_result1.Robux)
            clone_upvr_2.Visible = true
            clone_upvr_2.Parent = ContainerPreset_2.Parent
            module_upvr.Maid.Gifting[formatted_2] = clone_upvr_2
            module_upvr.Maid.Gifting[formatted_2.."Button"] = clone_upvr_2.Product.MouseButton1Down:Connect(function() -- Line 433
                task.spawn(Audio_upvr.ObjectLocal, LocalPlayer_upvr.PlayerGui, 6105461542, {
                    Volume = 0.15;
                })
                module_upvr.Maid.Gifting.Unselect = nil
                if var204_upvw == v_5_upvr.Title then
                    var204_upvw = nil
                    GiftContainer_upvr.Visible = false
                else
                    var204_upvw = v_5_upvr.Title
                    clone_upvr_2.Product.ContainerImage.SelectedFrame.Visible = true
                    module_upvr.Maid.Gifting.Unselect = function() -- Line 444
                        if clone_upvr_2.Parent then
                            clone_upvr_2.Product.ContainerImage.SelectedFrame.Visible = false
                        end
                    end
                    GiftContainer_upvr.ContainerIcon.Icon.Image = ""
                    GiftContainer_upvr.ContainerPlayerName.Text = ""
                    GiftContainer_upvr.Visible = LocalPlayer_upvr:GetAttribute(GamepassUtils_upvr.PLAYER_ALLOWED_TO_ATTEMPT_GAME_PASS_GIFT_ATTR_NAME)
                end
            end)
        end
    end
    GiftContainer_upvr.ContainerIcon.Icon.Image = ""
    GiftContainer_upvr.ContainerPlayerName.Text = ""
    module_upvr.Maid.Gifting:GiveTask(LocalPlayer_upvr:GetAttributeChangedSignal(GamepassUtils_upvr.PLAYER_ALLOWED_TO_ATTEMPT_GAME_PASS_GIFT_ATTR_NAME):Connect(function() -- Line 460
        local attribute = LocalPlayer_upvr:GetAttribute(GamepassUtils_upvr.PLAYER_ALLOWED_TO_ATTEMPT_GAME_PASS_GIFT_ATTR_NAME)
        if attribute then
            if var204_upvw == nil then
                attribute = false
            else
                attribute = true
            end
        end
        GiftContainer_upvr.Visible = attribute
        return true
    end))
    module_upvr.Maid.Gifting:GiveTask(GiftContainer_upvr.PurchaseButton.MouseButton1Down:Connect(function() -- Line 467
        local ObjectLocal = Audio_upvr.ObjectLocal
        task.spawn(ObjectLocal, LocalPlayer_upvr.PlayerGui, 6105461542, {
            Volume = 0.15;
        })
        local var221
        if var221 == nil then
            ObjectLocal = false
        else
            ObjectLocal = true
        end
        assert(ObjectLocal)
        if GetGiftProductInfoFromGamepass_upvr(var204_upvw) == nil then
            var221 = false
        else
            var221 = true
        end
        assert(var221)
        var221 = GiftContainer_upvr
        var221 = var221.ContainerPlayerName
        var221 = var221.Text
        if #var221 == 0 then
        else
            ReplicatedStorage_upvr:FindFirstChild(GamepassUtils_upvr.GIFT_REMOTE_NAME):FireServer(Players_upvr:GetUserIdFromNameAsync(var221), GamepassUtils_upvr.EnumGamepass[var204_upvw])
            GiftContainer_upvr.ContainerIcon.Icon.Image = ""
            GiftContainer_upvr.ContainerPlayerName.Text = ""
        end
    end))
    local var223_upvw = 0
    module_upvr.Maid.Gifting:GiveTask(GiftContainer_upvr.ContainerPlayerName:GetPropertyChangedSignal("Text"):Connect(function() -- Line 484
        -- Decomp Logic Error: Konstant variable analysis failed; temporary assignments in this block were preserved for review.
        var223_upvw += 1
        local var224_upvw
        local Text_upvr = GiftContainer_upvr.ContainerPlayerName.Text
        local function var225() -- Line 489
            var224_upvw = Players_upvr:GetUserIdFromNameAsync(Text_upvr)
        end
        local pcall_result1_2 = pcall(var225)
        var225 = nil
        local var228 = var225
        if pcall_result1_2 then
            local any_GetUserThumbnailAsync_result1, any_GetUserThumbnailAsync_result2 = Players_upvr:GetUserThumbnailAsync(var224_upvw, Enum.ThumbnailType.AvatarBust, Enum.ThumbnailSize.Size180x180)
            var228 = any_GetUserThumbnailAsync_result1
            pcall_result1_2 = any_GetUserThumbnailAsync_result2
        end
        if var223_upvw ~= var223_upvw then
            return false
        end
        if not pcall_result1_2 or not var228 then
        end
        GiftContainer_upvr.ContainerIcon.Icon.Image = ""
    end))
end
function module_upvr.Open() -- Line 505
    local var231
    if module_upvr.IsOpen ~= false then
        var231 = false
    else
        var231 = true
    end
    assert(var231)
    var231 = true
    module_upvr.Gui.Enabled = var231
    var231 = module_upvr
    var231.IsOpen = true
    var231 = module_upvr
    var231 = var231.OpenTabCash
    var231()
end
function module_upvr.Close() -- Line 512
    local var232
    if module_upvr.IsOpen ~= true then
        var232 = false
    else
        var232 = true
    end
    assert(var232)
    var232 = false
    module_upvr.Gui.Enabled = var232
    var232 = module_upvr
    var232.IsOpen = false
    var232 = module_upvr
    var232 = var232.Maid
    var232.Gifting = nil
    var232 = module_upvr
    var232 = var232.Maid
    var232.Subscription = nil
    var232 = task.spawn
    var232(Audio_upvr.ObjectLocal, LocalPlayer_upvr.PlayerGui, 6105461542, {
        Volume = 0.15;
    })
end
return module_upvr
