-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMVCEdldE93bmVyC0xvY2FsUGxheWVyB0dldE5hbWUDS2V5A25ldwRUZXh0QVRoaXMga2V5Y2FyZCBncmFudHMgeW91IGFjY2VzcyBpbnRvIFBvbGljZSBkb29ycyBhbmQgQmFuayB2YXVsdHMhCENyaW1lS2V5NlRoaXMgY3JpbWUgY2FyZCBncmFudHMgeW91IGFjY2VzcyBpbnRvIENyaW1pbmFsIEJhc2VzIQpEaXNjb25uZWN0BGdhbWUHUGxheWVycwpHZXRTZXJ2aWNlEVJlcGxpY2F0ZWRTdG9yYWdlB3JlcXVpcmUER2FtZQxOb3RpZmljYXRpb24JSW52ZW50b3J5E0ludmVudG9yeUl0ZW1CaW5kZXITR2V0Q2xhc3NBZGRlZFNpZ25hbAdDb25uZWN0AAIEAQUAAAA8+wEAACsBGAC8AQDDAAAAAJ8BAgL7AgEATQICMQEAAACaAREAAgAAALwBAFYCAAAAnwECAvABDAADAACA+wECAE0BAe8EAAAA4gIGAG8DBwAwAwL1BQAAAJ8BAgGpAQEA3gEAAGUAGQD7AQMAKwEXALwBAMMAAAAAnwECAvsCAQBNAgIxAQAAAJoBEAACAAAAvAEAVgIAAACfAQIC8AELAAgAAID7AQIATQEB7wQAAADiAgYAbwMJADADAvUFAAAAnwECAakBAQDeAQMA+wEAAA4BBgD7AQMADgEEAPsBBAC8AQEaCgAAAJ8BAgGCAAEACwMBAwIDAwMEAwUDBgUBBQMHAwgDCQMKAAkAARgAAAAAAAAAAAAAAAAAAAABAAAAAAAAAAEAAAEAAAAAAAAAAAAAAAAAAAEAAAAAAAAAAQACAAAAAQAAAAIKAAAAAAoAAAECAC2jAAAApAABAAAAAEBvAgIAvAAAFgMAAACfAAMCpAEBAAAAAEBvAwQAvAEBFgMAAACfAQMCpAIGAAAAUEBNAwG9BwAAAE0DA0kIAAAAnwICAqQDBgAAAFBATQQBYAkAAABNBASlCgAAAJ8DAgLGBAAAqQUAAKkGAAC8BwMHCwAAAJ8HAgLZCQAAEgEF/xIAAAASAAIAEgEG/xIBBP+8BwfHDAAAAJ8HAwJSBAcAwQQAAIIAAQANAwsEAAAAQAMMAw0DDgMPBAAAUEADEAMRAxIDEwMUAxUBAAEAARgAAAAAAAAAAQAAAAAAAQAAAAAAAAEAAAAAAAACAQEBAAAAAAAAAAAAAAAADAABAAAAAAGaiSIpNjfDMYasbkDTeKTX6pE1XahNSCg=

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:29:30
-- Luau version 6, Types version 3
-- Time taken: 0.001582 seconds

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local var3_upvw = false
local Players_upvr = game:GetService("Players")
local Notification_upvr = require(ReplicatedStorage.Game.Notification)
local var6_upvw = false
local var7_upvw
var7_upvw = require(ReplicatedStorage.Inventory.InventoryItemBinder):GetClassAddedSignal():Connect(function(arg1) -- Line 9
    --[[ Upvalues[5]:
        [1]: var3_upvw (read and write)
        [2]: Players_upvr (readonly)
        [3]: Notification_upvr (readonly)
        [4]: var6_upvw (read and write)
        [5]: var7_upvw (read and write)
    ]]
    if not var3_upvw and arg1:GetOwner() == Players_upvr.LocalPlayer and arg1:GetName() == "Key" then
        Notification_upvr.new({
            Text = "This keycard grants you access into Police doors and Bank vaults!";
        })
        var3_upvw = true
    elseif not var6_upvw and arg1:GetOwner() == Players_upvr.LocalPlayer and arg1:GetName() == "CrimeKey" then
        Notification_upvr.new({
            Text = "This crime card grants you access into Criminal Bases!";
        })
        var6_upvw = true
    end
    if var3_upvw and var6_upvw then
        var7_upvw:Disconnect()
    end
end)