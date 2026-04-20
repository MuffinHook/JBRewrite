
local RobberyMoneyUI = {}

RobberyMoneyUI.Formatter = {
	Money = function(value) return "$" .. tostring(value) end,
	Plain = function(value) return tostring(value) end,
}

local state = {
	visible = false,
	money = 0,
	maxMoney = 0,
	formatter = RobberyMoneyUI.Formatter.Money,
}
local upgradeButton

-- Decomp Error: RobberyMoneyUI failed decompilation; rebuilt a stateful compatibility facade for call sites.
function RobberyMoneyUI.Init() end
function RobberyMoneyUI.Show() state.visible = true end
function RobberyMoneyUI.Hide() state.visible = false end
function RobberyMoneyUI.SetMoney(money, maxMoney) state.money = money or 0; state.maxMoney = maxMoney or state.maxMoney end
function RobberyMoneyUI.SetFormatter(formatter) state.formatter = formatter or RobberyMoneyUI.Formatter.Money end
function RobberyMoneyUI.SetTime(timeLeft) state.timeLeft = timeLeft end
function RobberyMoneyUI.SetTier(tier, maxTier) state.tier = tier; state.maxTier = maxTier end
function RobberyMoneyUI.SetMessage(message) state.message = message end
function RobberyMoneyUI.SetRobbery(robbery) state.robbery = robbery end
function RobberyMoneyUI.GetState() return state end

function RobberyMoneyUI.getUpgradeButton()
	if not upgradeButton then
		upgradeButton = Instance.new("TextButton")
		upgradeButton.Name = "UpgradeButton"
		upgradeButton.Visible = false
	end
	return upgradeButton
end

return RobberyMoneyUI
