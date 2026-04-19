-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMdDVJvYmJlcnlNYXJrZXIJR2V0VGFnZ2VkBE5hbWUXZ2V0Um9iYmVyeU1hcmtlckZvck5hbWUKbWFya2VyTmFtZQthZGRXYXlwb2ludAVtZXJnZQRwYXJ0BHdhcm4dTm8gcGFydCBmb3VuZCBmb3IgbWFya2VyIG5hbWUEdGFzawR3YWl0A0FwcBhTZXRSb2JiZXJ5V2F5cG9pbnRSZW1vdGUMV2FpdEZvckNoaWxkDU9uQ2xpZW50RXZlbnQHQ29ubmVjdAVzcGF3bgRpbml0BGdhbWURQ29sbGVjdGlvblNlcnZpY2UKR2V0U2VydmljZRFSZXBsaWNhdGVkU3RvcmFnZQdyZXF1aXJlBEV6VWkKRGljdGlvbmFyeQZzY3JpcHQGUGFyZW50Dk1pbmltYXBTZXJ2aWNlAAUIAQEAAAYDAAAFAQMS+wEAAG8DAAC8AQEFAQAAAJ8BAwJSAgEAxgMAAMYEAABkAgUATQcGugIAAACaBwIAAAAAAIIGAgBuAvr/AgAAAMYCAACCAgIAAwMBAwIDAwAHBAEYAAAAAAABAAAAAQAAAAH+AAUACAAAAAAMAQQAAAA3+wIAAJUBAgDeAQAAqQIAAE0EAMABAAAA+wUBAG8HAgC8BQUFAwAAAJ8FAwJSBgUAxgcAAMYIAABkBgYATQsKugQAAACaCwMABAAAAFIDCgBlAAMAbgb5/wIAAADGAwAADgMOAPsEAgBNBAT2BQAAAPsFAwBNBQUfBgAAAFIGAADiBwgAMAMHJAcAAACfBQMAnwQAAakCAQBlAAoApAQKAAAAkEBvBQsATQYAwAEAAACfBAMBpAQOAAA0wICMBQEAnwQCASsCBAD7BAAAmgQCAAEAAABIAM3/ggABAA8CAAAAAAAA8D8DBQMBAwIDAwMGAwcDCAUBBwMJBAAAkEADCgMLAwwEADTAgAAUAAEYDQABAgEA7wAAAAABAAAAAQAAAAEA/gAFDAEAAAAAAAAAAQD/AAMAAgAAAAAAAQAAAAIAAAAAAQgAAAAABQAEAAAAFPsAAABNAADBAAAAAG8CAQC8AADTAgAAAJ8AAwKMAQAATQIAjAMAAADZBAAAEgEB/xICAQASAgIAEgIDALwCAscEAAAAnwIDAcEBAACCAAEABQMNAw4DDwMQAxEBAREAARgAAAAAAAAAAQEAAAAAAAAAAAARABIAAAAAAgAEAAAACaQAAgAABACAwAEDABICAAASAgEAEgICABICAwCfAAIBggABAAQDCwMSBAAEAIAGAgECEBMBGAAAAAAAAAAAFREAAAAABwAAAQIAKaMAAACkAAEAAAAAQG8CAgC8AAAWAwAAAJ8AAwKkAQEAAAAAQG8DBAC8AQEWAwAAAJ8BAwKkAgYAAABQQE0DAS0HAAAATQMDqQgAAACfAgICpAMGAAAAUECkBAoAAACQQE0EBCQLAAAATQQEXQwAAACfAwIC/wQBAAAAAADABQ0AEgAAAMAGDgASAAEAEgAAABIAAwASAAIAMAYEEw8AAACCBAIAEAMUBAAAAEADFQMWAxcDGAQAAFBAAxkDGgMbBAAAkEADHAMdBgAGAwMTAgADAQABGAAAAAAAAAABAAAAAAABAAAAAAAAAQAAAAAAAAAAAQACAAkAAAAAAAAXAQAAAAAEbHKQKv4BKbUHdetYRJqcdRxqh15etvor

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:40:24
-- Luau version 6, Types version 3
-- Time taken: 0.002509 seconds

local CollectionService_upvr = game:GetService("CollectionService")
local ReplicatedStorage_upvr = game:GetService("ReplicatedStorage")
local module = {}
local function _(arg1) -- Line 7, Named "getRobberyMarkerForName"
    --[[ Upvalues[1]:
        [1]: CollectionService_upvr (readonly)
    ]]
    for _, v in CollectionService_upvr:GetTagged("RobberyMarker"), nil do
        if v.Name == arg1 then
            return v
        end
    end
    return nil
end
local MinimapService_upvr = require(script.Parent.MinimapService)
local Dictionary_upvr = require(ReplicatedStorage_upvr.EzUi.Dictionary)
function module.init() -- Line 16
    --[[ Upvalues[4]:
        [1]: ReplicatedStorage_upvr (readonly)
        [2]: CollectionService_upvr (readonly)
        [3]: MinimapService_upvr (readonly)
        [4]: Dictionary_upvr (readonly)
    ]]
    task.spawn(function() -- Line 17
        --[[ Upvalues[4]:
            [1]: ReplicatedStorage_upvr (copied, readonly)
            [2]: CollectionService_upvr (copied, readonly)
            [3]: MinimapService_upvr (copied, readonly)
            [4]: Dictionary_upvr (copied, readonly)
        ]]
        local var10_upvw = 0
        ReplicatedStorage_upvr.App:WaitForChild("SetRobberyWaypointRemote").OnClientEvent:Connect(function(arg1) -- Line 20
            --[[ Upvalues[4]:
                [1]: var10_upvw (read and write)
                [2]: CollectionService_upvr (copied, readonly)
                [3]: MinimapService_upvr (copied, readonly)
                [4]: Dictionary_upvr (copied, readonly)
            ]]
            -- KONSTANTERROR: [0] 1. Error Block 1 start (CF ANALYSIS FAILED)
            local var11 = var10_upvw + 1
            var10_upvw = var11
            local var12
            -- KONSTANTERROR: [0] 1. Error Block 1 end (CF ANALYSIS FAILED)
            -- KONSTANTERROR: [23] 19. Error Block 25 start (CF ANALYSIS FAILED)
            local var13
            if var13 then
                MinimapService_upvr.addWaypoint(Dictionary_upvr.merge(arg1, {
                    part = var13;
                }))
            else
                warn("No part found for marker name", arg1.markerName)
                task.wait(1)
            end
            if nil then
                -- KONSTANTWARNING: GOTO [54] #43
            end
            if var10_upvw ~= var11 then
                -- KONSTANTWARNING: GOTO [54] #43
            end
            -- KONSTANTERROR: [23] 19. Error Block 25 end (CF ANALYSIS FAILED)
            -- KONSTANTERROR: [3] 4. Error Block 2 start (CF ANALYSIS FAILED)
            -- KONSTANTERROR: [3] 4. Error Block 2 end (CF ANALYSIS FAILED)
        end)
    end)
end
return module