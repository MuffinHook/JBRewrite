local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Roact_upvr = require(ReplicatedStorage.Roact)
local TradeReducerUtils_upvr = require(ReplicatedStorage.Trade.TradeReducerUtils)
local TradeUtils_upvr = require(ReplicatedStorage.Trade.TradeUtils)
local EnumSort_upvr = require(ReplicatedStorage.Garage.EnumSort)
return function(arg1) -- Line 9
    local any_extend_result1 = Roact_upvr.Component:extend("App")
    local function init(arg1_2) -- Line 12
        local any_buildItemProps_result1 = TradeReducerUtils_upvr.buildItemProps({
            Id = "a4";
            ItemType = "ItemSkin";
            SkinName = "WhiteMarble";
        })
        any_buildItemProps_result1.isOriginalOwner = true
        arg1_2.traderMeOfferItems = {TradeReducerUtils_upvr.buildItemProps({
            Id = "a1";
            ItemType = "VehicleCustomization";
            CategoryName = "Spoiler";
            ItemName = "Deathtrap";
        }), TradeReducerUtils_upvr.buildItemProps({
            Id = "a2";
            ItemType = "Vehicle";
            Make = "Chiron";
        }), TradeReducerUtils_upvr.buildItemProps({
            Id = "a3";
            ItemType = "Vehicle";
            Make = "Sloop";
        }), any_buildItemProps_result1}
        arg1_2.categories = TradeUtils_upvr.getCategories()
        arg1_2.category = arg1_2.categories[1]
        arg1_2:setState({
            sortId = EnumSort_upvr.Newest;
        })
    end
    any_extend_result1.init = init
    init = {}
    local var17_upvr = init
    for i = 1, 10 do
        table.insert(var17_upvr, {
            DisplayName = tostring(i);
        })
    end
    local TradeInventory_upvr = require(script.Parent.TradeInventory)
    function any_extend_result1.render(arg1_3) -- Line 51
        local module = {
            size = UDim2.new(0.75, 0, 0.75, 0);
            position = UDim2.new(0.1, 0, 0, 0);
            showChat = true;
            items = arg1_3.traderMeOfferItems;
            categories = arg1_3.categories;
            category = arg1_3.category;
            inventoryPlayers = {
                allPlayers = var17_upvr;
                selectedPlayer = {
                    DisplayName = "badcc";
                };
            };
        }
        function module.onCardFlipped() -- Line 65
            print("card flipped!")
        end
        module.sortId = arg1_3.state.sortId
        function module.onSelectSort(arg1_4) -- Line 69
            local var23
            if var23 == EnumSort_upvr.Newest then
                var23 = EnumSort_upvr.Alphabetical
            else
                var23 = EnumSort_upvr.Newest
            end
            arg1_3:setState({
                sortId = var23;
            })
        end
        return Roact_upvr.createElement(TradeInventory_upvr, module)
    end
    function any_extend_result1.willUnmount(arg1_5) -- Line 81
    end
    local any_mount_result1_upvr = Roact_upvr.mount(Roact_upvr.createElement(any_extend_result1), arg1)
    return function() -- Line 84
        Roact_upvr.unmount(any_mount_result1_upvr)
    end
end