local Timeline = {}
Timeline.__index = Timeline
function Timeline.new(sequenceData)
	assert(sequenceData)
	local timeline = setmetatable({}, Timeline)
	timeline.Data = sequenceData
	timeline.Seqi = 1
	timeline.CumulativeSeqAge = 0
	sequenceData[1][1](0, 0)
	return timeline
end
function Timeline.Update(timeline, elapsedTime)
	local CumulativeSeqAge = timeline.CumulativeSeqAge
	local Data = timeline.Data
	local Seqi = timeline.Seqi
	if #Data < Seqi then
		return true
	end
	for i = Seqi, #Data do
		local currentSequence = Data[i]
		if elapsedTime < CumulativeSeqAge then
			break
		end
		if Seqi < i then
			Data[i - 1][1](1, Data[i - 1][2])
			currentSequence[1](0, 0)
			timeline.Seqi = i
			timeline.CumulativeSeqAge = CumulativeSeqAge
		end
		CumulativeSeqAge = CumulativeSeqAge + currentSequence[2]
	end
	local currentSequenceIndex = timeline.Seqi
	local currentSequence = Data[currentSequenceIndex]
	local sequenceDuration = currentSequence[2]
	local previousCumulativeTime = CumulativeSeqAge - sequenceDuration
	if previousCumulativeTime + sequenceDuration <= elapsedTime then
		currentSequence[1](1, sequenceDuration)
		timeline.Seqi = currentSequenceIndex + 1
		return true
	else
		local progress = (elapsedTime - previousCumulativeTime) / sequenceDuration
		if progress ~= 0 and progress ~= 1 then
			currentSequence[1](progress, elapsedTime - previousCumulativeTime)
		end
		return false
	end
end
function Timeline.GetTotalLifespan(timeline)
	local sum = 0
	for i = 1, #timeline.Data do
		sum = sum + timeline.Data[i][2]
	end
	return sum
end
return Timeline
