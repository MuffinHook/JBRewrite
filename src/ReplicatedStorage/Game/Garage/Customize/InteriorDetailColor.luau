-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMhBU1vZGVsBmlwYWlycw5HZXREZXNjZW5kYW50cwROYW1lDlNlY29uZEludGVyaW9yBXRhYmxlBmluc2VydARNYWtlBkNoaXJvbg1TdGVlcmluZ1doZWVsDkZpbmRGaXJzdENoaWxkBVdlZGdlCE1hdmVyaWNrBVZlbm9tBVNsb29wBlZpc3VhbARGbGFnFUdldERlZmF1bHRWZWhpY2xlUGFydAhNYXRlcmlhbA9EZWZhdWx0TWF0ZXJpYWwLUmVmbGVjdGFuY2USRGVmYXVsdFJlZmxlY3RhbmNlBEVudW0NU21vb3RoUGxhc3RpYwRQYXJ0BGdhbWURUmVwbGljYXRlZFN0b3JhZ2UKR2V0U2VydmljZQdyZXF1aXJlBVBhaW50BEdhbWUGR2FyYWdlClBhaW50VXRpbHMAAg8CAwAAKAADCA8PDw8HCgwPCAoMDwpjIw8IYiQPCWIkDwIAiQEPAwKHAQ8EGHGJAU0CATsAAAAA/wMAAAAAAACkBAIAAAAQQLwFAkcDAAAAnwUCAJ8EAARRBAsATQkIugQAAADwCQgABQAAgJ40AwUIAAAAUgoDAFILCACkCQgAABxggJ8JAwFuBPT/AgAAgE0EAa0JAAAA8AQNAAoAAIBSBgMATQcCOwAAAABvCQsAvAcHAwwAAACfBwMATDQAAqQFCAAAHGCAnwUAAWUANgDwBA0ADQAAgFIGAwBNBwI7AAAAAG8JCwC8BwcDDAAAAJ8HAwBMNAACpAUIAAAcYICfBQABZQAoAPAEDQAOAACAUgYDAE0HAjsAAAAAbwkLALwHBwMMAAAAnwcDAEw0AAKkBQgAABxggJ8FAAFlABoA8AQNAA8AAIBSBgMATQcCOwAAAABvCQsAvAcHAwwAAACfBwMATDQAAqQFCAAAHGCAnwUAAWUADADwBAsAEAAAgE0IAtARAAAATQcIpBIAAACeNAMEBwAAAFIGAwCkBQgAABxggJ8FAwGkBQIAAAAQQFIGAwCfBQIEUQUjAPsLAABNCguIEwAAAFILCQCfCgICDgoLAPsLAQBNDAotFAAAADAMC8AVAAAA+wsBAE0MCmIWAAAAMAwLwBcAAABlAAkA+wsBAKQMGgAZUIDBMAwLwBUAAAD7CwEAjAwAADAMC8AXAAAADgAIAPsMAgBNCwxEGwAAAFIMCQBNDQC6BAAAAPsOAQCfCwQBbgXc/wIAAICCAAEAHAMBAwIEAAAQQAMDAwQDBQMGAwcEABxggAMIAwkDCgMLAwwDDQMOAw8DEAMRAxIDEwMUAxUDFgMXAxgEGVCAwQMZAAgAARgAAAIAAQAAAAAAAAEAAAABAAAAAAAA/gAFAAEAAgAAAAAAAAAAAAAAAQABAAAAAAAAAAAAAAABAAEAAAAAAAAAAAAAAAEAAQAAAAAAAAAAAAAAAQABAAAAAAAAAAAAAgAAAAABAAAAAAEBAAAAAAEAAAAAAAIAAAAAAQAAAAIBAAAAAAAAAPYADQkAAAAABgAAAQITAAAEDwABHw8BBxkPAhAQDwMZByCjAAAApAABAAAAAEBvAgIAvAAAFgMAAACfAAMCpAEFAAAAQEBNBAC9BwAAAE0DBCgIAAAATQIDUQYAAACfAQICpAIFAAAAQEBNBQC9BwAAAE0EBSgIAAAATQMEeQkAAACfAgIC/wMCAAAAAADABAoAEgACABIAAwASAAEAggQCAAsDGgQAAABAAxsDHAMdBAAAQEADHgMfAyADIQYAAQABAAEYAAEAAAAAAAEAAAAAAAAAAAEAAAAAAAAAAAIAAgAAAAABAAAAAAGrfW8RQKE/r5m5BYVyThUAaFLc588KG9lVs3KO/i0Lv7VJaZN4J77l

local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local v1 = require(l_ReplicatedStorage_0.Game.Garage.Paint);
local v2 = require(l_ReplicatedStorage_0.Game.Garage.PaintUtils);
local v3 = {};
return function(v4, v5) --[[ Line: 8 ]]
    -- upvalues: v2 (copy), v3 (copy), v1 (copy)
    local l_Model_0 = v5.Model;
    local v7 = {};
    for _, v9 in ipairs(l_Model_0:GetDescendants()) do
        if v9.Name == "SecondInterior" then
            table.insert(v7, v9);
        end;
    end;
    local l_Make_0 = v5.Make;
    if l_Make_0 == "Chiron" then
        table.insert(v7, l_Model_0.Model:FindFirstChild("SteeringWheel"));
    elseif l_Make_0 == "Wedge" then
        table.insert(v7, l_Model_0.Model:FindFirstChild("SteeringWheel"));
    elseif l_Make_0 == "Maverick" then
        table.insert(v7, l_Model_0.Model:FindFirstChild("SteeringWheel"));
    elseif l_Make_0 == "Venom" then
        table.insert(v7, l_Model_0.Model:FindFirstChild("SteeringWheel"));
    elseif l_Make_0 == "Sloop" then
        table.insert(v7, l_Model_0.Visual.Flag);
    end;
    for _, v12 in ipairs(v7) do
        local v13 = v2.GetDefaultVehiclePart(v12);
        if v13 then
            v3.DefaultMaterial = v13.Material;
            v3.DefaultReflectance = v13.Reflectance;
        else
            v3.DefaultMaterial = Enum.Material.SmoothPlastic;
            v3.DefaultReflectance = 0;
        end;
        if v4 then
            v1.Part(v12, v4.Name, v3);
        end;
    end;
end;