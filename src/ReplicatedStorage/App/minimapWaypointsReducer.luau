-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMXCHBvc2l0aW9uBHBhcnQYbWlzc2luZyBwb3NpdGlvbiBvciBwYXJ0BmFzc2VydAhwcmlvcml0eRBtaXNzaW5nIHByaW9yaXR5BG5hbWUMbWlzc2luZyBuYW1lBXRhYmxlBWNsb25lBnJlbW92ZQdtaW5EaXN0B21lc3NhZ2UGaW5zZXJ0C2FkZFdheXBvaW50FHJlbW92ZVdheXBvaW50QnlOYW1lFXJlbW92ZVdheXBvaW50Q3VycmVudARnYW1lEVJlcGxpY2F0ZWRTdG9yYWdlCkdldFNlcnZpY2UHcmVxdWlyZQVSb2R1eA1jcmVhdGVSZWR1Y2VyAAQKAgAAAAByqQMBAE0EAdsAAAAARwQHAAAAAIBNBAEkAQAAAEcEAgAAAACAqQMAAakDAQCBAQMEAgAAAG8EAgCkAgQAAAAwQJ8CAwFNBAHtBQAAAEcEAgAAAACAqQMAAakDAQCBAQMEBgAAAG8EBgCkAgQAAAAwQJ8CAwFNBAFaBwAAAEcEAgAAAACAqQMAAakDAQCBAQMECAAAAG8ECACkAgQAAAAwQJ8CAwGkAgsAACiQgFIDAACfAgICHAUCAIwDAQCMBP//qAMOAIcGAgVNBgZaBwAAAE0HAVoHAAAAmgYHAAcAAACkBg0AADCQgFIHAgBSCAUAnwYDAWUAAQCLA/L/xgAAABwEAgCVAwQOjAYBABwEAgCMBQEAqAQKAIcHAgZNBwftBQAAAE0IAe0FAAAAYAgDAAcAAABSAwYAZQABAIsE9v/iBxEATQgB2wAAAAAwCAfbAAAAAE0IASQBAAAAMAgHJAEAAABNCAHtBQAAADAIB+0FAAAATQgBWgcAAAAwCAdaBwAAAE0JAasPAAAAkAgJEjAIB6sPAAAATQgBmBAAAAAwCAeYEAAAADQ0AgUDBwAAUgUCAFIGAwCkBBQAAEyQgJ8EBAGCAgIAFQMBAwIDAwMEBAAAMEADBQMGAwcDCAMJAwoEACiQgAMLBAAwkIACAAAAAAAA8D8DDAMNBQYAAQUHDxACAAAAAAAASEADDgQATJCAAAcPARgAAAAAAAAAAAAAAAAAAAAAAAEAAAAAAAAAAAAAAAEAAAAAAAAAAAAAAAEAAAACAAAAAQAAAAAAAAEAAAAAAf0GAQABAAAAAQAAAAAAAAIB/AcBAAAAAQAAAAEAAAABAAAAAQAAAAABAAAAAAAAAPoAAAgIAAAAAAkCAAAAACNNBAFaAAAAAEcEAgAAAACAqQMAAakDAQCBAQMEAQAAAG8EAQCkAgMAAAAgQJ8CAwGkAgYAABRAgFIDAACfAgICHAUCAIwDAQCMBP//qAMOAIcGAgVNBgZaAAAAAE0HAVoAAAAAmgYHAAcAAACkBggAABxAgFIHAgBSCAUAnwYDAYICAgCLA/L/ggICAAkDBwMIAwQEAAAgQAMJAwoEABRAgAMLBAAcQIAAJhABGAAAAAAAAAAAAAAAAAEAAAABAAAAAQAAAAAAAAEAAAAAAf0GJwAAAAAFAQAAAAAOpAECAAAEAIBSAgAAnwECAhwCAQCMAwAAYAMGAAIAAACkAgQAAAwAgFIDAQAcBAEAnwIDAYIBAgAFAwkDCgQABACAAwsEAAwAgAAyEQEYAAAAAAEAAAABAAAAAAIzAAAAAAYAAAECAByjAAAApAABAAAAAEBvAgIAvAAAFgMAAACfAAMCpAEFAAAAQEBNAgCnBgAAAJ8BAgJNAgHWBwAAAP8DAAAAAAAA4gQLAMAFDAAwBQT2CAAAAMAFDQAwBQTACQAAAMAFDgAwBQQhCgAAAJ8CAwCCAgAADwMSBAAAAEADEwMUAxUEAABAQAMWAxcDDwMQAxEFAwgJCgYABgEGAgMAAQIBAAEYAAAAAAAAAAEAAAAABAAAAAABAAAfAAAMAADUAAEAAAAAA+FwY6u5O7Vsen9FXxNw2iyRaHTf07QJqg==

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:40:36
-- Luau version 6, Types version 3
-- Time taken: 0.002919 seconds

return require(game:GetService("ReplicatedStorage").Rodux).createReducer({}, {
    addWaypoint = function(arg1, arg2) -- Line 7, Named "addWaypoint"
        -- KONSTANTERROR: [0] 1. Error Block 39 start (CF ANALYSIS FAILED)
        local var2 = true
        if arg2.position == nil then
            if arg2.part == nil then
                var2 = false
            else
                var2 = true
            end
        end
        assert(var2, "missing position or part")
        if arg2.priority == nil then
            var2 = false
            -- KONSTANTWARNING: GOTO [23] #16
        end
        -- KONSTANTERROR: [0] 1. Error Block 39 end (CF ANALYSIS FAILED)
        -- KONSTANTERROR: [22] 15. Error Block 37 start (CF ANALYSIS FAILED)
        var2 = true
        assert(var2, "missing priority")
        if arg2.name == nil then
            var2 = false
        else
            var2 = true
        end
        assert(var2, "missing name")
        var2 = arg1
        var2 = 1
        -- KONSTANTERROR: [22] 15. Error Block 37 end (CF ANALYSIS FAILED)
    end;
    removeWaypointByName = function(arg1, arg2) -- Line 38, Named "removeWaypointByName"
        local var5
        if arg2.name == nil then
            var5 = false
        else
            var5 = true
        end
        assert(var5, "missing name")
        var5 = arg1
        local clone = table.clone(var5)
        var5 = 1
        for i = #clone, var5, -1 do
            if clone[i].name == arg2.name then
                table.remove(clone, i)
                return clone
            end
        end
        return clone
    end;
    removeWaypointCurrent = function(arg1) -- Line 50, Named "removeWaypointCurrent"
        local clone_2 = table.clone(arg1)
        if 0 < #clone_2 then
            table.remove(clone_2, #clone_2)
        end
        return clone_2
    end;
})