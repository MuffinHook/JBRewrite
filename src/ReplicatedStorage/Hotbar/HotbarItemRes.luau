-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMiDWlzU21hbGxTY3JlZW4JQ29udGFpbmVyBVVEaW0yA25ldwRTaXplCVVJUGFkZGluZwRVRGltDVBhZGRpbmdCb3R0b20HaXNUb3VjaAp1cGRhdGVTaXplCUhvdGJhckd1aQZzY3JpcHQGUGFyZW50A1JlcwtMb2NhbFBsYXllcglQbGF5ZXJHdWkMRGlzcGxheU9yZGVyA2d1aQRJdGVtBUNsb25lB0Rlc3Ryb3kLcHJlc2V0RnJhbWUcZ2V0Vmlld3BvcnRTaXplQ2hhbmdlZFNpZ25hbAdDb25uZWN0BGluaXQEZ2FtZQdQbGF5ZXJzCkdldFNlcnZpY2URUmVwbGljYXRlZFN0b3JhZ2UHcmVxdWlyZQRFelVpBVV0aWxzA1N0ZApJbnB1dFV0aWxzAAMGAAMAAABP+wAAAE0AAHkAAAAAnwABAg4AFwD7AAEATQAAbwEAAACkAQQAAAwggG8CBQCMAwAAjAQBAIwFAACfAQUCMAEALwYAAAD7AAEATQAAYgcAAACkAQkAAAyAgG8CCgCMAwAAnwEDAjABAOwLAAAAggABAPsAAgBNAADVDAAAAJ8AAQIOABcA+wABAE0AAG8BAAAApAEEAAAMIIBvAgUAjAMAAIwEAQCMBQAAnwEFAjABAC8GAAAA+wABAE0AAGIHAAAApAEJAAAMgIBvAg0AjAMAAJ8BAwIwAQDsCwAAAIIAAQD7AAEATQAAbwEAAACkAQQAAAwggG8CDgCMAwAAjAQBAIwFAACfAQUCMAEALwYAAAD7AAEATQAAYgcAAACkAQkAAAyAgG8CDQCMAwAAnwEDAjABAOwLAAAAggABAA8DAQMCAwMDBAQADCCAAmZmZmZmZuY/AwUDBgMHBAAMgIACuB6F61G4rj8DCAMJAnsUrkfheoQ/ApqZmZmZmdk/ABEKARgAAAAAAAEAAAAAAAAAAAAAAAEAAAAAAAAAAAAAAQAAAAACAAAAAAAAAAAAAAABAAAAAAAAAAAAAAIAAAAAAAAAAAAAAAEAAAAAAAAAAAACEwAAAAAGAAQAAAA1pAECAAAAEEBNAQEkAwAAAE0BAU0EAAAATQAB+wAAAAD7AQAATQEBMQUAAABNAQGZBgAAADABACQDAAAAjAELADABAMsHAAAA+wEBADAAAX8IAAAATQIAbwoAAABNAQLKCQAAALwBAToLAAAAnwECAk0DAG8KAAAATQIDygkAAAC8AgJQDAAAAJ8CAgH7AgEAMAEC8Q0AAADZAgAAEgICABIAAAASAgMA+wMCAE0DA+sOAAAAnwMBAlIFAgC8AwPHDwAAAJ8DAwFSAwIAnwMBAYIAAQAQAwsDDAQAABBAAw0DDgMPAxADEQMSAxMDAgMUAxUDFgMXAxgBAAcZARgAAAAAAAAAAAEAAAAAAAABAAABAAACAAAAAAAAAQAAAAAAAAEAAAIAAAAOAAAAAAAAAAEAAQgAAAAABgAAAQIAJaMAAACkAAEAAAAAQG8CAgC8AAAWAwAAAJ8AAwKkAQEAAAAAQG8DBAC8AQEWAwAAAJ8BAwKkAgYAAABQQE0DAS0HAAAATQMDoQgAAACfAgICpAMGAAAAUEBNBAGhCQAAAE0EBOUKAAAAnwMCAv8EAwAAAAAAwAULABIAAAASAAQAEgACABIAAwAwBQQTDAAAAIIEAgANAxoEAAAAQAMbAxwDHQMeBAAAUEADHwMgAyEDIgYBAxkBAQEAARgAAAAAAAAAAQAAAAAAAQAAAAAAAAEAAAAAAAACAAEAAAAAAAAbAQAAAAACyiJ8Y9JSZN8i5m2RhrJ3ubo6axf45hZi

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:43:30
-- Luau version 6, Types version 3
-- Time taken: 0.001867 seconds

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local module_upvr = {}
local Players_upvr = game:GetService("Players")
local Utils_upvr = require(ReplicatedStorage.EzUi.Utils)
local InputUtils_upvr = require(ReplicatedStorage.Std.InputUtils)
function module_upvr.init() -- Line 7
    --[[ Upvalues[4]:
        [1]: Players_upvr (readonly)
        [2]: module_upvr (readonly)
        [3]: Utils_upvr (readonly)
        [4]: InputUtils_upvr (readonly)
    ]]
    local HotbarGui_upvr = script.Parent.Res.HotbarGui
    HotbarGui_upvr.Parent = Players_upvr.LocalPlayer.PlayerGui
    HotbarGui_upvr.DisplayOrder = 11
    module_upvr.gui = HotbarGui_upvr
    HotbarGui_upvr.Container.Item:Destroy()
    module_upvr.presetFrame = HotbarGui_upvr.Container.Item:Clone()
    local function updateSize() -- Line 17
        --[[ Upvalues[3]:
            [1]: Utils_upvr (copied, readonly)
            [2]: HotbarGui_upvr (readonly)
            [3]: InputUtils_upvr (copied, readonly)
        ]]
        if Utils_upvr.isSmallScreen() then
            HotbarGui_upvr.Container.Size = UDim2.new(0.7, 0, 1, 0)
            HotbarGui_upvr.UIPadding.PaddingBottom = UDim.new(0.06, 0)
        else
            if InputUtils_upvr.isTouch() then
                HotbarGui_upvr.Container.Size = UDim2.new(0.7, 0, 1, 0)
                HotbarGui_upvr.UIPadding.PaddingBottom = UDim.new(0.01, 0)
                return
            end
            HotbarGui_upvr.Container.Size = UDim2.new(0.4, 0, 1, 0)
            HotbarGui_upvr.UIPadding.PaddingBottom = UDim.new(0.01, 0)
        end
    end
    Utils_upvr.getViewportSizeChangedSignal():Connect(updateSize)
    updateSize()
end
return module_upvr