local RateLimiter = {}
RateLimiter.__index = RateLimiter
RateLimiter.__ClassName = "RateLimiter"
function RateLimiter.new(budgetPerWindow, budgetWindowDuration)
	assert(budgetPerWindow ~= nil, "missing budgetPerWindow limit")
	local instance = {}
	setmetatable(instance, RateLimiter)
	instance._lastUpdate = os.clock()
	instance._budgetPerWindow = budgetPerWindow
	instance._budgetWindowDuration = budgetWindowDuration or 1
	instance._data = {}
	return instance
end
function RateLimiter.CanUseBudget(self, key, amount)
	assert(key ~= nil, "missing key")
	self:Update()
	return if self._data[key] then self._data[key].amount else 0 + (amount or 1) <= self._budgetPerWindow
end
function RateLimiter.UseBudget(self, key, amount, force)
	local budgetAmount = amount or 1
	assert(budgetAmount)
	assert(key ~= nil, "missing key")
	if force or self:CanUseBudget(key, budgetAmount) then
		local budgetEntry = self._data[key]
		if not budgetEntry then
			local newEntry = {
				amount = 0,
				lastUpdate = os.clock()
			}
			self._data[key] = newEntry
			budgetEntry = newEntry
		end
		budgetEntry.amount = budgetEntry.amount + budgetAmount
		return true
	else
		return false
	end
end
RateLimiter.Increment = RateLimiter.UseBudget
function RateLimiter.Update(self)
	local currentTime = os.clock()
	for key, budgetEntry in self._data do
		if currentTime - budgetEntry.lastUpdate >= self._budgetWindowDuration then
			budgetEntry.amount = budgetEntry.amount - self._budgetPerWindow
			if budgetEntry.amount <= 0 then
				self._data[key] = nil
			end
			budgetEntry.lastUpdate = currentTime
		end
	end
end
function RateLimiter.Destroy(self)
	table.clear(self._data)
	setmetatable(self, nil)
end
return RateLimiter
