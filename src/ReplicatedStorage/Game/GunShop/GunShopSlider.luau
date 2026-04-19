-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMjBVVEaW0yA25ldxNBYnNvbHV0ZUNvbnRlbnRTaXplAVgKQ2FudmFzU2l6ZQxzZXRtZXRhdGFibGUFX21haWQMUHJlc2V0U2xpZGVyBUNsb25lBlNsaWRlcgROYW1lDF9zbGlkZXJGcmFtZQhHaXZlVGFzawxVSUxpc3RMYXlvdXQYR2V0UHJvcGVydHlDaGFuZ2VkU2lnbmFsB0Nvbm5lY3QJX2xpc3RJdGVtDkdldExheW91dE9yZGVyDlNldExheW91dE9yZGVyCVNldFBhcmVudAV0YWJsZQZpbnNlcnQHQWRkSXRlbQZQYXJlbnQGaXBhaXJzB0Rlc3Ryb3kEZ2FtZRFSZXBsaWNhdGVkU3RvcmFnZQpHZXRTZXJ2aWNlB3JlcXVpcmUDU3RkBE1haWQIUmVzb3VyY2UHR3VuU2hvcAdfX2luZGV4AAYGAAIAAAAQ+wAAAKQBAgAABACAjAIAAPsEAQBNBATGBAAAAE0EBHkFAAAAlQMEA4wEAQCMBQAAnwEFAjABAM8GAAAAggABAAcDAQMCBAAEAIACAAAAAAAANEADAwMEAwUAFgABGAAAAAAAAAAAAAAAAAAAAAEYAAAAAAkAAwAAADb/AAMAAAAAAPsDAACePQAEAwAAAFICAACkAQEAAAAAQJ8BAwH7AQEATQEB7wIAAACfAQECMAEAwQMAAAD7AgIATQECowQAAAC8AgE6BQAAAJ8CAgJvAwYAMAMCugcAAAAwAgDZCAAAAE0DAMEDAAAAUgUCALwDA/0JAAAAnwMDAU0DAjQKAAAATQQAwQMAAABvCAsAvAYDlAwAAACfBgMC2QgAABIAAgASAAMAvAYGxw0AAACfBgMAvAQE/QkAAACfBAAB/wQAAAAAAAAwBAAaDgAAAIIAAgAPAwYEAAAAQAMCAwcDCAMJAwoDCwMMAw0DDgMDAw8DEAMRAQAIAgEYAAABAAAAAAAAAgAAAAAAAgAAAQAAAQAAAQACAAAAAAACAAEAAAAAAAAAAAAAAAAAAAUAAAACCQAAAAAHAgAAAAAjjAIAAE0EABoAAAAAHAMEAIwEAABgBAsAAwAAAE0EABoAAAAATQYAGgAAAAAcBQYAhwMEBbwDAyMBAAAAnwMCAlICAwCVBQICvAMBPwMAAACfAwMBTQUA2QQAAAC8AwEZBQAAAJ8DAwFNBAAaAAAAAJ40BAQBAAAAUgUBAKQDCAAAHGCAnwMDAYIAAQAJAxEDEgIAAAAAAADwPwMTAwwDFAMVAxYEABxggAAfFwEYAAEAAAAAAAEAAAAAAAAAAAACAAAAAQAAAAABAAAAAAAAAAEgAAAAAAMCAAAAAAVNAgDZAAAAADABAiQBAAAAggABAAIDDAMYACgUARgAAAAAASkAAAAACAEAAAAAFKQBAQAAAABATQIAGgIAAACfAQIEUQEDALwGBVADAAAAnwYCAW4B/P8CAACATQEAwQQAAAC8AQFQAwAAAJ8BAgHGAQAAMAEAwQQAAACCAAEABQMZBAAAAEADEQMaAwcAKxoBGAAAAAAAAAEAAP8AAwAAAAABAAABLAAAAAAFAAABAgAmowAAAKQAAQAAAABAbwICALwAABYDAAAAnwADAqQBBQAAAEBATQIAoQYAAABNAgJ2BwAAAJ8BAgJNAgBiCAAAAE0CAgYJAAAA/wMEAAAAAAAwAwNuCgAAAMAECwASAAMAEgABABIAAgAwBAPvDAAAAMAEDQAwBAN4DgAAAMAEDwAwBAMZEAAAAMAEEQAwBANQEgAAAIIDAgATAxsEAAAAQAMcAx0DHgQAAEBAAx8DIAMhAyIDIwYBAwIGAgMXBgMDFAYEAxoEAQIDBAEAARgAAAAAAAAAAQAAAAAAAAIAAAACAAEAAQAAAAAAFwAACQAAAwAABwEAAAAABQhpC75LqDapXTvFjqLv6qN4cRzKOq1hvw==

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:36:56
-- Luau version 6, Types version 3
-- Time taken: 0.002383 seconds

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local module_upvr = {}
module_upvr.__index = module_upvr
local Maid_upvr = require(ReplicatedStorage.Std.Maid)
local GunShop_upvr = ReplicatedStorage.Resource.GunShop
function module_upvr.new() -- Line 8
    --[[ Upvalues[3]:
        [1]: module_upvr (readonly)
        [2]: Maid_upvr (readonly)
        [3]: GunShop_upvr (readonly)
    ]]
    local module = {}
    setmetatable(module, module_upvr)
    module._maid = Maid_upvr.new()
    local clone_upvr = GunShop_upvr.PresetSlider:Clone()
    clone_upvr.Name = "Slider"
    module._sliderFrame = clone_upvr
    module._maid:GiveTask(clone_upvr)
    local UIListLayout_upvr = clone_upvr.UIListLayout
    module._maid:GiveTask(UIListLayout_upvr:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function() -- Line 22
        --[[ Upvalues[2]:
            [1]: clone_upvr (readonly)
            [2]: UIListLayout_upvr (readonly)
        ]]
        clone_upvr.CanvasSize = UDim2.new(0, UIListLayout_upvr.AbsoluteContentSize.X + 20, 1, 0)
    end))
    module._listItem = {}
    return module
end
function module_upvr.AddItem(arg1, arg2) -- Line 31
    local var9 = 0
    if 0 < #arg1._listItem then
        var9 = arg1._listItem[#arg1._listItem]:GetLayoutOrder()
    end
    arg2:SetLayoutOrder(var9 + 1)
    arg2:SetParent(arg1._sliderFrame)
    table.insert(arg1._listItem, arg2)
end
function module_upvr.SetParent(arg1, arg2) -- Line 40
    arg1._sliderFrame.Parent = arg2
end
function module_upvr.Destroy(arg1) -- Line 43
    for _, v in ipairs(arg1._listItem) do
        v:Destroy()
    end
    arg1._maid:Destroy()
    arg1._maid = nil
end
return module_upvr