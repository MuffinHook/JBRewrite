-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMZBU1vZGVsBE1ha2UFU2VhdHMORmluZEZpcnN0Q2hpbGQFdGFibGUGaW5zZXJ0CUNhcmJvbmFyYQ1TdGVlcmluZ1doZWVsFUdldERlZmF1bHRWZWhpY2xlUGFydAtSZWZsZWN0YW5jZRJEZWZhdWx0UmVmbGVjdGFuY2UITWF0ZXJpYWwPRGVmYXVsdE1hdGVyaWFsBEVudW0HUGxhc3RpYwRQYXJ0BE5hbWUEZ2FtZRFSZXBsaWNhdGVkU3RvcmFnZQpHZXRTZXJ2aWNlB3JlcXVpcmUER2FtZQZHYXJhZ2UKUGFpbnRVdGlscwVQYWludAACEAICAAAhAAIHDw8PCiIgDwsnGw8IISEPCSEhDwQFPw8CAEUPAwJDRU0CATsAAAAATQMBrQEAAAAOAD8A/wQAAAAAAABSBgQATQcCOwAAAABvCQIAvAcHAwMAAACfBwMATDQAAqQFBgAAFECAnwUAAfADCwAHAACATQgCOwAAAABNBwj2CAAAAJ40BAQHAAAAUgYEAKQFBgAAFECAnwUDAVIFBADGBgAAxgcAAGQFIAD7CwAATQoLiAkAAABSCwkAnwoCAv8LAgAAAAAADgoJAE0MCmIKAAAAMAwLwAsAAABNDAotDAAAADAMC8ANAAAAZQAHAG8MDgAwDAvACwAAAKQMEQAQMPDAMAwLwA0AAAD7DQEATQwNRBIAAABSDQkATQ4AuhMAAABSDwsAnwwEAW4F3/8CAAAAggABABQDAQMCAwMDBAMFAwYEABRAgAMHAwgDCQMKAwsDDAMNApqZmZmZmbk/Aw4DDwQQMPDAAxADEQAGAAEYAAABAAIBAAEAAAAAAAAAAAAAAQABAAAAAAAAAAAAAwAAAAEAAAAAAgABAQAAAAEAAAAAAgAAAQAAAAMAAAAAAAAA9AAPBwAAAAAGAAABAg8AAAMPAAEcDwEHFg8CEA0dowAAAKQAAQAAAABAbwICALwAABYDAAAAnwADAqQBBQAAAEBATQQAvQYAAABNAwQoBwAAAE0CA3kIAAAAnwECAqQCBQAAAEBATQUAvQYAAABNBAUoBwAAAE0DBFEJAAAAnwICAsADCgASAAEAEgACAIIDAgALAxIEAAAAQAMTAxQDFQQAAEBAAxYDFwMYAxkGAAEAAQABGAABAAAAAAABAAAAAAAAAAABAAAAAAAAAAACAAAAAQAAAAABc2eQ21ZybJ5Bo/pPiz8BCIwNhkXNCavbSullVyHSPPvb2zEN5tLbVA==

local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local v1 = require(l_ReplicatedStorage_0.Game.Garage.PaintUtils);
local v2 = require(l_ReplicatedStorage_0.Game.Garage.Paint);
return function(v3, v4) --[[ Line: 6 ]]
    -- upvalues: v1 (copy), v2 (copy)
    local l_Model_0 = v4.Model;
    local l_Make_0 = v4.Make;
    if v3 then
        local v7 = {};
        table.insert(v7, l_Model_0.Model:FindFirstChild("Seats"));
        if l_Make_0 == "Carbonara" then
            table.insert(v7, l_Model_0.Model.SteeringWheel);
        end;
        for _, v9 in v7 do
            local v10 = v1.GetDefaultVehiclePart(v9);
            local v11 = {};
            if v10 then
                v11.DefaultReflectance = v10.Reflectance;
                v11.DefaultMaterial = v10.Material;
            else
                v11.DefaultReflectance = 0.1;
                v11.DefaultMaterial = Enum.Material.Plastic;
            end;
            v2.Part(v9, v3.Name, v11);
        end;
    end;
end;