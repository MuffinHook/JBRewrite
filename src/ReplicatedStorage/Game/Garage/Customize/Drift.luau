-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMfBHdhcm4jRHJpZnQgSXRlbSBub3QgZm91bmQsIHVzaW5nIGRlZmF1bHQETmFtZQdDbGFzc2ljBU1vZGVsCFJlc291cmNlDkRyaWZ0UGFydGljbGVzDkZpbmRGaXJzdENoaWxkD1BhcnRpY2xlRW1pdHRlchVGaW5kRmlyc3RDaGlsZE9mQ2xhc3MGUHJlc2V0C0dldENoaWxkcmVuBURyaWZ0BXRhYmxlBmluc2VydAdEZXN0cm95BUNsb25lB0VuYWJsZWQERW51bQhOb3JtYWxJZARCYWNrEUVtaXNzaW9uRGlyZWN0aW9uCUlzRWRpdGluZwRSYXRlC051bWJlclJhbmdlA25ldwVTcGVlZAZQYXJlbnQEZ2FtZRFSZXBsaWNhdGVkU3RvcmFnZQpHZXRTZXJ2aWNlAAIRBAEAACwAAQoPDwslDA8MJQwPDTcnDw4/Hw8LNigPDDYoDwQKVw8FDFUPBhhJDwccRWErAAkApAQBAAAAAEBvBQIAnwQCAeIEBABvBQUAMAUEugMAAABSAAQATQQBOwYAAAD7BgAATQUGYgcAAABvBwgAvAUFAwkAAACfBQMCTQcAugMAAAC8BQUDCQAAAJ8FAwJvCAoAvAYFuAsAAACfBgMC/wcAAAAAAABvCgwAvAgEAwkAAACfCAMCvAgIaA0AAACfCAIEZAgLAE0NDLoDAAAA8A0IAA4AAICeNAcFDAAAAFIOBwBSDwwApA0RAABA8ICfDQMBbgj0/wIAAABSCAcAxgkAAMYKAABkCCcAbw8KALwNDLgLAAAAnw0DAg4NAwC8Dg1QEgAAAJ8OAgG8DgY6EwAAAJ8OAgJvDwoAMA8OugMAAACpDwAAMA8O8BQAAACkDxgAF1hQwTAPDvgZAAAADgMPAE0PAwAaAAAADg8MAIwPJAAwDw72GwAAAKQPHgAAdMCBjBAPAJ8PAgIwDw4sHwAAAKkPAQAwDw7wFAAAADAMDiQgAAAAbgjY/wIAAACCAAEAIQMBBAAAAEADAgMDBQEDAwQDBQMGAwcDCAMJAwoDCwMMAw0DDgMPBABA8IADEAMRAxIDEwMUAxUEF1hQwQMWAxcDGAMZAxoEAHTAgQMbAxwABAABGAABAAAAAQEAAAADAAIAAAAAAAAAAAAAAAEAAAAEAAEAAAAAAAAAAQAAAAEAAAAAAAD+AAUAAAABAAAAAQEAAAIAAAEAAAEAAAEAAAABAAAAAQAAAQAAAAAAAQAAAgDyABAFAAAAAAMAAAECBwAAAQ8AAQkKowAAAKQAAQAAAABAbwICALwAABYDAAAAnwADAsABBAASAAAAggECAAUDHQQAAABAAx4DHwYAAQABAAEYAAEAAAAAAAIAAAEAAAAAAch/GpOv03mW+rtwB4560ipp1l4WJSkEak7ZmqG55+MrhHG9V+Pkoww=

local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
return function(v1, v2, _, v4) --[[ Line: 4 ]]
    -- upvalues: l_ReplicatedStorage_0 (copy)
    if not v1 then
        warn("Drift Item not found, using default");
        v1 = {
            Name = "Classic"
        };
    end;
    local l_Model_0 = v2.Model;
    local l_ParticleEmitter_0 = l_ReplicatedStorage_0.Resource:FindFirstChild("DriftParticles"):FindFirstChild(v1.Name):FindFirstChildOfClass("ParticleEmitter");
    local v7 = {};
    for _, v9 in l_Model_0:FindFirstChild("Preset"):GetChildren() do
        if v9.Name == "Drift" then
            table.insert(v7, v9);
        end;
    end;
    for _, v11 in v7 do
        local l_ParticleEmitter_1 = v11:FindFirstChildOfClass("ParticleEmitter");
        if l_ParticleEmitter_1 then
            l_ParticleEmitter_1:Destroy();
        end;
        local v13 = l_ParticleEmitter_0:Clone();
        v13.Name = "ParticleEmitter";
        v13.Enabled = false;
        v13.EmissionDirection = Enum.NormalId.Back;
        if v4 and v4.IsEditing then
            v13.Rate = 36;
            v13.Speed = NumberRange.new(15);
            v13.Enabled = true;
        end;
        v13.Parent = v11;
    end;
end;