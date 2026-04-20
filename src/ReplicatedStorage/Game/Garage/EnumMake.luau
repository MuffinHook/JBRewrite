local module = {}
for i, v in ipairs(require(script.Parent.VehicleData)) do
    module[i] = v.Make
end
return require(game:GetService("ReplicatedStorage").Std.Enumer)(module)