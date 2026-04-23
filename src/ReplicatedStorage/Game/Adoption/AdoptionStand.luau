local LocalPlayer = game:GetService("Players").LocalPlayer
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Maid = require(ReplicatedStorage.Std.Maid)
local Interval = require(ReplicatedStorage.Std.Interval)
local PlayerUtils = require(ReplicatedStorage.Game.PlayerUtils)
local DogConsts = require(ReplicatedStorage.Game.Dog.DogConsts)
local CircleAction = require(ReplicatedStorage.Module.UI).CircleAction
local AdoptionStandUI = require(script.Parent.AdoptionStandUI)
local AdoptionSystem = require(script.Parent.AdoptionSystem)
local AdoptionStandConsts = require(script.Parent.AdoptionStandConsts)
local t = {}
t.__index = t
t.__ClassName = "AdoptionStand"
function t.new(p1) --[[ Line: 18 | Upvalues: t (copy), Maid (copy), AdoptionStandConsts (copy), Interval (copy), PlayerUtils (copy), LocalPlayer (copy), AdoptionStandUI (copy), AdoptionSystem (copy), DogConsts (copy), CircleAction (copy) ]]
	local t2 = {}
	setmetatable(t2, t)
	t2._maid = Maid.new()
	t2._breedIdValue = p1:WaitForChild(AdoptionStandConsts.BREED_ID_VALUE_NAME)
	t2._adoptRemote = p1:WaitForChild(AdoptionStandConsts.ADOPT_REMOTE_NAME)
	local t3 = {
		Part = p1,
		Timed = false,
		Dist = 8,
		Callback = function(p12, p2) --[[ Name: action | Line: 26 | Upvalues: t2 (copy), Interval (ref), PlayerUtils (ref), LocalPlayer (ref), p1 (copy), AdoptionStandUI (ref), AdoptionSystem (ref), DogConsts (ref) ]]
			if p2 then
				local v1 = t2:GetBreedId()
				t2._maid.walkAwayLoop = Interval.every(1):Connect(function() --[[ Line: 29 | Upvalues: PlayerUtils (ref), LocalPlayer (ref), p1 (ref), AdoptionStandUI (ref) ]]
					local v1 = PlayerUtils.getRootPart(LocalPlayer)
					if v1 and ((v1.Position - p1.Position).Magnitude > 16 and AdoptionStandUI.isOpen()) then
						AdoptionStandUI.close()
					end
				end)
				t2._maid.onClickAdopt = AdoptionStandUI.getOnClickAdoptSignal():Connect(function() --[[ Line: 40 | Upvalues: AdoptionStandUI (ref), t2 (ref) ]]
					t2._adoptRemote:FireServer((AdoptionStandUI.getName()))
					AdoptionStandUI.close()
				end)
				t2._maid.onClosed = AdoptionStandUI.getOnClosedSignal():Connect(function() --[[ Line: 45 | Upvalues: t2 (ref) ]]
					t2._maid.walkAwayLoop = nil
					t2._maid.onClosed = nil
					t2._maid.onClickAdopt = nil
				end)
				local v2 = AdoptionSystem.doesOwn(v1)
				local v3 = if v2 then nil else DogConsts.PRICE[v1]
				AdoptionStandUI.setName(AdoptionSystem.getDogName(v1) or "")
				AdoptionStandUI.setTitle(DogConsts.TITLE[v1]:upper())
				AdoptionStandUI.setImageId(DogConsts.IMAGE_ID[v1])
				AdoptionStandUI.setDescriptionTeam(DogConsts.OPT_TEAM[v1])
				AdoptionStandUI.setPrice(v3)
				AdoptionStandUI.setFirstAdopt(not v2)
				AdoptionStandUI.open()
				return true
			end
		end,
		PreUpdateFun = function(p1) --[[ Name: preUpdateFun | Line: 65 | Upvalues: AdoptionStandUI (ref) ]]
			p1.Enabled = not AdoptionStandUI.isOpen()
		end,
		PreUpdatePeriod = 0.5
	}
	CircleAction.Add(t3, p1)
	t2._maid:GiveTask(function() --[[ Line: 77 | Upvalues: CircleAction (ref), p1 (copy) ]]
		CircleAction.Remove(p1)
	end)
	local function updateSpec() --[[ Line: 81 | Upvalues: t2 (copy), t3 (copy), DogConsts (ref) ]]
		t3.Name = ("Adopt %s"):format(DogConsts.TITLE[t2:GetBreedId()])
	end
	t2._maid:GiveTask(t2._breedIdValue.Changed:Connect(updateSpec))
	t3.Name = ("Adopt %s"):format(DogConsts.TITLE[t2:GetBreedId()])
	return t2
end
function t.GetBreedId(p1) --[[ Line: 90 ]]
	return p1._breedIdValue.Value
end
function t.Destroy(p1) --[[ Line: 93 ]]
	local _maid = p1._maid
	assert(_maid ~= nil)
	p1._maid = nil
	_maid:Destroy()
end
return t