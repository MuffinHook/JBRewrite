-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMnCURhbWFnZUZ1bgRnYW1lEVJlcGxpY2F0ZWRTdG9yYWdlCkdldFNlcnZpY2UHcmVxdWlyZQ9HdW5TeXN0ZW1Db25zdHMER2FtZQpJdGVtU3lzdGVtCFJlc291cmNlCFNldHRpbmdzA0hpcAVTY29wZQ9SaWdodEVsYm93QW5nbGUSUmlnaHRXcmlzdFJvdGF0aW9uB1NwcmluZ3MKSXRlbU9mZnNldAxJdGVtUm90YXRpb24MTmVja1JvdGF0aW9uB1ZlY3RvcjMDbmV3BkNGcmFtZQZNb3Rpb24PZmxpbnRsb2NrX3Nob290FWZsaW50bG9ja19yZWxvYWRfb3BlbhZmbGludGxvY2tfcmVsb2FkX2Nsb3NlEGZsaW50bG9ja19oYW1tZXIFU291bmQHTWFnU2l6ZRFDYW1TaGFrZU1hZ25pdHVkZQtCdWxsZXRTcGVlZA5GaXJlQXV0b01vYmlsZQhGaXJlQXV0bwhGaXJlRnJlcQpSZWxvYWRUaW1lBVByaWNlBkltYWdlcwlGbGludGxvY2sHSW1hZ2VJZAlFcXVpcFRpbWUAAgYBAAAAABGMARQAfQADAAEAAACMASgAggECAIwBZAB9AQMAAAAAAIwBFACCAQIAeAIAAT4BAgCMAygAjAXs/wkEBQFDAgMEggICAAICAAAAAAAAVEACAAAAAAAANEAAKAEBGAAAAAEAAQAAAQACAAEAAAAALQAAAAAIAAABAgB8owAAAKQAAQAAAABAbwICALwAABYDAAAAnwADAqQBBQAAAEBATQMAvQcAAABNAwPwCAAAAE0CA0kGAAAAnwECAqQCBQAAAEBATQMAYgkAAABNAwPKCgAAAJ8CAgL/AwUAAAAAAOIEDwDiBREA4gYVAG8HFgAwBwaAEgAAAG8HFwAwBwblEwAAAEw2AAKkBxoAAGSAgZ8HAQIwBwaNFAAAADAGBZgQAAAAMAUEvQsAAADiBREA4gYVAG8HGwAwBwaAEgAAAG8HHAAwBwblEwAAAEw2AAKkBxoAAGSAgZ8HAQIwBwaNFAAAADAGBZgQAAAAMAUE9AwAAACMBQAAMAUEoA0AAACkBR4AAGTQgZ8FAQIwBQQODgAAADAEA5cfAAAA4gQkAG8FJQAwBQT6IAAAAG8FJgAwBQSZIQAAAG8FJwAwBQQ8IgAAAG8FKAAwBQSoIwAAADAEA24pAAAAjAQBADAEA/cqAAAAjASWADAEA6MrAAAAjASEAzAEA6UsAAAAqQQBADAEAz0tAAAAqQQAADAEA00uAAAAjAQEADAEA0AvAAAAjAQEADAEA7wwAAAAwAQxADAEA3IyAAAAjAQQJzAEAyQzAAAATQQC4zQAAABNBARPNQAAADAEA5Y2AAAAbwQ3ADAEA9c4AAAAggMCADkDAgQAAABAAwMDBAMFBAAAQEADBgMHAwgDCQMKAwsDDAMNAw4FBAsMDQ4DDwUBEAMQAxEDEgUDEhMUBwAAgD8zM7M/AAAAwAAAAAAHAAAAAM3MzL0AAAAAAAAAAAMTAxQEAGSAgQcAAIA/MzOzP83MLMAAAAAAB83MTD7NzMy+AAAAAAAAAAADFQQAZNCBAxYDFwMYAxkDGgUEICEiIwIAABiWuAQPQgIAAFCXZOPxQQIAAJCtZOPxQQIAAFC7ZOPxQQMbAxwDHQMeAx8DIAMhAyIGAAMBAyMDJAMlAyYCAAAAAAAA4D8DJwEAAQABGAAAAAAAAAABAAAAAAAAAAABAAAAAAAAAgABAQEBAAABAAABAAAAAAD9AP8ABwEBAAABAAABAAAAAAD9AP8ACAAAAgAAAADuABQBAAABAAABAAABAAD8AAYAAAEAAAEAAAEAAAEAAAEAAAEAAAIAAA4AAAEAAAAAAAEAAAIBAAAAAAGdQvgCNkBRfn9xrZEiSb0j7Vrvdq+GkgM=

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:37:43
-- Luau version 6, Types version 3
-- Time taken: 0.001880 seconds

local module = {
    Motion = {
        Hip = {
            Springs = {
                ItemOffset = Vector3.new(1, 1.39999, -2);
                ItemRotation = Vector3.new(0, -0.1000, 0);
                NeckRotation = Vector3.new();
            };
        };
        Scope = {
            Springs = {
                ItemOffset = Vector3.new(1, 1.39999, -2.7000);
                ItemRotation = Vector3.new(0.20000, -0.4000, 0);
                NeckRotation = Vector3.new();
            };
        };
        RightElbowAngle = 0;
        RightWristRotation = CFrame.new();
    };
    Sound = {
        flintlock_shoot = 16652899011;
        flintlock_reload_open = 4801841525;
        flintlock_reload_close = 4801841881;
        flintlock_hammer = 4801842101;
    };
    MagSize = 1;
    CamShakeMagnitude = 150;
    BulletSpeed = 900;
    FireAutoMobile = true;
    FireAuto = false;
    FireFreq = 4;
    ReloadTime = 4;
}
function module.DamageFun(arg1) -- Line 40
    if arg1 <= 20 then
        return 40
    end
    if 100 <= arg1 then
        return 20
    end
    return 40 + (-20) * ((arg1 - 20) / 80)
end
module.Price = 10000
module.ImageId = require(game:GetService("ReplicatedStorage").Resource.Settings).Images.Flintlock
module.EquipTime = 0.5
return module