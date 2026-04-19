-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMeBE1ha2UFTW9kZWwETmFtZQVXaGl0ZQhHZXRDb2xvcgZpcGFpcnMOR2V0RGVzY2VuZGFudHMKSGVhZGxpZ2h0cwV0YWJsZQZpbnNlcnQVR2V0RGVmYXVsdFZlaGljbGVQYXJ0C1JlZmxlY3RhbmNlEkRlZmF1bHRSZWZsZWN0YW5jZQRQYXJ0DkZpbmRGaXJzdENoaWxkBEJvZHkLR2V0Q2hpbGRyZW4JSGVhZGxpZ2h0BUxpZ2h0FkZpbmRGaXJzdENoaWxkV2hpY2hJc0EFQ29sb3IEZ2FtZRFSZXBsaWNhdGVkU3RvcmFnZQpHZXRTZXJ2aWNlB3JlcXVpcmUFUGFpbnQER2FtZQZHYXJhZ2UKUGFpbnRVdGlscw9EaXNhYmxlTWF0ZXJpYWwAAhECAwAAQgADDw8PDw8KGAwPCxgMDwwrEQ8KKhIPCyoSDw5SBw8MTQwPDU0MDwhDGA8CAFwPAwJaDwQEWA8FC1EPBhBMDwc+HlxNAgGtAAAAAE0DATsBAAAAxgQAAEcABAAAAAAATQQAugIAAABlAAEAbwQDAPsGAABNBQYLBAAAAFIGBACfBQIC/wYAAAAAAACkBwYAAABQQLwIA0cHAAAAnwgCAJ8HAARRBwsATQwLugIAAADwDAgACAAAgJ40BgULAAAAUg0GAFIOCwCkDAsAACiQgJ8MAwFuB/T/AgAAgKQHBgAAAFBAUggGAJ8HAgRRBxEA+w0BAE0MDYgMAAAAUg0LAJ8MAgL7DQIATQ4MYg0AAAAwDg3ADgAAAPsOAABNDQ5EDwAAAFIOCwBSDwQA+xACAJ8NBAFuB+7/AgAAgG8JAQC8BwMDEAAAAJ8HAwIOBxgAbwoRALwIBwMQAAAAnwgDAqQJBgAAAFBAvAoIaBIAAACfCgIAnwkABFEJCwBNDg26AgAAAPAOCAATAACAbxAUALwODVQVAAAAnw4DAg4OAgAwBQ6kFgAAAG4J9P8CAACAggABABcDAQMCAwMDBAMFAwYEAABQQAMHAwgDCQMKBAAokIADCwMMAw0DDgMPAxADEQMSAxMDFAMVAAoAARgAAAEAAQEAAQAAAgIAAAAAAQABAAAAAAAAAQAAAAEAAAAAAAD+AAUAAAAAAQAAAAABAAAAAAEAAAAAAAD9AAYAAAABAQAAAAEAAAAAAAABAAAAAQAAAAEBAPwACQsAAAAABgAAAQITAAAEDwABJA8BBx4PAhAVDwMZDCWjAAAApAABAAAAAEBvAgIAvAAAFgMAAACfAAMCpAEFAAAAQEBNBAC9BwAAAE0DBCgIAAAATQIDUQYAAACfAQICpAIFAAAAQEBNBQC9BwAAAE0EBSgIAAAATQMEeQkAAACfAgIC4gMMAIwEAAAwBAPACgAAAKkEAQAwBAPACwAAAMAEDQASAAEAEgACABIAAwCCBAIADgMWBAAAAEADFwMYAxkEAABAQAMaAxsDHAMdAw0DHgUCCgsGAAEAAQABGAABAAAAAAABAAAAAAAAAAABAAAAAAAAAAABAQAAAQAAAwAAAAABAAAAAAGUzYKfZJ1CZKYJ6AtQ52+IE+DTyRW6Z8aKCF+sB4y46eIIEAvCNXcM

local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local v1 = require(l_ReplicatedStorage_0.Game.Garage.Paint);
local v2 = require(l_ReplicatedStorage_0.Game.Garage.PaintUtils);
local v3 = {
    DefaultReflectance = 0, 
    DisableMaterial = true
};
return function(v4, v5) --[[ Line: 10 ]]
    -- upvalues: v1 (copy), v2 (copy), v3 (copy)
    local _ = v5.Make;
    local l_Model_0 = v5.Model;
    local v8 = nil;
    v8 = if v4 ~= nil then v4.Name else "White";
    local v9 = v1.GetColor(v8);
    local v10 = {};
    for _, v12 in ipairs(l_Model_0:GetDescendants()) do
        if v12.Name == "Headlights" then
            table.insert(v10, v12);
        end;
    end;
    for _, v14 in ipairs(v10) do
        v3.DefaultReflectance = v2.GetDefaultVehiclePart(v14).Reflectance;
        v1.Part(v14, v8, v3);
    end;
    local l_Model_1 = l_Model_0:FindFirstChild("Model");
    if l_Model_1 then
        local l_Body_0 = l_Model_1:FindFirstChild("Body");
        for _, v18 in ipairs(l_Body_0:GetChildren()) do
            if v18.Name == "Headlight" then
                local l_Light_0 = v18:FindFirstChildWhichIsA("Light");
                if l_Light_0 then
                    l_Light_0.Color = v9;
                end;
            end;
        end;
    end;
end;