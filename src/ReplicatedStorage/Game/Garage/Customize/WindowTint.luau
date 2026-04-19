-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMVFUdldERlZmF1bHRWZWhpY2xlUGFydAxUcmFuc3BhcmVuY3kPc2V0VHJhbnNwYXJlbmN5BU1vZGVsBVZhbHVlDkZpbmRGaXJzdENoaWxkBmlwYWlycw5HZXREZXNjZW5kYW50cwROYW1lB1dpbmRvd3MGUHJlc2V0CERvb3JMZWZ0BldpbmRvdwlEb29yUmlnaHQEZ2FtZRFSZXBsaWNhdGVkU3RvcmFnZQpHZXRTZXJ2aWNlB3JlcXVpcmUKUGFpbnRVdGlscwRHYW1lBkdhcmFnZQADBAIBAAAIAAEBDw8CAgcMRwEIAAAAAID7AwAATQIDiAAAAABSAwAAnwICAk0BAtkBAAAAMAEA2QEAAACCAAEAAgMBAwIABQMBGAAAAQAAAAABAAIAAQYAAAAADQIBAABQAAETDw8LGQcPCRcLDwoWDA8IEREPCRERDwk2Bw8HNAsPCDMMDwcuEQ8KTAcPCEoLDwlJDA8IRBEPBiksDwc/Fg8FJDEPAgBWDwMCVA8EBlBWTQIBOwAAAABSAwAADgMCAE0DAOwBAAAAbwYAALwEAgMCAAAAnwQDAg4ESgCkBQQAAAAwQLwGAkcFAAAAnwYCAJ8FAARRBRAATQoJugYAAADwCg0ABwAAgFIKAwBHCggAAAAAgPsMAABNCwyICAAAAFIMCQCfCwICTQoL2QkAAAAwCgnZCQAAAG4F7/8CAACAbwcKALwFAgMCAAAAnwUDAg4FLABvCAsAvAYFAwIAAACfBgMCDgYRAG8JDAC8BwYDAgAAAJ8HAwIOBwwAUggDAEcICAAAAACA+woAAE0JCogIAAAAUgoHAJ8JAgJNCAnZCQAAADAIB9kJAAAAbwkNALwHBQMCAAAAnwcDAg4HEQBvCgwAvAgHAwIAAACfCAMCDggMAFIJAwBHCQgAAAAAgPsLAABNCguICAAAAFILCACfCgICTQkK2QkAAAAwCQjZCQAAAIIAAQAOAwQDBQMGAwcEAAAwQAMIAwkDCgMBAwIDCwMMAw0DDgANAAEYCAABAAAAAwAAAAEBAAAAAAAAAQAAAAHwAAEAAAAAAQACAAoABgAAAAEBAAAAAQEAAAABAeYAAQAAAAABAAIAGQAAAAEBAAAAAQHfAAEAAAAAAQACACIGAAAAAAUAAAECDwAAAw8AARQPAQcODwIQBRWjAAAApAABAAAAAEBvAgIAvAAAFgMAAACfAAMCpAEFAAAAQEBNBAC9BwAAAE0DBCgIAAAATQIDeQYAAACfAQICwAIJABIAAQDAAwoAEgABAIIDAgALAw8EAAAAQAMQAxEDEgQAAEBAAxMDFAMVBgAGAQIAAQEAARgAAQAAAAAAAQAAAAAAAAAAAgAIAAABAAAAAAI0F6wbtMtvAQbTxo/bjRUedAHXzcVOSzUPKOefKN2243ddzfSLQ+zm

local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local v1 = require(l_ReplicatedStorage_0.Game.Garage.PaintUtils);
local function _(v2, v3) --[[ Line: 5 ]] --[[ Name: setTransparency ]]
    -- upvalues: v1 (copy)
    if v3 == nil then
        v3 = v1.GetDefaultVehiclePart(v2).Transparency;
    end;
    v2.Transparency = v3;
end;
return function(v5, v6) --[[ Line: 13 ]]
    -- upvalues: v1 (copy)
    local l_Model_0 = v6.Model;
    local v8 = v5 and v5.Value;
    if l_Model_0:FindFirstChild("Model") then
        for _, v10 in ipairs(l_Model_0:GetDescendants()) do
            if v10.Name == "Windows" then
                local l_v8_0 = v8;
                if l_v8_0 == nil then
                    l_v8_0 = v1.GetDefaultVehiclePart(v10).Transparency;
                end;
                v10.Transparency = l_v8_0;
            end;
        end;
        local l_Preset_0 = l_Model_0:FindFirstChild("Preset");
        if l_Preset_0 then
            local l_DoorLeft_0 = l_Preset_0:FindFirstChild("DoorLeft");
            if l_DoorLeft_0 then
                local l_Window_0 = l_DoorLeft_0:FindFirstChild("Window");
                if l_Window_0 then
                    local l_v8_1 = v8;
                    if l_v8_1 == nil then
                        l_v8_1 = v1.GetDefaultVehiclePart(l_Window_0).Transparency;
                    end;
                    l_Window_0.Transparency = l_v8_1;
                end;
            end;
            local l_DoorRight_0 = l_Preset_0:FindFirstChild("DoorRight");
            if l_DoorRight_0 then
                local l_Window_1 = l_DoorRight_0:FindFirstChild("Window");
                if l_Window_1 then
                    local l_v8_2 = v8;
                    if l_v8_2 == nil then
                        l_v8_2 = v1.GetDefaultVehiclePart(l_Window_1).Transparency;
                    end;
                    l_Window_1.Transparency = l_v8_2;
                end;
            end;
        end;
    end;
end;