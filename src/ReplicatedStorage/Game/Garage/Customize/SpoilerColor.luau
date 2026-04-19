-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMoBU1vZGVsB0NsYXNzaWMHU3BvaWxlchJEZWZhdWx0UmVmbGVjdGFuY2UPRGVmYXVsdE1hdGVyaWFsBEVudW0ITWF0ZXJpYWwNU21vb3RoUGxhc3RpYwhSZXNvdXJjZQ5GaW5kRmlyc3RDaGlsZAtSZWZsZWN0YW5jZQtTcG9pbGVyUGFydARQYXJ0BE5hbWUFV2hpdGUKR3VpdGFyUmlmZgZpcGFpcnMLR2V0Q2hpbGRyZW4FVHJhaWwDSXNBDUNvbG9yU2VxdWVuY2UDbmV3BUNvbG9yEFZlaGljbGVDb2xvclBhcnQGSGFzVGFnBkFkZFRhZxFpc0h5cGVyQ2hyb21lTmFtZR9IWVBFUkNIUk9NRV9OQU1FX0FUVFJJQlVURV9OQU1FDFNldEF0dHJpYnV0ZQRnYW1lEVJlcGxpY2F0ZWRTdG9yYWdlCkdldFNlcnZpY2UHcmVxdWlyZQVQYWludARHYW1lBkdhcmFnZRFDb2xsZWN0aW9uU2VydmljZQtIeXBlckNocm9tZRFIeXBlckNocm9tZUNvbnN0cxBIeXBlckNocm9tZVV0aWxzAAIPAwUAACQABQcPDw8PDw8GDhEPCj4NDws+DQ8DAHMPBAJxDwUFbg8GH1RzTQMBOwAAAABNBQKCAgAAAJAEBQHiBQUAjAYAADAGBcADAAAApAYJAAgcYMAwBgXABAAAAA4EEQD7CAAATQcIYgoAAABNBgeCAgAAAFIIBAC8BgYDCwAAAJ8GAwJNBwZiDAAAADAHBcADAAAATQcGLQcAAAAwBwXABAAAAG8IDQC8BgMDCwAAAJ8GAwIOBk4ARwAKAAAAAAD7CAEATQcIRA4AAABSCAYATQkAug8AAABSCgUAnwcEAWUABwD7CAEATQcIRA4AAABSCAYAbwkQAFIKBQCfBwQB8AQWABEAAICkBxMAAAAgQbwIBmgUAAAAnwgCAJ8HAARRBwwAbw4VALwMC/4WAAAAnwwDAg4MBwCkDBkAAGBwgU0NBqQaAAAAnwwCAjAMC6QaAAAAbgfz/wIAAID7BwIAUgkGAG8KGwC8BwfeHAAAAJ8HBAIrBwYA+wcCAFIJBgBvChsAvAcHRR0AAACfBwQBDgAQAPsIAwBNBwiGHgAAAE0IALoPAAAAnwcCAg4HCQD7CgQATQkK/h8AAABNCgC6DwAAALwHBi4gAAAAnwcEAYIAAQD7CgQATQkK/h8AAADGCgAAvAcGLiAAAACfBwQBggABACEDAQMCAwMDBAMFBQIDBAMGAwcDCAQIHGDAAwkDCgMLAwwDDQMOAw8DEAMRBAAAIEEDEgMTAxQDFQMWBABgcIEDFwMYAxkDGgMbAxwDHQAIAAEYAAABAAABAQAAAQAAAAMBAAAAAAAAAAABAAAAAQAAAAIAAAABAQABAAAAAAAAAAACAAAAAAAAAwABAAAAAAAAAQAAAAABAAAAAAAA/gAHAAAAAAAAAQAAAAAAAgAAAAAAAAABAAAAAAAAAAACAAAAAAAAAwkAAAAABwAAAQIXAAAFDwABKg8BByQPAhAbDwMWFQ8EHQ4rowAAAKQAAQAAAABAbwICALwAABYDAAAAnwADAqQBBQAAAEBATQQAvQcAAABNAwQoCAAAAE0CA1EGAAAAnwECAqQCAQAAAABAbwQJALwCAhYDAAAAnwIDAqQDBQAAAEBATQUAowoAAABNBAXGCwAAAJ8DAgKkBAUAAABAQE0GAKMKAAAATQUGswwAAACfBAICwAUNABIAAAASAAEAEgACABIABAASAAMAggUCAA4DHgQAAABAAx8DIAMhBAAAQEADIgMjAyQDJQMmAycDKAYAAQABAAEYAAEAAAAAAAEAAAAAAAAAAAEAAAAAAAEAAAAAAAABAAAAAAAAAgAAAAAAAAEAAAAAASLOw92ncdoMEAqpSXrFiI+vbppFC+EsbrA+iyE9sd8a2JWuOSrBHUY=

local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local v1 = require(l_ReplicatedStorage_0.Game.Garage.Paint);
local l_CollectionService_0 = game:GetService("CollectionService");
local v3 = require(l_ReplicatedStorage_0.HyperChrome.HyperChromeConsts);
local v4 = require(l_ReplicatedStorage_0.HyperChrome.HyperChromeUtils);
return function(v5, v6, v7) --[[ Line: 8 ]]
    -- upvalues: l_ReplicatedStorage_0 (copy), v1 (copy), l_CollectionService_0 (copy), v4 (copy), v3 (copy)
    local l_Model_0 = v6.Model;
    local v9 = v7.Spoiler or "Classic";
    local v10 = {
        DefaultReflectance = 0, 
        DefaultMaterial = Enum.Material.SmoothPlastic
    };
    if v9 then
        local l_FirstChild_0 = l_ReplicatedStorage_0.Resource.Spoiler:FindFirstChild(v9);
        v10.DefaultReflectance = l_FirstChild_0.Reflectance;
        v10.DefaultMaterial = l_FirstChild_0.Material;
    end;
    local l_SpoilerPart_0 = l_Model_0:FindFirstChild("SpoilerPart");
    if l_SpoilerPart_0 then
        if v5 ~= nil then
            v1.Part(l_SpoilerPart_0, v5.Name, v10);
        else
            v1.Part(l_SpoilerPart_0, "White", v10);
        end;
        if v9 == "GuitarRiff" then
            for _, v14 in ipairs(l_SpoilerPart_0:GetChildren()) do
                if v14:IsA("Trail") then
                    v14.Color = ColorSequence.new(l_SpoilerPart_0.Color);
                end;
            end;
        end;
        if not l_CollectionService_0:HasTag(l_SpoilerPart_0, "VehicleColorPart") then
            l_CollectionService_0:AddTag(l_SpoilerPart_0, "VehicleColorPart");
        end;
        if v5 and v4.isHyperChromeName(v5.Name) then
            l_SpoilerPart_0:SetAttribute(v3.HYPERCHROME_NAME_ATTRIBUTE_NAME, v5.Name);
            return;
        else
            l_SpoilerPart_0:SetAttribute(v3.HYPERCHROME_NAME_ATTRIBUTE_NAME, nil);
        end;
    end;
end;