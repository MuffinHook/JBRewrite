local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Roact_upvr = require(ReplicatedStorage.Roact)
local TradeReducerUtils_upvr = require(ReplicatedStorage.Trade.TradeReducerUtils)
return function(arg1) -- Line 6
    local any_extend_result1 = Roact_upvr.Component:extend("App")
    function any_extend_result1.init(arg1_2) -- Line 9
        arg1_2:setState({
            traderMeReady = false;
            traderThemReady = false;
            traderMeAccepted = false;
        })
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
            Make = "Sentinel";
        })}
        arg1_2.traderThemOfferItems = {TradeReducerUtils_upvr.buildItemProps({
            Id = "b1";
            ItemType = "Vehicle";
            Make = "Torpedo";
        })}
    end
    local TradeOffering_upvr = require(script.Parent.TradeOffering)
    function any_extend_result1.render(arg1_3) -- Line 41
        return Roact_upvr.createElement(TradeOffering_upvr, {
            size = UDim2.new(0.75, 0, 0.75, 0);
            traderMe = {
                userId = 2025110;
                displayName = "badcc";
                ready = arg1_3.state.traderMeReady;
                accepted = arg1_3.state.traderMeAccepted;
                offerItems = arg1_3.traderMeOfferItems;
            };
            traderThem = {
                userId = 2837719;
                displayName = "asimo3089";
                ready = arg1_3.state.traderThemReady;
                offerItems = arg1_3.traderThemOfferItems;
            };
            onClickReady = function() -- Line 57, Named "onClickReady"
                arg1_3:setState({
                    traderMeReady = true;
                })
                task.delay(0.2 + 0.5 * math.random(), function() -- Line 61
                    arg1_3:setState({
                        traderThemReady = true;
                    })
                end)
            end;
            onClickUnready = function() -- Line 67, Named "onClickUnready"
                arg1_3:setState({
                    traderMeReady = false;
                })
            end;
            onClickAccept = function() -- Line 72, Named "onClickAccept"
                arg1_3:setState({
                    traderMeAccepted = true;
                })
            end;
            onClickExit = function() -- Line 77, Named "onClickExit"
                arg1_3:setState({
                    traderMeAccepted = false;
                    traderMeReady = false;
                    traderThemReady = false;
                })
            end;
        })
    end
    function any_extend_result1.willUnmount(arg1_4) -- Line 86
    end
    local any_mount_result1_upvr = Roact_upvr.mount(Roact_upvr.createElement(any_extend_result1), arg1)
    return function() -- Line 89
        Roact_upvr.unmount(any_mount_result1_upvr)
    end
end