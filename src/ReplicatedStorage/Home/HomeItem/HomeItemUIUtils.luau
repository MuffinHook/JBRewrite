local module = {
    getUpdateCamera = function() -- Line 4, Named "getUpdateCamera"
        local var3_upvw
        local var4_upvw
        local cframe_upvw = CFrame.Angles(0, 0, 0)
        return function(arg1, arg2) -- Line 8
            if not arg2 then
            else
                if arg2 ~= var3_upvw then
                    local any_GetBoundingBox_result1, any_GetBoundingBox_result2 = arg2:GetBoundingBox()
                    _ = any_GetBoundingBox_result1 -- Setting global
                    var4_upvw = any_GetBoundingBox_result2
                    var3_upvw = arg2
                    local UpDot = var3_upvw:FindFirstChild("UpDot")
                    if UpDot then
                        any_GetBoundingBox_result2 = UpDot.Value
                        local var13 = any_GetBoundingBox_result2
                        if var13 ~= 1 then
                            if UpDot.Value == 0 then
                                var13 = CFrame.Angles((math.pi/2), 0, (math.pi/2))
                            else
                                var13 = CFrame.Angles(0, 0, math.pi)
                            end
                            cframe_upvw = var13
                        end
                    end
                end
                local os_clock_result1 = os.clock()
                arg1.CFrame = CFrame.new(0, 0, 0) * cframe_upvw * CFrame.Angles(0, os_clock_result1 % (-math.pi*2), 0) * CFrame.Angles(math.sin(os_clock_result1 * 0.5) * 0.3 - 0.4, 0, 0) * CFrame.new(0, 0, var4_upvw.Magnitude * 0.8)
            end
        end
    end;
}
local ReplicatedStorage_upvr = game:GetService("ReplicatedStorage")
function module.getModel(arg1) -- Line 32
    local SOME = ReplicatedStorage_upvr.Resource.HomeItem:FindFirstChild(arg1)
    if not SOME then
        error("No HomeItem exists by name: "..arg1)
    end
    local clone = SOME:Clone()
    for _, v in clone:GetDescendants() do
        if v:IsA("LuaSourceContainer") then
            v:Destroy()
        end
    end
    clone:SetPrimaryPartCFrame(clone.PrimaryPart.CFrame:ToObjectSpace(clone:GetBoundingBox()):Inverse())
    return clone
end
return module