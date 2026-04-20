local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Roact_upvr = require(ReplicatedStorage.Roact)
local createElement_upvr = Roact_upvr.createElement
local any_extend_result1_upvr = Roact_upvr.PureComponent:extend("SettingItem")
local function init(arg1) -- Line 30
    arg1:setState({
        value = arg1.props.defaultValue;
    })
end
any_extend_result1_upvr.init = init
local Checkbox_upvr = require(ReplicatedStorage.EzUi.Checkbox)
local function render(arg1) -- Line 35
    return createElement_upvr("Frame", {
        BackgroundTransparency = 1;
        Size = arg1.props.size;
        Position = arg1.props.position;
    }, {
        Value = createElement_upvr(Checkbox_upvr, {
            size = UDim2.new(1, 0, 1, 0);
            value = arg1.state.value;
            onChecked = function(arg1_2) -- Line 44, Named "onChecked"
                local tbl = {}
                tbl.value = arg1_2
                arg1:setState(tbl)
                if arg1.props.onChecked then
                    arg1.props.onChecked(arg1_2)
                end
            end;
            layoutOrder = 1;
            checkColor = arg1.props.color;
            cornerRadius = UDim.new(0, 4);
            disabled = arg1.props.disabled;
        });
        Title = createElement_upvr("TextLabel", {
            BackgroundTransparency = 1;
            Size = UDim2.fromScale((1) - (1 / arg1.props.aspectRatio + arg1.props.paddingRatio / arg1.props.aspectRatio), 0.8);
            AnchorPoint = Vector2.new(0, 0.5);
            Position = UDim2.fromScale(1 / arg1.props.aspectRatio + arg1.props.paddingRatio / arg1.props.aspectRatio, 0.5);
            Text = arg1.props.title;
            Font = Enum.Font.LuckiestGuy;
            LineHeight = 0.7;
            TextXAlignment = Enum.TextXAlignment.Left;
            TextScaled = true;
            TextColor3 = Color3.new(1, 1, 1);
            LayoutOrder = 2;
        });
    })
end
any_extend_result1_upvr.render = render
local any_extend_result1 = Roact_upvr.Component:extend("HomeApp")
function any_extend_result1.init(arg1) -- Line 80
    arg1.categories = {{
        name = "floorFurniture";
        title = "Floor Furniture";
        module = "HomeItem";
        upDot = 1;
        use = 1;
    }, {
        name = "wallFurniture";
        title = "Wall Furniture";
        module = "HomeItem";
        upDot = 0;
        use = 1;
    }, {
        name = "ceilingFurniture";
        title = "Ceiling Furniture";
        module = "HomeItem";
        upDot = -1;
        use = 1;
    }, {
        name = "defense";
        title = "Defense";
        module = "HomeItem";
        use = 2;
    }, {
        name = "wallColor";
        title = "Wall Color";
        module = "WallColor";
    }, {
        name = "secondWallColor";
        title = "Second Wall Color";
        module = "SecondWallColor";
    }, {
        name = "floorMaterial";
        title = "Floor Material";
        module = "FloorMaterial";
    }, {
        name = "floorColor";
        title = "Floor Color";
        module = "FloorColor";
    }, {
        name = "windowColor";
        title = "Window Color";
        module = "WindowColor";
    }, {
        name = "windowTint";
        title = "Window Tint";
        module = "WindowTint";
    }}
    function arg1.categoryOnClick(arg1_3) -- Line 142
        local var25 = arg1.categories[arg1_3]
        if var25.name == "floorFurniture" or var25.name == "wallFurniture" or var25.name == "ceilingFurniture" or var25.name == "defense" then
            arg1.props.setFurnitureCategory(var25)
        elseif var25.module then
            arg1.props.setCategory(var25)
        end
        arg1:setState({
            categoryName = var25.name;
            selectedName = Roact_upvr.None;
        })
        local any_getValue_result1_3 = arg1.searchRef:getValue()
        if any_getValue_result1_3 then
            any_getValue_result1_3.Text = ""
        end
    end
    arg1.pages = {{
        name = "inventory";
        title = "INVENTORY";
        bgColor = Color3.fromRGB(255, 202, 11);
    }, {
        name = "store";
        title = "STORE";
        bgColor = Color3.fromRGB(255, 155, 25);
    }, {
        name = "settings";
        title = "SETTINGS";
        bgColor = Color3.fromRGB(255, 112, 25);
    }, {
        name = "edit";
        title = "EDIT";
        bgColor = Color3.fromRGB(255, 151, 24);
    }}
    function arg1.pageOnClick(arg1_4) -- Line 186
        arg1:setState({
            pageName = arg1.pages[arg1_4].name;
            selectedName = Roact_upvr.None;
        })
        local any_getValue_result1 = arg1.searchRef:getValue()
        if any_getValue_result1 then
            any_getValue_result1.Text = ""
        end
    end
    local _1 = arg1.categories[1]
    arg1:setState({
        pageName = "inventory";
        categoryName = _1.name;
        selectedName = Roact_upvr.None;
    })
    arg1.props.setFurnitureCategory(_1)
    arg1.settingItems = {{
        name = "entryAllowFriends";
        title = "ENTRY: ALLOW FRIENDS";
    }, {
        name = "entryAllowTeam";
        title = "ENTRY: ALLOW TEAM";
    }, {
        name = "entryAllowEveryone";
        title = "ENTRY: ALLOW EVERYONE";
    }, {
        name = "editingAllowFriends";
        title = "EDITING: ALLOW FRIENDS";
        requires = "entryAllowFriends";
    }, {
        name = "editingAllowTeam";
        title = "EDITING: ALLOW TEAM";
        requires = "entryAllowTeam";
    }, {
        name = "editingAllowEveryone";
        title = "EDITING: ALLOW EVERYONE";
        requires = "entryAllowEveryone";
    }}
    arg1.searchRef = Roact_upvr.createRef()
    arg1:setState({
        search = "";
    })
end
local var46_upvw = false
local Players_upvr = game:GetService("Players")
local PaddedContainer_upvr = require(ReplicatedStorage.EzUi.PaddedContainer)
local PageButtonComponent_upvr = require(script.Parent.PageButtonComponent)
local ItemUtils_upvr = require(ReplicatedStorage.App.ItemUtils)
local CreatorValues_upvr = require(ReplicatedStorage.Trade.CreatorValues)
local paddedScrollingGrid_upvr = require(ReplicatedStorage.Safes.UI.paddedScrollingGrid)
local CustomizeItem_upvr = require(ReplicatedStorage.Garage.UI.CustomizeItem)
local ButtonComponent_upvr = require(script.Parent.ButtonComponent)
local CategoryButtonComponent_upvr = require(script.Parent.CategoryButtonComponent)
local CashBar_upvr = require(ReplicatedStorage.Garage.UI.CashBar)
local ColorUtils_upvr = require(ReplicatedStorage.Std.ColorUtils)
function any_extend_result1.render(arg1) -- Line 252
    -- Decomp Logic Error: Konstant variable analysis failed; temporary assignments in this block were preserved for review.
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    local var83
    if not arg1.props.visible then
        if typeof(var46_upvw) == "RBXScriptConnection" then
            var46_upvw:Disconnect()
        end
        var46_upvw = false
        return
    end
    if not var46_upvw then
        var46_upvw = true
        function var83() -- Line 263
            arg1:setState({
                search = "";
            })
            local any_getValue_result1_2_upvr = arg1.searchRef:getValue()
            if any_getValue_result1_2_upvr then
                var46_upvw = any_getValue_result1_2_upvr:GetPropertyChangedSignal("Text"):Connect(function() -- Line 269
                    task.delay(0.02, function() -- Line 270
                        arg1:setState({
                            search = any_getValue_result1_2_upvr.Text;
                        })
                    end)
                end)
            end
        end
        task.delay(0.05, var83)
    end
    if arg1.props.home ~= nil then
        var83 = Players_upvr
        var83 = var83.LocalPlayer
        var83 = var83.UserId
        if arg1.props.home:GetOwnerId() ~= var83 then
        else
        end
    end
    local tbl_3 = {}
    var83 = nil
    for i, v in arg1.pages do
        local tbl_5 = {}
        local var91
        if v.name ~= arg1.state.pageName then
            var91 = false
        else
            var91 = true
        end
        tbl_5.selected = var91
        tbl_3[i] = tbl_5
        if tbl_3[i].selected then
            var83 = v
        end
    end
    if var83 == nil then
    else
    end
    assert(true, "selectedPage must not be nil")
    for i_2_upvr, v_2 in arg1.pages do
        var91 = tbl_3[i_2_upvr]
        ;({})[v_2.name] = createElement_upvr(PaddedContainer_upvr, {
            size = UDim2.fromScale(1, 1 / #arg1.pages);
            position = UDim2.fromScale(0, (i_2_upvr - 1) / #arg1.pages);
            paddingTop = 0.5;
            paddingBottom = 0.5;
            paddingLeft = 0.5;
            paddingRight = 0.5;
            component = PageButtonComponent_upvr;
            props = {
                title = v_2.title;
                selected = var91.selected;
                backgroundColor = v_2.bgColor;
                onClick = function() -- Line 317, Named "onClick"
                    arg1.pageOnClick(i_2_upvr)
                end;
            };
        })
        local _
    end
    local tbl_4 = {}
    for i_3, v_3 in arg1.categories do
        local tbl_6 = {}
        local var97
        if v_3.name ~= arg1.state.categoryName then
            var97 = false
        else
            var97 = true
        end
        tbl_6.selected = var97
        tbl_4[i_3] = tbl_6
        if tbl_4[i_3].selected then
        end
    end
    if v_3 == nil then
    else
    end
    assert(true, "selectedCategory must not be nil")
    local _ = {
        selectedBgColor = var83.bgColor;
        onClick = arg1.categoryOnClick;
    }
    if 0 >= #arg1.state.search or "":lower():gsub(' ', "") then
    else
    end
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
end
return require(ReplicatedStorage.RoactRodux).connect(function(arg1, arg2) -- Line 844
    return {
        home = arg1.home;
        cash = arg1.cash;
        items = arg1.items;
        visible = arg1.visible;
        inventory = arg1.inventory;
        equipped = arg1.equipped;
        quantityPlaced = arg1.quantityPlaced;
        savedSettings = arg1.savedSettings;
    }
end, function(arg1) -- Line 855
    return {
        setFurnitureCategory = function(arg1_5) -- Line 857, Named "setFurnitureCategory"
            arg1({
                type = "setFurnitureCategory";
                upDot = arg1_5.upDot;
                use = arg1_5.use;
            })
        end;
        setCategory = function(arg1_6) -- Line 864, Named "setCategory"
            arg1({
                type = "setCategory";
                module = arg1_6.module;
            })
        end;
        setSavedSetting = function(arg1_7, arg2) -- Line 870, Named "setSavedSetting"
            local tbl_2 = {
                type = "setSavedSetting";
            }
            tbl_2.key = arg1_7
            tbl_2.value = arg2
            arg1(tbl_2)
        end;
    }
end)(any_extend_result1)