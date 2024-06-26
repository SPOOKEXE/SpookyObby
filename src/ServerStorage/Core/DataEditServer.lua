local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ReplicatedModules = require(ReplicatedStorage:WaitForChild("Modules"))

local TableUtility = ReplicatedModules.Utility.Table

local SystemsContainer = {}

-- // Module // --
local Module = {}

function Module.SetCheckpoint( LocalPlayer, checkpointNumber )
	local Profile = SystemsContainer.DataServer.GetProfileFromPlayer( LocalPlayer )
	if not Profile then
		return
	end
	Profile.Data.CheckpointIndex = checkpointNumber
end

function Module.IncrementCheckpoint( LocalPlayer, amount )
	local Profile = SystemsContainer.DataServer.GetProfileFromPlayer( LocalPlayer )
	if not Profile then
		return
	end
	Profile.Data.CheckpointIndex += amount
end

-- Wipe a player's data
function Module.WipeUserId( UserId )
	local Profile, wasLoaded = SystemsContainer.DataServer._LoadDataFromUserId( UserId )
	if not Profile then
		return
	end

	for propName, propValue in pairs( TableUtility.DeepCopy( SystemsContainer.DataServer.TemplateData ) ) do
		Profile.Data[ propName ] = propValue
	end

	if not wasLoaded then
		Profile:Release()
	end
end

function Module.Start()

end

function Module.Init(otherSystems)
	SystemsContainer = otherSystems
end

return Module
