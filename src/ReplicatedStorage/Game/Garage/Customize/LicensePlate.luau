-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMaGEZpbHRlclN0cmluZ0ZvckJyb2FkY2FzdAV1cHBlcgdbXiV3JXNdAARnc3ViA3N1YgVwY2FsbAR3YXJuH0xpY2Vuc2VQbGF0ZSBmaWx0ZXJpbmcgZmFpbGVkOiAGQkFESU1PF0dldEZpbHRlcmVkTGljZW5zZVBsYXRlBFR5cGUETWFrZQVNb2RlbAZEcml2ZXIORmluZEZpcnN0Q2hpbGQFcGxhdGUETmFtZQpTdXJmYWNlR3VpBUZyYW1lCVRleHRMYWJlbARUZXh0BGdhbWUHUGxheWVycwpHZXRTZXJ2aWNlBENoYXQABAQABAAABwAEAA8PDw8I+wABAPsCAgD7AwMAvAAAyAAAAACfAAQC3gAAAIIAAQABAwEADAABGAAAAAAAAAABEgAAAAAIAgEAABAAAQMPDwIQFA8DERMPBBETJLwCAUsAAAAAnwICAlIBAgBvBAEAbwUCALwCAcwDAAAAnwIEAlIBAgCMBAEAjAUHALwCAfAEAAAAnwIEAlIBAgDGAgAApAMGAAAAUEDZBAAAEgEC/xICAAASAQH/EgAAAJ8DAgMrAwYApAUIAAAAcEBvBgkAUgcEAJ8FAwHGAgAAKwIBAG8CCgDBAQAAggICAAsDAgMDAwQDBQMGAwcEAABQQAMIBAAAcEADCQMKAQAHCwEYAAAAAAEAAAAAAAEAAAAAAAEBAAAAAAAAAAgBAAAAAAEEAQIACAAAAAAMAgEAACAAAQcPDwgUDQ8HDRQPAgAiDwMCIA8EBB4PBQYcDwYIGiJNAgERAAAAAE0DAa0BAAAATQQBOwIAAABNBQG5AwAAAG8IAgC8BgQDBAAAAJ8GAwIOBhQAbwkFALwHBgMEAAAAnwcDAg4HDwAOAA4ADgUNAPsIAABSCQUATQoAugYAAACfCAMCTQsHJwcAAABNCgudCAAAAE0JCpoJAAAAMAgJ9QoAAACCAAEACwMMAw0DDgMPAxADEQMSAxMDFAMVAxYAIAABGAAAAQABAAIAAQAAAAEBAAAAAQEAAQAAAAABAAAAAAAAAAQhAAAAAAQAAAECDwAAAw8AAREPAQcLDwINBRKjAAAApAABAAAAAEBvAgIAvAAAFgMAAACfAAMCpAEBAAAAAEBvAwQAvAEBFgMAAACfAQMCwAIFABIAAQDAAwYAEgACAIIDAgAHAxcEAAAAQAMYAxkDGgYBBgICAQIBAAEYAAIAAAAAAAEAAAAAAAMAGQAAAQAAAAADwjy4kMjjDBfw+NIEB6gcFL9HNtWscLyqTWNkSriBcppnjD/B6nj7uQ==

local _ = game:GetService("Players");
local l_Chat_0 = game:GetService("Chat");
local function v7(v2, v3) --[[ Line: 7 ]] --[[ Name: GetFilteredLicensePlate ]]
    -- upvalues: l_Chat_0 (copy)
    v3 = v3:upper():gsub("[^%w%s]", ""):sub(1, 7);
    local v4 = nil;
    local l_status_0, l_result_0 = pcall(function() --[[ Line: 12 ]]
        -- upvalues: v4 (ref), l_Chat_0 (ref), v3 (ref), v2 (copy)
        v4 = l_Chat_0:FilterStringForBroadcast(v3, v2);
    end);
    if not l_status_0 then
        warn("LicensePlate filtering failed: ", l_result_0);
        v4 = nil;
    end;
    if not v4 then
        v4 = "BADIMO";
    end;
    return v4;
end;
return function(v8, v9) --[[ Line: 32 ]]
    -- upvalues: v7 (copy)
    local _ = v9.Type;
    local _ = v9.Make;
    local l_Model_0 = v9.Model;
    local l_Driver_0 = v9.Driver;
    local l_Model_1 = l_Model_0:FindFirstChild("Model");
    if l_Model_1 then
        local l_plate_0 = l_Model_1:FindFirstChild("plate");
        if l_plate_0 and v8 and l_Driver_0 then
            local v16 = v7(l_Driver_0, v8.Name);
            l_plate_0.SurfaceGui.Frame.TextLabel.Text = v16;
        end;
    end;
end;