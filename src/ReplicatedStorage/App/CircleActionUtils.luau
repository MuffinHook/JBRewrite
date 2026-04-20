return {
    setDist = function(arg1, arg2) -- Line 2, Named "setDist"
        local children_4 = arg1:IsA("Model")
        if not children_4 then
            children_4 = arg1:IsA("BasePart")
        end
        assert(children_4)
        assert(arg1:HasTag("CircleAction"))
        arg1:SetAttribute("CircleActionDist", arg2)
    end;
    setDuration = function(arg1, arg2) -- Line 7, Named "setDuration"
        local children_3 = arg1:IsA("Model")
        if not children_3 then
            children_3 = arg1:IsA("BasePart")
        end
        assert(children_3)
        assert(arg1:HasTag("CircleAction"))
        arg1:SetAttribute("CircleActionDuration", arg2)
    end;
    setText = function(arg1, arg2) -- Line 12, Named "setText"
        local children_2 = arg1:IsA("Model")
        if not children_2 then
            children_2 = arg1:IsA("BasePart")
        end
        assert(children_2)
        assert(arg1:HasTag("CircleAction"))
        arg1:SetAttribute("CircleActionText", arg2)
    end;
    setDisabled = function(arg1, arg2) -- Line 17, Named "setDisabled"
        local children_5 = arg1:IsA("Model")
        if not children_5 then
            children_5 = arg1:IsA("BasePart")
        end
        assert(children_5)
        assert(arg1:HasTag("CircleAction"))
        arg1:SetAttribute("CircleActionDisabled", arg2)
    end;
    getDisabled = function(arg1) -- Line 22, Named "getDisabled"
        local children_6 = arg1:IsA("Model")
        if not children_6 then
            children_6 = arg1:IsA("BasePart")
        end
        assert(children_6)
        local assert = assert
        assert(arg1:HasTag("CircleAction"))
        if arg1:GetAttribute("CircleActionDisabled") ~= true then
            assert = false
        else
            assert = true
        end
        return assert
    end;
    getTagPart = function(arg1) -- Line 27, Named "getTagPart"
        local children = arg1:IsA("Model")
        if not children then
            children = arg1:IsA("BasePart")
        end
        assert(children)
        assert(arg1:HasTag("CircleAction"))
        if arg1:IsA("Model") then
            return arg1.PrimaryPart
        end
        assert(arg1:IsA("BasePart"))
        return arg1
    end;
}