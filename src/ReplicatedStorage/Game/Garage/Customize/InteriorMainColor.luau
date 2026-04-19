-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMdBU1vZGVsBE1ha2UFU2xvb3AGVmlzdWFsCVNhaWxGcm9udAV0YWJsZQZpbnNlcnQHUGh5c2ljcwhTYWlsQmFjawRTYWlsBmlwYWlycw5HZXREZXNjZW5kYW50cwROYW1lCEludGVyaW9yFUdldERlZmF1bHRWZWhpY2xlUGFydAhNYXRlcmlhbA9EZWZhdWx0TWF0ZXJpYWwLUmVmbGVjdGFuY2USRGVmYXVsdFJlZmxlY3RhbmNlBFBhcnQFQ29sb3IEZ2FtZRFSZXBsaWNhdGVkU3RvcmFnZQpHZXRTZXJ2aWNlB3JlcXVpcmUFUGFpbnQER2FtZQZHYXJhZ2UKUGFpbnRVdGlscwACDgIDAAAiAAMHDw8PDwclDA8IJQwPCTglDwc3Jg8INyYPAgBgDwMCXmBNAgE7AAAAAP8DAAAAAAAATQQBrQEAAADwBBgAAgAAgE0HAtADAAAATQYHVQQAAACeNAMEBgAAAFIFAwCkBAcAABhQgJ8EAwFNCAIzCAAAAE0HCCQJAAAATQYHIgoAAACeNAMEBgAAAFIFAwCkBAcAABhQgJ8EAwFlABQApAQMAAAAsEC8BQJHDQAAAJ8FAgCfBAAEUQQLAE0JCLoOAAAA8AkIAA8AAICeNAMFCAAAAFIKAwBSCwgApAkHAAAYUICfCQMBbgT0/wIAAICkBAwAAACwQFIFAwCfBAIEUQQlAPsKAABNCQqIEAAAAFIKCACfCQIC+woBAE0LCS0RAAAAMAsKwBIAAAD7CgEATQsJYhMAAAAwCwrAFAAAAA4ACQD7CwIATQoLRBUAAABSCwgATQwAug4AAAD7DQEAnwoEAWUADABNCgmkFgAAADAKCKQWAAAATQoJLREAAAAwCggtEQAAAE0KCWITAAAAMAoIYhMAAABuBNr/AgAAgIIAAQAXAwEDAgMDAwQDBQMGAwcEABhQgAMIAwkDCgMLBAAAsEADDAMNAw4DDwMQAxEDEgMTAxQDFQAIAAEYAAACAAEAAAABAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAIAAAAAAAABAAAAAQAAAAAAAP4ABgAAAAABAAAAAAEAAAAAAQAAAAABAQAAAAAAAAAAAgAAAAEAAAABAAAA9wAMCQAAAAAGAAABAhMAAAQPAAEfDwEHGQ8CEBAPAxkHIKMAAACkAAEAAAAAQG8CAgC8AAAWAwAAAJ8AAwKkAQUAAABAQE0EAL0HAAAATQMEKAgAAABNAgNRBgAAAJ8BAgKkAgUAAABAQE0FAL0HAAAATQQFKAgAAABNAwR5CQAAAJ8CAgL/AwIAAAAAAMAECgASAAIAEgADABIAAQCCBAIACwMWBAAAAEADFwMYAxkEAABAQAMaAxsDHAMdBgABAAEAARgAAQAAAAAAAQAAAAAAAAAAAQAAAAAAAAAAAgACAAAAAAEAAAAAAZ/u7xU3lpzxrSqFgSXneo/JHt5C0iZFCJqWb881kduqwi3vYL9yaGE=

local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local v1 = require(l_ReplicatedStorage_0.Game.Garage.Paint);
local v2 = require(l_ReplicatedStorage_0.Game.Garage.PaintUtils);
local v3 = {};
return function(v4, v5) --[[ Line: 8 ]]
    -- upvalues: v2 (copy), v3 (copy), v1 (copy)
    local l_Model_0 = v5.Model;
    local v7 = {};
    if v5.Make == "Sloop" then
        table.insert(v7, l_Model_0.Visual.SailFront);
        table.insert(v7, l_Model_0.Physics.SailBack.Sail);
    else
        for _, v9 in ipairs(l_Model_0:GetDescendants()) do
            if v9.Name == "Interior" then
                table.insert(v7, v9);
            end;
        end;
    end;
    for _, v11 in ipairs(v7) do
        local v12 = v2.GetDefaultVehiclePart(v11);
        v3.DefaultMaterial = v12.Material;
        v3.DefaultReflectance = v12.Reflectance;
        if v4 then
            v1.Part(v11, v4.Name, v3);
        else
            v11.Color = v12.Color;
            v11.Material = v12.Material;
            v11.Reflectance = v12.Reflectance;
        end;
    end;
end;