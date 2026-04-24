-- Reviewed by Claude
-- variables reassigned
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Maid = require(script.Parent.Maid)
local PlayerUtils = require(script.Parent.PlayerUtils)
local t = {
	getHumanoid = function(p1)
		if p1 then
			return p1:FindFirstChild("Humanoid")
		else
			return nil
		end
	end,
	getRootPart = function(p1)
		if p1 then
			return p1.PrimaryPart
		else
			return nil
		end
	end,
	setEnabled = function(p1, p2)
		if p1 then
			local Humanoid = p1:FindFirstChild("Humanoid")
			if Humanoid then
				for i, v in ipairs(Enum.HumanoidStateType:GetEnumItems()) do
					if v ~= Enum.HumanoidStateType.Dead and (v ~= Enum.HumanoidStateType.None and v ~= Enum.HumanoidStateType.Jumping) then
						Humanoid:SetStateEnabled(v, p2)
					end
				end
				Humanoid:ChangeState(Enum.HumanoidStateType.PlatformStanding)
			end
		end
	end,
	setMassless = function(p1, p2)
		for i, v in ipairs(p1:GetDescendants()) do
			if v:IsA("BasePart") then
				local oldMassless = v:FindFirstChild("oldMassless")
				if p2 then
					if not oldMassless and v.Massless then
						local oldMassless_2 = Instance.new("BoolValue")
						oldMassless_2.Name = "oldMassless"
						oldMassless_2.Parent = v
						oldMassless_2.Value = v.Massless
					end
					v.Massless = true
				elseif oldMassless then
					v.Massless = oldMassless.Value
					oldMassless:Destroy()
				else
					v.Massless = false
				end
			end
		end
	end,
	_setValue = function(p1, p2, p3)
		local count = 0
		repeat
			count = count + 1
		until not p1:FindFirstChild(("_stack_value_%d"):format(count))
		local v1 = Instance.new("NumberValue")
		v1.Name = ("_stack_value_%d"):format(count)
		v1.Value = p1[p2]
		v1.Parent = p1
		p1[p2] = p3
	end,
	_popValue = function(p1, p2)
		local count = 0
		repeat
			count = count + 1
		until not p1:FindFirstChild(("_stack_value_%d"):format(count))
		local v1 = count - 1
		if not (v1 <= 0) then
			local v2 = p1:FindFirstChild(("_stack_value_%d"):format(v1))
			assert(v2 ~= nil)
			p1[p2] = v2.Value
			v2:Destroy()
		end
	end
}
function t.setInvisible(p1, p2)
	if p1 then
		for v1, v2 in p1:GetDescendants() do
			if v2:IsA("BasePart") and (v2 ~= p1.PrimaryPart and (not p2 or p2(v2))) then
				t._setValue(v2, "Transparency", 1)
			end
		end
		local Head = p1:FindFirstChild("Head")
		if Head then
			local Decal = Head:FindFirstChildOfClass("Decal")
			if Decal then
				t._setValue(Decal, "Transparency", 1)
			end
		end
	end
end
function t.popInvisible(p1, p2)
	if p1 then
		for v1, v2 in p1:GetDescendants() do
			if v2:IsA("BasePart") and (v2 ~= p1.PrimaryPart and (not p2 or p2(v2))) then
				t._popValue(v2, "Transparency")
			end
		end
		local Head = p1:FindFirstChild("Head")
		if Head then
			local Decal = Head:FindFirstChildOfClass("Decal")
			if Decal then
				t._popValue(Decal, "Transparency")
			end
		end
	end
end
function t.setScale(p1, p2)
	local Humanoid = p1:FindFirstChild("Humanoid")
	local HeadScale = Humanoid:FindFirstChild("HeadScale")
	t._setValue(HeadScale, "Value", p2)
	local BodyDepthScale = Humanoid:FindFirstChild("BodyDepthScale")
	t._setValue(BodyDepthScale, "Value", p2)
	local BodyWidthScale = Humanoid:FindFirstChild("BodyWidthScale")
	t._setValue(BodyWidthScale, "Value", p2)
	local BodyHeightScale = Humanoid:FindFirstChild("BodyHeightScale")
	t._setValue(BodyHeightScale, "Value", p2)
end
function t.popScale(p1)
	local Humanoid = p1:FindFirstChild("Humanoid")
	local HeadScale = Humanoid:FindFirstChild("HeadScale")
	t._popValue(HeadScale, "Value")
	local BodyDepthScale = Humanoid:FindFirstChild("BodyDepthScale")
	t._popValue(BodyDepthScale, "Value")
	local BodyWidthScale = Humanoid:FindFirstChild("BodyWidthScale")
	t._popValue(BodyWidthScale, "Value")
	local BodyHeightScale = Humanoid:FindFirstChild("BodyHeightScale")
	t._popValue(BodyHeightScale, "Value")
end
function t.getAncestorPartHumanoid(p1)
	if p1 and p1.Parent then
		assert(p1)
		local v1 = p1.Parent
		while true do
			local Humanoid = v1:FindFirstChild("Humanoid")
			if Humanoid then
				return Humanoid
			end
			v1 = v1.Parent
			local _ = not v1 or v1 == workspace
		end
	end
end
function t.getRootAttachment(p1)
	assert(p1)
	local RootAttachment = p1:FindFirstChild("RootAttachment")
	if not RootAttachment then
		local RootAttachment_2 = Instance.new("Attachment")
		RootAttachment_2.Name = "RootAttachment"
		RootAttachment_2.Parent = p1
		RootAttachment = RootAttachment_2
	end
	RootAttachment.CFrame = CFrame.new()
	return RootAttachment
end
local function _observeOnPlayerAdded(p1, p2, p3)
	local function onCharacterAdded(p1)
		local v1 = Maid.new()
		p2._characterMaid = v1
		local Humanoid = p1:WaitForChild("Humanoid", 1)
		assert(Humanoid)
		if Players:GetPlayerFromCharacter(p1) then
			v1:GiveTask(p1.Destroying:Connect(function()
				task.defer(v1.DoCleaning, v1)
			end))
			task.spawn(p3, p1, v1, p2)
		end
	end
	if p1.Character then
		task.spawn(onCharacterAdded, p1.Character)
	end
	local function onCharacterRemoving(p1)
		p2._characterMaid = nil
	end
	p2:GiveTask(p1.CharacterAdded:Connect(onCharacterAdded))
	p2:GiveTask(p1.CharacterRemoving:Connect(onCharacterRemoving))
end
function t.observeCharacterAdded(p1)
	local v1 = Maid.new()
	v1:GiveTask(PlayerUtils.observePlayerAdded(function(p12, p2)
		_observeOnPlayerAdded(p12, p2, p1)
	end))
	return v1
end
function t.observeLocalCharacterAdded(p1)
	assert(RunService:IsClient(), "observeLocalCharacterAdded must be called on the client")
	local v2 = Maid.new()
	_observeOnPlayerAdded(Players.LocalPlayer, v2, p1)
	return v2
end
return t
