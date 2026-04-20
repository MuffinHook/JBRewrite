local ReplicatedStorage_upvr = game:GetService("ReplicatedStorage")
local module_upvr = {
    Bounties = {};
    onBountiesUpdated = require(ReplicatedStorage_upvr.Std.Signal).new();
}
local BountyData_upvr = ReplicatedStorage_upvr:FindFirstChild("BountyData")
function module_upvr.init() -- Line 18
    module_upvr.updateBounties()
    BountyData_upvr:GetPropertyChangedSignal("Value"):Connect(module_upvr.updateBounties)
end
local function _(arg1) -- Line 23, Named "thumbnailBust"
    return "rbxthumb://type=AvatarHeadShot&id=%d&w=420&h=420":format(arg1)
end
local function _(arg1) -- Line 26, Named "comma"
    local string_match_result1, string_match_result2, string_match_result3 = string.match(arg1, "^([^%d]*%d)(%d*)(.-)$")
    return string_match_result1..string_match_result2:reverse():gsub("(%d%d%d)", "%1,"):reverse()..string_match_result3
end
local function clearFrame_upvr(arg1) -- Line 30, Named "clearFrame"
    for _, v in arg1:GetChildren() do
        if v:IsA("Frame") then
            v:Destroy()
        end
    end
end
local Players_upvr = game:GetService("Players")
function module_upvr.updateGui(arg1, arg2) -- Line 38
    local any_IsDescendantOf_result1 = arg1:IsDescendantOf(Players_upvr)
    local var16
    if any_IsDescendantOf_result1 then
        var16 = 6
    else
        var16 = 4
    end
    clearFrame_upvr(arg1)
    for i_2 = 1, var16 do
        local clone = ReplicatedStorage_upvr.Bounty.Res.PlayerFrame:Clone()
        clone.Visible = true
        clone.LayoutOrder = i_2
        if any_IsDescendantOf_result1 then
            clone.Size = UDim2.new(0.28, 0, 0.5, 0)
            clone.BountyText.TextScaled = true
        end
        local var18 = arg2[i_2]
        if var18 then
            clone.NameText.Text = Players_upvr:GetPlayerByUserId(var18.UserId).DisplayName
            local string_match_result1_2, string_match_result2_2, string_match_result3_2 = string.match(var18.Bounty, "^([^%d]*%d)(%d*)(.-)$")
            clone.BountyText.Text = '$'..string_match_result1_2..string_match_result2_2:reverse():gsub("(%d%d%d)", "%1,"):reverse()..string_match_result3_2
            clone.ImageLabel.Image = "rbxthumb://type=AvatarHeadShot&id=%d&w=420&h=420":format(var18.UserId)
        else
            clone:ClearAllChildren()
            clone.BackgroundTransparency = 1
        end
        clone.Parent = arg1
    end
end
function module_upvr.getTopBounties(arg1) -- Line 70
    local module = {}
    for _, v_2 in module_upvr.Bounties do
        if arg1 <= #module then break end
        table.insert(module, v_2)
    end
    return module
end
local HttpService_upvr = game:GetService("HttpService")
local CollectionService_upvr = game:GetService("CollectionService")
local BountyConsts_upvr = require(ReplicatedStorage_upvr.Bounty.BountyConsts)
function module_upvr.updateBounties() -- Line 81
    table.clear(module_upvr.Bounties)
    module_upvr.Bounties = HttpService_upvr:JSONDecode(BountyData_upvr.Value)
    module_upvr.onBountiesUpdated:Fire(module_upvr.Bounties)
    for _, v_3 in CollectionService_upvr:GetTagged(BountyConsts_upvr.BOARD_LIST_TAG_NAME) do
        module_upvr.updateGui(v_3, module_upvr.getTopBounties(4))
    end
end
return module_upvr