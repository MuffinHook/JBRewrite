-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMXBmFzc2VydAZzY3JpcHQORmluZEZpcnN0Q2hpbGQFcHJpbnQWTm8gY2F0ZWdvcnkgbW9kdWxlOiAlcwZmb3JtYXQFZXJyb3ISTm8gY2F0ZWdvcnkgbW9kdWxlB3JlcXVpcmURR2V0Q2F0ZWdvcnlCeU5hbWUNR2V0SXRlbUJ5TmFtZQhHZXRJdGVtcwVJdGVtcwROYW1lH05vIENhdGVnb3J5TmFtZS9JdGVtTmFtZTogJXMvJXMISXNTZXJ2ZXIEd2FybgVwYWlycxNHZXRNYXBGcm9tU2VsZWN0aW9uBGdhbWUKUnVuU2VydmljZQpHZXRTZXJ2aWNlC0dldENoaWxkcmVuAAQGAQIAAAoDAAEFAQMDAxMCJ7sBAANSAgAApAEBAAAAAECfAQIB+wIAAIcBAgArARwApAEDAAAAIEBSAwAAvAEBAwQAAACfAQMCKwEMAKQCBgAAAFBAbwMHAFIFAAC8AwONCAAAAJ8DAwCfAgABpAIKAAAAkEBvAwsAnwICAfsCAQCkAw0AAADAQFIEAQCfAwICagMCAPsCAACpAwEAagMCAPsCAQCHAQIAggECAA4DAQQAAABAAwIEAAAgQAMDAwQEAABQQAMFAwYDBwQAAJBAAwgDCQQAAMBAAAgKARgAAAAAAAEAAAEAAAAAAAEBAAAAAAAAAAEAAAACAAAAAAABAAACAAAJAAAAAAoCAgAABwAAAQMDNAJCuwEAA1IDAACkAgEAAAAAQJ8CAgG7AQEDUgMBAKQCAQAAAABAnwICAfsCAABSAwAAnwICAg4CIwCeAQIFAAAAAFIEAgBSBQAApAMBAAAAAECfAwMBTQMCoQIAAAAOAwUATQMCoQIAAABSBAEAnwMCAIIDAABNBALmAwAAAA4EBABNAwLmAwAAAJ8DAQJlAAIATQMCOAQAAABSBAMAxgUAAMYGAABkBAUATQkIugUAAACaCQIAAQAAAIIIAgBuBPr/AgAAAG8DBgBSBQAAUgYBALwDA40HAAAAnwMEAvsEAQC8BAQLCAAAAJ8EAgIOBAQApAQKAAAAkEBSBQMAnwQCAcYEAACCBAIACwMBBAAAAEADCwMMAw0DDgMPAwYDEAMRBAAAkEAAFQsBGAAAAAAAAQAAAAABAAADAQAAAAAAAAIAAAEAAAAAAgAAAAAAAAAAAQAAAAEAAAAB/gAHAAAAAAACAAAAAAEAAAACABYAAAAACgEBAAAAFLsBAANSAgAApAEBAAAAAECfAQIB/wEAAAAAAACkAgMAAAAgQFIDAACfAgIEFwIFAPsHAABSCAUAUgkGAJ8HAwJqBwEFbgL6/wIAAACCAQIABAMBBAAAAEADEgQAACBAADITARgAAAAAAAEAAQAAAAABAAAAAf4ABDMAAAAACgAAAQAAJ6MAAACkAAEAAAAAQG8CAgC8AAAWAwAAAJ8AAwL/AQAAAAAAAP8CAAAAAAAApAMFAAAAQEC8AwNoBgAAAJ8DAgRkAwQATQgHugcAAACpCQAAagkCCG4D+/8CAAAAwAMIABIAAgASAAEAwAQJABIAAwASAAAAwAUKABIABADiBg4AMAMGBgsAAAAwBAahDAAAADAFBm4NAAAAggYCAA8DFAQAAABAAxUDFgMCBAAAQEADFwMOBgAGAQYCAwoDCwMTBQMLDA0DAAECAQABGAAAAAAAAAABAAIAAQAAAAAAAQAAAP8AAwAADQAAHQAKAQABAAEAAAEAAAAAA5s378jTyfzEkb3xBOaNQ+3rL/i8qfOFyQ==

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:36:18
-- Luau version 6, Types version 3
-- Time taken: 0.003052 seconds

local tbl_upvr = {}
for _, v in script:GetChildren() do
    tbl_upvr[v.Name] = false
end
local module_2_upvr = {}
local function GetCategoryByName_upvr(arg1) -- Line 8, Named "GetCategoryByName"
    --[[ Upvalues[2]:
        [1]: tbl_upvr (readonly)
        [2]: module_2_upvr (readonly)
    ]]
    assert(arg1)
    if not tbl_upvr[arg1] then
        local SOME = script:FindFirstChild(arg1)
        if not SOME then
            print(string.format("No category module: %s", arg1))
            error("No category module")
        end
        module_2_upvr[arg1] = require(SOME)
        tbl_upvr[arg1] = true
    end
    return module_2_upvr[arg1]
end
local RunService_upvr = game:GetService("RunService")
local function GetItemByName_upvr(arg1, arg2) -- Line 21, Named "GetItemByName"
    --[[ Upvalues[2]:
        [1]: GetCategoryByName_upvr (readonly)
        [2]: RunService_upvr (readonly)
    ]]
    assert(arg1)
    assert(arg2)
    local GetCategoryByName_upvr_result1 = GetCategoryByName_upvr(arg1)
    local var17
    if GetCategoryByName_upvr_result1 then
        var17 = assert
        var17(GetCategoryByName_upvr_result1, arg1)
        var17 = GetCategoryByName_upvr_result1.GetItemByName
        if var17 then
            var17 = GetCategoryByName_upvr_result1.GetItemByName(arg2)
            return var17
        end
        if GetCategoryByName_upvr_result1.GetItems then
            var17 = GetCategoryByName_upvr_result1.GetItems()
        else
            var17 = GetCategoryByName_upvr_result1.Items
        end
        for _, v_2 in var17 do
            if v_2.Name == arg2 then
                return v_2
            end
        end
    end
    if RunService_upvr:IsServer() then
        warn(string.format("No CategoryName/ItemName: %s/%s", arg1, arg2))
    end
    return nil
end
return {
    GetCategoryByName = GetCategoryByName_upvr;
    GetItemByName = GetItemByName_upvr;
    GetMapFromSelection = function(arg1) -- Line 50, Named "GetMapFromSelection"
        --[[ Upvalues[1]:
            [1]: GetItemByName_upvr (readonly)
        ]]
        assert(arg1)
        local module = {}
        for i_3, v_3 in pairs(arg1) do
            module[i_3] = GetItemByName_upvr(i_3, v_3)
        end
        return module
    end;
}