local DoorConsts = require(script.Parent.DoorConsts)
return require(game:GetService("ReplicatedStorage").ManifestBinder).new(DoorConsts.TAG_NAME, {
    innerModel = DoorConsts.INNER_MODEL_NAME;
}, require(script.Parent.Door))