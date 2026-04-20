local function addLabel_upvr(arg1, arg2) -- Line 5, Named "addLabel"
    assert(arg2.title, "minimap label missing unique title")
    table.insert(arg1, {
        title = arg2.title;
        imageId = arg2.imageId;
        position = arg2.position;
        updatePosition = arg2.updatePosition;
        adornee = arg2.adornee;
        markerColor = arg2.markerColor;
        updateMarkerColor = arg2.updateMarkerColor;
        scale = arg2.scale;
    })
end
return require(game:GetService("ReplicatedStorage").Rodux).createReducer({}, {
    addMinimapLabel = function(arg1, arg2) -- Line 19, Named "addMinimapLabel"
        assert(arg2.title, "minimap label missing unique title")
        local module = {}
        for _, v in ipairs(arg1) do
            if v.title ~= arg2.title then
                table.insert(module, v)
            end
        end
        addLabel_upvr(module, arg2)
        return module
    end;
    addMinimapLabels = function(arg1, arg2) -- Line 30, Named "addMinimapLabels"
        assert(arg2.labels, "missing labels")
        local clone = table.clone(arg1)
        for _, v_2 in ipairs(arg2.labels) do
            addLabel_upvr(clone, v_2)
        end
        return clone
    end;
    removeMinimapLabel = function(arg1, arg2) -- Line 38, Named "removeMinimapLabel"
        assert(arg2.title, "minimap label missing unique title")
        for _, v_3 in ipairs(arg1) do
            if v_3.title ~= arg2.title then
                table.insert({}, v_3)
            end
        end
        -- Decomp Logic Error: Konstant reused an expression here; surrounding logic was preserved for review.
        return {}
    end;
})