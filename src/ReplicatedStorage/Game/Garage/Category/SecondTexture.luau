local tbl_upvr = {
    Trailblazer = true;
    R8 = true;
    MoltenM12 = true;
    Ray9 = true;
    BeamHybrid = true;
    Concept = true;
    Celsior = true;
    JackRabbit = true;
    Sentinel = true;
    BananaCar = true;
    EscapeBot = true;
    Shogun = true;
    Poseidon = true;
    Stunt = true;
    Dirtbike = true;
    Sloop = true;
    Cruiser = true;
    Wedge = true;
    Blackbeard = true;
    OrionM42 = true;
    Polaire = true;
}
return function(arg1) -- Line 27
    if tbl_upvr[arg1.Make] then
        return false
    end
    local Model = arg1.Model
    if not Model then return end
    return Model:FindFirstChild("SecondBody", true)
end