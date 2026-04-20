local ReplicatedStorage_upvr = game:GetService("ReplicatedStorage")
local module = {}
local waitForChild_upvr = require(ReplicatedStorage_upvr.Std.waitForChild)
local SafesConsts_upvr = require(ReplicatedStorage_upvr.Safes.SafesConsts)
local Audio_upvr = require(ReplicatedStorage_upvr.Std.Audio)
local Players_upvr = game:GetService("Players")
local store_upvr = require(ReplicatedStorage_upvr.App.store)
local CashBuyUI_upvr = require(ReplicatedStorage_upvr.Game.CashBuyUI)
function module.init(arg1) -- Line 11
    local em_upvr = arg1.em
    waitForChild_upvr(ReplicatedStorage_upvr, SafesConsts_upvr.FIREWORK_FX_REMOTE_NAME):andThen(function(arg1_2) -- Line 13
        arg1_2.OnClientEvent:Connect(function() -- Line 14
            em_upvr.at2y4lws(10)
        end)
    end)
    waitForChild_upvr(ReplicatedStorage_upvr, SafesConsts_upvr.SAFE_PURCHASE_REMOTE_NAME):andThen(function(arg1_3) -- Line 19
        arg1_3.OnClientEvent:Connect(function(arg1_4) -- Line 20
            if arg1_4 then
                Audio_upvr.ObjectLocal(Players_upvr.LocalPlayer, 4977134975, {
                    Volume = 0.3;
                })
            else
                store_upvr:dispatch({
                    type = "setSafesOpen";
                    value = false;
                })
                CashBuyUI_upvr.Open()
            end
        end)
    end)
    waitForChild_upvr(ReplicatedStorage_upvr, SafesConsts_upvr.UPDATE_SAFES_INVENTORY_REMOTE_NAME):andThen(function(arg1_5) -- Line 35
        arg1_5.OnClientEvent:Connect(function(arg1_6) -- Line 36
            local tbl = {
                type = "setSafesInventoryItems";
            }
            tbl.itemsOwned = arg1_6
            store_upvr:dispatch(tbl)
        end)
    end)
end
return module