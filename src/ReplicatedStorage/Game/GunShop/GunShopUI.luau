local LocalPlayer_upvr = game:GetService("Players").LocalPlayer
local ReplicatedStorage_upvr = game:GetService("ReplicatedStorage")
local EzUtils_upvr = require(ReplicatedStorage_upvr.EzUi.EzUtils)
local GunShopUtils_upvr = require(script.Parent.GunShopUtils)
local var5_upvw
local function _(arg1) -- Line 17, Named "SelectIfGamepad"
    EzUtils_upvr.selectIfGamepad(arg1)
end
local module_upvr = {
    maid = nil;
    currentSlider = nil;
}
local var7_upvw
function module_upvr.init(arg1) -- Line 24
    var5_upvw = arg1.Event
    var7_upvw = arg1.em
    local GunShopGui = ReplicatedStorage_upvr.StarterGui:FindFirstChild("GunShopGui")
    GunShopGui.Parent = LocalPlayer_upvr.PlayerGui
    module_upvr.gui = GunShopGui
end
function module_upvr.isOpen() -- Line 31
    local var9
    if module_upvr.maid == nil then
        var9 = false
    else
        var9 = true
    end
    return var9
end
local Maid_upvr = require(ReplicatedStorage_upvr.Std.Maid)
function module_upvr.open() -- Line 34
    -- Decomp Logic Error: Konstant variable analysis failed; temporary assignments in this block were preserved for review.
    assert(not module_upvr.isOpen())
    local any_new_result1 = Maid_upvr.new()
    module_upvr.maid = any_new_result1
    local gui_upvr = module_upvr.gui
    gui_upvr.Enabled = true
    any_new_result1:GiveTask(function() -- Line 40
        gui_upvr.Enabled = false
    end)
    local Sidebar = gui_upvr.Container.Container.Sidebar
    local tbl_upvr = {}
    for _, v in ipairs(Sidebar:GetChildren()) do
        if v:IsA("ImageButton") then
            table.insert(tbl_upvr, v)
        end
    end
    local function onButtonClick_upvr(arg1) -- Line 52, Named "onButtonClick"
        assert(arg1)
        for i_2, v_2 in ipairs(tbl_upvr) do
            v_2.Image = "rbxassetid://5834230837"
        end
        arg1.Image = "rbxassetid://5834230671"
        local Name = arg1.Name
        local any_getCategoryData_result1 = GunShopUtils_upvr.getCategoryData(Name)
        if not any_getCategoryData_result1 then
            i_2 = string.format("No data for gun shop category: %s", Name)
            error(i_2)
        end
        module_upvr.displayList(any_getCategoryData_result1)
    end
    for _, v_3_upvr in ipairs(tbl_upvr) do
        any_new_result1:GiveTask(v_3_upvr.MouseButton1Down:Connect(function() -- Line 66
            onButtonClick_upvr(v_3_upvr)
        end))
        local var46
    end
    var46(Sidebar.Held)
    EzUtils_upvr.selectIfGamepad(Sidebar.Held)
    any_new_result1:GiveTask(gui_upvr.Container.Close.MouseButton1Down:Connect(function() -- Line 74
        module_upvr.close()
    end))
end
local GunShopSlider_upvr = require(script.Parent.GunShopSlider)
local ItemSystem_upvr = require(ReplicatedStorage_upvr.Game.ItemSystem.ItemSystem)
local GunShopSystem_upvr = require(script.Parent.GunShopSystem)
local GunShopItem_upvr = require(script.Parent.GunShopItem)
local InventoryItemBinder_upvr = require(ReplicatedStorage_upvr.Inventory.InventoryItemBinder)
function module_upvr.displayList(arg1) -- Line 78
    -- Decomp Logic Error: Konstant variable analysis failed; temporary assignments in this block were preserved for review.
    local any_new_result1_upvr = GunShopSlider_upvr.new(arg1)
    module_upvr.maid.currentSlider = any_new_result1_upvr
    any_new_result1_upvr:SetParent(module_upvr.gui.Container.Container.Main.Container)
    for _, v_4 in ipairs(arg1) do
        local Name_upvr = v_4.Name
        local any_GetConfig_result1 = ItemSystem_upvr.GetConfig(Name_upvr)
        if not any_GetConfig_result1 then
            error(string.format("Missing item config for item: %s", Name_upvr))
        end
        if not any_GetConfig_result1.Price then
            error(string.format("Missing price data for item: %s", Name_upvr))
        end
        if not any_GetConfig_result1.ImageId then
            error(string.format("Missing image asset for item: %s", Name_upvr))
        end
        local var83
        if any_GetConfig_result1.ShopHidden and not GunShopSystem_upvr.doesPlayerOwn(Name_upvr) then
            var83 = false
        end
        if var83 then
            local any_new_result1_upvr_2 = GunShopItem_upvr.new()
            any_new_result1_upvr_2:SetName(Name_upvr, GunShopUtils_upvr.getTranslatedTitleFromName(Name_upvr))
            any_new_result1_upvr_2:SetPrice(any_GetConfig_result1.Price)
            if not any_GetConfig_result1.ImageId then
                error(string.format("Missing image asset for item: %s", Name_upvr))
            end
            any_new_result1_upvr_2:SetImageId(any_GetConfig_result1.ImageId)
            if any_GetConfig_result1.ImageColor then
                any_new_result1_upvr_2:SetImageColor(any_GetConfig_result1.ImageColor)
            end
            any_new_result1_upvr_2:SetLevel(any_GetConfig_result1.Level)
            any_new_result1_upvr_2._maid:GiveTask(any_new_result1_upvr_2.onMouseButton1Down:Connect(function() -- Line 123
                if any_new_result1_upvr_2:GetEquipped() then
                    var5_upvw:FireServer('m'.."oj6n2g":sub(2, 3):reverse():reverse():reverse().."".."uqvp9", Name_upvr)
                else
                    if GunShopSystem_upvr.doesPlayerOwn(Name_upvr) then
                        var5_upvw:FireServer('e'.."mpfi6uvcv4":sub(5, 6):reverse():reverse():reverse().."".."1j5p6", Name_upvr)
                        return
                    end
                    var5_upvw:FireServer('t'.."j46yx5qpun":sub(4, 6):reverse():reverse():reverse():reverse():reverse().."".."".."uoztt":sub(4, 4):reverse():reverse():reverse():reverse():reverse().."".."".."ky55p1k":sub(5, 6):reverse():reverse():reverse():reverse():reverse()..""..'k', Name_upvr)
                end
            end))
            if any_GetConfig_result1.RequireAnyGamepass then
                for _, v_5 in ipairs(any_GetConfig_result1.RequireAnyGamepass) do
                    any_new_result1_upvr_2:AddRequiredGamepass(v_5)
                    local var89
                end
            end
            -- Decomp Logic Error: Konstant reused an expression here; surrounding logic was preserved for review.
            if GunShopSystem_upvr.doesPlayerOwn(Name_upvr) then
                var89:SetOwned(true)
            end
            any_new_result1_upvr:AddItem(var89)
            var89:SetLayoutOrder((any_GetConfig_result1.SortOrderPage or 0) * 100000 + any_GetConfig_result1.Price * 10)
        end
    end
    any_new_result1_upvr._maid:GiveTask(GunShopSystem_upvr.onAnyOwned:Connect(function(arg1_2) -- Line 148
        for _, v_6 in ipairs(any_new_result1_upvr._listItem) do
            if v_6:GetName() == arg1_2 then
                v_6:SetOwned(true)
                return
            end
        end
    end))
    local function handleInventoryItemAdded(arg1_3) -- Line 158
        if arg1_3:GetOwner() == LocalPlayer_upvr then
            for _, v_7 in ipairs(any_new_result1_upvr._listItem) do
                if v_7:GetName() == arg1_3:GetName() then
                    v_7:SetEquipped(true)
                    return
                end
            end
        end
    end
    any_new_result1_upvr._maid:GiveTask(InventoryItemBinder_upvr:GetClassAddedSignal():Connect(handleInventoryItemAdded))
    for _, v_9 in ipairs(InventoryItemBinder_upvr:GetAll()) do
        handleInventoryItemAdded(v_9)
        local _
    end
    any_new_result1_upvr._maid:GiveTask(InventoryItemBinder_upvr:GetClassRemovingSignal():Connect(function(arg1_4) -- Line 168, Named "handleInventoryItemRemoved"
        if arg1_4:GetOwner() == LocalPlayer_upvr then
            for _, v_8 in ipairs(any_new_result1_upvr._listItem) do
                if v_8:GetName() == arg1_4:GetName() then
                    v_8:SetEquipped(false)
                    return
                end
            end
        end
    end))
end
function module_upvr.close() -- Line 195
    assert(module_upvr.isOpen())
    module_upvr.maid = nil
    module_upvr.maid:Destroy()
end
return module_upvr