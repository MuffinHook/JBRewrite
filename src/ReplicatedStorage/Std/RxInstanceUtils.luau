-- Reviewed by Claude
-- variables reassigned
local Promise = require(script.Parent.Promise)
local Maid = require(script.Parent.Maid)
local t = {
	waitForChild = require(script.Parent.waitForChild)
}
local function f1()
	return true
end
function t.waitForProperty(p1, p2, p3)
	if p3 == nil then
		p3 = f1
	end
	local v1 = p3
	return Promise.new(function(p12, p22, p3)
		if p1[p2] and v1(p1[p2]) then
			p12(p1[p2])
		else
			local v12 = nil
			v12 = p1:GetPropertyChangedSignal(p2):Connect(function()
				if p1[p2] and v1(p1[p2]) then
					v12:Disconnect()
					v12 = nil
					p12(p1[p2])
				end
			end)
			p3(function()
				v12:Disconnect()
				v12 = nil
			end)
		end
	end)
end
function t.observeProperty(p1, p2, p3)
	local v1 = Maid.new()
	v1._property = Maid.new()
	p3(p1[p2], v1._property)
	v1:GiveTask(p1:GetPropertyChangedSignal(p2):Connect(function()
		v1._property:DoCleaning()
		p3(p1[p2], v1._property)
	end))
	return v1
end
function t.observeAttribute(p1, p2, p3)
	local v1 = Maid.new()
	v1._property = Maid.new()
	p3(p1:GetAttribute(p2), v1._property)
	v1:GiveTask(p1:GetAttributeChangedSignal(p2):Connect(function()
		v1._property:DoCleaning()
		p3(p1:GetAttribute(p2), v1._property)
	end))
	return v1
end
function t.observeChildren(p1, p2)
	local v1 = Maid.new()
	local function handleChildAdded(p1)
		assert(v1[p1] == nil)
		local v2 = Maid.new()
		v1[p1] = v2
		p2(p1, v2)
	end
	for i, v in ipairs(p1:GetChildren()) do
		local v2
		v2 = v1[v] == nil
		assert(v2)
		local v3 = Maid.new()
		v1[v] = v3
		p2(v, v3)
	end
	v1:GiveTask(p1.ChildAdded:Connect(handleChildAdded))
	v1:GiveTask(p1.ChildRemoved:Connect(function(p1)
		v1[p1] = nil
	end))
	return v1
end
function t.observeChildrenNamed(p1, p2, p3)
	local v1 = Maid.new()
	local function handleChildAdded(p1)
		if p1.Name == p2 then
			assert(v1[p1] == nil)
			local v2 = Maid.new()
			v1[p1] = v2
			p3(p1, v2)
		end
	end
	for i, v in ipairs(p1:GetChildren()) do
		local v2
		if v.Name == p2 then
			v2 = v1[v] == nil
			assert(v2)
			local v3 = Maid.new()
			v1[v] = v3
			p3(v, v3)
		end
	end
	v1:GiveTask(p1.ChildAdded:Connect(handleChildAdded))
	v1:GiveTask(p1.ChildRemoved:Connect(function(p1)
		v1[p1] = nil
	end))
	return v1
end
function t.observeOneChildNamed(p1, p2, p3)
	local v1 = Maid.new()
	local function handleChildAdded(p1)
		assert(v1[p1] == nil)
		local v2 = Maid.new()
		v1[p1] = v2
		p3(p1, v2)
	end
	local v2 = nil
	local v3 = nil
	local function check()
		local v12 = p1:FindFirstChild(p2)
		if v12 then
			assert(v1[v12] == nil)
			local v32 = Maid.new()
			v1[v12] = v32
			p3(v12, v32)
			v3()
		else
			v2()
		end
	end
	v2 = function()
		v1.childAdded = p1.ChildAdded:Connect(function(p12)
			if p12.Name == p2 then
				v1.childAdded = nil
				local v12 = p1:FindFirstChild(p2)
				if v12 then
					assert(v1[v12] == nil)
					local v32 = Maid.new()
					v1[v12] = v32
					p3(v12, v32)
					v3()
					return
				end
				v2()
			end
		end)
	end
	v3 = function()
		v1.childRemoved = p1.ChildRemoved:Connect(function(p12)
			if v1[p12] then
				v1[p12] = nil
				v1.childRemoved = nil
				local v12 = p1:FindFirstChild(p2)
				if v12 then
					assert(v1[v12] == nil)
					local v32 = Maid.new()
					v1[v12] = v32
					p3(v12, v32)
					v3()
					return
				end
				v2()
			end
		end)
	end
	local v4 = p1:FindFirstChild(p2)
	if v4 then
		assert(v1[v4] == nil)
		local v6 = Maid.new()
		v1[v4] = v6
		p3(v4, v6)
		v3()
	else
		v2()
	end
	return v1
end
function t.observeDescendants(p1, p2)
	local v1 = Maid.new()
	local function handleDescendantAdded(p1)
		assert(v1[p1] == nil)
		local v2 = Maid.new()
		v1[p1] = v2
		p2(p1, v2)
	end
	for i, v in ipairs(p1:GetDescendants()) do
		local v2
		v2 = v1[v] == nil
		assert(v2)
		local v3 = Maid.new()
		v1[v] = v3
		p2(v, v3)
	end
	v1:GiveTask(p1.DescendantAdded:Connect(handleDescendantAdded))
	v1:GiveTask(p1.DescendantRemoving:Connect(function(p1)
		if v1[p1] then
			v1[p1] = nil
		end
	end))
	return v1
end
function t.waitForAttribute(p1, p2)
	return Promise.new(function(p12, p22, p3)
		local v1 = p1:GetAttribute(p2)
		if v1 == nil then
			local v2 = nil
			if not p3(function()
				if v2 then
					v2:Disconnect()
					v2 = nil
				end
			end) then
				v2 = p1:GetAttributeChangedSignal(p2):Connect(function()
					v1 = p1:GetAttribute(p2)
					if v1 ~= nil then
						p12(v1)
					end
				end)
			end
		else
			p12(v1)
			return
		end
	end)
end
function t.yieldForProperty(p1, p2)
	if not p1[p2] then
		local v1 = coroutine.running()
		local v2 = Maid.new()
		v2:GiveTask(p1:GetPropertyChangedSignal(p2):Connect(function()
			if p1[p2] then
				v2:DoCleaning()
				task.spawn(v1)
			end
		end))
		local v3 = debug.traceback("[yieldForProperty] Timeout on " .. p1:GetFullName() .. "." .. p2, 2)
		v2:GiveTask(task.delay(5, function()
			warn(v3)
			task.defer(v2.DoCleaning, v2)
		end))
		coroutine.yield()
	end
end
return t
