local ReplicatedStorage_upvr = game:GetService("ReplicatedStorage")
local var2_upvw
local module_upvr = {}
local LocalPlayer_upvr = game:GetService("Players").LocalPlayer
function module_upvr.init() -- Line 9
    local tbl = {}
    for i, v in pairs(require(script.Parent.DogConsts).ANIM_ID) do
        tbl[i] = {}
        for i_2, v_2 in pairs(v) do
            local Animation = Instance.new("Animation")
            Animation.AnimationId = string.format("rbxassetid://%d", v_2)
            tbl[i][i_2] = Animation
        end
    end
    module_upvr._mapAnimInst = tbl
    var2_upvw = require(script.Parent.DogBinder)
    var2_upvw:Start()
    LocalPlayer_upvr.CharacterAdded:Connect(function(arg1) -- Line 28, Named "setupCharacter"
        module_upvr._petTrack = arg1:WaitForChild("Humanoid"):LoadAnimation(ReplicatedStorage_upvr.Resource.Dog.Anim.Pet)
    end)
    if LocalPlayer_upvr.Character then
        module_upvr._petTrack = LocalPlayer_upvr.Character:WaitForChild("Humanoid"):LoadAnimation(ReplicatedStorage_upvr.Resource.Dog.Anim.Pet)
    end
end
function module_upvr.getAnimInsts(arg1) -- Line 37
    return module_upvr._mapAnimInst[arg1]
end
function module_upvr.getAll() -- Line 40
    return var2_upvw:GetAll()
end
function module_upvr.getPetTrack() -- Line 43
    return module_upvr._petTrack
end
return module_upvr