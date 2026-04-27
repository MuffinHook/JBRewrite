local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Maid = require(script.Parent.Maid)
local PlayerUtils = require(script.Parent.PlayerUtils)
local CharacterUtils = {
	getHumanoid = function(character)
		if character then
			return character:FindFirstChild("Humanoid")
		else
			return nil
		end
	end,
	getRootPart = function(character)
		if character then
			return character.PrimaryPart
		else
			return nil
		end
	end,
	setEnabled = function(character, isEnabled)
		if character then
			local Humanoid = character:FindFirstChild("Humanoid")
			if Humanoid then
				for i, stateType in ipairs(Enum.HumanoidStateType:GetEnumItems()) do
					if stateType ~= Enum.HumanoidStateType.Dead and (stateType ~= Enum.HumanoidStateType.None and stateType ~= Enum.HumanoidStateType.Jumping) then
						Humanoid:SetStateEnabled(stateType, isEnabled)
					end
				end
				Humanoid:ChangeState(Enum.HumanoidStateType.PlatformStanding)
			end
		end
	end,
	setMassless = function(character, shouldBeMassless)
		for i, descendant in ipairs(character:GetDescendants()) do
			if descendant:IsA("BasePart") then
				local oldMasslessValue = descendant:FindFirstChild("oldMassless")
				if shouldBeMassless then
					if not oldMasslessValue and descendant.Massless then
						local oldMasslessStorage = Instance.new("BoolValue")
						oldMasslessStorage.Name = "oldMassless"
						oldMasslessStorage.Parent = descendant
						oldMasslessStorage.Value = descendant.Massless
					end
					descendant.Massless = true
				elseif oldMasslessValue then
					descendant.Massless = oldMasslessValue.Value
					oldMasslessValue:Destroy()
				else
					descendant.Massless = false
				end
			end
		end
	end,
	_setValue = function(instance, propertyName, newValue)
		local count = 0
		repeat
			count = count + 1
		until not instance:FindFirstChild(("_stack_value_%d"):format(count))
		local stackValue = Instance.new("NumberValue")
		stackValue.Name = ("_stack_value_%d"):format(count)
		stackValue.Value = instance[propertyName]
		stackValue.Parent = instance
		instance[propertyName] = newValue
	end,
	_popValue = function(instance, propertyName)
		local count = 0
		repeat
			count = count + 1
		until not instance:FindFirstChild(("_stack_value_%d"):format(count))
		local previousStackIndex = count - 1
		if not (previousStackIndex <= 0) then
			local previousStackValue = instance:FindFirstChild(("_stack_value_%d"):format(previousStackIndex))
			assert(previousStackValue ~= nil)
			instance[propertyName] = previousStackValue.Value
			previousStackValue:Destroy()
		end
	end
}
function CharacterUtils.setInvisible(character, filterCallback)
	if character then
		for index, descendant in character:GetDescendants() do
			if descendant:IsA("BasePart") and (descendant ~= character.PrimaryPart and (not filterCallback or filterCallback(descendant))) then
				CharacterUtils._setValue(descendant, "Transparency", 1)
			end
		end
		local Head = character:FindFirstChild("Head")
		if Head then
			local Decal = Head:FindFirstChildOfClass("Decal")
			if Decal then
				CharacterUtils._setValue(Decal, "Transparency", 1)
			end
		end
	end
end
function CharacterUtils.popInvisible(character, filterCallback)
	if character then
		for index, descendant in character:GetDescendants() do
			if descendant:IsA("BasePart") and (descendant ~= character.PrimaryPart and (not filterCallback or filterCallback(descendant))) then
				CharacterUtils._popValue(descendant, "Transparency")
			end
		end
		local Head = character:FindFirstChild("Head")
		if Head then
			local Decal = Head:FindFirstChildOfClass("Decal")
			if Decal then
				CharacterUtils._popValue(Decal, "Transparency")
			end
		end
	end
end
function CharacterUtils.setScale(character, scaleFactor)
	local Humanoid = character:FindFirstChild("Humanoid")
	local HeadScale = Humanoid:FindFirstChild("HeadScale")
	CharacterUtils._setValue(HeadScale, "Value", scaleFactor)
	local BodyDepthScale = Humanoid:FindFirstChild("BodyDepthScale")
	CharacterUtils._setValue(BodyDepthScale, "Value", scaleFactor)
	local BodyWidthScale = Humanoid:FindFirstChild("BodyWidthScale")
	CharacterUtils._setValue(BodyWidthScale, "Value", scaleFactor)
	local BodyHeightScale = Humanoid:FindFirstChild("BodyHeightScale")
	CharacterUtils._setValue(BodyHeightScale, "Value", scaleFactor)
end
function CharacterUtils.popScale(character)
	local Humanoid = character:FindFirstChild("Humanoid")
	local HeadScale = Humanoid:FindFirstChild("HeadScale")
	CharacterUtils._popValue(HeadScale, "Value")
	local BodyDepthScale = Humanoid:FindFirstChild("BodyDepthScale")
	CharacterUtils._popValue(BodyDepthScale, "Value")
	local BodyWidthScale = Humanoid:FindFirstChild("BodyWidthScale")
	CharacterUtils._popValue(BodyWidthScale, "Value")
	local BodyHeightScale = Humanoid:FindFirstChild("BodyHeightScale")
	CharacterUtils._popValue(BodyHeightScale, "Value")
end
function CharacterUtils.getAncestorPartHumanoid(instance)
	if instance and instance.Parent then
		assert(instance)
		local currentAncestor = instance.Parent
		while true do
			local Humanoid = currentAncestor:FindFirstChild("Humanoid")
			if Humanoid then
				return Humanoid
			end
			currentAncestor = currentAncestor.Parent
			local _ = not currentAncestor or currentAncestor == workspace
		end
	end
end
function CharacterUtils.getRootAttachment(instance)
	assert(instance)
	local RootAttachment = instance:FindFirstChild("RootAttachment")
	if not RootAttachment then
		local newRootAttachment = Instance.new("Attachment")
		newRootAttachment.Name = "RootAttachment"
		newRootAttachment.Parent = instance
		RootAttachment = newRootAttachment
	end
	RootAttachment.CFrame = CFrame.new()
	return RootAttachment
end
local function _observeOnPlayerAdded(player, playerMaid, characterCallback)
	local function onCharacterAdded(character)
		local characterMaid = Maid.new()
		playerMaid._characterMaid = characterMaid
		local Humanoid = character:WaitForChild("Humanoid", 1)
		assert(Humanoid)
		if Players:GetPlayerFromCharacter(character) then
			characterMaid:GiveTask(character.Destroying:Connect(function()
				task.defer(characterMaid.DoCleaning, characterMaid)
			end))
			task.spawn(characterCallback, character, characterMaid, playerMaid)
		end
	end
	if player.Character then
		task.spawn(onCharacterAdded, player.Character)
	end
	local function onCharacterRemoving(character)
		playerMaid._characterMaid = nil
	end
	playerMaid:GiveTask(player.CharacterAdded:Connect(onCharacterAdded))
	playerMaid:GiveTask(player.CharacterRemoving:Connect(onCharacterRemoving))
end
function CharacterUtils.observeCharacterAdded(characterCallback)
	local observerMaid = Maid.new()
	observerMaid:GiveTask(PlayerUtils.observePlayerAdded(function(player, playerMaid)
		_observeOnPlayerAdded(player, playerMaid, characterCallback)
	end))
	return observerMaid
end
function CharacterUtils.observeLocalCharacterAdded(characterCallback)
	assert(RunService:IsClient(), "observeLocalCharacterAdded must be called on the client")
	local localPlayerMaid = Maid.new()
	_observeOnPlayerAdded(Players.LocalPlayer, localPlayerMaid, characterCallback)
	return localPlayerMaid
end
return CharacterUtils
