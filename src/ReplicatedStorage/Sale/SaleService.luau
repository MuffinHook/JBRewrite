-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMWCGdldFN0YXRlBHR5cGUIcGFnZU5hbWUMY2F0ZWdvcnlOYW1lBnNvcnRJZAdzZXRQYWdlCmdhcmFnZVBhZ2UOZ2FyYWdlQ2F0ZWdvcnkKZ2FyYWdlU29ydAhkaXNwYXRjaA1vblNhbGVSZWZyZXNoB0Nvbm5lY3QEaW5pdARnYW1lEVJlcGxpY2F0ZWRTdG9yYWdlCkdldFNlcnZpY2UHcmVxdWlyZQNBcHAFc3RvcmUGc2NyaXB0BlBhcmVudApTYWxlU2hhcmVkAAMFAAEAAAAZ+wAAALwAABYAAAAAnwACAvsBAADiAwUAbwQGADAEA3EBAAAATQQA+gcAAAAwBAPpAgAAAE0EAF0IAAAAMAQDvgMAAABNBAAyCQAAADAEA6YEAAAAvAEBTAoAAACfAQMBggABAAsDAQMCAwMDBAMFBQQBAgMEAwYDBwMIAwkDCgAHAAEYAAAAAAEAAQAAAQAAAAEAAAABAAAA/AAABggAAAAAAwACAAAACfsAAABNAABAAAAAAMACAQASAgEAvAAAxwIAAACfAAMBggABAAMDCwYAAwwBAAYNARgAAAAAAAAAAAkHAAAAAAUAAAECAB+jAAAApAABAAAAAEBvAgIAvAAAFgMAAACfAAMCpAEFAAAAQEBNAgDBBgAAAE0CAn4HAAAAnwECAqQCBQAAAEBApAMJAAAAgEBNAwMkCgAAAE0DA+4LAAAAnwICAv8DAQAAAAAAwAQMABIAAgASAAEAMAQDEw0AAACCAwIADgMOBAAAAEADDwMQAxEEAABAQAMSAxMDFAQAAIBAAxUDFgYBAw0BAQEAARgAAAAAAAAAAQAAAAAAAAEAAAAAAAAAAAEAAgAAAAALAQAAAAAC6CQX+SAxFSgY/bHWgoYxS5g8AI3a4H34

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:45:50
-- Luau version 6, Types version 3
-- Time taken: 0.001012 seconds

local module = {}
local SaleShared_upvr = require(script.Parent.SaleShared)
local store_upvr = require(game:GetService("ReplicatedStorage").App.store)
function module.init() -- Line 6
    --[[ Upvalues[2]:
        [1]: SaleShared_upvr (readonly)
        [2]: store_upvr (readonly)
    ]]
    SaleShared_upvr.onSaleRefresh:Connect(function() -- Line 7
        --[[ Upvalues[1]:
            [1]: store_upvr (copied, readonly)
        ]]
        local any_getState_result1 = store_upvr:getState()
        store_upvr:dispatch({
            type = "setPage";
            pageName = any_getState_result1.garagePage;
            categoryName = any_getState_result1.garageCategory;
            sortId = any_getState_result1.garageSort;
        })
    end)
end
return module