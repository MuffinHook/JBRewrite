local ReplicatedStorage = game:GetService("ReplicatedStorage")
return require(ReplicatedStorage.Std.Binder).new("Contract", require(script.Parent.Contract))