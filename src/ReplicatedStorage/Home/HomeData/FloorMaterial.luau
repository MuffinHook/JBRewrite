local module = {
    getInstance = function(arg1) -- Line 3, Named "getInstance"
        local Part = Instance.new("Part")
        Part.Shape = Enum.PartType.Ball
        Part.Size = Vector3.new(4, 4, 4)
        Part.TopSurface = 0
        Part.BottomSurface = 0
        Part.Color = Color3.new(1, 1, 1)
        if arg1.Material then
            Part.Material = arg1.Material
        else
            Part.Material = Enum.Material.SmoothPlastic
        end
        if arg1.MaterialVariant then
            Part.MaterialVariant = arg1.MaterialVariant
        else
            Part.MaterialVariant = ""
        end
        Part.Anchored = true
        Part.CFrame = CFrame.new()
        return Part
    end;
    updateCamera = function(arg1, arg2) -- Line 24, Named "updateCamera"
        local var3 = os.clock() / 2
        arg1.CFrame = CFrame.Angles(0, var3 % (-math.pi*2), 0) * CFrame.Angles(math.sin(var3) * 0.25 - 0.3, 0, 0) * CFrame.new(0, 0, 8)
    end;
}
local module_upvr = {{
    Name = "Smooth";
    None = true;
    Price = 0;
}, {
    Name = "Stone";
    Material = Enum.Material.Cobblestone;
    Price = 25000;
}, {
    Name = "Raw Planks";
    Material = Enum.Material.WoodPlanks;
    Price = 25000;
}, {
    Name = "Oak Planks";
    Material = Enum.Material.WoodPlanks;
    MaterialVariant = "Interior_OakPlank";
    Price = 50000;
}, {
    Name = "Modern Carpet";
    Material = Enum.Material.Fabric;
    MaterialVariant = "Interior_ModernCarpet";
    Price = 50000;
}, {
    Name = "Heavy Tile";
    Material = Enum.Material.SmoothPlastic;
    MaterialVariant = "Interior_IndustrialTile";
    Price = 50000;
}, {
    Name = "Concrete";
    Material = Enum.Material.Concrete;
    Price = 30000;
}}
function module.getItems() -- Line 70
    return module_upvr
end
function module.apply(arg1, arg2) -- Line 73
    -- Decomp Logic Error: Konstant variable analysis failed; temporary assignments in this block were preserved for review.
    local FlooringMaterial = arg2:FindFirstChild("FlooringMaterial")
    local var21
    if not FlooringMaterial then
        var21 = warn
        var21("Missing subModel")
    else
        var21 = 0
        for _, v in FlooringMaterial:GetChildren() do
            local var25
            if var25 then
                var21 += 1
                var25 = arg1
                if var25 then
                    var25 = arg1.Material
                end
                if var25 then
                    v.Material = var25
                else
                    local OriginalMaterial = v:GetAttribute("OriginalMaterial")
                    if not OriginalMaterial then
                        OriginalMaterial = Enum.Material.SmoothPlastic
                    end
                    v.Material = OriginalMaterial
                end
                if arg1 and arg1.MaterialVariant then
                    assert(var25, "MaterialVariant requires Material")
                    v.MaterialVariant = arg1.MaterialVariant
                else
                    v.MaterialVariant = v:GetAttribute("OriginalMaterialVariant") or ""
                end
            end
        end
        if 0 >= var21 then
        else
        end
        assert(true, "No parts to apply to")
    end
end
return module