
local SystemsContainer = {}

-- // Module // --
local Module = {}

function Module.RegisterObbyCheckpoint( CheckpointInstace )

end

function Module.UnregisterObbyCheckpoint( CheckpointInstace )

end

function Module.Start()

end

function Module.Init(otherSystems)
	SystemsContainer = otherSystems
end

return Module
