-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMSFmNhbGN1bGF0ZU5ld1JhdGluZ0RhdGEEbWF0aANhYnMFcHJpbnQGZXhwZWN0AnRvBWVxdWFsAml0JnNpbmdsZSBiYXR0bGUgcmF0aW5nIHNob3VsZCBiZSBjb3JyZWN0CGRlc2NyaWJlEWNoZWNrU2luZ2xlQmF0dGxlFGNoZWNrTXVsdGlwbGVCYXR0bGVzBGdhbWURUmVwbGljYXRlZFN0b3JhZ2UKR2V0U2VydmljZQdyZXF1aXJlB0dsaWNrbzIMR2xpY2tvMlV0aWxzAAYIAAEAAABE+wAAAE0AAIEAAAAAjAHcBYwCXgFvAwEA/wQAAAEAAACMBdwFxQQFAgEAAAD/BQAAAQAAAIwGXgHFBQYCAQAAAP8GAAABAAAAjAcBAMUGBwIBAAAAnwAHBKkDAQB4BQACuwIFAqQEBQAAEDCAnwQCAm8FBgBgBQIABAAAAKkDAAB4BQEHuwIFAqQEBQAAEDCAnwQCAm8FBgBgBQIABAAAAKkDAAB4BQIIuwIFAqQEBQAAEDCAnwQCAm8FBgBgBQIABAAAAKkDAAArAwYApAQKAAAAkEBSBQAAUgYBAFIHAgCfBAQBpAQMAAAAsEBSBQMAnwQCAk0EBJINAAAATQQEew4AAACpBQEAnwQCAYIAAQAPAwECuB6F61G4rj8CCtejcD35mUADAgMDBAAQMIACexSuR+F6hD8CyXa+nxolckACoK29Lke4rj8DBAQAAJBAAwUEAACwQAMGAwcADAABGAAAAAEBAQEAAAAAAQAAAAABAAAAAPoIAQAAAAAAAAABAgAAAAAAAAABAgAAAAAAAAABAgEAAAAAAAIAAAAAAAAAAAABDQAAAAADAAEAAAAHpAABAAAAAEBvAQIAwAIDABICAACfAAMBggABAAQDCAQAAABAAwkGAAEACwABGAAAAAAAABgMAAAAAAoAAQAAAEr7AAAATQAAgQAAAACMAdwFjALIAG8DAQD/BAAAAwAAAIwFeAWMBg4GjAekBsUEBQQBAAAA/wUAAAMAAACMBh4AjAdkAIwILAHFBQYEAQAAAP8GAAADAAAAjAcBAIwIAACMCQAAxQYHBAEAAACfAAcEqQMBAHgFAAK7AgUCpAQFAAAQMICfBAICbwUGAGAFAgAEAAAAqQMAAHgFAQe7AgUCpAQFAAAQMICfBAICbwUGAGAFAgAEAAAAqQMAAHgFAgi7AgUCpAQFAAAQMICfBAICbwUGAGAFAgAEAAAAqQMAACsDBgCkBAoAAACQQFIFAABSBgEAUgcCAJ8EBAGkBAwAAACwQFIFAwCfBAICTQQEkg0AAABNBAR7DgAAAKkFAQCfBAIBggABAA8DAQK4HoXrUbiuPwIK16NwPeCWQAMCAwMEABAwgAJ7FK5H4XqEPwJxPQrXo/BiQAKCkCxgAreuPwMEBAAAkEADBQQAALBAAwYDBwAnAAEYAAAAAQEBAQAAAAAAAAEAAAAAAAABAAAAAAAA+ggBAAAAAAAAAAECAAAAAAAAAAECAAAAAAAAAAECAQAAAAAAAgAAAAAAAAAAAAEoAAAAAAMAAQAAAAekAAEAAAAAQG8BAgDAAgMAEgIAAJ8AAwGCAAEABAMIBAAAAEADCQYCAQImAAEYAAAAAAAAGCcAAAAAAwABAAAADaQAAQAAAABAbwECAMACAwASAgAAnwADAaQAAQAAAABAbwEEAMACBQASAgAAnwADAYIAAQAGAwoEAAAAQAMLBgEDDAYDAgEDCQABGAAAAAAAABsAAAAAABoLAAAAAAMAAAECABGjAAAApAABAAAAAEBvAgIAvAAAFgMAAACfAAMCpAEFAAAAQEBNAgC9BgAAAE0CAnoHAAAAnwECAsACCAASAAEAggICAAkDDQQAAABAAw4DDwMQBAAAQEADEQMSBgQBBAEAARgAAAAAAAAAAQAAAAAAAAcAAAEAAAAABXkUj+CKPoOf1RPUrUvn2RQJDJiUS9Dl4Q==

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:42:42
-- Luau version 6, Types version 3
-- Time taken: 0.004285 seconds

local Glicko2Utils_upvr = require(game:GetService("ReplicatedStorage").Glicko2.Glicko2Utils)
return function() -- Line 9
    --[[ Upvalues[1]:
        [1]: Glicko2Utils_upvr (readonly)
    ]]
    describe("checkSingleBattle", function() -- Line 11
        --[[ Upvalues[1]:
            [1]: Glicko2Utils_upvr (copied, readonly)
        ]]
        it("single battle rating should be correct", function() -- Line 12
            --[[ Upvalues[1]:
                [1]: Glicko2Utils_upvr (copied, readonly)
            ]]
            local any_calculateNewRatingData_result1, any_calculateNewRatingData_result2, any_calculateNewRatingData_result3 = Glicko2Utils_upvr.calculateNewRatingData(1500, 350, 0.06, {1500}, {350}, {1})
            local var11
            if 0.01 < math.abs(any_calculateNewRatingData_result1 - 1662.31) then
                var11 = false
            end
            if 0.01 < math.abs(any_calculateNewRatingData_result2 - 290.319) then
                var11 = false
            end
            if 0.01 < math.abs(any_calculateNewRatingData_result3 - 0.05999968) then
                var11 = false
            end
            if not var11 then
                print(any_calculateNewRatingData_result1, any_calculateNewRatingData_result2, any_calculateNewRatingData_result3)
            end
            expect(var11).to.equal(true)
        end)
    end)
    describe("checkMultipleBattles", function() -- Line 38
        --[[ Upvalues[1]:
            [1]: Glicko2Utils_upvr (copied, readonly)
        ]]
        it("single battle rating should be correct", function() -- Line 39
            --[[ Upvalues[1]:
                [1]: Glicko2Utils_upvr (copied, readonly)
            ]]
            local any_calculateNewRatingData_result1_2, any_calculateNewRatingData_result2_2, any_calculateNewRatingData_result3_2 = Glicko2Utils_upvr.calculateNewRatingData(1500, 200, 0.06, {1400, 1550, 1700}, {30, 100, 300}, {1, 0, 0})
            local var20
            if 0.01 < math.abs(any_calculateNewRatingData_result1_2 - 1464.06) then
                var20 = false
            end
            if 0.01 < math.abs(any_calculateNewRatingData_result2_2 - 151.52) then
                var20 = false
            end
            if 0.01 < math.abs(any_calculateNewRatingData_result3_2 - 0.05999) then
                var20 = false
            end
            if not var20 then
                print(any_calculateNewRatingData_result1_2, any_calculateNewRatingData_result2_2, any_calculateNewRatingData_result3_2)
            end
            expect(var20).to.equal(true)
        end)
    end)
end