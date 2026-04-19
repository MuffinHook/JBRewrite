-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMRCEJhc2VQYXJ0A0lzQQpJc0NyYXdsaW5nCkNhbkNvbGxpZGUFQWRkZWQNQ3Jhd2xQYXNzT25seQlHZXRUYWdnZWQEZ2FtZRFDb2xsZWN0aW9uU2VydmljZQpHZXRTZXJ2aWNlEVJlcGxpY2F0ZWRTdG9yYWdlB3JlcXVpcmUER2FtZQ1DaGFyYWN0ZXJVdGlsFkdldEluc3RhbmNlQWRkZWRTaWduYWwHQ29ubmVjdBFJc0NyYXdsaW5nQ2hhbmdlZAADBAEBAAAADG8DAAC8AQD+AQAAAJ8BAwIOAQYA+wIAAE0CAoUCAAAAVgECADABANMDAAAAggABAAQDAQMCAwMDBAAHBQEYAAAAAAABAAAAAAACCAAAAAAIAAIAAAAU+wAAAG8CAAC8AAAFAQAAAJ8AAwRkAAsAbwcCALwFBP4DAAAAnwUDAg4FBgD7BgEATQYGhQQAAABWBQYAMAUE0wUAAABuAPT/AgAAAIIAAQAGAwYDBwMBAwIDAwMEABEAARgKAAAAAAD2AAAAAAEAAAAAAAkAAwgAAAAADAAAAQAAOKMAAACkAAEAAAAAQG8CAgC8AAAWAwAAAJ8AAwKkAQEAAAAAQG8DBAC8AQEWAwAAAJ8BAwKkAgYAAABQQE0DAb0HAAAATQMDwwgAAACfAgICwAMJABIAAgBvBgoAvAQAXgsAAACfBAMCUgYDALwEBMcMAAAAnwQDAW8GCgC8BAAFDQAAAJ8EAwRkBAoAbwsOALwJCP4PAAAAnwkDAg4JBQBNCgKFEAAAAFYJCgAwCQjTEQAAAG4E9f8CAAAATQQCORIAAADABhMAEgAAABIAAgC8BATHDAAAAJ8EAwGCAAEAFAMIBAAAAEADCQMKAwsDDAQAAFBAAw0DDgYAAwYDDwMQAwcDAQMCAwMDBAMRBgECAAEBAAEYAAAAAAAAAAEAAAAAAAEAAAAAAAAEAAUAAAAAAAAAAQAAAAD7AAAAAAEAAAAABAAEAAAAAAAAAAUBAAAAAAJexuRD6PkGoLTkXffBDD+GLt7zN2wCjkI=

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:29:27
-- Luau version 6, Types version 3
-- Time taken: 0.001708 seconds

local CollectionService_upvr = game:GetService("CollectionService")
local CharacterUtil_upvr = require(game:GetService("ReplicatedStorage").Game.CharacterUtil)
CollectionService_upvr:GetInstanceAddedSignal("CrawlPassOnly"):Connect(function(arg1) -- Line 7, Named "Added"
    --[[ Upvalues[1]:
        [1]: CharacterUtil_upvr (readonly)
    ]]
    if arg1:IsA("BasePart") then
        arg1.CanCollide = not CharacterUtil_upvr.IsCrawling
    end
end)
for _, v in CollectionService_upvr:GetTagged("CrawlPassOnly") do
    if v:IsA("BasePart") then
        v.CanCollide = not CharacterUtil_upvr.IsCrawling
    end
end
CharacterUtil_upvr.IsCrawlingChanged:Connect(function() -- Line 17
    --[[ Upvalues[2]:
        [1]: CollectionService_upvr (readonly)
        [2]: CharacterUtil_upvr (readonly)
    ]]
    for _, v_2 in CollectionService_upvr:GetTagged("CrawlPassOnly") do
        if v_2:IsA("BasePart") then
            v_2.CanCollide = not CharacterUtil_upvr.IsCrawling
        end
    end
end)